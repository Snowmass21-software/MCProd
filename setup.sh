if [[ `basename $PWD` != "MCProd" ]]; then echo "Execute from MCProd dir"; exit; fi

export prodBase=$PWD
unset PYTHONPATH
unset PYTHONHOME

if [[ $HOSTNAME == "login.snowmass21.io" ]]; then
    module purge
    module use /software/modulefiles
 
    module load python/3.7.0
    module load gcc-8.2.0
    module load cmake
    
    module load py-numpy/1.15.2-py3.7
    module load py-six/1.11.0-py3.7
    
    module load emacs
# else
#     which root >> /dev/null
#     if [[ $? -ne 0 ]]; then
# 	echo "Please ensure ROOT is available and retry"
# 	exit
#     fi
fi

#source /cvmfs/sft.cern.ch/lcg/releases/LCG_101/ROOT/v6.22.06/x86_64-centos7-gcc8-opt/ROOT-env.sh
source /cvmfs/sft.cern.ch/lcg/views/LCG_101/x86_64-centos7-gcc8-opt/setup.sh

export PYTHIA8DATA=$prodBase/MG5_aMC_v3_3_1/HEPTools/pythia8/share/Pythia8/xmldoc
export PATH=/cvmfs/sft.cern.ch/lcg/external/texlive/2020/bin/x86_64-linux/:$PATH:${prodBase}/bin
export LHAPDF_DATA_PATH=/cvmfs/sft.cern.ch/lcg/external/lhapdfsets/current/:/cvmfs/sft.cern.ch/lcg/views/LCG_101/x86_64-centos7-gcc8-opt/share/LHAPDF/
