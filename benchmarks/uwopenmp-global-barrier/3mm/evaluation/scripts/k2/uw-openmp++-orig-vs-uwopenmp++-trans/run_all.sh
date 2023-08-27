if [ $# -ne 3 ]
then
  echo "usage: ./run_all.sh <SIZE_START> <SIZE_END> <NRUNS>"
  exit
fi
SIZE_START=$1
SIZE_END=$2
i=$SIZE_START
NRUNS=$3
iend=`echo $SIZE_END + 1 | bc -l`;
while [ $i -lt $iend ];
do 
 echo `date` >> results.txt 
 #./script.sh $i $NRUNS "ICS" 64;
 ./script.sh $i $NRUNS "NOOPT" 64;
 ./script.sh $i $NRUNS "CPS" 64;
 ./script.sh $i $NRUNS "OPT" 64;
 i=`echo $i \* 2 | bc -l`;
done
