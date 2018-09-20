{% include nav.html %}
# Special Note for DSpace 4x Images
_DSpace 4x does not contain the Flyway DB software which automatically updates the database schema in DSpace 5x, 6x, and 7x.  The schema must be manually loaded into the database image before starting the tomcat webapps._

A specialized postgres image exists for DSpace 4x testing.

https://hub.docker.com/r/dspace/dspace-postgres-4x/
