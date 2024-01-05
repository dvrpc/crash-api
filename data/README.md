# Instructions for Data Updates

When we get a new year's data from the state departments of transportation (in the form of an MS Access database), GIS (@seandoesgis) uses the geo data for each record (if available, from either lat/lon or sri/milepost fields) to determine the planning areas (as the "municipality" field) for the Philadelphia County records. Our DB admin (@heelizabeth) then inserts that into the appropriate tables in the database. GIS will also provide to the Back End Developer (@kdwarn) a csv file that maps crash id (id) to a wkt geometry field (geom) using SRID 4326, for use in the import script (`data_import.py`). The script that creates that csv file is `create_crashgeom_csv.sql`, in this directory.

Once we have the data from *both* departments — there's no reason to add only one of them to the database — export the appropriate tables from the Access databases. You can locate the table names in the data import script — `required_data_files` is a list of the required files, in format "STATE_YEAR-RANGE_TABLENAME.csv", e.g. "PA_2014-20_CRASH.csv" refers to the "CRASH" table from the 2014-20 PA database. 

After creating queries in Access to limit records to the particular year being updated, export the tables as CSV files (checking the box for "Include Field Names as First Row" to add a header of column names) and update the year as appropriate in both the exported filenames and the filenames listed in `required_data_files`. For instance, PA_2021_CRASH.csv from the PA 2017-2022 database.

Check that the latitude and longitude fields have the same number of decimal points in the exported file as they do in the Access database. If not — say, if they get truncated to two decimal places — this is likely a result of a Windows regional setting. See [this](https://support.microsoft.com/en-us/office/change-the-windows-regional-settings-to-modify-the-appearance-of-some-data-types-edf41006-f6e2-4360-bc1b-30e9e8a54989) to adjust the setting so the fields will get exported with the appropriate number of decimal places (increase "No. of digits after decimal" to 5).

Add these files to this directory (data) of this repo locally. **They should never be added to version control.** If you are just updating data, rather than creating the database from scratch, start from step 5 below.

Note:
  * We assume/prefer adding data year-by-year, however the script is set up to be able to wipe the database and insert all records anew. This is controlled by a variable at the top, set to False by default.
  * Postgres with the [PostGIS](https://postgis.net/) extension is required. See Postgres/PostGIS docs on installation. For Debian and derivatives, install PostGIS on an already-installed Postgres 12 cluster with `sudo apt install postgresql-12-postgis-3`.
  * like the API, this requires (for step 6) a connection string in the variable `PG_CREDS` in a config.py file. The connection string should include host, port, user, password, and dbname. In this case, the file should be located in the data/ directory rather than the api/ directory.

Create/update the database on your local machine:
  1. Create the database in postgres:
      1. switch to the postgres user: `su postgres`
      2. create the database: `createdb crash`
  2. cd into the `data` directory of this repo
  3. Create/populate tables (using port/host/user settings as necessary):
      1. `psql crash < create_tables.sql`
      2. `psql crash < populate_geoid.sql`
      3. `psql crash < create_geom_index.sql`
  4. `exit` to return to your regular user account
  5. Create/activate virtual environment and install requirements as needed:
      1. `python3 -m venv ve`
      2. `. ../api/ve/bin/activate` (or wherever it's located)
      3. `pip install -r requirements.txt`
  6. Run the import script, which first wipes all records from the db before inserting new records: `python data_import.py`. It takes 1.5 minutes for one full year of data.
  7. Run tests to verify previous years' data.
  8. Create new tests to verify new data. (Previous tests are fairly extensive and ensure that the data was transformed properly. New tests can just ensure some broad counts are correct.)

Then copy this database to the production server:
  1. Create a backup of the database you just created, as postgres user: `pg_dump -O -F c crash > crash-[yyyy-mm-dd].pgc`
  2. Add that backup to the roles/crash/files/ directory of [the cloud ansible repo](https://github.com/dvrpc/cloud-ansible), update name of `db_backup` var in roles/crash/vars/main.yaml, and run the playbook.

Finally, create a CSV file for GIS to generate vector tiles for the front-end viewer: `psql -U postgres -d crash -c "COPY ( select id, year, st_x(geom) as x, st_y(geom) as y, max_severity as max_sever, left(CAST(geoid as text),5) as c, geoid as m from crash ) TO STDOUT WITH CSV HEADER" > crashes_for_vector_tiles.csv` and share it.
