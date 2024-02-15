# API

See <https://cloud.dvrpc.org/api/crash-data/v1/docs> for full API documentation.

Note: the API requires a connection string constructed from variables in a .env file in the project root. See the .env.example file.

## Development

Version 1 of this API is finished. Features, enhancements, bugs, questions, and similar - including breaking changes that may be required for a v2 - are tracked in [issues](https://github.com/dvrpc/crash-api/issues). These are then distilled into [milestones](https://github.com/dvrpc/crash-api/milestones).

To run the API locally, within a Python virtual environment (see top-level README), and from the api/ directory, run `uvicorn --reload app:app`. It will be available at <http://127.0.0.1:8000/api/crash-data/v1/docs>.

