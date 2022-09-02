#!/bin/bash -x

processes="W Z tt" #"H vbf B BB BBB tt t tB ttB LL LLB" #vbf-B vbf-H
energies="13 100"

if [[ $# > 0 ]]; then
    test=$1
else
    test=0
fi

##############################################
rm $prodBase/gridpacks/*

cd $prodBase/run
echo "set run_mode 0\nsave options" | ${prodBase}/MG5_aMC_v3_3_1/bin/mg5_aMC
for process in $processes; do
    for E in $energies; do
	sample=${E}TeV_${process}
	source $prodBase/commonParameters.sh #set nJetMax and qCut for this sample
	
	if [[ -d $sample ]]; then rm -rf $sample; fi

	python ${prodBase}/makeGridPacks.py $E $process $nJetMax $xqCut $test

        # Run once in regular mode to get the SubProcess info for reweighting...
	echo ">> Getting subproc"
        # LINE 307
        python ${prodBase}/MG5_aMC_v3_3_1/bin/mg5_aMC < ${sample}.mg
        RET=$?
        if [ $RET -ne 0 ]; then
            1>&2 echo "MG failed with exit code $RET"
            exit 1
        fi
        echo "Got return $RET"
        pushd ${sample}
        
        # ... then add the reweighting shared libs
        if [[ -d tarball ]]; then rm -rf tarball; fi
        mkdir -p tarball
	tar -C tarball -xzf run_01_gridpack.tar.gz
        cd tarball
        # Run once to get events
        ./run.sh 500 1
        mkdir -p madevent/Events/pilotrun
        cp events.lhe.gz madevent/Events/pilotrun/unweighted_events.lhe.gz
        cd madevent
        # Don't know how to suppress it asking Qs. Apparently -f doesn't work
        echo 0 | bin/madevent --debug reweight pilotrun
        ${prodBase}/make_makefile.sh > makefile
        make -j 48 all
        echo "mg5_path = ../../MG5_aMC_v3_3_1" >> Cards/me5_configuration.txt
        echo "cluster_temp_path = None" >> Cards/me5_configuration.txt
        echo "run_mode = 0" >> Cards/me5_configuration.txt
        pwd
        # Cleanup unecessary files
        # taken from https://github.com/cms-sw/genproductions/blob/master/bin/MadGraph5_aMCatNLO/Utilities/cleangridmore.sh
        du -ckhs .
        find ./ -name "*.lhe" | xargs -r rm
        find ./ -name "*.lhe.gz" | xargs -r rm
        find ./ -name "*.lhe.rwgt" | xargs -r rm
        find ./ -name "check_poles" | xargs -r rm
        find ./ -name "test_MC" | xargs -r rm
        find ./ -name "test_ME" | xargs -r rm
        find ./ -name "*.f" | xargs -r rm
        find ./ -name "*.F" | xargs -r rm
        find ./ -name "*.cc" | xargs -r rm
        find ./ -name "*.html" | xargs -r rm
        find ./ -name "gensym" | xargs -r rm
        find ./ -name "ftn25" | xargs -r rm
        find ./ -name "ftn26" | xargs -r rm
        find ./ -name "core.*" | xargs -r rm
        find ./ -name "LSFJOB_*" | xargs -r rm -r
        find ./ -wholename "*SubProcesses/*/*.o" | xargs -r rm
        du -ckhs .
        cd ..
        tar czf ${prodBase}/gridpacks/${sample}.tar.gz madevent/ run.sh 
        popd
        
	if [[ $test == 1 ]]; then break; fi
    done
    if [[ $test == 1 ]]; then break; fi
done
