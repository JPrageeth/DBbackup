#System Name : Mysql DB Backup Programe
#Create Date : 14/03/06
#Create By   : Prageeth Sudarshana


#!/bin/sh

# ----- Data Base Setting -----

# Data base setting
DBNAME=#database name
DBUSER=#user name
DBPASS=#password
DBHOST=#host name

PATH=/bin:/usr/bin:/usr/local/bin

# Saving Dates
bk_days=30 # Delete data after 30days


# Backup dir
bk_dir=/home/アカウント/mysqldb/



# ---------- Make Date & file ----------

# Make time
TSNOW=`date +%Y%m%d%H`

# File name setting
file_temp=mysqldb_$TSNOW.sql
file_backup=mysqldb_$TSNOW.tar.gz

# ---------- Programing ----------
# Move data backup dir
cd $bk_dir
if [ $? != 0 ]; then
echo "Backup directory does not exist."
exit 1
fi

# DB backup setting
mysqldump -Q -h $DBHOST -u $DBUSER -p$DBPASS --default-character-set=binary $DBNAME > $file_temp
if [ $? != 0 -o ! -e $file_temp ]; then
echo "Cannot dump database."
exit 1
fi

# Check file 
tar cfz $file_backup $file_temp
if [ $? != 0 -o ! -e $file_backup ]; then
echo "Cannot archive files."
exit 1
fi

# Delete temper file
rm -f $file_temp

# Delete Old files
find $bk_dir -name "*.tar.gz" -mtime +$bk_days -exec rm -f {} \;
ls -l $bk_dir


exit 0
