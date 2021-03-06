/* Use psql: psql -f /path/to/this/file -d name_of_database (and potentially user, port, localhost
depending on setup)
*/

BEGIN;

CREATE EXTENSION IF NOT EXISTS postgis;

/* create one table for all the data 
There are four categories of how people are physically affected by a crash:
    - fatality ("fatalities" column below)
    - injured (injuries)
    - not injured (uninjured)
    - unknown if injured (unknown)

Within injuries, there are also four categories:
    - suspected serious injury (sus_serious_inj)
    - suspected minor injury (sus_minor_inj)
    - possible injury (possible_inj)
    - unknown severity (unk_inj) - note that NJ does not have this category
*/

CREATE TABLE IF NOT EXISTS crash (
    id text PRIMARY KEY NOT NULL,
    geoid bigint,
    state text NOT NULL,
    county text NOT NULL,
    municipality text NOT NULL,
    geom geometry(Point, 4326),
    year integer NOT NULL,
    month integer NOT NULL,
    collision_type text NOT NULL,
    vehicles integer NOT NULL,
    persons integer,
    bicyclists integer NOT NULL,
    pedestrians integer NOT NULL,
    fatalities integer NOT NULL,
    injuries integer NOT NULL,
    uninjured integer,
    unknown integer NOT NULL,
    sus_serious_inj integer NOT NULL,
    sus_minor_inj integer NOT NULL,
    possible_inj integer NOT NULL,
    unk_inj integer,
    max_severity text,
    bike_fatalities integer NOT NULL,
    ped_fatalities integer NOT NULL
);

CREATE TABLE IF NOT EXISTS geoid (
    state char(2) NOT NULL,
    county varchar(15),
    municipality varchar(100),
    geoid bigint primary key NOT NULL
);

COMMIT;
