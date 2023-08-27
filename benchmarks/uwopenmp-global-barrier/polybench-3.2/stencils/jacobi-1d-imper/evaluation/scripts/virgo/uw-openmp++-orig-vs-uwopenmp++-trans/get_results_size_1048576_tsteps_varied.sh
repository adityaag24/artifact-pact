i=50
STEPS=10
while [ $i -lt 220 ]
do
./script.sh 32000 $i 5
i=`echo $i + $STEPS | bc -l`
done
