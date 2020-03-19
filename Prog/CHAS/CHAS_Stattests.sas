/**************************************************************************
 Program:  CHAS_Stattests.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Rob Pitingolo
 Created:  03/12/2020
 Version:  SAS 9.4
 Environment:  Windows
 Description: Tests of statistical significance for CHAS indicators.
 Modifications: 

**************************************************************************/

%let indata = Chas_3502000;


%macro chas_stattest (est1,moe1,est2,moe2);

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

%chas_stattest(est1 = rent_hasplumb_2006_10, moe1 = Mrent_hasplumb_2006_10, 
		  	   est2 = rent_hasplumb_2012_16, moe2 = Mrent_hasplumb_2012_16 );

%chas_stattest(est1 = all_units_tot_2006_10, moe1 = Mall_units_tot_2006_10, 
		  	   est2 = all_units_tot_2012_16, moe2 = Mall_units_tot_2012_16 );

%chas_stattest(est1 = Powner_unit_aff50_2006_10, moe1 = Oowner_unit_aff50_2006_10, 
		  	   est2 = Powner_unit_aff50_2012_16, moe2 = Oowner_unit_aff50_2012_16 );

%chas_stattest(est1 = Prnt030_allbr_2006_10, moe1 = Ornt030_allbr_2006_10, 
		  	   est2 = Prnt030_allbr_2012_16, moe2 = Ornt030_allbr_2012_16 );

%chas_stattest(est1 = Prnt3050_allbr_2006_10, moe1 = Ornt3050_allbr_2006_10, 
		  	   est2 = Prnt3050_allbr_2012_16, moe2 = Ornt3050_allbr_2012_16 );		   
	
%chas_stattest(est1 = inc030_allbr_2006_10, moe1 = Minc030_allbr_2006_10, 
		  	   est2 = inc030_allbr_2012_16, moe2 = Minc030_allbr_2012_16 );	 
		   
%chas_stattest(est1 = inc3050_allbr_2006_10, moe1 = Minc3050_allbr_2006_10, 
		  	   est2 = inc3050_allbr_2012_16, moe2 = Minc3050_allbr_2012_16 );	 	   

%chas_stattest(est1 = Prenter_inc030_scb_2006_10, moe1 = Orenter_inc030_scb_2006_10, 
		  	   est2 = Prenter_inc030_scb_2012_16, moe2 = Orenter_inc030_scb_2012_16 );	


%chas_stattest(est1 = rnt030_allbr_2006_10, moe1 = Mrnt030_allbr_2006_10, 
		  	   est2 = rnt030_allbr_2012_16, moe2 = Mrnt030_allbr_2012_16 );	
			   
%chas_stattest(est1 = rnt3050_allbr_2006_10, moe1 = Mrnt3050_allbr_2006_10, 
		  	   est2 = rnt3050_allbr_2012_16, moe2 = Mrnt3050_allbr_2012_16 );	
			   
%chas_stattest(est1 = rnt5080_allbr_2006_10, moe1 = Mrnt5080_allbr_2006_10, 
		  	   est2 = rnt5080_allbr_2012_16, moe2 = Mrnt5080_allbr_2012_16 );	
			   
%chas_stattest(est1 = rnt80pl_allbr_2006_10, moe1 = Mrnt80pl_allbr_2006_10, 
		  	   est2 = rnt80pl_allbr_2012_16, moe2 = Mrnt80pl_allbr_2012_16 );	
			   
			   


			   

