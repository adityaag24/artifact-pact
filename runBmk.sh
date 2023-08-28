if [ $# -lt 1 ]
then
	echo -e "Setting Number of Threads to the maximum."
	export OMP_NUM_THREADS=$(nproc)
else
	echo -e "Setting Number of Threads to the parameter given."
	export OMP_NUM_THREADS=$1
fi
BASE=$(pwd)
echo -e "Building Point-to-Point Benchmarks"
./compileBmkP2P.sh $BASE/reduciblePhasers/benchmarks/Artifact-P2P TranslatorDriver
echo -e "Building Global Barrier (Without Reduction) Benchmarks"
./compileBmkNoRed.sh $BASE/reduciblePhasers/benchmarks/Artifact-GBNR TranslatorDriverStatic
echo -e "Building Global Barrier (With    Reduction) Benchmarks"
./compileBmkRed.sh $BASE/reduciblePhasers/benchmarks/Artifact-GBR TranslatorDriverStatic
