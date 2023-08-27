echo -e "Building Point-to-Point Benchmarks"
./compileBmkP2P.sh /mnt/c/Users/AdityaAgrawal/Research/Artifact/imop/reduciblePhasers/benchmarks/Artifact-P2P TranslatorDriver
echo -e "Building Global Barrier (Without Reduction) Benchmarks"
./compileBmkNoRed.sh /mnt/c/Users/AdityaAgrawal/Research/Artifact/imop/reduciblePhasers/benchmarks/Artifact-GBNR TranslatorDriverStatic
echo -e "Building Global Barrier (With    Reduction) Benchmarks"
./compileBmkRed.sh /mnt/c/Users/AdityaAgrawal/Research/Artifact/imop/reduciblePhasers/benchmarks/Artifact-GBR TranslatorDriverStatic
