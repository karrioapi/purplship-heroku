#!/bin/bash

export DJANGO_SETTINGS_MODULE='heroku_settings';

set -m # turn on bash's job control

purplship collectstatic --noinput

gunicorn purpleserver.wsgi --preload --log-file - &

purplship run_huey -w 2 &

fg %1
