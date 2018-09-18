{% include nav.html %}
# Special Note for DSpace 4x Images
_DSpace 4x does not contain the Flyway DB software which automatically updates the database schema in DSpace 5x, 6x, and 7x.  The schema must be manually loaded into the database image before starting the tomcat webapps._

#### Save the following file as **schema.sql**

- [DSpace 4x Schema File](https://github.com/DSpace/DSpace/blob/dspace-4_x/dspace/etc/postgres/database_schema.sql)

#### Update Database Schema
```
docker exec -it ${DPROJ}_dspacedb_1 psql -U dspace -c < schema.sql
```
