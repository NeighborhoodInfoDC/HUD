/**************************************************************************
 Program:  chas_stattest.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Rob Pitingolo
 Created:  03/12/2020
 Version:  SAS 9.4
 Environment:  Windows
 Description: Macro for tests of statistical significance for CHAS indicators.
 Modifications: 

**************************************************************************/

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


/* End of Macro */
