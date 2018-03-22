[app:app]
use = egg:demo_geoportal
pyramid.reload_templates = true
pyramid.debug_authorization = false
pyramid.debug_notfound = true
pyramid.debug_routematch = false
pyramid.debug_templates = true
pyramid.includes =
    pyramid_debugtoolbar
mako.directories = demo_geoportal:templates
    c2cgeoportal_geoportal:templates
authtkt_secret = ${authtkt["secret"]}
authtkt_cookie_name = ${authtkt["cookie_name"]}
% if "timeout" in authtkt:
authtkt_timeout = ${authtkt["timeout"]}
% endif
app.cfg = %(here)s/config.yaml

[pipeline:main]
pipeline =
    app

###
# logging configuration
# http://docs.pylonsproject.org/projects/pyramid/en/1.5-branch/narr/logging.html
###

[loggers]
keys = root, sqlalchemy, gunicorn.access, gunicorn.error, c2cgeoportal_commons, c2cgeoportal_geoportal, c2cgeoportal_admin, demo_geoportal, c2cwsgiutils

[handlers]
keys = console

[formatters]
keys = generic

[logger_root]
level = WARN
handlers = console

[logger_c2cgeoportal_commons]
level = INFO
handlers =
qualname = c2cgeoportal_commons

[logger_c2cgeoportal_geoportal]
level = INFO
handlers =
qualname = c2cgeoportal_geoportal

[logger_c2cgeoportal_admin]
level = INFO
handlers =
qualname = c2cgeoportal_admin

[logger_demo_geoportal]
level = DEBUG
handlers =
qualname = demo_geoportal

[logger_c2cwsgiutils]
level = INFO
handlers =
qualname = c2cwsgiutils

[logger_gunicorn.access]
level = INFO
handlers =
qualname = gunicorn.access

[logger_gunicorn.error]
level = INFO
handlers =
qualname = gunicorn.error

[logger_sqlalchemy]
level = WARN
handlers =
qualname = sqlalchemy.engine
# "level = INFO" logs SQL queries.
# "level = DEBUG" logs SQL queries and results.
# "level = WARN" logs neither.  (Recommended for production systems.)

[handler_console]
class = StreamHandler
args = (sys.stderr,)
level = NOTSET
formatter = generic

[formatter_generic]
format = %(asctime)s %(levelname)-5.5s [%(name)s][%(threadName)s] %(message)s
