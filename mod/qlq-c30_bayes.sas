
proc import datafile='H:/qlq-c30_data_l.csv' 
            out=qlq_c30_data_l replace;
run;

proc sort data=qlq_c30_data_l;
 by variable_name USUBJID AVISIT_N;
run;

PROC GENMOD data = qlq_c30_data_l ;
 BAYES NBI=1000 NMC=10000 THINNING=5 SEED=123 OUTPOST=qlqc30_data_post PLOTS=NONE;
 BY variable_name;
 /* WHERE variable_name = 'QL'; */
 CLASS USUBJID AVISIT_N ARM;
 MODEL value = AVISIT_N*ARM / NOINT;
 REPEATED SUBJECT=USUBJID / type=ar(1);
 LSMEANS AVISIT_N*ARM;
run;

proc export data=qlqc30_data_post
 outfile='H:/qlq-c30_bayes.csv' replace;
run;
