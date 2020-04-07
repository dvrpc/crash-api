"""
@TODO (not listed elsewhere in the code):
    - create list of possible values for the various area "types" - check against
    - add try/except for connecting to database
    - for get_crash(), figure out how to return 400 if <id> not provided
"""

import calendar

from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
import psycopg2 
import yaml

from config import PSQL_CREDS

app = Flask(__name__)
CORS(app)


def get_db_cursor():
    connection = psycopg2.connect(PSQL_CREDS)
    return connection.cursor()


@app.route('/api/crash-data/v1/documentation')
def docs():
    '''Documentation for the API'''
    with open("openapi.yaml", 'r') as stream:
        spec = yaml.safe_load(stream)

    return render_template('documentation.html', spec=spec)


@app.route('/api/crash-data/v1/crashes/<id>', methods=['GET'])
def get_crash(id):
    '''Return select fields about an individual crash.'''
    if not id:
        return jsonify({'message': 'Required path parameter *id* not provided'}), 400
    
    cursor = get_db_cursor()
    query = """
        SELECT
            month,
            year,
            vehicles,
            bicyclists,
            bike_fatalities,
            pedestrians,
            ped_fatalities,
            persons,
            collision_type
        FROM crash
        WHERE id = %s 
        """

    try:    
        cursor.execute(query, [id])
    except psycopg2.Error as e:
        return jsonify({'message': 'Database error: ' + str(e)}), 400
        
    result = cursor.fetchone()
    
    if not result:
        return jsonify({'message': 'Crash not found'}), 404
    
    crash = {
        'month': calendar.month_name[result[0]],
        'year': result[1],
        'vehicle_count': result[2],
        'bicycle_count': result[3],
        'bicycle_fatalities': result[4],
        'ped_count': result[5],
        'ped_fatalities': result[6],
        'vehicle_occupants': result[7] - result[3] - result[5],
        'collision_type': result[8],
    }
    return jsonify(crash) 


@app.route('/api/crash-data/v1/summary', methods=['GET'])
def get_summary():
    '''
    Return summary of various attributes by year.
    If provided, *type* and *value* query parameters will limit result by geographic area.
    If *ksi_only* == yes, return only fatal and major crashes.
    '''    

    keys = list(request.args)

    for key in keys:
        if key not in ['state', 'county', 'municipality', 'geoid', 'geojson', 'ksi_only']:
            return jsonify({'message': f'Query parameter *{key}* not recognized'}), 400

    state = request.args.get('state')
    county = request.args.get('county')
    municipality = request.args.get('municipality')
    geoid = request.args.get('geoid')
    geojson = request.args.get('geojson')
    ksi_only = request.args.get('ksi_only')

    # build query incrementally, to add possible WHERE clauses before GROUP BY and 
    # to easily pass value parameter to execute in order to prevent SQL injection 
    severity_and_mode_query = """
        SELECT 
            year,
            SUM(fatalities),
            SUM(maj_inj),
            SUM(mod_inj),
            SUM(min_inj),
            SUM(unk_inj),
            SUM(uninjured),
            SUM(unknown),
            SUM(bicyclists),
            SUM(pedestrians),
            SUM(persons),
            count(id)
        FROM crash
    """

    collision_type_query = """
        SELECT 
            year,
            collision_type,
            count(collision_type) 
        FROM crash
    """

    cursor = get_db_cursor() 
    
    # build the where clause

    sub_clauses = []  # the individual "x = y" clauses
    values = []  # list of values that will be in the WHERE clause when executed

    if state or county or municipality:
        # state, county, and municipality can be chained together in the same query
        if state:
            sub_clauses.append("state = %s")
            values.append(state)
        if county:
            sub_clauses.append("county = %s")
            values.append(county)
        if municipality:
            sub_clauses.append("municipality = %s")
            values.append(municipality)
    elif geoid:
        # get the name and area type for this geoid
        cursor.execute("SELECT area_type, name from geoid where geoid = %s", [geoid])
        result = cursor.fetchone()
        if not result:
            return jsonify({"message": "No location found with the provide geoid"}), 404
        # now set up where clause
        sub_clauses.append(f"{result[0]} = %s")
        values.append(result[1])
    elif geojson:
        sub_clauses.append("ST_WITHIN(geom,ST_GeomFromGeoJSON(%s))")
        values.append(geojson)
            
    if ksi_only == 'yes':
        sub_clauses.append("(fatalities > 0 OR maj_inj > 0)")

    # put the where clauses together
    if len(sub_clauses) == 0:
        where = ''
    elif len(sub_clauses) == 1:
        where = ' WHERE ' + sub_clauses[0]
    else:
        where = ' WHERE ' + ' AND '.join(sub_clauses)

    severity_and_mode_query += where + " GROUP BY year"
    collision_type_query += where + " GROUP BY year, collision_type"
    
    try:
        cursor.execute(severity_and_mode_query, values)
    except psycopg2.Error as e:
        return jsonify({'message': 'Database error: ' + str(e)}), 400
    
    result = cursor.fetchall()
    
    if not result:
        return jsonify({'message': 'No information found for given type/value.'}), 404

    summary = {}

    for row in result:
        summary[str(row[0])] = {
            'total crashes': row[11],
            'severity': {
                'fatal': row[1],
                'major': row[2],
                'moderate': row[3],
                'minor': row[4],
                'unknown severity': row[5],
                'uninjured': row[6],
                'unknown if injured': row[7]
            },
            'mode': {
                'bike': row[8],
                'ped': row[9],
                'vehicle occupants': row[10] - row[9] - row[8]
            },
            'type': {},
        } 

    # now get numbers/types of collisions per year and add to summary
    
    collision_type_query = cursor.execute(collision_type_query, values)
    result = cursor.fetchall()

    collisions_by_year = {}

    for row in result:
        try:
            collisions_by_year[str(row[0])][row[1]] = row[2]
        except KeyError:
            collisions_by_year[str(row[0])] = {}
            collisions_by_year[str(row[0])][row[1]] = row[2] 

    for k in summary.keys():
        summary[k]['type'] = collisions_by_year[k]

    return jsonify(summary)


@app.route('/api/crash-data/v1/crash-ids', methods=['GET'])
def get_crash_ids():
    '''Return list of crash_ids based on provided parameters.'''

    # @TODO: more ways to get this info in addition to by geojson

    geojson = request.args.get('geojson')
    
    if not geojson:
        return jsonify({'Message': 'Required parameter *geojson* not provided.'}), 400

    cursor = get_db_cursor()
    query = """
        SELECT id
        FROM crash
        WHERE ST_WITHIN(geom, ST_GeomFromGeoJSON(%s));
    """ 
        
    try:
        cursor.execute(query, [geojson])
    except psycopg2.Error as e:
        return jsonify({'message': 'Database error: ' + str(e)}), 400

    result = cursor.fetchall()
    
    if not result:
        return jsonify({'message': 'No crashes found for provided geojson'}), 404
    
    ids = []

    for row in result:
        ids.append(row[0])
    return jsonify(ids)