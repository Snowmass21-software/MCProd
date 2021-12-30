#!/bin/bash -x

processes="B BB BBB tt t tB ttB LL LLB vbf H" #vbf-B vbf-H
energies="13 100" #TeV

if [[ $# > 0 ]]; then
    test=$1
else
    test=0
fi

##############################################

for process in $processes; do
    for E in $energies; do
	sample=${E}TeV_${process}
	if [[ -d $sample ]]; then rm -rf $sample; fi

	python ${prodBase}/makeGridPacks.py $E $process $test

	python ${prodBase}/MG5_aMC_v3_3_1/bin/mg5_aMC < ${sample}.mg

	tar -xzvf $sample/run_01_gridpack.tar.gz
	
	cd madevent
	./bin/compile
	./bin/clean4grid
	cd ..
	chmod a+x run.sh
	tar -czvf ${prodBase}/gridpacks/${sample}.tar.gz madevent run.sh
	rm -rf madevent

	if [[ $test == 1 ]]; then break; fi
    done
    if [[ $test == 1 ]]; then break; fi
done
