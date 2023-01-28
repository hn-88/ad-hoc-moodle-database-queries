# partial script - did not complete since Google Sheets cannot deal with more than 400,000 cells for csv import
#!/bin/bash
# Adapted from Shell script to backup MySql database
# https://www.cyberciti.biz/nixcraft/vivek/blogger/2005/01/mysql-backup-script.html
# -------------------------------------------------------------------------
# The original script is part of nixCraft shell script collection (NSSC)
# Visit http://bash.cyberciti.biz/ for more information.
# -------------------------------------------------------------------------

MyUSER=""     # USERNAME
MyPASS=""       # PASSWORD
MyHOST="localhost"          # Hostname
Month="01"
Year="2022"
StartDate=`date "+%s" -d "$Month/01/2022 00:00:01"`
EndDate=`date "+%s" -d "02/01/2022 00:00:00"`
#echo $StartDate
#echo $EndDate

# Linux bin paths, change this if it can not be autodetected via which command
MYSQL="$(which mysql)"
MYSQL="$(which mysql)"
CHOWN="$(which chown)"
CHMOD="$(which chmod)"
GZIP="$(which gzip)"

# Backup Dest directory, change this if you have someother location
DEST="/home/ouruser/db-backups-temp"

# Main directory where backup will be stored
MBD="$DEST/mysql"

# Get hostname
HOST="$(hostname)"

# Get data in dd-mm-yyyy format
NOW="$(date +"%d-%m-%Y")"

# File to store current backup file
FILE=""
# Store list of databases
DBS="sssvv_learning_master_db"
TABLE="logtable"
# DO NOT BACKUP these databases
IGGY=""

[ ! -d $MBD ] && mkdir -p $MBD || :
FILE=""
# Store list of databases
DBS="sssvv_learning_master_db"
TABLE="logtable"
# DO NOT BACKUP these databases
IGGY=""

[ ! -d $MBD ] && mkdir -p $MBD || :

# Only root can access it!
$CHOWN 0.0 -R $DEST
$CHMOD 0600 $DEST

# Get all database list first
#DBS="$($MYSQL -u $MyUSER -h $MyHOST -p$MyPASS -Bse 'show databases')"

        FILE="$MBD/$DBS.$TABLE.$NOW.csv"
        #echo $FILE # do all inone job in pipe,
        # connect to mysql for select mysql database
        # and pipe it out
        $MYSQL --batch -u $MyUSER -h $MyHOST -p$MyPASS $DBS -e "select l.id, l.timecreated, l.userid, l.ip, f.filename from prefix_logstore_standard_log l le
ft join prefix_files f on l.contextid = f.contextid where l.timecreated > $StartDate  and l.timecreated < $EndDate and l.action = 'viewed' and l.target='cour
se_module' and f.filename like '%.ppt%' order by l.timecreated;" > $FILE
