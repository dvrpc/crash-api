/* Use psql: psql -f /path/to/this/file -d name_of_database (and potentially user, port, localhost
depending on setup)
*/

BEGIN;

DROP INDEX IF EXISTS geom_index;

COMMIT;
