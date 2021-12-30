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

case $gridpack in
    *_BBB.*) rivetAnalyses='ATLAS_2021_I1849535';
	     nJetMax=1;
	     qCut=40;;
    *_BB.*) rivetAnalyses='ATLAS_2019_I1764342,ATLAS_2021_I1887997,CMS_2020_I1794169,CMS_2020_I1814328,ATLAS_2021_I1849535';
	    nJetMax=2;
            qCut=40;;
    *_B.*) rivetAnalyses='CMS_2017_I1610623,CMS_2019_I1753680';
           nJetMax=3;
           qCut=40;;
    *_ttB.*) rivetAnalyses='CMS_2018_I1663958';
             nJetMax=1;
             qCut=80;;
    *_tt.*) rivetAnalyses='CMS_2018_I1663958';
            nJetMax=2;
            qCut=80;;
    *_tB.*) rivetAnalyses='CMS_2018_I1686000';
            nJetMax=2;
            qCut=60;;
    *_t.*) rivetAnalyses='CMS_2019_I1744604';
           nJetMax=3;
           qCut=60;;
    *_LLB.*) rivetAnalyses='ATLAS_2021_I1849535';
             nJetMax=1;
             qCut=40;;
    *_LL.*)rivetAnalyses='ATLAS_2021_I1849535';
           nJetMax=2;
           qCut=40;;
    *_H.*) rivetAnalyses='ATLAS_2020_I1790439,ATLAS_2021_I1849535';
           nJetMax=3;
           qCut=40;;
    *_vbf.*) rivetAnalyses='ATLAS_2020_I1803608';
             nJetMax=3;
             qCut=40;;
esac

#--------------------------------------------------------------------------------------------------------------------------

$prodBase/runGridpack.sh $gridpack $seed $nEvents $outputDir

cp $pythiaCard .
sed s/N_JET_MAX/$nJetMax/g $pythiaCard --in-place
sed s/Q_CUT/$qCut/g        $pythiaCard --in-place
$prodBase/runPythiaDelphesRivet.sh $outputDir/unweighted_events.lhe.gz `basename $pythiaCard` $delphesCard $rivetAnalyses $outputDir $runRivet #take modified pythia card from working directory (no placeholders)
