if [ $# -ne 4 ]
then
  echo "usage: ./run_all.sh <SIZE_START> <SIZE_END> <TSTEP_START> <TSTEP_END>"
  exit
fi
SIZE_START=$1
SIZE_END=$2
TSTEP_START=$3
TSTEP_END=$4
i=$SIZE_START
iend=`echo $SIZE_END + 1 | bc -l`;
while [ $i -lt $iend ];
do 
 j=$TSTEP_START;
 jend=`echo $TSTEP_END + 1 | bc -l`;
 while [ $j -lt $jend ];
 do
./script.sh $i $j 5 "ICS" 64;
     ./script.sh $i $j 5 "NOOPT" 64;
./script.sh $i $j 5 "CPS" 64;
./script.sh $i $j 5 "OPT" 64;
     j=`echo $j \* 2 | bc -l`;
 done
 i=`echo $i \* 2 | bc -l`;
done
