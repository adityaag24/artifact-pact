i=8192
while [ $i -lt 1048576 ]
do
./script.sh $i 100 1
i=`echo $i \* 2 | bc -l`
done
