#!/bin/bash -xe

if [[ $# > 3 ]]; then
    gridpack=$1
    seed=$2
    nEvents=$3
    outputDir=$4
else
    echo "Usage: ./runGridpack.sh <gridpack> <seed> <nEvents> <outputDir>"
    echo "./runGridpack.sh /work/jstupak/prod/MCProd/run/gridpacks/100TeV_B.tar.gz 1 100 $PWD/run"
    exit
fi

if [[ ! -d run ]]; then mkdir run; fi
cd run

cp $gridpack .
tar -xzvf $gridpack

./run.sh $nEvents $seed
mv events.lhe.gz $outputDir/unweighted_events.lhe.gz
