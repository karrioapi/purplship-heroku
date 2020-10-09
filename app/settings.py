import os

os.environ.setdefault('DATABASE_PASSWORD', '')
os.environ.setdefault('DATABASE_USERNAME', '')
os.environ.setdefault('DATABASE_HOST', '')
os.environ.setdefault('DATABASE_PORT', '')

from purpleserver.settings import *  # noqa

# HTTPS configuration
SECURE_SSL_REDIRECT = True
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
SESSION_COOKIE_SECURE = True
SECURE_HSTS_SECONDS = 1
SECURE_HSTS_INCLUDE_SUBDOMAINS = True
CSRF_COOKIE_SECURE = True
SECURE_HSTS_PRELOAD = True


SECURITY, *EXTRA_MIDDLEWARE = MIDDLEWARE
MIDDLEWARE = (
    [SECURITY] + ['whitenoise.middleware.WhiteNoiseMiddleware'] + EXTRA_MIDDLEWARE
)


# Heroku: Update database configuration from $DATABASE_URL.
import dj_database_url  # noqa
db_from_env = dj_database_url.config(conn_max_age=500)
DATABASES['default'].update(db_from_env)


# Simplified static file serving.
# https://warehouse.python.org/project/whitenoise/
STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'
