echo "### create dbs ###" 
psql -f /docker-entrypoint-initdb.d/create_dbs.sq -U "$POSTGRES_USER" -v ON_ERROR_STOP=1

echo "### /var/lib/postgresql/backups ###" 
cd /var/lib/postgresql/backups
backupFolder="./backups"
backupArchiveName="./backup-latest.tar.gz"
echo "### Unzip backups: $backupArchiveName ###"
[ -d "$backupFolder" ] || mkdir "$backupFolder"
rm -rf "$backupFolder/*"
tar -zxvf $backupArchiveName 

echo "### Restore databases ###"
backupDbs=(dbname1 dbname2)
echo "### ${backupDbs[*]} ###"
for dbName in ${backupDbs[@]}; do
  echo "### $dbName ###"
  cat $backupFolder/$dbName/$dbName-* | psql $dbName -v ON_ERROR_STOP=1
done

echo "### craete users ###" 
psql -f /docker-entrypoint-initdb.d/create_users.sq -U "$POSTGRES_USER" -d dbname1 -v ON_ERROR_STOP=1
