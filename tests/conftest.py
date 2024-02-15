import pytest
from fastapi.testclient import TestClient

from api import app


@pytest.fixture
def client():
    client = TestClient(app.app)
    return client
