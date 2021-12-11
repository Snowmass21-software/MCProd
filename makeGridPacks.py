definitions="""define p = g u c d s u~ c~ d~ s~ b b~
define j = g u c d s u~ c~ d~ s~ b b~
define l+ = e+ mu+ ta+
define l- = e- mu- ta-
define vl = ve vm vt
define vl~ = ve~ vm~ vt~

define lept = l+ l- vl vl~
define bos = Z W+ W- a
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
["bos j %s"%common],

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

xqcut={
    'B':40,
    'vbf':40,
    'BB':40,
    'BBB':40,
    'tB':60,
    't':60,
    'tt':80,
    'ttB':80,
    'H':40,
    'LL':40,
    'LLB':40
}

import os
if __name__=='__main__':
    # Parse arguments
    from sys import argv,exit

    if len(argv)<3:
        print('usage: {} E process [test]'.format(argv[0]))
        sys.exit(1)

    E=int(argv[1])
    process=argv[2]
    if len(argv)>3: test=bool(int(argv[3]))

    # Currnt working directory for absolute path for resources
    prodBase=os.path.dirname(os.path.realpath(__file__))

    # Generate MG command
    f=open('makeGridPacks.mg','w')
    f.write(definitions+'\n')

    command=processes[process]
    n=len(command[0].split('%')[0].split())

    if process=='H': f.write('import model heft\n')
    for i in range(len(command)):
        for j in range(5-n):
            if i==0 and j==0: 
                f.write('generate p p > '+command[i].replace('nQCD',str(j))%('j '*j)+'\n')
            else: 
                f.write('add process p p > '+command[i].replace('nQCD',str(j))%('j '*j)+'\n')
            if test: break
        if test: break

    f.write('output %sTeV_%s\n'%(E,process))
    f.write('launch %sTeV_%s\n'%(E,process))
    #f.write('shower = Pythia8\n')
    f.write('reweight=ON\n')
    #f.write('madspin=ON\n')  #causes crash
    f.write('done\n')
    #f.write('%s/Cards/param_card.dat\n'%prodBase)
    f.write('%s/Cards/run_card.dat\n'%prodBase)
    f.write('%s/Cards/pythia8_card.dat\n'%prodBase)
    if process in ['t','tB','vbf']:
        f.write('set auto_ptj_mjj False\n')
    f.write('set gridpack = .true.\n')
    f.write('set ebeam1 = %i\n'%(1000*E/2))
    f.write('set ebeam2 = %i\n'%(1000*E/2))
    f.write('set xqcut %i\n'%xqcut[process])
    f.write('done\n')
    f.write('\n')

