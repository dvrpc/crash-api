# Instructions for Data Updates

## Introduction

When we get a new year's data from the state departments of transportation (in the form of an MS Access database), GIS (@seandoesgis) uses the geo data for each record (if available, from either lat/lon or sri/milepost fields) to determine the planning areas (as the "municipality" field) for the Philadelphia County records. Our DB admin (@heelizabeth) then inserts that into the appropriate tables in the database. GIS will also provide to the Back End Developer (@kdwarn) a csv file that maps crash id (id) to a wkt geometry field (geom) using SRID 4326, for use in the import script (`data_import.py`). The script that creates that csv file is `create_crashgeom_csv.sql`, in this directory.

## Extracting data from Access database and configuring script

Once we have the data from *both* departments — there's no reason to add only one of them to the database — export the appropriate tables from the Access databases. You can locate the table names in the data import script — `required_data_files` is a list of the required files, in format "STATE_YEAR-RANGE_TABLENAME.csv", e.g. "PA_2014-20_CRASH.csv" refers to the "CRASH" table from the 2014-20 PA database. 

After creating queries in Access to limit records to the particular year being updated, export the tables as CSV files (checking the box for "Include Field Names as First Row" to add a header of column names) and update the year as appropriate in both the exported filenames and the filenames listed in `required_data_files`. For instance, PA_2021_CRASH.csv from the PA 2017-2022 database.

Add these files to this directory (data) of this repo locally. **They should never be added to version control.** 

## Importing the data, restoring to production server, and creating CSV for vector tiles

The command runner `just` can be used to greatly simplify the steps listed below and should be the preferred way to make updates - see the section below on its use.

Requirements: 
  * Postgres with the [PostGIS](https://postgis.net/) extension is required. See Postgres/PostGIS docs on installation. For example, on Debian and derivatives, install PostGIS on an already-installed Postgres 12 cluster with `sudo apt install postgresql-12-postgis-3`.
  * A .env file with variables for connecting to the database. See .env.example.

Create/update the database on your local machine, from the `data` directory of this repo:
  1. Set up the database (using port/host settings as necessary, but minimally as postgres user): 
      1. `createdb -U postgres crash`
      2. `psql -U postgres crash < create_tables.sql`
      3. `psql -U postgres crash < populate_geoid.sql`
      4. `psql -U postgres crash < create_geom_index.sql`
  2. Create/activate virtual environment at project root and install requirements:
      1. `python3 -m venv ve`
      2. `. ve/bin/activate`
      3. `pip install -r requirements.txt`
  3. From the data/ directory, run the import script: `python data_import.py`, calling it with one of two parameters:
      * `--year [YYYY]` to add/update date for a single year. The program will first delete all existing records for this year, so that updates can be made if corrections are necessary. e.g. `python data-import.py --year 2021`. It takes about 90 seconds to add one year of data.
      * `--reset-db` to wipe the database and import data for all years.
      * If duplicates.csv was generated, check it to confirm expectations.
      * Run tests to verify previous years' data. 
  4. Create new tests to verify new data. (Previous tests are fairly extensive and ensure that the data was transformed properly. New tests can just ensure some broad counts are correct.)
  5. Create a backup of the database you just created, as postgres user: `pg_dump -O crash > crash-[yyyy-mm-dd].sql`

Add the backup to the roles/crash/files/ directory of [the cloud ansible repo](https://github.com/dvrpc/cloud-ansible), update name of `db_backup` var in roles/crash/vars/main.yaml, and run the playbook, using `--tags crash`.

Finally, create a CSV file for GIS to generate vector tiles for the front-end viewer: `psql -U postgres -d crash -c "COPY ( select id, year, st_x(geom) as x, st_y(geom) as y, max_severity as max_sever, left(CAST(geoid as text),5) as c, geoid as m from crash ) TO STDOUT WITH CSV HEADER" > crashes_for_vector_tiles.csv` and share it.

## Just 

`just` is a command runner. See [its website](https://just.systems/) for installation and full usage, but once installed and the .env file discussed above has been created:
  * use `just update [year]` e.g. `just update 2021` to add/update data for 2021
  * use `just reset` to drop the existing database and add all years of data to it

Both commands will first create a Python virtual environment if not already created and use it to run the data import script. Then, once the database work has finished, they will show number of duplicates, run the tests, dump the database to file, and create the CSV for generating vector tiles.

You can also run `just` by itself to run the default command (Python tests) and `just --list` to see all available commands.

**Although `just` automates much of the process of the preceding section, there are two things it cannot do that will need to be done separately: 1) restore the database backup that it creates to the production server 2) share the CSV to create vector tiles that it generates.**
