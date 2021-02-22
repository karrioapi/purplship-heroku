#!/bin/sh

mkdir -p /app/.heroku/python/lib/python3.8/site-packages/staticfiles

DJANGO_SETTINGS_MODULE='heroku_settings' python -m purpleserver migrate &&
DEBUG_MODE=True DJANGO_SETTINGS_MODULE='heroku_settings' python -m purpleserver collectstatic --noinput &&
# Create super user for demo
(echo "
from django.contrib.auth import get_user_model
if not any(get_user_model().objects.all()):
	get_user_model().objects.create_superuser('$ADMIN_EMAIL', '$ADMIN_PASSWORD')
" | DJANGO_SETTINGS_MODULE='heroku_settings' python -m purpleserver shell)
