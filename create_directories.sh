mkdir -p /u01/app/oracle/product/19.0.0/dbhome_1
mkdir -p /u02/oradata
mkdir /home/oracle/scripts
chown -R oracle:oinstall /u01 /u02 /home/oracle/scripts
chmod -R 775 /u01 /u02 /home/oracle/scripts

echo "Finished creating directories for Oracle database"
