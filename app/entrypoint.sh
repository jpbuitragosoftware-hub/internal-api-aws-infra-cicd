#!/bin/sh
set -eu

python -c "from app import initialize_database; initialize_database()"

exec gunicorn --bind "0.0.0.0:${PORT:-5000}" app:app
