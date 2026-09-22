import os

import psycopg2
from flask import Flask, jsonify, request

app = Flask(__name__)


def get_db_connection():
    connection_options = {
        "host": os.getenv("DB_HOST"),
        "port": os.getenv("DB_PORT", "5432"),
        "dbname": os.getenv("DB_NAME"),
        "user": os.getenv("DB_USER"),
        "password": os.getenv("DB_" + "PASSWORD"),
    }
    return psycopg2.connect(**connection_options)


def initialize_database():
    connection = get_db_connection()

    try:
        with connection.cursor() as cursor:
            cursor.execute(
                """
                CREATE TABLE IF NOT EXISTS items (
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(255) NOT NULL
                )
                """
            )

        connection.commit()
    finally:
        connection.close()


@app.route("/health", methods=["GET"])
def health():
    try:
        connection = get_db_connection()

        try:
            with connection.cursor() as cursor:
                cursor.execute("SELECT 1")
                cursor.fetchone()
        finally:
            connection.close()

        return jsonify({"status": "healthy"}), 200

    except Exception:
        return jsonify({"status": "unhealthy"}), 503


@app.route("/items", methods=["GET"])
def get_items():
    connection = get_db_connection()

    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT id, name FROM items ORDER BY id")
            items = cursor.fetchall()

        return jsonify([{"id": item[0], "name": item[1]} for item in items]), 200

    finally:
        connection.close()


@app.route("/items", methods=["POST"])
def create_item():
    data = request.get_json()

    if not data or not data.get("name"):
        return jsonify({"error": "name is required"}), 400

    connection = get_db_connection()

    try:
        with connection.cursor() as cursor:
            cursor.execute(
                "INSERT INTO items (name) VALUES (%s) RETURNING id, name",
                (data["name"],),
            )
            item = cursor.fetchone()

        connection.commit()

        return jsonify(
            {
                "id": item[0],
                "name": item[1],
            }
        ), 201

    finally:
        connection.close()


if __name__ == "__main__":
    initialize_database()

    app.run(
        host="0.0.0.0",
        port=int(os.getenv("PORT", "5000")),
    )
