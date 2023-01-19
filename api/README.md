# API

See <https://cloud.dvrpc.org/api/crash-data/v1/docs> for full API documentation.

Note: the API requires a connection string in the variable PSQL_CREDS in a config.py file in this directory. The connection string should include host, port, user, password, and dbname.

## Development

Version 1 of this API is finished. Features, enhancements, bugs, questions, and similar - including breaking changes that may be required for a v2 - are tracked in [issues](https://github.com/dvrpc/crash-api/issues). These are then distilled into [milestones](https://github.com/dvrpc/crash-api/milestones).

To run the API locally, create and activate a Python virtual environment, from the "api" directory, with the dependencies installed:

```bash
python3 -m venv ve
. ve/bin/activate
pip install -r requirements.txt
```

Then run `uvicorn --reload app:app`. It will be available at <http://127.0.0.1:8000/api/crash-data/v1/docs>.

### Tests

The tests check both the database accuracy as well as the API functionality. Therefore, before running tests, follow the instructions in data/README.md to set up and populate a database.

After that, create/activate a virtual environment (see above) and then run `python -m pytest` from this directory.
