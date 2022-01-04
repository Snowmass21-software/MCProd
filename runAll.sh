#!/bin/bash -xe

if [[ $# < 7 ]]; then
    echo "Usage: ./runAll.sh <gridpack> <seed> <nEvents> <pythia card> <delphes card> <outputDir> [runRivet]"
    echo "Example: ./runAll.sh /work/jstupak/prod/MCProd/gridpacks/13TeV_B.tar.gz 1 100 $prodBase/Cards/pythia8_card.dat $prodBase/delphes/cards/FCC/FCChh.tcl $PWD/run 1"
    exit
else
    #for runGridpack.sh
    gridpack=$1
    seed=$2
    nEvents=$3
    #for runPythiaDelphesRivet.sh
    pythiaCard=$4
    delphesCard=$5
    outputDir=$6
    runRivet=$7
fi

#--------------------------------------------------------------------------------------------------------------------------
sample=`basename $gridpack`
sample=${sample%%.*}
source $prodBase/commonParameters.sh

$prodBase/runGridpack.sh $gridpack $seed $nEvents $outputDir

cp $pythiaCard .
pythiaCard=`basename $pythiaCard`
sed s/N_JET_MAX/$nJetMax/g $pythiaCard --in-place
sed s/Q_CUT/$qCut/g        $pythiaCard --in-place
$prodBase/runPythiaDelphesRivet.sh $outputDir/unweighted_events.lhe.gz $pythiaCard $delphesCard $rivetAnalyses $outputDir $runRivet #take modified pythia card from working directory (no placeholders)
