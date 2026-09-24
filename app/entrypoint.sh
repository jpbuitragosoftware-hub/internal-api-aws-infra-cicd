#!/bin/sh
set -eu

# Create the table before the API starts serving requests.
python -c "from app import initialize_database; initialize_database()"

# Keep custom Docker commands working in CI and smoke tests.
if [ "$#" -gt 0 ]; then
  exec "$@"
fi

exec gunicorn --bind "0.0.0.0:${PORT:-5000}" app:app
