#!/bin/sh
set -eu

superset db upgrade
python3 /opt/superset/initialize.py
superset init

exec gunicorn \
    --bind 0.0.0.0:8088 \
    --workers 2 \
    --timeout 120 \
    --access-logfile - \
    --error-logfile - \
    superset:app
