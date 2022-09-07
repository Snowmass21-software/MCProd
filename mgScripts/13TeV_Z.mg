define p = g u c d s u~ c~ d~ s~
define j = g u c d s u~ c~ d~ s~ b b~
define l+ = e+ mu+ ta+
define l- = e- mu- ta-
define vl = ve vm vt
define vl~ = ve~ vm~ vt~

define lept = l+ l- vl vl~
define W = W+ W-
define bos = Z W
define top = t t~

set lhapdf_py3 /cvmfs/sft.cern.ch/lcg/views/LCG_101/x86_64-centos7-gcc8-opt/bin/lhapdf-config
generate p p > Z  $ top bos h
add process p p > Z j  $ top bos h
add process p p > Z j j  $ top bos h
add process p p > Z j j j  $ top bos h
output 13TeV_Z
launch 13TeV_Z
reweight=ON
done
/work/jstupak/prod/MCProd/Cards/run_card.dat
set xqcut 40
set gridpack = .true.
set ebeam1 = 6500
set ebeam2 = 6500
done

