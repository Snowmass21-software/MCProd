from sys import argv
E=int(argv[1])
process=argv[2]
sample="%iTeV_%s"%(E,process)
nJetMax=int(argv[3])
qCut=int(argv[4])
if len(argv)>5: test=bool(int(argv[5]))

import os

definitions="""define p = g u c d s u~ c~ d~ s~
define j = g u c d s u~ c~ d~ s~ b b~
define l+ = e+ mu+ ta+
define l- = e- mu- ta-
define vl = ve vm vt
define vl~ = ve~ vm~ vt~

define lept = l+ l- vl vl~
define W = W+ W-
define bos = Z W
define top = t t~
"""

common='%s $ top bos h'

"""
processes={
"B":
["bos j %s"%common],

"vbf-B":
["bos j j %s QCD=nQCD"%common],

"vbf-H":    
["h j j %s QCD=nQCD"%common],

"BB":
["bos bos %s"%common],

"BBB":
["bos bos bos %s"%common],

"BH":
["bos h %s"%common],

"tB":
["top bos %s"%common],

"t":
["top j %s"%common],

"tt":
["top top %s"%common],

"ttB":
["top top bos %s"%common],

"ttH":    
["top top h %s"%common],

"H":
["h %s HIG=1 HIW=0"%common],

"LL":
["lept lept %s"%common],

"LLB":
["lept lept bos %s"%common],
}
"""

#2013 style
processes={
"B":
["bos %s"%common],

"W":
["W %s"%common],

"Z":
["Z %s"%common],    
    
"vbf":
["bos j j %s QCD=nQCD"%common,
"h j j %s QCD=nQCD"%common],

"BB":
["bos bos %s"%common],

"BBB":
["bos bos bos %s"%common,
"bos h %s"%common],

"tB":
["top bos %s"%common],

"t":
["top j %s"%common],

"tt":
["top top %s"%common],

"ttB":
["top top bos %s"%common,
"top top h %s"%common],

"H":
["h %s HIG=1 HIW=0"%common],
  
"LL":
["lept lept %s"%common],

"LLB":
["lept lept bos %s"%common],
}

import os
import subprocess
f=open(sample+'.mg','w')
if __name__=='__main__':
    f.write(definitions+'\n')
    f.write('set lhapdf_py3 /cvmfs/sft.cern.ch/lcg/views/LCG_101/x86_64-centos7-gcc8-opt/bin/lhapdf-config\n')
    
    command=processes[process]
    #n=len(command[0].split('%')[0].split())

    if process=='H':
        f.write('set auto_convert_model T\n')
        f.write('import model heft\n')

    for i in range(len(command)):
        nJetMin=command[i].count(" j")
        for j in range(0,nJetMax-nJetMin+1):
            if i==0 and j==0: f.write('generate p p > '+command[i].replace('nQCD',str(j))%('j '*j)+'\n')
            else:          f.write('add process p p > '+command[i].replace('nQCD',str(j))%('j '*j)+'\n')
            if j==1 and test: break
        if test: break

    f.write('output %sTeV_%s\n'%(E,process))
    f.write('launch %sTeV_%s\n'%(E,process))
    f.write('reweight=ON\n')
    f.write('done\n')
    #if not test:
    f.write('%s/Cards/run_card.dat\n'%os.environ['prodBase'])
    f.write('set xqcut %i\n'%qCut)

    f.write('set nevents = 500\n')
    f.write('set gridpack = .true.\n')
    f.write('set run_mode = 2\n')  #this doesn't work
    if process not in ['vbf']:
        f.write('set bias_module HT\n')
    if E==13:f.write('set bias_parameters = {\'ht_bias_min\':10.0}\n')
    else:    f.write('set bias_parameters = {\'ht_bias_min\':100.0}\n')

    f.write('set ebeam1 = %i\n'%(1000*E/2))
    f.write('set ebeam2 = %i\n'%(1000*E/2))
    
    if process in ['t','tB','vbf']:
        f.write('set auto_ptj_mjj False\n')
        
    f.write('done\n')
    f.write('\n')

    """
    pythiaCard=open('%s/pythia8_card.dat'%sample,'w')    
    for line in open(os.environ['prodBase']+'/Cards/pythia8_card.dat'):
        pythiaCard.write(line.replace('Q_CUT',str(qCut)).replace('N_JET_MAX',str(nJetMax)))
    pythiaCard.close()
    """
