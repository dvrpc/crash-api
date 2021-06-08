/* Use psql: psql -f /path/to/this/file -d name_of_database (and potentially user, port, localhost
depending on setup)
*/

BEGIN;

CREATE INDEX IF NOT EXISTS geom_index ON crash USING GIST (geom);

COMMIT;
