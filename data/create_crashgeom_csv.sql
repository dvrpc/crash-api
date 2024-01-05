/* Use this sql to create a csv that includes crash id and geometry to be used with data_import.py
GIS db connection details - Host: gis-db, DB: gis, Port: 5432, Login: dvrpc_viewer, Password: viewer
Caution - script may need to be modified to accommodate changes in the GIS db (use a guide)
*/

with NJ as
(select casenumber as nj_id, st_force2d(shape) as shape
from transportation.crash_newjersey
where st_isempty(shape)='false'),
PA as 
(select cast(crn as varchar(10)) as pa_id, st_force2d(shape) as shape
from transportation.crash_pennsylvania
where st_isempty(shape)='false')
select  *
from (select concat('NJ', nj_id) as id, shape as geom from NJ 
union select concat('PA', pa_id) as id, shape as geom from PA) crash
