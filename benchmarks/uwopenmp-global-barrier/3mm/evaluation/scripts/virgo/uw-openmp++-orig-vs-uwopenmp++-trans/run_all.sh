if [ $# -ne 2 ]
then
  echo "usage: ./run_all.sh <SIZE_START> <SIZE_END>"
  exit
fi
SIZE_START=$1
SIZE_END=$2
i=$SIZE_START
iend=`echo $SIZE_END + 1 | bc -l`;
while [ $i -lt $iend ];
do 
 echo `date` >> results.txt 
 ./script.sh $i 1 "ICS" 32;
 ./script.sh $i 1 "CPS" 32;
 i=`echo $i \* 2 | bc -l`;
done
