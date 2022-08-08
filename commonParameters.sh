#!/bin/bash -a

case $sample in
    *TeV_BBB) rivetAnalyses='ATLAS_2017_I1644367,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
	     nJetMax=1;
	     xqCut=40;;
    *TeV_BB)  rivetAnalyses='ATLAS_2019_I1764342,ATLAS_2021_I1887997,CMS_2020_I1794169,CMS_2020_I1814328,ATLAS_2021_I1849535,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
	     nJetMax=2;
             xqCut=40;;
    *TeV_B)   rivetAnalyses='CMS_2017_I1610623,CMS_2019_I1753680,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=3;
             xqCut=40;;
    *TeV_ttB) rivetAnalyses='ATLAS_2018_I1707015,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=1;
             xqCut=80;;
    *TeV_tt)  rivetAnalyses='CMS_2018_I1663958,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=2;
             xqCut=80;;
    *TeV_tB)  rivetAnalyses='CMS_2018_I1686000,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=2;
             xqCut=60;;
    *TeV_t)   rivetAnalyses='CMS_2019_I1744604,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=3;
             xqCut=60;;
    *TeV_LLB) rivetAnalyses='ATLAS_2021_I1849535,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=1;
             xqCut=40;;
    *TeV_LL)  rivetAnalyses='ATLAS_2021_I1849535,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=2;
             xqCut=40;;
    *TeV_H)   rivetAnalyses='ATLAS_2020_I1790439,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=3;
             xqCut=40;;
    *TeV_vbf) rivetAnalyses='ATLAS_2020_I1803608,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=3;
             xqCut=40;;
    *mg_pp_aa012j_5f) rivetAnalyses='ATLAS_2021_I1887997,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=2;
             xqCut=20.0 ;;
    *mg_pp_h012j_5f) rivetAnalyses='ATLAS_2020_I1790439,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=2;
             xqCut=30.0 ;;
    *mg_pp_ll012j_5f) rivetAnalyses='CMS_2019_I1753680,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=2;
             xqCut=30.0 ;;
    *mg_pp_llv01j_5f) rivetAnalyses='CMS_2017_I1610623,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=1;
             xqCut=40.0 ;;
    *mg_pp_t123j_5f) rivetAnalyses='CMS_2019_I1744604,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=3;
             xqCut=40.0 ;;
    *mg_pp_tt012j_5f) rivetAnalyses='CMS_2018_I1663958,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=2;
             xqCut=60.0 ;;
    *mg_pp_ttv01j_5f) rivetAnalyses='ATLAS_2018_I1707015,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=1;
             xqCut=80.0 ;;
    *mg_pp_v0123j_5f) rivetAnalyses='CMS_2017_I1610623,CMS_2019_I1753680,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=3;
             xqCut=30.0 ;;
    *mg_pp_vbf_h01j_5f) rivetAnalyses='ATLAS_2020_I1803608,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=3;
             xqCut=40.0 ;;
    *mg_pp_vbf_v01j_5f) rivetAnalyses='ATLAS_2020_I1803608,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=3;
             xqCut=40.0 ;;
    *mg_pp_vh012j_5f) rivetAnalyses='ATLAS_2017_I1644367,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=2;
             xqCut=40.0 ;;
    *mg_pp_vv012j_5f) rivetAnalyses='ATLAS_2019_I1764342,ATLAS_2021_I1887997,CMS_2020_I1794169,CMS_2020_I1814328,ATLAS_2021_I1849535,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=2;
             xqCut=40.0 ;;
    *mg_pp_vvv01j_5f) rivetAnalyses='ATLAS_2017_I1644367,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=1;
             xqCut=60.0 ;;
    *mg_pp_w0123j_4f) rivetAnalyses='CMS_2017_I1610623,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=3;
             xqCut=30.0 ;;
    *mg_pp_wz012j_4f) rivetAnalyses='CMS_2020_I1794169,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=2;
             xqCut=40.0 ;;
    *mg_pp_z0123j_4f) rivetAnalyses='CMS_2019_I1753680,MC_FSPARTICLES,MC_WEIGHTS,MC_KTSPLITTINGS';
             nJetMax=3;
             xqCut=30.0 ;;
    *) echo 'ERROR: sample not found';;
esac

echo Setting:
echo rivetAnalyses = $rivetAnalyses
echo nJetMax = $nJetMax
echo xqCut = $xqCut
