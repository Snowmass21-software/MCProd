#!/bin/bash -xe

if [[ $# < 4 ]]; 
then 
    echo "Usage: ./runPythiaDelphesRivet.sh <LHE> <pythia card> <delphes card> <rivetAnalyses> <outputDir>"
    echo "Example: ./runPythiaDelphesRivet.sh $prodBase/test/unweighted_events.lhe.gz $prodBase/test/pythia8_card.dat $prodBase/delphes/cards/FCC/FCChh.tcl MC_GENERIC $PWD/run"
    exit
else
    lhe=$1
    pythiaCard=$2
    delphesCard=$3
    rivetAnalyses=$4
    outputDir=$5
fi

#########################################################################

if [[ ! -d run ]]; then mkdir run; fi
cd run
if [[ `dirname $lhe` != $PWD ]]; then cp $lhe .
fi					   

if [[ "$lhe" == *".gz" ]]; then
    lhe=${lhe%%.gz}
    gunzip -c $lhe.gz > $lhe
fi
pythiaOutput=${lhe%%.lhe}.hepmc
delphesOutput=${lhe%%.lhe}.root
if [ 1 -eq 0 ]; then
#------------------------------------------------------------------------
#Pythia
set -xe

$prodBase/MG5_aMC_v3_3_1/HEPTools/bin/MG5aMC_PY8_interface $pythiaCard 

#------------------------------------------------------------------------
#Delphes

if [[ -e $delphesOutput ]]; then rm $delphesOutput; fi
pwd
DelphesHepMC2 $delphesCard $delphesOutput $pythiaOutput

#------------------------------------------------------------------------
#Rivet

if [[ $runRivet && ! $rivetAnalyses ]]; then exit; fi
fi
rivet --analysis=$rivetAnalyses $pythiaOutput
export PATH=$PATH:/cvmfs/sft.cern.ch/lcg/external/texlive/2021/bin/x86_64-linux/:$prodBase/bin
rivet-mkhtml Rivet.yoda

#for dir in ${rivetAnalyses//,/ }; do
#mv $prodBase/run/rivet-plots/$d $outputDir
#done
