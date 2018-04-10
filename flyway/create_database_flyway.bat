SET PGPASSWORD=Pa$$word1
psql -U csrh_attachments_user -p 5432 -d postgres -tc "SELECT 1 FROM pg_database WHERE datname='my_db'" | findstr -q 1 || psql.exe -U csrh_attachments_user -p 5432 -d postgres -c "CREATE DATABASE my_db"
flyway -url=jdbc:postgresql://localhost:5432/my_db -user=csrh_attachments_user -password=Pa$$word1 -locations=filesystem:Migrations migrate