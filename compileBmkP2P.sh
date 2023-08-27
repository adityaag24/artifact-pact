#!/bin/bash
#Obtain the root folder containing the test-programs to run
if [ $# -lt 2 ]; 
then
	echo -e "Usage: ./compileBmk.sh <Folder To Test Benchmarks> <.java file for your Project>"
else
	BASE=$(pwd)
	TESTROOT=$(readlink -f $1)
	echo "Benchmarks will be taken from this folder = $TESTROOT"
	DATE=$(date | tr ' ' '_' | tr ':' '_')
	ERRFILE=$BASE/output-dump/errStream${DATE}.err
	IMOPHOME=$BASE
	pushd $TESTROOT
	mkdir -p bin
	for FILE in $(ls *.c)
	do
		echo -e "Preprocessing $FILE using gcc"
		echo -e "Preprocessing $FILE using gcc" >> $ERRFILE
		FILENAME=$(echo $FILE | cut -f1 -d.)
		PREFILE=${TESTROOT}/${FILENAME}.i
		gcc -P -E $FILE -o $PREFILE
	done
	for FILE in $(ls *.i)
	do
		echo -e "Processing File $FILE"
		echo "Processing $FILE" >> $ERRFILE
		FILENAME=$(echo $FILE | cut -f1 -d.)
		cd $IMOPHOME/bin
		java -da -Xms2048M -Xmx4096M -cp ${IMOPHOME}/third-party-tools/com.microsoft.z3.jar:. imop.$2 -nru -f $TESTROOT/$FILE  
		if [ ! -f "$IMOPHOME/output-dump/$FILENAME-processed.i" ]
		then
			echo "Could not generate the processed file. Exiting..."
			#echo -e "DUMP: $(cat $ERRFILE)"
			continue
		fi	
		mv $IMOPHOME/output-dump/$FILENAME-processed.i $TESTROOT/bin/$FILENAME-processed.i
		echo -e "\n$FILE Processing Complete."
		echo -e "Compiling Processed Benchmark $FILENAME-processed.i\n\n"
                gcc -fopenmp -O3 -o $TESTROOT/bin/$FILENAME $TESTROOT/bin/$FILENAME-processed.i
                #$TESTROOT/bin/$FILENAME $TESTROOT/input-$FILENAME.txt --in $TESTROOT/input-$FILENAME.txt --verify
		$TESTROOT/bin/$FILENAME
		echo -e "\n\n$FILENAME Complete."
	done
fi
