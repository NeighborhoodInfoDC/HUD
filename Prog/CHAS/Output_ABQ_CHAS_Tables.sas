/**************************************************************************
 Program:  Output_CHAS_Tables.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Rob Pitingolo
 Created:  01/22/2020
 Version:  SAS 9.4
 Environment:  Windows
 Description: Output CSVs for CHAS tables that then get copied into worksheets. 
			  Optional stat tests to check for significance between any two cells
			  in the output data. 
 Modifications: 

**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas"; 

** Define standard libraries **;
%DCData_lib( HUD );


** Folder to save output CSVs **;
%let outfolder = &_dcdata_r_path.\HUD\Prog\CHAS\CHASoutput\&Level.\;


** Create CHAS summary variables from national file **;
%chas_summary_vars (years=2006_10, out=chas);
%chas_summary_vars (years=2012_16, out=chas);


** Export data to CSV for each geography **;
%export_chas_csv(county,35001);
%export_chas_csv(place,3502000);


** Optional: stat tests to check statistical power between two cells **;

%let testdata = Chas_3502000;

%chas_stattest(indata = &testdata., 
				est1 = rent_hasplumb_2006_10, moe1 = Mrent_hasplumb_2006_10, 
		  	   	est2 = rent_hasplumb_2012_16, moe2 = Mrent_hasplumb_2012_16 );

%chas_stattest(indata = &testdata., 
				est1 = all_units_tot_2006_10, moe1 = Mall_units_tot_2006_10, 
		  	   	est2 = all_units_tot_2012_16, moe2 = Mall_units_tot_2012_16 );

%chas_stattest(indata = &testdata., 
				est1 = Powner_unit_aff50_2006_10, moe1 = Oowner_unit_aff50_2006_10, 
		  	   	est2 = Powner_unit_aff50_2012_16, moe2 = Oowner_unit_aff50_2012_16 );

%chas_stattest(indata = &testdata., 
				est1 = Prnt030_allbr_2006_10, moe1 = Ornt030_allbr_2006_10, 
		  	   	est2 = Prnt030_allbr_2012_16, moe2 = Ornt030_allbr_2012_16 );

%chas_stattest(indata = &testdata., 
				est1 = Prnt3050_allbr_2006_10, moe1 = Ornt3050_allbr_2006_10, 
		  	   	est2 = Prnt3050_allbr_2012_16, moe2 = Ornt3050_allbr_2012_16 );		   
	
%chas_stattest(indata = &testdata., 
				est1 = inc030_allbr_2006_10, moe1 = Minc030_allbr_2006_10, 
		  	   	est2 = inc030_allbr_2012_16, moe2 = Minc030_allbr_2012_16 );	 
		   
%chas_stattest(indata = &testdata., 
				est1 = inc3050_allbr_2006_10, moe1 = Minc3050_allbr_2006_10, 
		  	   	est2 = inc3050_allbr_2012_16, moe2 = Minc3050_allbr_2012_16 );	 	   

%chas_stattest(indata = &testdata., 
				est1 = Prenter_inc030_scb_2006_10, moe1 = Orenter_inc030_scb_2006_10, 
		  	   	est2 = Prenter_inc030_scb_2012_16, moe2 = Orenter_inc030_scb_2012_16 );	


%chas_stattest(indata = &testdata., 
				est1 = rnt030_allbr_2006_10, moe1 = Mrnt030_allbr_2006_10, 
		  	   	est2 = rnt030_allbr_2012_16, moe2 = Mrnt030_allbr_2012_16 );	
			   
%chas_stattest(indata = &testdata., 
				est1 = rnt3050_allbr_2006_10, moe1 = Mrnt3050_allbr_2006_10, 
		  	   	est2 = rnt3050_allbr_2012_16, moe2 = Mrnt3050_allbr_2012_16 );	
			   
%chas_stattest(indata = &testdata., 
				est1 = rnt5080_allbr_2006_10, moe1 = Mrnt5080_allbr_2006_10, 
		  	   	est2 = rnt5080_allbr_2012_16, moe2 = Mrnt5080_allbr_2012_16 );	
			   
%chas_stattest(indata = &testdata., 
				est1 = rnt80pl_allbr_2006_10, moe1 = Mrnt80pl_allbr_2006_10, 
		  	   	est2 = rnt80pl_allbr_2012_16, moe2 = Mrnt80pl_allbr_2012_16 );	
			   
			   
%chas_stattest(indata = &testdata., 
				est1 = renter_1un_tot_2006_10, moe1 = Mrenter_1un_tot_2006_10, 
		  	   	est2 = renter_1un_tot_2012_16, moe2 = Mrenter_1un_tot_2012_16);	

%chas_stattest(indata = &testdata., 
				est1 = renter_24un_tot_2006_10, moe1 = Mrenter_24un_tot_2006_10, 
		  	   	est2 = renter_24un_tot_2012_16, moe2 = Mrenter_24un_tot_2012_16);	

%chas_stattest(indata = &testdata., 
				est1 = renter_5un_tot_2006_10, moe1 = Mrenter_5un_tot_2006_10, 
		  	   	est2 = renter_5un_tot_2012_16, moe2 = Mrenter_5un_tot_2012_16);	

%chas_stattest(indata = &testdata., 
				est1 = renter_xun_tot_2006_10, moe1 = Mrenter_xun_tot_2006_10, 
		  	   	est2 = renter_xun_tot_2012_16, moe2 = Mrenter_xun_tot_2012_16);	


%chas_stattest(indata = &testdata., 
				est1 = inc030_1un_2006_10, moe1 = Minc030_1un_2006_10, 
		  	   	est2 = inc030_1un_2012_16, moe2 = Minc030_1un_2012_16 );	

%chas_stattest(indata = &testdata., 
				est1 = inc030_24un_2006_10, moe1 = Minc030_24un_2006_10, 
		  	   	est2 = inc030_24un_2012_16, moe2 = Minc030_24un_2012_16 );	

%chas_stattest(indata = &testdata., 
				est1 = inc030_5un_2006_10, moe1 = Minc030_5un_2006_10, 
		  	   	est2 = inc030_5un_2012_16, moe2 = Minc030_5un_2012_16 );	

%chas_stattest(indata = &testdata., 
				est1 = inc030_Xun_2006_10, moe1 = Minc030_Xun_2006_10, 
		  	   	est2 = inc030_Xun_2012_16, moe2 = Minc030_Xun_2012_16 );	


%chas_stattest(indata = &testdata., 
				est1 = rnt030_1un_2006_10, moe1 = Mrnt030_1un_2006_10, 
		  	   	est2 = rnt030_1un_2012_16, moe2 = Mrnt030_1un_2012_16 );	

%chas_stattest(indata = &testdata., 
				est1 = rnt030_24un_2006_10, moe1 = Mrnt030_24un_2006_10, 
		  	   	est2 = rnt030_24un_2012_16, moe2 = Mrnt030_24un_2012_16 );	

%chas_stattest(indata = &testdata., 
				est1 = rnt030_5un_2006_10, moe1 = Mrnt030_5un_2006_10, 
		  	   	est2 = rnt030_5un_2012_16, moe2 = Mrnt030_5un_2012_16 );	

%chas_stattest(indata = &testdata., 
				est1 = rnt030_5un_2006_10, moe1 = Mrnt030_5un_2006_10, 
		  	   	est2 = rnt030_5un_2012_16, moe2 = Mrnt030_5un_2012_16 );	


%chas_stattest(indata = &testdata., 
				est1 = rnt030_5un_2006_10, moe1 = Mrnt030_5un_2006_10, 
		  	   	est2 = rnt030_5un_2012_16, moe2 = Mrnt030_5un_2012_16 );	

%chas_stattest(indata = &testdata., 
				est1 = rnt3050_5un_2006_10, moe1 = Mrnt3050_5un_2006_10, 
		  	   	est2 = rnt3050_5un_2012_16, moe2 = Mrnt3050_5un_2012_16 );	

%chas_stattest(indata = &testdata., 
				est1 = rnt5080_5un_2006_10, moe1 = Mrnt5080_5un_2006_10, 
		  	   	est2 = rnt5080_5un_2012_16, moe2 = Mrnt5080_5un_2012_16 );	

%chas_stattest(indata = &testdata., 
				est1 = rnt80pl_5un_2006_10, moe1 = Mrnt80pl_5un_2006_10, 
		  	   	est2 = rnt80pl_5un_2012_16, moe2 = Mrnt80pl_5un_2012_16 );	


%chas_stattest(indata = &testdata., 
				est1 = Prenter_030_lgfam_nop_2006_10, moe1 = Orenter_030_lgfam_nop_2006_10, 
		  	   	est2 = Prenter_030_lgfam_nop_2012_16, moe2 = Orenter_030_lgfam_nop_2012_16 );

%chas_stattest(indata = &testdata., 
				est1 = renter_1un_tot_2012_16, moe1 = Mrenter_1un_tot_2012_16, 
		  	   	est2 = renter_5un_tot_2012_16, moe2 = Mrenter_5un_tot_2012_16 );



/* End of Program */
