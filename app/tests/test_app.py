from unittest.mock import patch

import psycopg2

from app import app


def test_create_item_requires_name():
    client = app.test_client()

    response = client.post("/items", json={})

    assert response.status_code == 400
    assert response.get_json() == {"error": "name is required"}


def test_health_returns_unhealthy_when_database_is_unavailable():
    client = app.test_client()

    with patch(
        "app.get_db_connection",
        side_effect=psycopg2.Error("database unavailable"),
    ):
        response = client.get("/health")

    assert response.status_code == 503
    assert response.get_json() == {"status": "unhealthy"}


def test_ready_returns_unhealthy_when_database_is_unavailable():
    client = app.test_client()

    with patch(
        "app.get_db_connection",
        side_effect=psycopg2.Error("database unavailable"),
    ):
        response = client.get("/ready")

    assert response.status_code == 503
    assert response.get_json() == {"status": "unhealthy"}


def test_metrics_exposes_http_request_metrics():
    client = app.test_client()

    client.post("/items", json={})
    response = client.get("/metrics")

    assert response.status_code == 200
    assert response.content_type.startswith("text/plain")
    assert b"http_requests_total" in response.data
    assert b'endpoint="/items"' in response.data
