#!/bin/bash -a

case $sample in
    *TeV_BBB) rivetAnalyses='ATLAS_2021_I1849535';
	     nJetMax=1;
	     qCut=40;;
    *TeV_BB)  rivetAnalyses='ATLAS_2019_I1764342,ATLAS_2021_I1887997,CMS_2020_I1794169,CMS_2020_I1814328,ATLAS_2021_I1849535';
	     nJetMax=2;
             qCut=40;;
    *TeV_B)   rivetAnalyses='CMS_2017_I1610623,CMS_2019_I1753680';
             nJetMax=3;
             qCut=40;;
    *TeV_ttB) rivetAnalyses='CMS_2018_I1663958';
             nJetMax=1;
             qCut=80;;
    *TeV_tt)  rivetAnalyses='CMS_2018_I1663958';
             nJetMax=2;
             qCut=80;;
    *TeV_tB)  rivetAnalyses='CMS_2018_I1686000';
             nJetMax=2;
             qCut=60;;
    *TeV_t)   rivetAnalyses='CMS_2019_I1744604';
             nJetMax=3;
             qCut=60;;
    *TeV_LLB) rivetAnalyses='ATLAS_2021_I1849535';
             nJetMax=1;
             qCut=40;;
    *TeV_LL)  rivetAnalyses='ATLAS_2021_I1849535';
             nJetMax=2;
             qCut=40;;
    *TeV_H)   rivetAnalyses='ATLAS_2020_I1790439,ATLAS_2021_I1849535';
             nJetMax=3;
             qCut=40;;
    *TeV_vbf) rivetAnalyses='ATLAS_2020_I1803608';
             nJetMax=3;
             qCut=40;;
    *) echo 'ERROR: sample not found';;
esac

echo Setting:
echo rivetAnalyses = $rivetAnalyses
echo nJetMax = $nJetMax
echo qCut = $qCut
