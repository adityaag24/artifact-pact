i=32000
STEPS=4000
while [ $i -lt 66000 ]
do
./script.sh $i 100 5
i=`echo $i + $STEPS | bc -l`
done
