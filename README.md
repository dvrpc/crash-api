# Crash API

API and data import for DVRPC's crash data.

Front end repo is at https://github.com/dvrpc/crash-data-tool.

See the [API](api/README.md) and [Data](data/README.md) READMEs for additional information.

Note: the API will be automatically redeployed upon a successful pull request merge via a Webhook (in conjunction with the [automated deployments API](https://github.com/dvrpc/automated-deployments-api) and the [cloud-ansible](https://github.com/dvrpc/cloud-ansible) project, with results emailed to those monitoring such activities.

## Virtual environment

A Python virtual environment is required for the API, the data import, and the tests. Create it in the project root (this top-level directory) and install the requirements:

```bash
python3 -m venv ve
. ve/bin/activate
pip install -r requirements.txt
```

## Tests

The tests check both the database accuracy as well as the API functionality. Therefore, before running tests, follow the instructions in data/README.md to set up and populate a database.

Then, within a virtual environment and from the project root, run `python -m pytest`. All tests in the tests/ directory will be executed.

Testing auto deployment
