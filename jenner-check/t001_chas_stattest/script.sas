/**************************************************************************
 Bundle:  t001_chas_stattest
 Source:  Macros/chas_stattest.sas  (NeighborhoodInfoDC/HUD)

 The %chas_stattest macro is reproduced verbatim from the repository. It
 runs a test of statistical significance between two CHAS estimates given
 their margins of error, producing a "***" / "**" / "*" / "" flag. Here we
 supply a small mock table of estimate/MOE pairs (the real caller reads a
 CHAS summary data set) and invoke the macro exactly as the library does.
**************************************************************************/

/** ---- Macro reproduced verbatim from Macros/chas_stattest.sas ---- **/

%macro chas_stattest (indata,est1,moe1,est2,moe2);

data a_tests ;
	set &indata.;

	E1 = &est1.;
	M1 = &moe1.;
	E2 = &est2.;
	M2 = &moe2.;

Vdiff = sqrt( ((M1/1.96)**2) + ((M2/1.96)**2) );
Tstat = ( E1 - E2 ) / Vdiff ;

if abs(Tstat) >= 2.576 then sig = "***";
else if 2.576 > abs(Tstat) >= 1.96 then sig = "**";
else if 1.96 > abs(Tstat) >= 1.645 then sig = "*";
else if abs(Tstat) < 1.645 then sig = "";

run;

data a_sig;
	set a_tests;
	keep sig;
run;

proc print data = a_sig; run;

%mend chas_stattest;

/** ---- Mock CHAS estimate/MOE pairs (stands in for a summary data set) ---- **/

data chas_indicators;
  input geoid $ est_a moe_a est_b moe_b;
  datalines;
11001 4200 310 3100 290
11003 1850 240 1810 250
11005 9600 410 7300 380
11007 2200 200 2130 210
11009 5400 350 5390 360
;
run;

/** ---- Invoke exactly as the library does ---- **/

%chas_stattest( chas_indicators, est_a, moe_a, est_b, moe_b )
