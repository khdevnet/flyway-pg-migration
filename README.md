# flyway-pg-migration
This guid writed for windows, but Flyway and PogreSql can be work on any OS

1. Install PostgreSql  https://www.postgresql.org/download/
2. Install Flyway console https://flywaydb.org/getstarted/download
3. Register flyway:
   - Go to "Control Panel\System and Security\System"
   - Select "Advanced system settings"
   - Select tab "Advanced"
   - Click "Environment variables"
   - In "Path" variable Add flyway directory location c:\flyway-4.2.0\
   - In cmd run flyway to check if everything register correct
4. Register PostgreSql psql.exe
   - Go to "Control Panel\System and Security\System"
   - Select "Advanced system settings"
   - Select tab "Advanced"
   - Click "Environment variables"
   - In "Path" variable add PostgreSql directory location C:\Program Files\PostgreSQL\9.6\bin\
   - In cmd run psql to check if everything register correct
5. Update create_database_flyway.bat file 
   - add PostgreSql database credentials
   - Add path to flyway migrations locations=filesystem:[path to you migrations] example: -locations=filesystem:Migrations
   
5. run bat file

Documentation:
1. Flyway - https://flywaydb.org/documentation
2. PostgreSql - https://www.postgresql.org/docs/9.2/static/app-psql.html
