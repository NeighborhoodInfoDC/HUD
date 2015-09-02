** PROGRAM NAME: CHAS_0610_sum.sas
**
** PROJECT:  DMPED - Affordable Housing Assessment 
**
** DESCRIPTION :  create summary files for Tables 1, 3, 8, and 16. 
**
** ASSISTING PROGRAMS:
** PREVIOUS PROGRAM: CHAS_0610_readin.sas
** FOLLOWING PROGRAM:
**
** AUTHOR      :  Simone Zhang
**
** CREATED     : 2/2/2013
** 
**
*************************************************************************************************************************;
FILENAME MPRINT 'd:\dcdata\MACCODE.SAS'; 
options mprint mfile spool mlogic symbolgen; 

%include "L:\SAS\Inc\StdLocal.sas";
%DCData_lib( HUD )

/*calcuate key variables in tables, get totals based on tenure-spefic variables*/
%macro calc_newvars(tnum, start, end, diff);
	%do i=&start. %to &end.;
	%let j = %eval(&i.+&diff.);
	T&tnum._est&i._t = sum(T&tnum._est&i.,T&tnum._est&j.);
	%end;
%mend calc_newvars;


/*special sums*/
%macro calc_newvarsB(tnum, start, end, diff, rhud);
	%do i=&start. %to &end. %by &diff.;
	%let j = %eval(&i.+1);
	%let k = %eval(&i.+2);
	T&tnum._&rhud._0or1b = sum(T&tnum._&rhud._0or1b,T&tnum._est&i.);
	T&tnum._&rhud._2b = sum(T&tnum._&rhud._2b,T&tnum._est&j.);
	T&tnum._&rhud._3b = sum(T&tnum._&rhud._3b ,T&tnum._est&k.);
	%end;
%mend calc_newvarsB;

%macro create_all_newvars(level, filename, levelshort);
data &level._newvars;
	set HUD.&filename.;
	%calc_newvars(1,2,125,124);
	%calc_newvars(3,2,44,43);
	%calc_newvars(8,2,67,66);
	%calc_newvars(16,2,86,85);
	%calc_newvarsB(15c,6,22,4, less30);
	%calc_newvarsB(15c,27,43,4, 3050);
	%calc_newvarsB(15c,48,64,4, 5080);
	%calc_newvarsB(15c,69,85,4, great80);
run;

data HUD.chas_sum_&levelshort.; 
	set &level._newvars;
	/*all households by cost burden*/
	pay_30p = T8_est4_t + T8_est17_t +T8_est30_t+ T8_est43_t +T8_est56_t; 
	pay_30_50p= T8_est7_t + T8_est20_t + T8_est33_t+T8_est46_t +T8_est59_t;
	pay_50p = T8_est10_t + T8_est23_t + T8_est36_t + T8_est49_t + T8_est62_t;
	pay_unknown = T8_est13_t + T8_est26_t + T8_est39_t + T8_est52_t + T8_est65_t;
	elderly_fam = T16_est5_t + T16_est26_t + T16_est47_t + T16_est68_t;
	elderly_nonfam = T16_est17_t + T16_est38_t +T16_est59_t +T16_est80_t;
	elderly_tot = elderly_fam + elderly_nonfam ;
	rentocc_0or1b = t15c_less30_0or1b + t15c_3050_0or1b + t15c_5080_0or1b  + t15c_great80_0or1b ;
	rentocc_2b = t15c_less30_2b + t15c_3050_2b + t15c_5080_2b  + t15c_great80_2b ;
	rentocc_3b = t15c_less30_3b + t15c_3050_3b + t15c_5080_3b  + t15c_great80_3b ;
	rentocc_all = rentocc_0or1b + rentocc_2b+ rentocc_3b; 

	vacant_0or1b = T14B_est5 + T14B_est9 + T14B_est13 + T14B_est17;
	vacant_2b = T14B_est6 + T14B_est10 + T14B_est14 + T14B_est18;
	vacant_3b = T14B_est7 + T14B_est11 + T14B_est15 + T14B_est19;
	vacant_all = vacant_0or1b + vacant_2b + vacant_3b;
run;
%mend;

%create_all_newvars(st, chas_2006_2010_dc_city, city10_orig);
%create_all_newvars(trct, chas_2006_2010_dc, tr10);

proc means data= HUD.chas_sum_tr10 SUM; var T14b_est8 T14b_est9 T14b_est10 T14b_est11; run; 

 %Create_summary_from_tracts( 
  geo=ward2012, 
  lib=HUD,
  data_pre=chas_sum,
  data_label=%str(CHAS 2006-2010 summary, DC),
  count_vars=t1: t3: t8: t16: pay: elderly: t14: t15: rentocc: vacant: , 
  prop_vars=,
  calc_vars=,
  calc_vars_labels=,
  tract_yr=2010,
  register=N, 
  creator_process=chas_0610_sum.sas,
  restrictions=,
  revisions=,
  mprint=y
);

 %Create_summary_from_tracts( 
  geo=city, 
  lib=HUD,
  data_pre=chas_sum,
  data_label=%str(CHAS 2006-2010 summary, DC),
  count_vars=t1: t3: t8: t16: pay: elderly:  t14: t15: rentocc: vacant: , 
  prop_vars=,
  calc_vars=,
  calc_vars_labels=,
  tract_yr=2010,
  register=N, 
  creator_process=chas_0610_sum.sas,
  restrictions=,
  revisions=,
  mprint=y
);

data city;
	set hud.chas_sum_city;
	if city = '1' then city = 'C';
run; 

data master_num;
	set hud.chas_sum_wd12 (rename=(ward2012=geo2012)) city (rename=(city=geo2012));
run;

/*
proc tabulate data = master_num;
	class geo2012 S=[cellwidth=30];
	var pay: ;
	table (pay_30p pay_30_50p pay_50p pay_unknown), geo2012*sum ;
run;

*/
%macro run_tables(baseDS, level);
data table_cost_burden (keep = geo2012  T8_est1 pay_30p pay_30_50p pay_50p pay_unknown
		T8_est3_t T8_est4_t T8_est7_t T8_est10_t T8_est13_t
		T8_est16_t T8_est17_t T8_est20_t T8_est23_t T8_est26_t
		T8_est29_t T8_est30_t T8_est33_t T8_est36_t T8_est39_t
		T8_est42_t T8_est43_t T8_est46_t T8_est49_t T8_est52_t
		T8_est55_t T8_est56_t T8_est59_t T8_est62_t T8_est65_t
);
	retain geo2012  T8_est1 pay_30p pay_30_50p pay_50p pay_unknown
		T8_est3_t T8_est4_t T8_est7_t T8_est10_t T8_est13_t
		T8_est16_t T8_est17_t T8_est20_t T8_est23_t T8_est26_t
		T8_est29_t T8_est30_t T8_est33_t T8_est36_t T8_est39_t
		T8_est42_t T8_est43_t T8_est46_t T8_est49_t T8_est52_t
		T8_est55_t T8_est56_t T8_est59_t T8_est62_t T8_est65_t;
	set &baseDS. ;
run;

PROC EXPORT DATA= WORK.Table_cost_burden 
            OUTFILE= "D:\DCData\Libraries\HUD\&level\cost_burden.csv"
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;

data housing_needs  (keep = geo2012  T3_est1 T3_est2_t T3_est3_t T3_est9_t T3_est15_t T3_est21_t T3_est27_t T3_est33_t T3_est39_t
);
	retain geo2012  T3_est1 T3_est2_t T3_est3_t T3_est9_t T3_est15_t T3_est21_t T3_est27_t T3_est33_t T3_est39_t;
	set &baseDS.;
run;

PROC EXPORT DATA= WORK.housing_needs 
            OUTFILE= "D:\DCData\Libraries\HUD\&level\housing_needs.csv"
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;

data elderly_income  (keep = geo2012  elderly_tot elderly_fam elderly_nonfam T1_est3_t T1_est4_t T1_est12_t T1_est20_t T1_est28_t T1_est36_t);
	retain geo2012   elderly_tot elderly_fam elderly_nonfam T1_est3_t T1_est4_t T1_est12_t T1_est20_t T1_est28_t T1_est36_t;
	set &baseDS.;
run;

PROC EXPORT DATA= WORK.elderly_income 
            OUTFILE= "D:\DCData\Libraries\HUD\&level\elderly_income.csv"
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;

data vacant_for_rent (keep = geo2012 vacant_all vacant_0or1b vacant_2b vacant_3b t14b: );
	retain geo2012  vacant_all vacant_0or1b vacant_2b vacant_3b t14b: ;
	set &baseDS. ;
run;

PROC EXPORT DATA= WORK.vacant_for_rent
            OUTFILE= "D:\DCData\Libraries\HUD\&level\vacant_for_rent.csv"
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;


data rent_occ (keep = geo2012   rentocc: t15c_less30: t15c_3050: t15c_5080: t15c_great80: T15C_est4 T15C_est25 T15C_est46 T15C_est67:);;
	retain geo2012  rentocc_all rentocc_0or1b rentocc_2b rentocc_3b T15C_est4 t15c_less30: T15C_est25 t15c_3050: T15C_est46 t15c_5080: T15C_est67 t15c_great80:  ;
	set &baseDS. ;
run;

PROC EXPORT DATA= WORK.rent_occ
            OUTFILE= "D:\DCData\Libraries\HUD\&level\rent_occ.csv"
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;

%mend;

%run_tables(master_num, tract);
%run_tables(HUD.chas_sum_city10_orig, dc);
