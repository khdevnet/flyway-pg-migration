#!/bin/sh
# Backup all databases declarated in "backupDbs" array.

backupFolder="./backups"
backupZipFileName="./backup-latest.tar.gz"
psqlUsername=""
psqlHost=""
psqlPort="" 
export PGPASSWORD="" 

removeFolder () {
  [ -e $1 ] && rm -r $1
}

echo "### Backup to temp folder $backupFolder ###"
removeFolder $backupFolder
mkdir "$backupFolder" 

echo "### Backup databases ###"
backupDbs=(dbname1 dbname2)
echo "### ${backupDbs[*]} ###"
for dbName in ${backupDbs[@]}; do
   mkdir "$backupFolder/$dbName"
   pg_dump -x --exclude-table=snpshot* -h "$psqlHost" -p "$psqlPort" -U "$psqlUsername" $dbName | split -b 1000m - "$backupFolder/$dbName/$dbName-"
done

export PGPASSWORD=""

echo "### Remove unuse sql scripts ###"
for file in $backupFolder/*/*-aa
do
   echo $file
   sed -i "/edb_redwood_date\|default_with_rowids\|edb_dblink_libpq\|edb_dblink_oci\|pldbgapi/d" "$file"
done 

echo "### Zip backups $backupZipFileName ###"
tar -zcvf "$backupZipFileName" "$backupFolder/"

echo "Remove temp backups folder: $backupFolder"
removeFolder $backupFolder

echo "### Backups: ${backupDbs[*]} ###"
echo "### Run command to restore backups ###"
echo "$ restore-backup.sh $backupZipFileName"
exit 0
