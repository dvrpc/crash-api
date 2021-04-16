# Instructions for Data Updates

When we get a new year's data from the state departments of transportation (in the form of an MS Access database), GIS (@seandoesgis) uses the geo data for each record (if available, from either lat/lon or sri/milepost fields) to determine the planning areas (as the "municipality" field) for the Philadelphia County records. Our DB admin (@heelizabeth) then inserts that into the appropriate tables in the database. GIS will also provide to the Back End Developer (@kdwarn) a csv file that maps crash id (id) to a wkt geometry field (geom) using SRID 4326, for use in the import script (`data_import.py`). The script that creates that csv file is create_crashgeom_csv.sql, in this directory.

Once we have the data from *both* departments — there's no reason to add only one of them to the database — export the appropriate tables from the Access databases, following the convention for the filenames as noted at the top of the import script. (The last part of the filenames are the table names, e.g. "CRASH" for PA.) Update the years as appropriate, both in the filenames and the code within that file. It's easiest to export to Excel and then to csv from Excel. Be sure to include headers.

Add these files to the `data` directory of this repo (use `scp` to upload them to the server). **They should never be added to version control.** If you are just updating data, rather than creating the database from scratch, start from step 5.

Note:
  * this is a full import of all years' data. The script begins by deleting all records from the existing database.
  * this requires Postgres with the [PostGIS](https://postgis.net/) extension installed. See Postgres/PostGIS docs on installation. For Debian, install PostGIS on an already-installed Postgres 12 cluster with `sudo apt install postgres-12-postgis-3`.
  * like the API, this requires (for step 6) a connection string in the variable `PSQL_CREDS` in a config.py file. The connection string should include host, port, user, password, and dbname. In this case, the file should be located in the data/ directory rather than the api/ directory.

1. Create the database in postgres:
    1. switch to the postgres user: `su postgres`
    2. create the database: `createdb crash_data`
2. cd into the `data` directory of this repo
3. Use psql to create the main table and indexes: `psql -U postgres -p 5432 -h localhost -d crash_data < create_table_and_geom_index.sql`
4. Also create the geoid table (which maps geoids to county/municipality names): `psql -U postgres -p 5432 -h localhost -d crash_data < geoid.sql`
5. Activate the virtual environment if not activated already: `source ../ve/bin/activate` (or wherever it's located)
6. Import the data into the table: `python data_import.py`. It takes ~10 minutes to run.
