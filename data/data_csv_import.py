"""
Import data from csv files pulled from the MS Access DBs (and one from our DVRPC GIS db, crashgeom.csv) into Postgresql for the Crash API.

Note that the code skips the first row of CSV files, as it expects that row to be header.

Required files:
  - PA_2014-19_MCDlist.csv
  - PA_2014-19_CRASH.csv
  - NJ_2010-16_1_Accidents.csv
  - NJ_2017-19_1_Accidents.csv
  - NJ_2010-16_4_Pedestrians.csv
  - NJ_2017-19_4_Pedestrians.csv
  - crashgeom.csv
"""

import csv
import time

import psycopg2

from config import PSQL_CREDS


duplicates = []  # duplicate CRN (PA) / CaseNumber (NJ)

pa_counties = {
    "09": "Bucks",
    "67": "Philadelphia",
    "15": "Chester",
    "23": "Delaware",
    "46": "Montgomery",
}

pa_collisions = {
    "0": "Non-collision",
    "1": "Rear-end",
    "2": "Head-on",
    "3": "Rear-to-rear (backing)",
    "4": "Angle",
    "5": "Sideswipe (same direction)",
    "6": "Sideswipe (opposite direction)",
    "7": "Hit fixed object",
    "8": "Hit pedestrian",
    "9": "Other or unknown",
}

nj_collisions = {
    "10": "Non-collision",
    "01": "Rear-end",
    "07": "Head-on",
    "04": "Head-on",
    "08": "Rear-to-rear (backing)",
    "03": "Angle",
    "02": "Sideswipe (same direction)",
    "05": "Sideswipe (opposite direction)",
    "11": "Hit fixed object",
    "06": "Hit fixed object",
    "14": "Hit pedestrian",
    "13": "Hit pedestrian",
    "12": "Other or unknown",
    "99": "Other or unknown",
    "00": "Other or unknown",
    "15": "Other or unknown",
    "16": "Other or unknown",
    "09": "Other or unknown",
}

# connect to postgres database
con = psycopg2.connect(PSQL_CREDS)
cur = con.cursor()

# delete all existing records from db (previous data import)
cur.execute("DELETE FROM crash")
con.commit()

start = time.time()

# enter MCD values into pa_municipalities (unnecessary for NJ)
with open("PA_2014-19_MCDlist.csv", newline="") as csvfile:
    reader = csv.DictReader(csvfile, delimiter=",")
    pa_municipalities = {}
    for row in reader:
        pa_municipalities[row["MCDcode"]] = row["MCDname"]

# insert PA crash data into db
with open("PA_2014-19_CRASH.csv", newline="") as csvfile:
    reader = csv.DictReader(csvfile, delimiter=",")
    for row in reader:

        try:
            cur.execute(
                """
                INSERT INTO crash (
                    id, state, county, municipality,
                    year, month, collision_type,
                    vehicles, persons, bicyclists, pedestrians,
                    fatalities, injuries,
                    uninjured,
                    unknown,
                    sus_serious_inj, sus_minor_inj, possible_inj, unk_inj,
                    bike_fatalities, ped_fatalities
                )
                VALUES (
                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,
                    %s, %s
                )
                """,
                [
                    "PA" + row["CRN"],
                    "pa",
                    pa_counties[row["COUNTY"]],
                    pa_municipalities[row["MUNICIPALITY"]],
                    row["CRASH_YEAR"],
                    row["CRASH_MONTH"],
                    pa_collisions[row["COLLISION_TYPE"]],
                    int(row["VEHICLE_COUNT"]),
                    int(row["PERSON_COUNT"]),
                    int(row["BICYCLE_COUNT"]),
                    int(row["PED_COUNT"]),
                    int(row["FATAL_COUNT"]),
                    int(row["TOT_INJ_COUNT"]),
                    int(row["PERSON_COUNT"])
                    - int(row["FATAL_COUNT"])
                    - int(row["TOT_INJ_COUNT"])
                    - int(row["UNK_INJ_PER_COUNT"]),
                    int(row["UNK_INJ_PER_COUNT"]),
                    int(row["MAJ_INJ_COUNT"]),
                    int(row["MOD_INJ_COUNT"]),
                    int(row["MIN_INJ_COUNT"]),
                    int(row["UNK_INJ_DEG_COUNT"]),
                    int(row["BICYCLE_DEATH_COUNT"]),
                    int(row["PED_DEATH_COUNT"]),
                ],
            )
        except psycopg2.errors.UniqueViolation:
            duplicates.append(["PA", row["CRN"]])
            con.rollback()
        else:
            con.commit()


def insert_nj_accidents(filename: str):
    """Insert data from the NJ 1_accidents tables into db."""
    with open(filename, newline="") as csvfile:
        reader = csv.DictReader(csvfile, delimiter=",")
        for row in reader:
            # skip any crashes from before the year 2014
            if int(row["CrashDate"].split("/")[2]) < 2014:
                continue
            # change some abbreviations
            if "TWP" in row["MunicipalityName"]:
                municipality = row["MunicipalityName"].replace("TWP", "Township")
            elif row["MunicipalityName"].endswith("BORO"):
                # NJ data truncates Borough to BORO, but we don't want to change any "boro"
                # in the name of the municipality if it's not this abbreviation/last word
                municipality = row["MunicipalityName"].rstrip("BORO")
                municipality = municipality + "Borough"
            else:
                municipality = row["MunicipalityName"]

            # deal with possible null values for various fields
            if not row["CrashTypeCode"]:
                collision_type = "Other or unknown"
            else:
                collision_type = nj_collisions[row["CrashTypeCode"]]
            unknown = 0 if not row["Unknow_Injury"] else int(row["Unknow_Injury"])

            # there are some missing values for TotalPerson
            if not row["TotalPerson"].strip():
                person_count = None
                uninjured = None
            else:
                person_count = int(row["TotalPerson"])
                uninjured = (
                    person_count - int(row["TotalKilled"]) - int(row["TotalInjured"]) - unknown
                )

            sus_serious_inj = 0 if not row["Major_Injury"] else int(row["Major_Injury"])
            sus_minor_inj = 0 if not row["Moderate_Injury"] else int(row["Moderate_Injury"])
            possible_inj = 0 if not row["Minor_Injury"] else int(row["Minor_Injury"])

            try:
                cur.execute(
                    """
                    INSERT INTO crash (
                        id, state, county, municipality,
                        year, month,
                        collision_type,
                        vehicles, persons,
                        fatalities, injuries, uninjured, unknown,
                        sus_serious_inj, sus_minor_inj, possible_inj, unk_inj,
                        bicyclists, bike_fatalities, pedestrians, ped_fatalities
                    )
                    VALUES (
                        %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,
                        %s, %s
                    )
                    """,
                    [
                        "NJ" + row["CaseNumber"],
                        "nj",
                        row["CountyName"].title(),
                        municipality.title(),
                        row["CrashDate"].split("/")[2],
                        row["CrashDate"].split("/")[0],
                        collision_type,
                        int(row["TotalVehiclesInvolved"]),
                        person_count,
                        int(row["TotalKilled"]),
                        int(row["TotalInjured"]),
                        uninjured,
                        unknown,
                        sus_serious_inj,
                        sus_minor_inj,
                        possible_inj,
                        0,
                        0,
                        0,
                        0,
                        0,
                    ],
                )
            except psycopg2.errors.UniqueViolation:
                duplicates.append(["NJ", row["CaseNumber"]])
                con.rollback()
            else:
                con.commit()


def insert_nj_pedestrians(filename: str):
    """Insert data from the NJ 4_pedestrians tables into db."""
    with open(filename, newline="") as csvfile:
        reader = csv.DictReader(csvfile, delimiter=",")
        for row in reader:
            if row["PhysicalCondition"] == "01":  # "Killed"
                if row["IsBycyclist"].strip() == "Y":
                    bicycle_fatality = 1
                    ped_fatality = 0
                else:
                    bicycle_fatality = 0
                    ped_fatality = 1
            else:
                bicycle_fatality = 0
                ped_fatality = 0

            if row["IsBycyclist"].strip() == "Y":
                bicyclist = 1
                pedestrian = 0
            else:
                bicyclist = 0
                pedestrian = 1

            cur.execute(
                """
                UPDATE crash
                SET
                    bicyclists = bicyclists + %s,
                    pedestrians = pedestrians + %s,
                    bike_fatalities = bike_fatalities + %s,
                    ped_fatalities = ped_fatalities + %s
                WHERE id = %s
                """,
                [bicyclist, pedestrian, bicycle_fatality, ped_fatality, "NJ" + row["CaseNumber"]],
            )


insert_nj_accidents("NJ_2010-16_1_Accidents.csv")
insert_nj_accidents("NJ_2017-19_1_Accidents.csv")
insert_nj_pedestrians("NJ_2010-16_4_Pedestrians.csv")
insert_nj_pedestrians("NJ_2017-19_4_Pedestrians.csv")

# fix some municipality names
muni_names = [
    {
        "Delaware": [
            ["Newton Township", "Newtown Township"],  # incorrect, correct
            ["Brook Haven Borough", "Brookhaven Borough"],
            ["Sharon Borough", "Sharon Hill Borough"],
            ["Birmingham Township", "Chadds Ford Township"],
            ["Chichester Township", "Upper Chichester Township"],
        ]
    },
    {"Mercer": [["Princeton Borough", "Princeton"], ["Princeton Township", "Princeton"]]},
    {"Montgomery": [["Marlboro Township", "Marlborough Township"]]},
    {"Camden": [["Mount Ephriam Borough", "Mount Ephraim Borough"]]},
    {
        "Chester": [
            ["East Marlboro Township", "East Marlborough Township"],
            ["West Marlboro Township", "West Marlborough Township"],
        ]
    },
]

for county in muni_names:
    for k, v in county.items():  # k is county name, v is list of lists of incorrect,correct munis
        for each in v:
            cur.execute(
                "UPDATE crash SET municipality = %s WHERE county = %s AND municipality = %s",
                [each[1], k, each[0]],
            )
con.commit()

# add the geom field
with open("crashgeom.csv", newline="") as csvfile:
    reader = csv.DictReader(csvfile, delimiter=",")
    for row in reader:
        cur.execute("UPDATE crash SET geom = %s where id = %s", [row["geom"], row["id"]])

con.commit()

# max_severity and geoid are added to this table (rather than calculating and returning within the
# API/joining with the geoid table) so we can easily export their values in a geojson via script

# set max_severity
# unlike API's get_crash and get_crashes, this uses ints, since there the max_severity on the
# tiles is heavily used
cur.execute(
    """
    SELECT
        id,
        fatalities,
        sus_serious_inj,
        sus_minor_inj,
        possible_inj,
        unk_inj
    FROM crash
"""
)

for row in cur.fetchall():
    if row[1]:
        max_severity = 0
    elif row[2]:
        max_severity = 1
    elif row[3]:
        max_severity = 2
    elif row[4]:
        max_severity = 3
    elif row[5]:
        max_severity = 4
    else:
        max_severity = 5

    cur.execute("UPDATE crash SET max_severity = %s WHERE id = %s", [max_severity, row[0]])

# add geoid
cur.execute(
    """
    UPDATE crash c
    SET geoid = g.geoid
    FROM geoid g
    WHERE
        c.state = g.state AND
        c.county = g.county AND
        c.municipality = g.municipality
    """
)

with open("duplicates.csv", "w", newline="") as f:
    writer = csv.writer(f)
    for duplicate in duplicates:
        writer.writerow(duplicate)

# check if there are any records in the crash table with NULL geoid - if so, that means there's
# a discrepancy in names between crash data and the official places names
cur.execute("SELECT distinct(municipality) FROM crash WHERE geoid is NULL")
name_check = cur.fetchall()
if name_check:
    print(
        "Insertion failed. Unable to find a municipality in the geoid table with names listed"
        " below. Account for these names and re-run this script."
    )
    for row in name_check:
        print(row[0])
else:
    con.commit()
    print("Postgres insertion took", time.time() - start, "seconds to run.")

cur.close()
con.close()
