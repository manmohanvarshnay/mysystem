#!/bin/bash


PATHS="/"
HOSTNAME=$(hostname)
CRITICAL=98
WARNING=90
CRITICALMAIL="manmohanvarshnay@yahoo.com"
WARNMAIL="manmohanvarshnay@yahoo.com"
mkdir -p /home/ec2-user/cputilhist
LOGFILE=/home/ec2-user/cputilhist/cpuusage-`date +%h%d%y`.log
touch $LOGFILE
for path in $PATHS
do 
	CPULOAD=`top -b -n 2 d1 | grep "Cpu(s)" | tail -n1 | awk '{print $2}' | awk -F. '{print $1}'`
if [ -n $WARNING -a -n $CRITICAL ]; then
if [ "$CPULOAD" -ge $WARNING -a "$CPULOAD" -lt "$CRITICAL" ]; then
echo "`date "+%F %H:%M:%S"` WARNING - $CPULOAD on host $HOSTNAME" >> $LOGFILE
#echo "warning  cpuload $CPULOAD host is $HOSTNAME" | mail -s "CPULOAD is warning" $WARNMAIL
exit 1
elif [ "$CPULOAD" -gt "$CRITICAL" ]; then
echo "`date "+%F %H:%M:%S"` CRITICAL - $CPULOAD on host $HOSTNAME" >> $LOGFILE
#echo "Critical cpuload $CPULOAD host is $HOSTNAME" | mail -s "CPULOAD is CRITICAL" $CRITICALMAIL
exit 2
else
echo "`date "+%F %H:%M:%S"` OK - $CPULOAD on host $HOSTNAME" >> $LOGFILE
exit 0
fi
fi 
done




