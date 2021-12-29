if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

#source $prodBase/setup.sh

if [[ ! -d run ]]; then mkdir run;
else rm -rf run/*;
fi
cd run
../makeGridPacks.sh 1
cd ..

if [[ ! -d test ]]; then mkdir test;
else rm -rf test/*;
fi
cd test
cp ../run/gridpacks/13TeV_B.tar.gz .
tar -xzvf 13TeV_B.tar.gz

#MadGraph
sed 's%${DIR}/bin/gridrun $num_events $seed $gran%python ${DIR}/bin/gridrun $num_events $seed $gran%' run.sh --in-place
./run.sh 10 8
gunzip events.lhe.gz
mv events.lhe unweighted_events.lhe

#Pythia
#$prodBase/MG5_aMC_v3_3_1/HEPTools/MG5aMC_PY8_interface/MG5aMC_PY8_interface $prodBase/Cards/pythia8_card_kk.dat
$prodBase/MG5_aMC_v3_3_1/HEPTools/MG5aMC_PY8_interface/MG5aMC_PY8_interface $prodBase/run/pythia8_card.dat #take local copy without placeholders


#Delphes
$prodBase/delphes/DelphesHepMC2 $prodBase/delphes/cards/gen_card.tcl unweighted_events.root $prodBase/test/unweighted_events.hepmc

#Rivet
rivet --analysis=MC_GENERIC $prodBase/test/unweighted_events.hepmc
rivet-mkhtml Rivet.yoda
