#!/bin/bash +x

if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

Nproc=8
source /cvmfs/sft.cern.ch/lcg/views/LCG_101/x86_64-centos7-gcc8-opt/setup.sh

#MadGraph
wget https://launchpad.net/mg5amcnlo/3.0/3.3.x/+download/MG5_aMC_v3.3.1.tar.gz
tar -xzvf MG5_aMC_v3.3.1.tar.gz
cp -r lepMult/lepMultBias/ MG5_aMC_v3_3_1/Template/LO/Source/BIAS/lepMult
cp -r HT                   MG5_aMC_v3_3_1/Template/LO/Source/BIAS/HT
echo "install pythia8" | python ./MG5_aMC_v3_3_1/bin/mg5_aMC
if [[ $? -ne 0 ]]; then
    echo "ERROR getting madgraph"
    exit
fi

#Dependency needed for rivet
wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9550/ghostscript-9.55.0.tar.gz
tar -xzvf ghostscript-9.55.0.tar.gz
OLDPWD=$PWD
cd ghostscript-9.55.0/
./configure --prefix=$OLDPWD
make  -j${Nproc}
if [[ $? -ne 0 ]]; then
    echo "ERROR installing rivet dependencies"
    exit
fi;
make install
