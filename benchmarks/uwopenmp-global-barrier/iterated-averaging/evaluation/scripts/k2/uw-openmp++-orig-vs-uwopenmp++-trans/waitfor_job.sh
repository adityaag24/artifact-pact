jobid=$1
jobname=$2
stat="E"
while [ "$stat" != "C" ]
do
  sleep 0.00001
  stat=`qstat $jobid | grep $jobname | awk '{print $5}'`
#  echo "jobstatus = "$stat
done
