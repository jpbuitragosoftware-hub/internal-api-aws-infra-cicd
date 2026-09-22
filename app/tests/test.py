from unittest.mock import patch

from app import app


def test_create_item_requires_name():
    client = app.test_client()

    response = client.post("/items", json={})

    assert response.status_code == 400
    assert response.get_json() == {"error": "name is required"}


def test_health_returns_unhealthy_when_database_is_unavailable():
    client = app.test_client()

    with patch("app.get_db_connection", side_effect=Exception("database unavailable")):
        response = client.get("/health")

    assert response.status_code == 503
    assert response.get_json() == {"status": "unhealthy"}
