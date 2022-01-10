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

source /cvmfs/sft.cern.ch/lcg/releases/LCG_99/ROOT/v6.22.06/x86_64-centos7-gcc8-opt/ROOT-env.sh
source /cvmfs/sft.cern.ch/lcg/views/LCG_99/x86_64-centos7-gcc8-opt/setup.sh  #for LHAPDF

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${prodBase}/lib:$prodBase/delphes #:${prodBase}/MG5_aMC_v3_3_1/HEPTools/lhapdf6_py3/lib
export PATH=$PATH:${prodBase}/bin:$prodBase/delphes:/cvmfs/sft.cern.ch/lcg/external/texlive/2016/bin/x86_64-linux
export PYTHONPATH=$PYTHONPATH:$PWD/lib/python3.8/site-packages
export LHAPDF_DATA_PATH=/cvmfs/sft.cern.ch/lcg/external/lhapdfsets/current/:/cvmfs/sft.cern.ch/lcg/views/LCG_99/x86_64-centos7-gcc8-opt/share/LHAPDF/
export ROOT_INCLUDE_PATH=$prodBase/delphes/external  #fixes issues related to missing libraries needed by delphes
