from purpleserver.settings import *

# HTTPS configuration
if USE_HTTPS is True:
    global SECURE_SSL_REDIRECT
    global SECURE_PROXY_SSL_HEADER
    global SESSION_COOKIE_SECURE
    global SECURE_HSTS_SECONDS
    global SECURE_HSTS_INCLUDE_SUBDOMAINS
    global CSRF_COOKIE_SECURE
    global SECURE_HSTS_PRELOAD

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
DATABASE_URL = config('DATABASE_URL', default=None, cast=str)
if DATABASE_URL is None:
    import dj_database_url
    db_from_env = dj_database_url.config(conn_max_age=500)
    DATABASES['default'].update(db_from_env)


# Simplified static file serving.
# https://warehouse.python.org/project/whitenoise/
STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'
