#!/bin/bash -xe

if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

if [[ ! -d gridpacks ]]; then mkdir gridpacks; fi

if [[ ! -d run ]]; then mkdir run;
#else rm -rf run/*;
fi
cd run
../makeGridPacks.sh 1

cp ../gridpacks/13TeV_H.tar.gz .
tar -xzvf 13TeV_H.tar.gz

#MadGraph
#sed 's%${DIR}/bin/gridrun $num_events $seed $gran%python ${DIR}/bin/gridrun $num_events $seed $gran%' run.sh --in-place
./run.sh 10 8
gunzip events.lhe.gz
mv events.lhe unweighted_events.lhe

#Pythia
$prodBase/MG5_aMC_v3_3_1/HEPTools/MG5aMC_PY8_interface/MG5aMC_PY8_interface $prodBase/Cards/pythia8_card_noPlaceholders.dat #take local copy without placeholders

#Delphes
if [[ -e unweighted_events.root ]]; then rm unweighted_events.root; fi
DelphesHepMC2 $prodBase/delphes/cards/gen_card.tcl unweighted_events.root $prodBase/run/unweighted_events.hepmc

#Rivet
rivet --analysis=MC_GENERIC $prodBase/run/unweighted_events.hepmc
rivet-mkhtml Rivet.yoda
