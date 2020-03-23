/**************************************************************************
 Program:  Output_CHAS_Tables.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Rob Pitingolo
 Created:  01/22/2020
 Version:  SAS 9.4
 Environment:  Windows
 Description: Output CSVs for CHAS tables that then get copied into worksheets. 
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


%macro export_chas_csv (level,code);

data chas_&code.;
	merge Chas_2006_10 (drop = T1: T2: T3: T4: T5: T7: T8: T9: T10: T11: T12: T13: T14: T15: T16: T17: T18:)
		  Chas_2012_16 (drop = T1: T2: T3: T4: T5: T6: T7: T8: T9: T10: T11: T12: T13: T14: T15: T16: T17: T18:) ;
	by geoid;
	%if %upcase( &level. ) = COUNTY %then %do;
	if sumlevel = "50" and ucounty = "&code.";
	%end;
	%else %if %upcase( &level. ) = PLACE %then %do;
	if uplace = "&code.";
	%end;
	placeholder = .;
	tot100 = 100;
run;

%let chas_in = chas_&code.;

/* Supply */

%reshape_chas(&chas_in.,1a,1,owner_units_tot_2006_10 owner_units_tot_2012_16 placeholder placeholder owner_unit_aff50_2006_10 owner_unit_aff50_2012_16);
%reshape_chas(&chas_in.,1a,2,forsale_units_tot_2006_10 forsale_units_tot_2012_16 placeholder placeholder forsale_units_aff50_2006_10 forsale_units_aff50_2012_16);
%reshape_chas(&chas_in.,1a,3,renter_unit_tot_2006_10 renter_unit_tot_2012_16 renter_unit_aff30_2006_10 renter_unit_aff30_2012_16 renter_unit_aff50_2006_10 renter_unit_aff50_2012_16);
%reshape_chas(&chas_in.,1a,4,forrent_units_tot_2006_10 forrent_units_tot_2012_16 forrent_units_aff30_2006_10 forrent_units_aff30_2012_16 forrent_units_aff50_2006_10 forrent_units_aff50_2012_16);
%reshape_chas(&chas_in.,1a,5,all_units_tot_2006_10 all_units_tot_2012_16 tot_aff30_2006_10 tot_aff30_2012_16 tot_aff50_2006_10 tot_aff50_2012_16);

data table1a;
	set Table1a_row1 Table1a_row2 Table1a_row3 Table1a_row4 Table1a_row5;
run;

proc export data=table1a
   outfile="&outfolder.table1a.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,1b,1,Powner_units_tot_2006_10 Powner_units_tot_2012_16 placeholder placeholder Powner_unit_aff50_2006_10 Powner_unit_aff50_2012_16);
%reshape_chas(&chas_in.,1b,2,Pforsale_units_tot_2006_10 Pforsale_units_tot_2012_16 placeholder placeholder Pforsale_units_aff50_2006_10 Pforsale_units_aff50_2012_16);
%reshape_chas(&chas_in.,1b,3,Prenter_unit_tot_2006_10 Prenter_unit_tot_2012_16 Prenter_unit_aff30_2006_10 Prenter_unit_aff30_2012_16 Prenter_unit_aff50_2006_10 Prenter_unit_aff50_2012_16);
%reshape_chas(&chas_in.,1b,4,Pforrent_units_tot_2006_10 Pforrent_units_tot_2012_16 Pforrent_units_aff30_2006_10 Pforrent_units_aff30_2012_16 Pforrent_units_aff50_2006_10 Pforrent_units_aff50_2012_16);
%reshape_chas(&chas_in.,1b,5,all_units_tot_2006_10 all_units_tot_2012_16 tot_aff30_2006_10 tot_aff30_2012_16 tot_aff50_2006_10 tot_aff50_2012_16);

data table1b;
	set Table1b_row1 Table1b_row2 Table1b_row3 Table1b_row4 Table1b_row5;
run;

proc export data=table1b
   outfile="&outfolder.table1b.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,1c,1,rent_hasplumb_2006_10 rent_hasplumb_2012_16 renter_unit_aff30_2006_10 renter_unit_aff30_2012_16 renter_unit_aff50_2006_10 renter_unit_aff50_2012_16);
%reshape_chas(&chas_in.,1c,2,renter_01br_tot_2006_10 renter_01br_tot_2012_16 renter_01br_aff30_2006_10 renter_01br_aff30_2012_16 renter_01br_aff50_2006_10 renter_01br_aff50_2012_16);
%reshape_chas(&chas_in.,1c,3,renter_2br_tot_2006_10 renter_2br_tot_2012_16 renter_2br_aff30_2006_10 renter_2br_aff30_2012_16 renter_2br_aff50_2006_10 renter_2br_aff50_2012_16);
%reshape_chas(&chas_in.,1c,4,renter_3plusbr_tot_2006_10 renter_3plusbr_tot_2012_16 renter_3plusbr_aff30_2006_10 renter_3plusbr_aff30_2012_16 renter_3plusbr_aff50_2006_10 renter_3plusbr_aff50_2012_16);

data table1c;
	set Table1c_row1 Table1c_row2 Table1c_row3 Table1c_row4 ;
run;

proc export data=table1c
   outfile="&outfolder.table1c.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,1d,1,Prent_hasplumb_2006_10 Prent_hasplumb_2012_16 Prenter_unit_aff30_2006_10 Prenter_unit_aff30_2012_16 Prenter_unit_aff50_2006_10 Prenter_unit_aff50_2012_16);
%reshape_chas(&chas_in.,1d,2,Prenter_01br_tot_2006_10 Prenter_01br_tot_2012_16 Prenter_01br_aff30_2006_10 Prenter_01br_aff30_2012_16 Prenter_01br_aff50_2006_10 Prenter_01br_aff50_2012_16);
%reshape_chas(&chas_in.,1d,3,Prenter_2br_tot_2006_10 Prenter_2br_tot_2012_16 Prenter_2br_aff30_2006_10 Prenter_2br_aff30_2012_16 Prenter_2br_aff50_2006_10 Prenter_2br_aff50_2012_16);
%reshape_chas(&chas_in.,1d,4,Prenter_3plusbr_tot_2006_10 Prenter_3plusbr_tot_2012_16 Prenter_3plusbr_aff30_2006_10 Prenter_3plusbr_aff30_2012_16 Prenter_3plusbr_aff50_2006_10 Prenter_3plusbr_aff50_2012_16);

data table1d;
	set Table1d_row1 Table1d_row2 Table1d_row3 Table1d_row4 ;
run;

proc export data=table1d
   outfile="&outfolder.table1d.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,1e,1,own_hasplumb_2006_10 own_hasplumb_2012_16 placeholder placeholder owner_unit_aff50_2006_10 owner_unit_aff50_2012_16);
%reshape_chas(&chas_in.,1e,2,owner_01br_tot_2006_10 owner_01br_tot_2012_16 placeholder placeholder owner_01br_aff50_2006_10 owner_01br_aff50_2012_16);
%reshape_chas(&chas_in.,1e,3,owner_2br_tot_2006_10 owner_2br_tot_2012_16 placeholder placeholder owner_2br_aff50_2006_10 owner_2br_aff50_2012_16);
%reshape_chas(&chas_in.,1e,4,owner_3plusbr_tot_2006_10 owner_3plusbr_tot_2012_16 placeholder placeholder owner_3plusbr_aff50_2006_10 owner_3plusbr_aff50_2012_16);

data table1e;
	set Table1e_row1 Table1e_row2 Table1e_row3 Table1e_row4 ;
run;

proc export data=table1e
   outfile="&outfolder.table1e.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,1f,1,Pown_hasplumb_2006_10 Pown_hasplumb_2012_16 placeholder placeholder Powner_unit_aff50_2006_10 Powner_unit_aff50_2012_16);
%reshape_chas(&chas_in.,1f,2,Powner_01br_tot_2006_10 Powner_01br_tot_2012_16 placeholder placeholder Powner_01br_aff50_2006_10 Powner_01br_aff50_2012_16);
%reshape_chas(&chas_in.,1f,3,Powner_2br_tot_2006_10 Powner_2br_tot_2012_16 placeholder placeholder Powner_2br_aff50_2006_10 Powner_2br_aff50_2012_16);
%reshape_chas(&chas_in.,1f,4,Powner_3plusbr_tot_2006_10 Powner_3plusbr_tot_2012_16 placeholder placeholder Powner_3plusbr_aff50_2006_10 Powner_3plusbr_aff50_2012_16);

data table1f;
	set Table1f_row1 Table1f_row2 Table1f_row3 Table1f_row4 ;
run;

proc export data=table1f
   outfile="&outfolder.table1f.csv" dbms=csv replace;
run;


/* Supply vs. Demand */

%reshape_chas(&chas_in.,2a,1,rnt030_inc030_allbr_2006_10 rnt3050_inc030_allbr_2006_10 rnt5080_inc030_allbr_2006_10 rnt80pl_inc030_allbr_2006_10 inc030_allbr_2006_10);
%reshape_chas(&chas_in.,2a,2,rnt030_inc3050_allbr_2006_10 rnt3050_inc3050_allbr_2006_10 rnt5080_inc3050_allbr_2006_10 rnt80pl_inc3050_allbr_2006_10 inc3050_allbr_2006_10);
%reshape_chas(&chas_in.,2a,3,rnt030_inc5080_allbr_2006_10 rnt3050_inc5080_allbr_2006_10 rnt5080_inc5080_allbr_2006_10 rnt80pl_inc5080_allbr_2006_10 inc5080_allbr_2006_10);
%reshape_chas(&chas_in.,2a,4,rnt030_inc80100_allbr_2006_10 rnt3050_inc80100_allbr_2006_10 rnt5080_inc80100_allbr_2006_10 rnt80pl_inc80100_allbr_2006_10 inc80100_allbr_2006_10);
%reshape_chas(&chas_in.,2a,5,rnt030_inc100pl_allbr_2006_10 rnt3050_inc100pl_allbr_2006_10 rnt5080_inc100pl_allbr_2006_10 rnt80pl_inc100pl_allbr_2006_10 inc100pl_allbr_2006_10);
%reshape_chas(&chas_in.,2a,6,rnt030_allbr_2006_10 rnt3050_allbr_2006_10 rnt5080_allbr_2006_10 rnt80pl_allbr_2006_10 rent_hasplumb_2006_10);

data table2a;
	set Table2a_row1 Table2a_row2 Table2a_row3 Table2a_row4 Table2a_row5 Table2a_row6;
run;

proc export data=table2a
   outfile="&outfolder.table2a.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2b,1,Prnt030_inc030_allbr_2006_10 Prnt3050_inc030_allbr_2006_10 Prnt5080_inc030_allbr_2006_10 Prnt80pl_inc030_allbr_2006_10 tot100);
%reshape_chas(&chas_in.,2b,2,Prnt030_inc3050_allbr_2006_10 Prnt3050_inc3050_allbr_2006_10 Prnt5080_inc3050_allbr_2006_10 Prnt80pl_inc3050_allbr_2006_10 tot100);
%reshape_chas(&chas_in.,2b,3,Prnt030_inc5080_allbr_2006_10 Prnt3050_inc5080_allbr_2006_10 Prnt5080_inc5080_allbr_2006_10 Prnt80pl_inc5080_allbr_2006_10 tot100);
%reshape_chas(&chas_in.,2b,4,Prnt030_inc80100_allbr_2006_10 Prnt3050_inc80100_allbr_2006_10 Prnt5080_inc80100_allbr_2006_10 Prnt80pl_inc80100_allbr_2006_10 tot100);
%reshape_chas(&chas_in.,2b,5,Prnt030_inc100pl_allbr_2006_10 Prnt3050_inc100pl_allbr_2006_10 Prnt5080_inc100pl_allbr_2006_10 Prnt80pl_inc100pl_allbr_2006_10 tot100);
%reshape_chas(&chas_in.,2b,6,Prnt030_allbr_2006_10 Prnt3050_allbr_2006_10 Prnt5080_allbr_2006_10 Prnt80pl_allbr_2006_10 tot100);

data table2b;
	set Table2b_row1 Table2b_row2 Table2b_row3 Table2b_row4 Table2b_row5 Table2b_row6;
run;

proc export data=table2b
   outfile="&outfolder.table2b.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2c,1,rnt030_inc030_allbr_2012_16 rnt3050_inc030_allbr_2012_16 rnt5080_inc030_allbr_2012_16 rnt80pl_inc030_allbr_2012_16 inc030_allbr_2012_16);
%reshape_chas(&chas_in.,2c,2,rnt030_inc3050_allbr_2012_16 rnt3050_inc3050_allbr_2012_16 rnt5080_inc3050_allbr_2012_16 rnt80pl_inc3050_allbr_2012_16 inc3050_allbr_2012_16);
%reshape_chas(&chas_in.,2c,3,rnt030_inc5080_allbr_2012_16 rnt3050_inc5080_allbr_2012_16 rnt5080_inc5080_allbr_2012_16 rnt80pl_inc5080_allbr_2012_16 inc5080_allbr_2012_16);
%reshape_chas(&chas_in.,2c,4,rnt030_inc80100_allbr_2012_16 rnt3050_inc80100_allbr_2012_16 rnt5080_inc80100_allbr_2012_16 rnt80pl_inc80100_allbr_2012_16 inc80100_allbr_2012_16);
%reshape_chas(&chas_in.,2c,5,rnt030_inc100pl_allbr_2012_16 rnt3050_inc100pl_allbr_2012_16 rnt5080_inc100pl_allbr_2012_16 rnt80pl_inc100pl_allbr_2012_16 inc100pl_allbr_2012_16);
%reshape_chas(&chas_in.,2c,6,rnt030_allbr_2012_16 rnt3050_allbr_2012_16 rnt5080_allbr_2012_16 rnt80pl_allbr_2012_16 rent_hasplumb_2012_16);

data table2c;
	set Table2c_row1 Table2c_row2 Table2c_row3 Table2c_row4 Table2c_row5 Table2c_row6;
run;

proc export data=table2c
   outfile="&outfolder.table2c.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2d,1,Prnt030_inc030_allbr_2012_16 Prnt3050_inc030_allbr_2012_16 Prnt5080_inc030_allbr_2012_16 Prnt80pl_inc030_allbr_2012_16 tot100);
%reshape_chas(&chas_in.,2d,2,Prnt030_inc3050_allbr_2012_16 Prnt3050_inc3050_allbr_2012_16 Prnt5080_inc3050_allbr_2012_16 Prnt80pl_inc3050_allbr_2012_16 tot100);
%reshape_chas(&chas_in.,2d,3,Prnt030_inc5080_allbr_2012_16 Prnt3050_inc5080_allbr_2012_16 Prnt5080_inc5080_allbr_2012_16 Prnt80pl_inc5080_allbr_2012_16 tot100);
%reshape_chas(&chas_in.,2d,4,Prnt030_inc80100_allbr_2012_16 Prnt3050_inc80100_allbr_2012_16 Prnt5080_inc80100_allbr_2012_16 Prnt80pl_inc80100_allbr_2012_16 tot100);
%reshape_chas(&chas_in.,2d,5,Prnt030_inc100pl_allbr_2012_16 Prnt3050_inc100pl_allbr_2012_16 Prnt5080_inc100pl_allbr_2012_16 Prnt80pl_inc100pl_allbr_2012_16 tot100);
%reshape_chas(&chas_in.,2d,6,Prnt030_allbr_2012_16 Prnt3050_allbr_2012_16 Prnt5080_allbr_2012_16 Prnt80pl_allbr_2012_16 tot100);

data table2d;
	set Table2d_row1 Table2d_row2 Table2d_row3 Table2d_row4 Table2d_row5 Table2d_row6;
run;

proc export data=table2d
   outfile="&outfolder.table2d.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2e,1,rnt030_inc030_01br_2006_10 rnt3050_inc030_01br_2006_10 rnt5080_inc030_01br_2006_10 rnt80pl_inc030_01br_2006_10 inc030_01br_2006_10);
%reshape_chas(&chas_in.,2e,2,rnt030_inc3050_01br_2006_10 rnt3050_inc3050_01br_2006_10 rnt5080_inc3050_01br_2006_10 rnt80pl_inc3050_01br_2006_10 inc3050_01br_2006_10);
%reshape_chas(&chas_in.,2e,3,rnt030_inc5080_01br_2006_10 rnt3050_inc5080_01br_2006_10 rnt5080_inc5080_01br_2006_10 rnt80pl_inc5080_01br_2006_10 inc5080_01br_2006_10);
%reshape_chas(&chas_in.,2e,4,rnt030_inc80100_01br_2006_10 rnt3050_inc80100_01br_2006_10 rnt5080_inc80100_01br_2006_10 rnt80pl_inc80100_01br_2006_10 inc80100_01br_2006_10);
%reshape_chas(&chas_in.,2e,5,rnt030_inc100pl_01br_2006_10 rnt3050_inc100pl_01br_2006_10 rnt5080_inc100pl_01br_2006_10 rnt80pl_inc100pl_01br_2006_10 inc100pl_01br_2006_10);
%reshape_chas(&chas_in.,2e,6,rnt030_01br_2006_10 rnt3050_01br_2006_10 rnt5080_01br_2006_10 rnt80pl_01br_2006_10 renter_01br_tot_2006_10);


data table2e;
	set Table2e_row1 Table2e_row2 Table2e_row3 Table2e_row4 Table2e_row5 Table2e_row6;
run;

proc export data=table2e
   outfile="&outfolder.table2e.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2f,1,Prnt030_inc030_01br_2006_10 Prnt3050_inc030_01br_2006_10 Prnt5080_inc030_01br_2006_10 Prnt80pl_inc030_01br_2006_10 tot100);
%reshape_chas(&chas_in.,2f,2,Prnt030_inc3050_01br_2006_10 Prnt3050_inc3050_01br_2006_10 Prnt5080_inc3050_01br_2006_10 Prnt80pl_inc3050_01br_2006_10 tot100);
%reshape_chas(&chas_in.,2f,3,Prnt030_inc5080_01br_2006_10 Prnt3050_inc5080_01br_2006_10 Prnt5080_inc5080_01br_2006_10 Prnt80pl_inc5080_01br_2006_10 tot100);
%reshape_chas(&chas_in.,2f,4,Prnt030_inc80100_01br_2006_10 Prnt3050_inc80100_01br_2006_10 Prnt5080_inc80100_01br_2006_10 Prnt80pl_inc80100_01br_2006_10 tot100);
%reshape_chas(&chas_in.,2f,5,Prnt030_inc100pl_01br_2006_10 Prnt3050_inc100pl_01br_2006_10 Prnt5080_inc100pl_01br_2006_10 Prnt80pl_inc100pl_01br_2006_10 tot100);
%reshape_chas(&chas_in.,2f,6,Prnt030_01br_2006_10 Prnt3050_01br_2006_10 Prnt5080_01br_2006_10 Prnt80pl_01br_2006_10 tot100);

data table2f;
	set Table2f_row1 Table2f_row2 Table2f_row3 Table2f_row4 Table2f_row5 Table2f_row6;
run;

proc export data=table2f
   outfile="&outfolder.table2f.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2g,1,rnt030_inc030_01br_2012_16 rnt3050_inc030_01br_2012_16 rnt5080_inc030_01br_2012_16 rnt80pl_inc030_01br_2012_16 inc030_01br_2012_16);
%reshape_chas(&chas_in.,2g,2,rnt030_inc3050_01br_2012_16 rnt3050_inc3050_01br_2012_16 rnt5080_inc3050_01br_2012_16 rnt80pl_inc3050_01br_2012_16 inc3050_01br_2012_16);
%reshape_chas(&chas_in.,2g,3,rnt030_inc5080_01br_2012_16 rnt3050_inc5080_01br_2012_16 rnt5080_inc5080_01br_2012_16 rnt80pl_inc5080_01br_2012_16 inc5080_01br_2012_16);
%reshape_chas(&chas_in.,2g,4,rnt030_inc80100_01br_2012_16 rnt3050_inc80100_01br_2012_16 rnt5080_inc80100_01br_2012_16 rnt80pl_inc80100_01br_2012_16 inc80100_01br_2012_16);
%reshape_chas(&chas_in.,2g,5,rnt030_inc100pl_01br_2012_16 rnt3050_inc100pl_01br_2012_16 rnt5080_inc100pl_01br_2012_16 rnt80pl_inc100pl_01br_2012_16 inc100pl_01br_2012_16);
%reshape_chas(&chas_in.,2g,6,rnt030_01br_2012_16 rnt3050_01br_2012_16 rnt5080_01br_2012_16 rnt80pl_01br_2012_16 renter_01br_tot_2012_16);

data table2g;
	set Table2g_row1 Table2g_row2 Table2g_row3 Table2g_row4 Table2g_row5 Table2g_row6;
run;

proc export data=table2g
   outfile="&outfolder.table2g.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2h,1,Prnt030_inc030_01br_2012_16 Prnt3050_inc030_01br_2012_16 Prnt5080_inc030_01br_2012_16 Prnt80pl_inc030_01br_2012_16 tot100);
%reshape_chas(&chas_in.,2h,2,Prnt030_inc3050_01br_2012_16 Prnt3050_inc3050_01br_2012_16 Prnt5080_inc3050_01br_2012_16 Prnt80pl_inc3050_01br_2012_16 tot100);
%reshape_chas(&chas_in.,2h,3,Prnt030_inc5080_01br_2012_16 Prnt3050_inc5080_01br_2012_16 Prnt5080_inc5080_01br_2012_16 Prnt80pl_inc5080_01br_2012_16 tot100);
%reshape_chas(&chas_in.,2h,4,Prnt030_inc80100_01br_2012_16 Prnt3050_inc80100_01br_2012_16 Prnt5080_inc80100_01br_2012_16 Prnt80pl_inc80100_01br_2012_16 tot100);
%reshape_chas(&chas_in.,2h,5,Prnt030_inc100pl_01br_2012_16 Prnt3050_inc100pl_01br_2012_16 Prnt5080_inc100pl_01br_2012_16 Prnt80pl_inc100pl_01br_2012_16 tot100);
%reshape_chas(&chas_in.,2h,6,Prnt030_01br_2012_16 Prnt3050_01br_2012_16 Prnt5080_01br_2012_16 Prnt80pl_01br_2012_16 tot100);

data table2h;
	set Table2h_row1 Table2h_row2 Table2h_row3 Table2h_row4 Table2h_row5 Table2h_row6;
run;

proc export data=table2h
   outfile="&outfolder.table2h.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2i,1,rnt030_inc030_2br_2006_10 rnt3050_inc030_2br_2006_10 rnt5080_inc030_2br_2006_10 rnt80pl_inc030_2br_2006_10 inc030_2br_2006_10);
%reshape_chas(&chas_in.,2i,2,rnt030_inc3050_2br_2006_10 rnt3050_inc3050_2br_2006_10 rnt5080_inc3050_2br_2006_10 rnt80pl_inc3050_2br_2006_10 inc3050_2br_2006_10);
%reshape_chas(&chas_in.,2i,3,rnt030_inc5080_2br_2006_10 rnt3050_inc5080_2br_2006_10 rnt5080_inc5080_2br_2006_10 rnt80pl_inc5080_2br_2006_10 inc5080_2br_2006_10);
%reshape_chas(&chas_in.,2i,4,rnt030_inc80100_2br_2006_10 rnt3050_inc80100_2br_2006_10 rnt5080_inc80100_2br_2006_10 rnt80pl_inc80100_2br_2006_10 inc80100_2br_2006_10);
%reshape_chas(&chas_in.,2i,5,rnt030_inc100pl_2br_2006_10 rnt3050_inc100pl_2br_2006_10 rnt5080_inc100pl_2br_2006_10 rnt80pl_inc100pl_2br_2006_10 inc100pl_2br_2006_10);
%reshape_chas(&chas_in.,2i,6,rnt030_2br_2006_10 rnt3050_2br_2006_10 rnt5080_2br_2006_10 rnt80pl_2br_2006_10 renter_2br_tot_2006_10);

data table2i;
	set Table2i_row1 Table2i_row2 Table2i_row3 Table2i_row4 Table2i_row5 Table2i_row6;
run;

proc export data=table2i
   outfile="&outfolder.table2i.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2j,1,Prnt030_inc030_2br_2006_10 Prnt3050_inc030_2br_2006_10 Prnt5080_inc030_2br_2006_10 Prnt80pl_inc030_2br_2006_10 tot100);
%reshape_chas(&chas_in.,2j,2,Prnt030_inc3050_2br_2006_10 Prnt3050_inc3050_2br_2006_10 Prnt5080_inc3050_2br_2006_10 Prnt80pl_inc3050_2br_2006_10 tot100);
%reshape_chas(&chas_in.,2j,3,Prnt030_inc5080_2br_2006_10 Prnt3050_inc5080_2br_2006_10 Prnt5080_inc5080_2br_2006_10 Prnt80pl_inc5080_2br_2006_10 tot100);
%reshape_chas(&chas_in.,2j,4,Prnt030_inc80100_2br_2006_10 Prnt3050_inc80100_2br_2006_10 Prnt5080_inc80100_2br_2006_10 Prnt80pl_inc80100_2br_2006_10 tot100);
%reshape_chas(&chas_in.,2j,5,Prnt030_inc100pl_2br_2006_10 Prnt3050_inc100pl_2br_2006_10 Prnt5080_inc100pl_2br_2006_10 Prnt80pl_inc100pl_2br_2006_10 tot100);
%reshape_chas(&chas_in.,2j,6,Prnt030_2br_2006_10 Prnt3050_2br_2006_10 Prnt5080_2br_2006_10 Prnt80pl_2br_2006_10 tot100);

data table2j;
	set Table2j_row1 Table2j_row2 Table2j_row3 Table2j_row4 Table2j_row5 Table2j_row6;
run;

proc export data=table2j
   outfile="&outfolder.table2j.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2k,1,rnt030_inc030_2br_2012_16 rnt3050_inc030_2br_2012_16 rnt5080_inc030_2br_2012_16 rnt80pl_inc030_2br_2012_16 inc030_2br_2012_16);
%reshape_chas(&chas_in.,2k,2,rnt030_inc3050_2br_2012_16 rnt3050_inc3050_2br_2012_16 rnt5080_inc3050_2br_2012_16 rnt80pl_inc3050_2br_2012_16 inc3050_2br_2012_16);
%reshape_chas(&chas_in.,2k,3,rnt030_inc5080_2br_2012_16 rnt3050_inc5080_2br_2012_16 rnt5080_inc5080_2br_2012_16 rnt80pl_inc5080_2br_2012_16 inc5080_2br_2012_16);
%reshape_chas(&chas_in.,2k,4,rnt030_inc80100_2br_2012_16 rnt3050_inc80100_2br_2012_16 rnt5080_inc80100_2br_2012_16 rnt80pl_inc80100_2br_2012_16 inc80100_2br_2012_16);
%reshape_chas(&chas_in.,2k,5,rnt030_inc100pl_2br_2012_16 rnt3050_inc100pl_2br_2012_16 rnt5080_inc100pl_2br_2012_16 rnt80pl_inc100pl_2br_2012_16 inc100pl_2br_2012_16);
%reshape_chas(&chas_in.,2k,6,rnt030_2br_2012_16 rnt3050_2br_2012_16 rnt5080_2br_2012_16 rnt80pl_2br_2012_16 renter_2br_tot_2012_16);

data table2k;
	set Table2k_row1 Table2k_row2 Table2k_row3 Table2k_row4 Table2k_row5 Table2k_row6;
run;

proc export data=table2k
   outfile="&outfolder.table2k.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2l,1,Prnt030_inc030_2br_2012_16 Prnt3050_inc030_2br_2012_16 Prnt5080_inc030_2br_2012_16 Prnt80pl_inc030_2br_2012_16 tot100);
%reshape_chas(&chas_in.,2l,2,Prnt030_inc3050_2br_2012_16 Prnt3050_inc3050_2br_2012_16 Prnt5080_inc3050_2br_2012_16 Prnt80pl_inc3050_2br_2012_16 tot100);
%reshape_chas(&chas_in.,2l,3,Prnt030_inc5080_2br_2012_16 Prnt3050_inc5080_2br_2012_16 Prnt5080_inc5080_2br_2012_16 Prnt80pl_inc5080_2br_2012_16 tot100);
%reshape_chas(&chas_in.,2l,4,Prnt030_inc80100_2br_2012_16 Prnt3050_inc80100_2br_2012_16 Prnt5080_inc80100_2br_2012_16 Prnt80pl_inc80100_2br_2012_16 tot100);
%reshape_chas(&chas_in.,2l,5,Prnt030_inc100pl_2br_2012_16 Prnt3050_inc100pl_2br_2012_16 Prnt5080_inc100pl_2br_2012_16 Prnt80pl_inc100pl_2br_2012_16 tot100);
%reshape_chas(&chas_in.,2l,6,Prnt030_2br_2012_16 Prnt3050_2br_2012_16 Prnt5080_2br_2012_16 Prnt80pl_2br_2012_16 tot100);

data table2l;
	set Table2l_row1 Table2l_row2 Table2l_row3 Table2l_row4 Table2l_row5 Table2l_row6;
run;

proc export data=table2l
   outfile="&outfolder.table2l.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2m,1,rnt030_inc030_3br_2006_10 rnt3050_inc030_3br_2006_10 rnt5080_inc030_3br_2006_10 rnt80pl_inc030_3br_2006_10 inc030_3br_2006_10);
%reshape_chas(&chas_in.,2m,2,rnt030_inc3050_3br_2006_10 rnt3050_inc3050_3br_2006_10 rnt5080_inc3050_3br_2006_10 rnt80pl_inc3050_3br_2006_10 inc3050_3br_2006_10);
%reshape_chas(&chas_in.,2m,3,rnt030_inc5080_3br_2006_10 rnt3050_inc5080_3br_2006_10 rnt5080_inc5080_3br_2006_10 rnt80pl_inc5080_3br_2006_10 inc5080_3br_2006_10);
%reshape_chas(&chas_in.,2m,4,rnt030_inc80100_3br_2006_10 rnt3050_inc80100_3br_2006_10 rnt5080_inc80100_3br_2006_10 rnt80pl_inc80100_3br_2006_10 inc80100_3br_2006_10);
%reshape_chas(&chas_in.,2m,5,rnt030_inc100pl_3br_2006_10 rnt3050_inc100pl_3br_2006_10 rnt5080_inc100pl_3br_2006_10 rnt80pl_inc100pl_3br_2006_10 inc100pl_3br_2006_10);
%reshape_chas(&chas_in.,2m,6,rnt030_3br_2006_10 rnt3050_3br_2006_10 rnt5080_3br_2006_10 rnt80pl_3br_2006_10 renter_3plusbr_tot_2006_10);

data table2m;
	set Table2m_row1 Table2m_row2 Table2m_row3 Table2m_row4 Table2m_row5 Table2m_row6;
run;

proc export data=table2m
   outfile="&outfolder.table2m.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2n,1,Prnt030_inc030_3br_2006_10 Prnt3050_inc030_3br_2006_10 Prnt5080_inc030_3br_2006_10 Prnt80pl_inc030_3br_2006_10 tot100);
%reshape_chas(&chas_in.,2n,2,Prnt030_inc3050_3br_2006_10 Prnt3050_inc3050_3br_2006_10 Prnt5080_inc3050_3br_2006_10 Prnt80pl_inc3050_3br_2006_10 tot100);
%reshape_chas(&chas_in.,2n,3,Prnt030_inc5080_3br_2006_10 Prnt3050_inc5080_3br_2006_10 Prnt5080_inc5080_3br_2006_10 Prnt80pl_inc5080_3br_2006_10 tot100);
%reshape_chas(&chas_in.,2n,4,Prnt030_inc80100_3br_2006_10 Prnt3050_inc80100_3br_2006_10 Prnt5080_inc80100_3br_2006_10 Prnt80pl_inc80100_3br_2006_10 tot100);
%reshape_chas(&chas_in.,2n,5,Prnt030_inc100pl_3br_2006_10 Prnt3050_inc100pl_3br_2006_10 Prnt5080_inc100pl_3br_2006_10 Prnt80pl_inc100pl_3br_2006_10 tot100);
%reshape_chas(&chas_in.,2n,6,Prnt030_3br_2006_10 Prnt3050_3br_2006_10 Prnt5080_3br_2006_10 Prnt80pl_3br_2006_10 tot100);

data table2n;
	set Table2n_row1 Table2n_row2 Table2n_row3 Table2n_row4 Table2n_row5 Table2n_row6;
run;

proc export data=table2n
   outfile="&outfolder.table2n.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2o,1,rnt030_inc030_3br_2012_16 rnt3050_inc030_3br_2012_16 rnt5080_inc030_3br_2012_16 rnt80pl_inc030_3br_2012_16 inc030_3br_2012_16);
%reshape_chas(&chas_in.,2o,2,rnt030_inc3050_3br_2012_16 rnt3050_inc3050_3br_2012_16 rnt5080_inc3050_3br_2012_16 rnt80pl_inc3050_3br_2012_16 inc3050_3br_2012_16);
%reshape_chas(&chas_in.,2o,3,rnt030_inc5080_3br_2012_16 rnt3050_inc5080_3br_2012_16 rnt5080_inc5080_3br_2012_16 rnt80pl_inc5080_3br_2012_16 inc5080_3br_2012_16);
%reshape_chas(&chas_in.,2o,4,rnt030_inc80100_3br_2012_16 rnt3050_inc80100_3br_2012_16 rnt5080_inc80100_3br_2012_16 rnt80pl_inc80100_3br_2012_16 inc80100_3br_2012_16);
%reshape_chas(&chas_in.,2o,5,rnt030_inc100pl_3br_2012_16 rnt3050_inc100pl_3br_2012_16 rnt5080_inc100pl_3br_2012_16 rnt80pl_inc100pl_3br_2012_16 inc100pl_3br_2012_16);
%reshape_chas(&chas_in.,2o,6,rnt030_3br_2012_16 rnt3050_3br_2012_16 rnt5080_3br_2012_16 rnt80pl_3br_2012_16 renter_3plusbr_tot_2012_16);

data table2o;
	set Table2o_row1 Table2o_row2 Table2o_row3 Table2o_row4 Table2o_row5 Table2o_row6;
run;

proc export data=table2o
   outfile="&outfolder.table2o.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2p,1,Prnt030_inc030_3br_2012_16 Prnt3050_inc030_3br_2012_16 Prnt5080_inc030_3br_2012_16 Prnt80pl_inc030_3br_2012_16 tot100);
%reshape_chas(&chas_in.,2p,2,Prnt030_inc3050_3br_2012_16 Prnt3050_inc3050_3br_2012_16 Prnt5080_inc3050_3br_2012_16 Prnt80pl_inc3050_3br_2012_16 tot100);
%reshape_chas(&chas_in.,2p,3,Prnt030_inc5080_3br_2012_16 Prnt3050_inc5080_3br_2012_16 Prnt5080_inc5080_3br_2012_16 Prnt80pl_inc5080_3br_2012_16 tot100);
%reshape_chas(&chas_in.,2p,4,Prnt030_inc80100_3br_2012_16 Prnt3050_inc80100_3br_2012_16 Prnt5080_inc80100_3br_2012_16 Prnt80pl_inc80100_3br_2012_16 tot100);
%reshape_chas(&chas_in.,2p,5,Prnt030_inc100pl_3br_2012_16 Prnt3050_inc100pl_3br_2012_16 Prnt5080_inc100pl_3br_2012_16 Prnt80pl_inc100pl_3br_2012_16 tot100);
%reshape_chas(&chas_in.,2p,6,Prnt030_3br_2012_16 Prnt3050_3br_2012_16 Prnt5080_3br_2012_16 Prnt80pl_3br_2012_16 tot100);

data table2p;
	set Table2p_row1 Table2p_row2 Table2p_row3 Table2p_row4 Table2p_row5 Table2p_row6;
run;

proc export data=table2p
   outfile="&outfolder.table2p.csv" dbms=csv replace;
run;


/* Demand - Affordability */

%reshape_chas(&chas_in.,3a,1,renter_inc030_2006_10 Prenter_inc030_2006_10 Prenter_inc030_cb_2006_10 Prenter_inc030_scb_2006_10 Prenter_inc030_ncb_2006_10 );
%reshape_chas(&chas_in.,3a,2,renter_inc3050_2006_10 Prenter_inc3050_2006_10 Prenter_inc3050_cb_2006_10 Prenter_inc3050_scb_2006_10 Prenter_inc3050_ncb_2006_10 );
%reshape_chas(&chas_in.,3a,3,renter_inc5080_2006_10 Prenter_inc5080_2006_10 Prenter_inc5080_cb_2006_10 Prenter_inc5080_scb_2006_10 Prenter_inc5080_ncb_2006_10 );
%reshape_chas(&chas_in.,3a,4,renter_inc80100_2006_10 Prenter_inc80100_2006_10 Prenter_inc80100_cb_2006_10 Prenter_inc80100_scb_2006_10 Prenter_inc80100_ncb_2006_10 );
%reshape_chas(&chas_in.,3a,5,renter_inc100pl_2006_10 Prenter_inc100pl_2006_10 Prenter_inc100pl_cb_2006_10 Prenter_inc100pl_scb_2006_10 Prenter_inc100pl_ncb_2006_10 );
%reshape_chas(&chas_in.,3a,6,renter_unit_tot_2006_10 renter_unit_tot_2006_10 renter_cb_2006_10 renter_scb_2006_10 renter_ncb_2006_10);


data table3a;
	set table3a_row1 table3a_row2 table3a_row3 table3a_row4 table3a_row5 table3a_row6;
run;

proc export data=table3a
   outfile="&outfolder.table3a.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,3b,1,renter_inc030_2012_16 Prenter_inc030_2012_16 Prenter_inc030_cb_2012_16 Prenter_inc030_scb_2012_16 Prenter_inc030_ncb_2012_16 );
%reshape_chas(&chas_in.,3b,2,renter_inc3050_2012_16 Prenter_inc3050_2012_16 Prenter_inc3050_cb_2012_16 Prenter_inc3050_scb_2012_16 Prenter_inc3050_ncb_2012_16 );
%reshape_chas(&chas_in.,3b,3,renter_inc5080_2012_16 Prenter_inc5080_2012_16 Prenter_inc5080_cb_2012_16 Prenter_inc5080_scb_2012_16 Prenter_inc5080_ncb_2012_16 );
%reshape_chas(&chas_in.,3b,4,renter_inc80100_2012_16 Prenter_inc80100_2012_16 Prenter_inc80100_cb_2012_16 Prenter_inc80100_scb_2012_16 Prenter_inc80100_ncb_2012_16 );
%reshape_chas(&chas_in.,3b,5,renter_inc100pl_2012_16 Prenter_inc100pl_2012_16 Prenter_inc100pl_cb_2012_16 Prenter_inc100pl_scb_2012_16 Prenter_inc100pl_ncb_2012_16 );
%reshape_chas(&chas_in.,3b,6,renter_unit_tot_2012_16 renter_unit_tot_2012_16 renter_cb_2012_16 renter_scb_2012_16 renter_ncb_2012_16);

data table3b;
	set table3b_row1 table3b_row2 table3b_row3 table3b_row4 table3b_row5 table3b_row6;
run;

proc export data=table3b
   outfile="&outfolder.table3b.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,3c,1,renter_030_eldfam_2006_10 Prenter_030_eldfam_2006_10 Prenter_030_eldfam_cb_2006_10 Prenter_030_eldfam_scb_2006_10 Prenter_030_eldfam_nop_2006_10 Prenter_030_eldfam_ncb_2006_10);
%reshape_chas(&chas_in.,3c,2,renter_030_smfam_2006_10 Prenter_030_smfam_2006_10 Prenter_030_smfam_cb_2006_10 Prenter_030_smfam_scb_2006_10 Prenter_030_smfam_nop_2006_10 Prenter_030_smfam_ncb_2006_10);
%reshape_chas(&chas_in.,3c,3,renter_030_lgfam_2006_10 Prenter_030_lgfam_2006_10 Prenter_030_lgfam_cb_2006_10 Prenter_030_lgfam_scb_2006_10 Prenter_030_lgfam_nop_2006_10 Prenter_030_lgfam_ncb_2006_10);
%reshape_chas(&chas_in.,3c,4,renter_030_eldnf_2006_10 Prenter_030_eldnf_2006_10 Prenter_030_eldnf_cb_2006_10 Prenter_030_eldnf_scb_2006_10 Prenter_030_eldnf_nop_2006_10 Prenter_030_eldnf_ncb_2006_10);
%reshape_chas(&chas_in.,3c,5,renter_030_othhh_2006_10 Prenter_030_othhh_2006_10 Prenter_030_othhh_cb_2006_10 Prenter_030_othhh_scb_2006_10 Prenter_030_othhh_nop_2006_10 Prenter_030_othhh_ncb_2006_10);
%reshape_chas(&chas_in.,3c,6,renter_inc030_2006_10 renter_inc030_2006_10 renter_inc030_cb_2006_10 renter_inc030_scb_2006_10 renter_inc030_nop_2006_10 renter_inc030_ncb_2006_10);

data table3c;
	set table3c_row1 table3c_row2 table3c_row3 table3c_row4 table3c_row5 table3c_row6;
run;

proc export data=table3c
   outfile="&outfolder.table3c.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,3d,1,renter_030_eldfam_2012_16 Prenter_030_eldfam_2012_16 Prenter_030_eldfam_cb_2012_16 Prenter_030_eldfam_scb_2012_16 Prenter_030_eldfam_nop_2012_16 Prenter_030_eldfam_ncb_2012_16);
%reshape_chas(&chas_in.,3d,2,renter_030_smfam_2012_16 Prenter_030_smfam_2012_16 Prenter_030_smfam_cb_2012_16 Prenter_030_smfam_scb_2012_16 Prenter_030_smfam_nop_2012_16 Prenter_030_smfam_ncb_2012_16);
%reshape_chas(&chas_in.,3d,3,renter_030_lgfam_2012_16 Prenter_030_lgfam_2012_16 Prenter_030_lgfam_cb_2012_16 Prenter_030_lgfam_scb_2012_16 Prenter_030_lgfam_nop_2012_16 Prenter_030_lgfam_ncb_2012_16);
%reshape_chas(&chas_in.,3d,4,renter_030_eldnf_2012_16 Prenter_030_eldnf_2012_16 Prenter_030_eldnf_cb_2012_16 Prenter_030_eldnf_scb_2012_16 Prenter_030_eldnf_nop_2012_16 Prenter_030_eldnf_ncb_2012_16);
%reshape_chas(&chas_in.,3d,5,renter_030_othhh_2012_16 Prenter_030_othhh_2012_16 Prenter_030_othhh_cb_2012_16 Prenter_030_othhh_scb_2012_16 Prenter_030_othhh_nop_2012_16 Prenter_030_othhh_ncb_2012_16);
%reshape_chas(&chas_in.,3d,6,renter_inc030_2012_16 renter_inc030_2012_16 renter_inc030_cb_2012_16 renter_inc030_scb_2012_16 renter_inc030_nop_2012_16 renter_inc030_ncb_2012_16);

data table3d;
	set table3d_row1 table3d_row2 table3d_row3 table3d_row4 table3d_row5 table3d_row6;
run;

proc export data=table3d
   outfile="&outfolder.table3d.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,3e,1,renter_030_noplumb_2006_10 Prenter_030_noplumb_2006_10 Prenter_030_noplumb_cb_2006_10 Prenter_030_noplumb_scb_2006_10 Prenter_030_noplumb_ncb_2006_10);
%reshape_chas(&chas_in.,3e,2,renter_030_hasplumb_2006_10 Prenter_030_hasplumb_2006_10 Prenter_030_hasplumb_cb_2006_10 Prenter_030_hasplumb_scb_2006_10 Prenter_030_hasplumb_ncb_2006_10);
%reshape_chas(&chas_in.,3e,3,renter_inc030_2006_10 renter_inc030_2006_10 renter_inc030_cb_2006_10 renter_inc030_scb_2006_10 renter_inc030_ncb_2006_10);

data table3e;
	set table3e_row1 table3e_row2 table3e_row3;
run;

proc export data=table3e
   outfile="&outfolder.table3e.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,3f,1,renter_030_noplumb_2012_16 Prenter_030_noplumb_2012_16 Prenter_030_noplumb_cb_2012_16 Prenter_030_noplumb_scb_2012_16 Prenter_030_noplumb_ncb_2012_16);
%reshape_chas(&chas_in.,3f,2,renter_030_hasplumb_2012_16 Prenter_030_hasplumb_2012_16 Prenter_030_hasplumb_cb_2012_16 Prenter_030_hasplumb_scb_2012_16 Prenter_030_hasplumb_ncb_2012_16);
%reshape_chas(&chas_in.,3f,3,renter_inc030_2012_16 renter_inc030_2012_16 renter_inc030_cb_2012_16 renter_inc030_scb_2012_16 renter_inc030_ncb_2012_16);

data table3f;
	set table3f_row1 table3f_row2 table3f_row3;
run;

proc export data=table3f
   outfile="&outfolder.table3f.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,3g,1,renter_030_onlycb_2006_10 Prenter_030_onlycb_2006_10 );

data table3g;
	set table3g_row1 ;
run;

proc export data=table3g
   outfile="&outfolder.table3g.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,3h,1,renter_030_onlycb_2012_16 Prenter_030_onlycb_2012_16 );

data table3h;
	set table3h_row1 ;
run;

proc export data=table3h
   outfile="&outfolder.table3h.csv" dbms=csv replace;
run;


/* Demand - Size */

%reshape_chas(&chas_in.,4a,1,renter_inc030_2006_10 Prentr_inc030_lte1_2006_10 Prentr_inc030_lte15_2006_10 Prentr_inc030_gt15_2006_10);
%reshape_chas(&chas_in.,4a,2,renter_inc3050_2006_10 Prentr_inc3050_lte1_2006_10 Prentr_inc3050_lte15_2006_10 Prentr_inc3050_gt15_2006_10);
%reshape_chas(&chas_in.,4a,3,renter_inc5080_2006_10 Prentr_inc5080_lte1_2006_10 Prentr_inc5080_lte15_2006_10 Prentr_inc5080_gt15_2006_10);
%reshape_chas(&chas_in.,4a,4,renter_inc80100_2006_10 Prentr_inc80100_lte1_2006_10 Prentr_inc80100_lte15_2006_10 Prentr_inc80100_gt15_2006_10);
%reshape_chas(&chas_in.,4a,5,renter_inc100pl_2006_10 Prentr_inc100pl_lte1_2006_10 Prentr_inc100pl_lte15_2006_10 Prentr_inc100pl_gt15_2006_10);
%reshape_chas(&chas_in.,4a,6,renter_unit_tot_2006_10 rentr_lte1_2006_10 rentr_lte15_2006_10 rentr_gt15_2006_10);


data table4a;
	set Table4a_row1 Table4a_row2 Table4a_row3 Table4a_row4 Table4a_row5 Table4a_row6;
run;

proc export data=table4a
   outfile="&outfolder.table4a.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,4b,1,renter_inc030_2012_16 Prentr_inc030_lte1_2012_16 Prentr_inc030_lte15_2012_16 Prentr_inc030_gt15_2012_16);
%reshape_chas(&chas_in.,4b,2,renter_inc3050_2012_16 Prentr_inc3050_lte1_2012_16 Prentr_inc3050_lte15_2012_16 Prentr_inc3050_gt15_2012_16);
%reshape_chas(&chas_in.,4b,3,renter_inc5080_2012_16 Prentr_inc5080_lte1_2012_16 Prentr_inc5080_lte15_2012_16 Prentr_inc5080_gt15_2012_16);
%reshape_chas(&chas_in.,4b,4,renter_inc80100_2012_16 Prentr_inc80100_lte1_2012_16 Prentr_inc80100_lte15_2012_16 Prentr_inc80100_gt15_2012_16);
%reshape_chas(&chas_in.,4b,5,renter_inc100pl_2012_16 Prentr_inc100pl_lte1_2012_16 Prentr_inc100pl_lte15_2012_16 Prentr_inc100pl_gt15_2012_16);
%reshape_chas(&chas_in.,4b,6,renter_unit_tot_2012_16 rentr_lte1_2012_16 rentr_lte15_2012_16 rentr_gt15_2012_16);

data table4b;
	set Table4b_row1 Table4b_row2 Table4b_row3 Table4b_row4 Table4b_row5 Table4b_row6;
run;

proc export data=table4b
   outfile="&outfolder.table4b.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,4c,1,rentr_inc030_1fam_2006_10 Prentr_inc030_lte1_1fam_2006_10 Prentr_inc030_lte15_1fam_2006_10 Prentr_inc030_gt15_1fam_2006_10);
%reshape_chas(&chas_in.,4c,2,rentr_inc030_sfam_2006_10 Prentr_inc030_lte1_sfam_2006_10 Prentr_inc030_lte15_sfam_2006_10 Prentr_inc030_gt15_sfam_2006_10);
%reshape_chas(&chas_in.,4c,3,rentr_inc030_nfam_2006_10 Prentr_inc030_lte1_nfam_2006_10 Prentr_inc030_lte15_nfam_2006_10 Prentr_inc030_gt15_nfam_2006_10);
%reshape_chas(&chas_in.,4c,4,renter_inc030_2006_10 rentr_inc030_lte1_2006_10 rentr_inc030_lte15_2006_10 rentr_inc030_gt15_2006_10);

data table4c;
	set Table4c_row1 Table4c_row2 Table4c_row3 Table4c_row4;
run;

proc export data=table4c
   outfile="&outfolder.table4c.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,4d,1,rentr_inc030_1fam_2012_16 Prentr_inc030_lte1_1fam_2012_16 Prentr_inc030_lte15_1fam_2012_16 Prentr_inc030_gt15_1fam_2012_16);
%reshape_chas(&chas_in.,4d,2,rentr_inc030_sfam_2012_16 Prentr_inc030_lte1_sfam_2012_16 Prentr_inc030_lte15_sfam_2012_16 Prentr_inc030_gt15_sfam_2012_16);
%reshape_chas(&chas_in.,4d,3,rentr_inc030_nfam_2012_16 Prentr_inc030_lte1_nfam_2012_16 Prentr_inc030_lte15_nfam_2012_16 Prentr_inc030_gt15_nfam_2012_16);
%reshape_chas(&chas_in.,4d,4,renter_inc030_2012_16 rentr_inc030_lte1_2012_16 rentr_inc030_lte15_2012_16 rentr_inc030_gt15_2012_16);

data table4d;
	set Table4d_row1 Table4d_row2 Table4d_row3 Table4d_row4;
run;

proc export data=table4d
   outfile="&outfolder.table4d.csv" dbms=csv replace;
run;


/* Demand - Age */

%reshape_chas(&chas_in.,5a,1,renter_in50_2006_10 Prenter_inc050_bt00_2006_10 Prenter_inc050_bt8099_2006_10 Prenter_inc050_bt6079_2006_10 Prenter_inc050_bt4059_2006_10 Prenter_inc050_bt39_2006_10);
%reshape_chas(&chas_in.,5a,2,renter_in5080_2006_10 Prenter_inc5080_bt00_2006_10 Prenter_inc5080_bt8099_2006_10 Prenter_inc5080_bt6079_2006_10 Prenter_inc5080_bt4059_2006_10 Prenter_inc5080_bt39_2006_10);
%reshape_chas(&chas_in.,5a,3,renter_in80120_2006_10 Prenter_inc80120_bt00_2006_10 Prenter_inc80120_bt8099_2006_10 Prenter_inc80120_bt6079_2006_10 Prenter_inc80120_bt4059_2006_10 Prenter_inc80120_bt39_2006_10);
%reshape_chas(&chas_in.,5a,4,renter_in120pl_2006_10 Prenter_inc120pl_bt00_2006_10 Prenter_inc120pl_bt8099_2006_10 Prenter_inc120pl_bt6079_2006_10 Prenter_inc120pl_bt4059_2006_10 Prenter_inc120pl_bt39_2006_10);
%reshape_chas(&chas_in.,5a,5,renter_unit_tot_2006_10 renter_bt00_2006_10 renter_bt8099_2006_10 renter_bt6079_2006_10 renter_bt4059_2006_10 renter_bt39_2006_10);

data table5a;
	set Table5a_row1 Table5a_row2 Table5a_row3 Table5a_row4 Table5a_row5;
run;

proc export data=table5a
   outfile="&outfolder.table5a.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,5b,1,renter_in50_2012_16 Prenter_inc050_bt00_2012_16 Prenter_inc050_bt8099_2012_16 Prenter_inc050_bt6079_2012_16 Prenter_inc050_bt4059_2012_16 Prenter_inc050_bt39_2012_16);
%reshape_chas(&chas_in.,5b,2,renter_in5080_2012_16 Prenter_inc5080_bt00_2012_16 Prenter_inc5080_bt8099_2012_16 Prenter_inc5080_bt6079_2012_16 Prenter_inc5080_bt4059_2012_16 Prenter_inc5080_bt39_2012_16);
%reshape_chas(&chas_in.,5b,3,renter_in80120_2012_16 Prenter_inc80120_bt00_2012_16 Prenter_inc80120_bt8099_2012_16 Prenter_inc80120_bt6079_2012_16 Prenter_inc80120_bt4059_2012_16 Prenter_inc80120_bt39_2012_16);
%reshape_chas(&chas_in.,5b,4,renter_in120pl_2012_16 Prenter_inc120pl_bt00_2012_16 Prenter_inc120pl_bt8099_2012_16 Prenter_inc120pl_bt6079_2012_16 Prenter_inc120pl_bt4059_2012_16 Prenter_inc120pl_bt39_2012_16);
%reshape_chas(&chas_in.,5b,5,renter_unit_tot_2012_16 renter_bt00_2012_16 renter_bt8099_2012_16 renter_bt6079_2012_16 renter_bt4059_2012_16 renter_bt39_2012_16);

data table5b;
	set Table5b_row1 Table5b_row2 Table5b_row3 Table5b_row4 Table5b_row5;
run;

proc export data=table5b
   outfile="&outfolder.table5b.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,5c,1,renter_ncb_inc050_2006_10 Prenter_ncb_in050_bt00_2006_10 Prenter_ncb_in050_bt8099_2006_10 Prenter_ncb_in050_bt6079_2006_10 Prenter_ncb_in050_bt4059_2006_10 Prenter_ncb_in050_bt39_2006_10);
%reshape_chas(&chas_in.,5c,2,renter_cb_inc050_2006_10 Prenter_cb_in050_bt00_2006_10 Prenter_cb_in050_bt8099_2006_10 Prenter_cb_in050_bt6079_2006_10 Prenter_cb_in050_bt4059_2006_10 Prenter_cb_in050_bt39_2006_10);
%reshape_chas(&chas_in.,5c,3,renter_scb_inc050_2006_10 Prenter_scb_in050_bt00_2006_10 Prenter_scb_in050_bt8099_2006_10 Prenter_scb_in050_bt6079_2006_10 Prenter_scb_in050_bt4059_2006_10 Prenter_scb_in050_bt39_2006_10);
%reshape_chas(&chas_in.,5c,4,renter_in50_2006_10 renter_inc050_bt00_2006_10 renter_inc050_bt8099_2006_10 renter_inc050_bt6079_2006_10 renter_inc050_bt4059_2006_10 renter_inc050_bt39_2006_10);

data table5c;
	set Table5c_row1 Table5c_row2 Table5c_row3 Table5c_row4;
run;

proc export data=table5c
   outfile="&outfolder.table5c.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,5d,1,renter_ncb_inc050_2012_16 Prenter_ncb_in050_bt00_2012_16 Prenter_ncb_in050_bt8099_2012_16 Prenter_ncb_in050_bt6079_2012_16 Prenter_ncb_in050_bt4059_2012_16 Prenter_ncb_in050_bt39_2012_16);
%reshape_chas(&chas_in.,5d,2,renter_cb_inc050_2012_16 Prenter_cb_in050_bt00_2012_16 Prenter_cb_in050_bt8099_2012_16 Prenter_cb_in050_bt6079_2012_16 Prenter_cb_in050_bt4059_2012_16 Prenter_cb_in050_bt39_2012_16);
%reshape_chas(&chas_in.,5d,3,renter_scb_inc050_2012_16 Prenter_scb_in050_bt00_2012_16 Prenter_scb_in050_bt8099_2012_16 Prenter_scb_in050_bt6079_2012_16 Prenter_scb_in050_bt4059_2012_16 Prenter_scb_in050_bt39_2012_16);
%reshape_chas(&chas_in.,5d,4,renter_in50_2012_16 renter_inc050_bt00_2012_16 renter_inc050_bt8099_2012_16 renter_inc050_bt6079_2012_16 renter_inc050_bt4059_2012_16 renter_inc050_bt39_2012_16);

data table5d;
	set Table5d_row1 Table5d_row2 Table5d_row3 Table5d_row4;
run;

proc export data=table5d
   outfile="&outfolder.table5d.csv" dbms=csv replace;
run;

/* Race */

%reshape_chas(&chas_in.,6a,1,renter_inc030_2006_10 Prenter_inc030_wht_2006_10 Prenter_inc030_blk_2006_10 Prenter_inc030_api_2006_10 Prenter_inc030_aia_2006_10 Prenter_inc030_his_2006_10 Prenter_inc030_oth_2006_10);
%reshape_chas(&chas_in.,6a,2,renter_inc3050_2006_10 Prenter_inc3050_wht_2006_10 Prenter_inc3050_blk_2006_10 Prenter_inc3050_api_2006_10 Prenter_inc3050_aia_2006_10 Prenter_inc3050_his_2006_10 Prenter_inc3050_oth_2006_10);
%reshape_chas(&chas_in.,6a,3,renter_inc5080_2006_10 Prenter_inc5080_wht_2006_10 Prenter_inc5080_blk_2006_10 Prenter_inc5080_api_2006_10 Prenter_inc5080_aia_2006_10 Prenter_inc5080_his_2006_10 Prenter_inc5080_oth_2006_10);
%reshape_chas(&chas_in.,6a,4,renter_inc80100_2006_10 Prenter_inc80100_wht_2006_10 Prenter_inc80100_blk_2006_10 Prenter_inc80100_api_2006_10 Prenter_inc80100_aia_2006_10 Prenter_inc80100_his_2006_10 Prenter_inc80100_oth_2006_10);
%reshape_chas(&chas_in.,6a,5,renter_inc100pl_2006_10 Prenter_inc100pl_wht_2006_10 Prenter_inc100pl_blk_2006_10 Prenter_inc100pl_api_2006_10 Prenter_inc100pl_aia_2006_10 Prenter_inc100pl_his_2006_10 Prenter_inc100pl_oth_2006_10);
%reshape_chas(&chas_in.,6a,6,renter_unit_tot_2006_10 renter_wht_2006_10 renter_blk_2006_10 renter_api_2006_10 renter_aia_2006_10 renter_his_2006_10 renter_oth_2006_10);

data table6a;
	set Table6a_row1 Table6a_row2 Table6a_row3 Table6a_row4 Table6a_row5 Table6a_row6;
run;

proc export data=table6a
   outfile="&outfolder.table6a.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,6b,1,renter_inc030_2012_16 Prenter_inc030_wht_2012_16 Prenter_inc030_blk_2012_16 Prenter_inc030_api_2012_16 Prenter_inc030_aia_2012_16 Prenter_inc030_his_2012_16 Prenter_inc030_oth_2012_16);
%reshape_chas(&chas_in.,6b,2,renter_inc3050_2012_16 Prenter_inc3050_wht_2012_16 Prenter_inc3050_blk_2012_16 Prenter_inc3050_api_2012_16 Prenter_inc3050_aia_2012_16 Prenter_inc3050_his_2012_16 Prenter_inc3050_oth_2012_16);
%reshape_chas(&chas_in.,6b,3,renter_inc5080_2012_16 Prenter_inc5080_wht_2012_16 Prenter_inc5080_blk_2012_16 Prenter_inc5080_api_2012_16 Prenter_inc5080_aia_2012_16 Prenter_inc5080_his_2012_16 Prenter_inc5080_oth_2012_16);
%reshape_chas(&chas_in.,6b,4,renter_inc80100_2012_16 Prenter_inc80100_wht_2012_16 Prenter_inc80100_blk_2012_16 Prenter_inc80100_api_2012_16 Prenter_inc80100_aia_2012_16 Prenter_inc80100_his_2012_16 Prenter_inc80100_oth_2012_16);
%reshape_chas(&chas_in.,6b,5,renter_inc100pl_2012_16 Prenter_inc100pl_wht_2012_16 Prenter_inc100pl_blk_2012_16 Prenter_inc100pl_api_2012_16 Prenter_inc100pl_aia_2012_16 Prenter_inc100pl_his_2012_16 Prenter_inc100pl_oth_2012_16);
%reshape_chas(&chas_in.,6b,6,renter_unit_tot_2012_16 renter_wht_2012_16 renter_blk_2012_16 renter_api_2012_16 renter_aia_2012_16 renter_his_2012_16 renter_oth_2012_16);

data table6b;
	set Table6b_row1 Table6b_row2 Table6b_row3 Table6b_row4 Table6b_row5 Table6b_row6;
run;

proc export data=table6b
   outfile="&outfolder.table6b.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,6c,1,renter_inc030_wht_2006_10 placeholder renter_inc030_wht_2012_16 placeholder);
%reshape_chas(&chas_in.,6c,2,renter_inc030_1prob_wht_2006_10 Prenter_inc030_1prob_wht_2006_10 renter_inc030_1prob_wht_2012_16 Prenter_inc030_1prob_wht_2012_16);
%reshape_chas(&chas_in.,6c,3,renter_inc030_0prob_wht_2006_10 Prenter_inc030_0prob_wht_2006_10 renter_inc030_0prob_wht_2012_16 Prenter_inc030_0prob_wht_2012_16);
%reshape_chas(&chas_in.,6c,4,renter_inc030_nc_wht_2006_10 Prenter_inc030_nc_wht_2006_10 renter_inc030_nc_wht_2012_16 Prenter_inc030_nc_wht_2012_16);
%reshape_chas(&chas_in.,6c,5,renter_inc030_blk_2006_10 placeholder renter_inc030_blk_2012_16 placeholder);
%reshape_chas(&chas_in.,6c,6,renter_inc030_1prob_blk_2006_10 Prenter_inc030_1prob_blk_2006_10 renter_inc030_1prob_blk_2012_16 Prenter_inc030_1prob_blk_2012_16);
%reshape_chas(&chas_in.,6c,7,renter_inc030_0prob_blk_2006_10 Prenter_inc030_0prob_blk_2006_10 renter_inc030_0prob_blk_2012_16 Prenter_inc030_0prob_blk_2012_16);
%reshape_chas(&chas_in.,6c,8,renter_inc030_nc_blk_2006_10 Prenter_inc030_nc_blk_2006_10 renter_inc030_nc_blk_2012_16 Prenter_inc030_nc_blk_2012_16);
%reshape_chas(&chas_in.,6c,9,renter_inc030_api_2006_10 placeholder renter_inc030_api_2012_16 placeholder);
%reshape_chas(&chas_in.,6c,10,renter_inc030_1prob_api_2006_10 Prenter_inc030_1prob_api_2006_10 renter_inc030_1prob_api_2012_16 Prenter_inc030_1prob_api_2012_16);
%reshape_chas(&chas_in.,6c,11,renter_inc030_0prob_api_2006_10 Prenter_inc030_0prob_api_2006_10 renter_inc030_0prob_api_2012_16 Prenter_inc030_0prob_api_2012_16);
%reshape_chas(&chas_in.,6c,12,renter_inc030_nc_api_2006_10 Prenter_inc030_nc_api_2006_10 renter_inc030_nc_api_2012_16 Prenter_inc030_nc_api_2012_16);
%reshape_chas(&chas_in.,6c,13,renter_inc030_aia_2006_10 placeholder renter_inc030_aia_2012_16 placeholder);
%reshape_chas(&chas_in.,6c,14,renter_inc030_1prob_aia_2006_10 Prenter_inc030_1prob_aia_2006_10 renter_inc030_1prob_aia_2012_16 Prenter_inc030_1prob_aia_2012_16);
%reshape_chas(&chas_in.,6c,15,renter_inc030_0prob_aia_2006_10 Prenter_inc030_0prob_aia_2006_10 renter_inc030_0prob_aia_2012_16 Prenter_inc030_0prob_aia_2012_16);
%reshape_chas(&chas_in.,6c,16,renter_inc030_nc_aia_2006_10 Prenter_inc030_nc_aia_2006_10 renter_inc030_nc_aia_2012_16 Prenter_inc030_nc_aia_2012_16);
%reshape_chas(&chas_in.,6c,17,renter_inc030_his_2006_10 placeholder renter_inc030_his_2012_16 placeholder);
%reshape_chas(&chas_in.,6c,18,renter_inc030_1prob_his_2006_10 Prenter_inc030_1prob_his_2006_10 renter_inc030_1prob_his_2012_16 Prenter_inc030_1prob_his_2012_16);
%reshape_chas(&chas_in.,6c,19,renter_inc030_0prob_his_2006_10 Prenter_inc030_0prob_his_2006_10 renter_inc030_0prob_his_2012_16 Prenter_inc030_0prob_his_2012_16);
%reshape_chas(&chas_in.,6c,20,renter_inc030_nc_his_2006_10 Prenter_inc030_nc_his_2006_10 renter_inc030_nc_his_2012_16 Prenter_inc030_nc_his_2012_16);
%reshape_chas(&chas_in.,6c,21,renter_inc030_oth_2006_10 placeholder renter_inc030_oth_2012_16 placeholder);
%reshape_chas(&chas_in.,6c,22,renter_inc030_1prob_oth_2006_10 Prenter_inc030_1prob_oth_2006_10 renter_inc030_1prob_oth_2012_16 Prenter_inc030_1prob_oth_2012_16);
%reshape_chas(&chas_in.,6c,23,renter_inc030_0prob_oth_2006_10 Prenter_inc030_0prob_oth_2006_10 renter_inc030_0prob_oth_2012_16 Prenter_inc030_0prob_oth_2012_16);
%reshape_chas(&chas_in.,6c,24,renter_inc030_nc_oth_2006_10 Prenter_inc030_nc_oth_2006_10 renter_inc030_nc_oth_2012_16 Prenter_inc030_nc_oth_2012_16);

data table6c;
	set Table6c_row1 Table6c_row2 Table6c_row3 Table6c_row4 Table6c_row5 Table6c_row6 Table6c_row7 Table6c_row8 Table6c_row9 Table6c_row10
		Table6c_row11 Table6c_row12 Table6c_row13 Table6c_row14 Table6c_row15 Table6c_row16 Table6c_row17 Table6c_row18 Table6c_row19 Table6c_row20
		Table6c_row21 Table6c_row22 Table6c_row23 Table6c_row24;
run;

proc export data=table6c
   outfile="&outfolder.table6c.csv" dbms=csv replace;
run;

/* Disability */
%reshape_chas(&chas_in.,7a,1,renter_030_eyeear_2012_16 placeholder );
%reshape_chas(&chas_in.,7a,2,renter_030_eyeear_1prob_2012_16 Prenter_030_eyeear_1prob_2012_16 );
%reshape_chas(&chas_in.,7a,3,renter_030_eyeear_0prob_2012_16 Prenter_030_eyeear_0prob_2012_16);
%reshape_chas(&chas_in.,7a,4,renter_030_eyeear_nc_2012_16 Prenter_030_eyeear_nc_2012_16);
%reshape_chas(&chas_in.,7a,5,renter_030_amb_2012_16 placeholder );
%reshape_chas(&chas_in.,7a,6,renter_030_amb_1prob_2012_16 Prenter_030_amb_1prob_2012_16 );
%reshape_chas(&chas_in.,7a,7,renter_030_amb_0prob_2012_16 Prenter_030_amb_0prob_2012_16);
%reshape_chas(&chas_in.,7a,8,renter_030_amb_nc_2012_16 Prenter_030_amb_nc_2012_16);
%reshape_chas(&chas_in.,7a,9,renter_030_cog_2012_16 placeholder );
%reshape_chas(&chas_in.,7a,10,renter_030_cog_1prob_2012_16 Prenter_030_cog_1prob_2012_16 );
%reshape_chas(&chas_in.,7a,11,renter_030_cog_0prob_2012_16 Prenter_030_cog_0prob_2012_16);
%reshape_chas(&chas_in.,7a,12,renter_030_cog_nc_2012_16 Prenter_030_cog_nc_2012_16);
%reshape_chas(&chas_in.,7a,13,renter_030_self_2012_16 placeholder );
%reshape_chas(&chas_in.,7a,14,renter_030_self_1prob_2012_16 Prenter_030_self_1prob_2012_16 );
%reshape_chas(&chas_in.,7a,15,renter_030_self_0prob_2012_16 Prenter_030_self_0prob_2012_16);
%reshape_chas(&chas_in.,7a,16,renter_030_self_nc_2012_16 Prenter_030_self_nc_2012_16);
%reshape_chas(&chas_in.,7a,17,renter_030_nodis_2012_16 placeholder );
%reshape_chas(&chas_in.,7a,18,renter_030_nodis_1prob_2012_16 Prenter_030_nodis_1prob_2012_16 );
%reshape_chas(&chas_in.,7a,19,renter_030_nodis_0prob_2012_16 Prenter_030_nodis_0prob_2012_16);
%reshape_chas(&chas_in.,7a,20,renter_030_nodis_nc_2012_16 Prenter_030_nodis_nc_2012_16);

data table7a;
	set Table7a_row1 Table7a_row2 Table7a_row3 Table7a_row4 Table7a_row5 Table7a_row6 Table7a_row7 Table7a_row8 Table7a_row9 Table7a_row10
		Table7a_row11 Table7a_row12 Table7a_row13 Table7a_row14 Table7a_row15 Table7a_row16 Table7a_row17 Table7a_row18 Table7a_row19 Table7a_row20;
run;

proc export data=table7a
   outfile="&outfolder.table7a.csv" dbms=csv replace;
run;

%reshape_chas(&chas_in.,7b,1,renter_eyeear_2012_16 placeholder );
%reshape_chas(&chas_in.,7b,2,renter_eyeear_1prob_2012_16 Prenter_eyeear_1prob_2012_16 );
%reshape_chas(&chas_in.,7b,3,renter_eyeear_0prob_2012_16 Prenter_eyeear_0prob_2012_16);
%reshape_chas(&chas_in.,7b,4,renter_eyeear_nc_2012_16 Prenter_eyeear_nc_2012_16);
%reshape_chas(&chas_in.,7b,5,renter_amb_2012_16 placeholder );
%reshape_chas(&chas_in.,7b,6,renter_amb_1prob_2012_16 Prenter_amb_1prob_2012_16 );
%reshape_chas(&chas_in.,7b,7,renter_amb_0prob_2012_16 Prenter_amb_0prob_2012_16);
%reshape_chas(&chas_in.,7b,8,renter_amb_nc_2012_16 Prenter_amb_nc_2012_16);
%reshape_chas(&chas_in.,7b,9,renter_cog_2012_16 placeholder );
%reshape_chas(&chas_in.,7b,10,renter_cog_1prob_2012_16 Prenter_cog_1prob_2012_16 );
%reshape_chas(&chas_in.,7b,11,renter_cog_0prob_2012_16 Prenter_cog_0prob_2012_16);
%reshape_chas(&chas_in.,7b,12,renter_cog_nc_2012_16 Prenter_cog_nc_2012_16);
%reshape_chas(&chas_in.,7b,13,renter_self_2012_16 placeholder );
%reshape_chas(&chas_in.,7b,14,renter_self_1prob_2012_16 Prenter_self_1prob_2012_16 );
%reshape_chas(&chas_in.,7b,15,renter_self_0prob_2012_16 Prenter_self_0prob_2012_16);
%reshape_chas(&chas_in.,7b,16,renter_self_nc_2012_16 Prenter_self_nc_2012_16);
%reshape_chas(&chas_in.,7b,17,renter_nodis_2012_16 placeholder );
%reshape_chas(&chas_in.,7b,18,renter_nodis_1prob_2012_16 Prenter_nodis_1prob_2012_16 );
%reshape_chas(&chas_in.,7b,19,renter_nodis_0prob_2012_16 Prenter_nodis_0prob_2012_16);
%reshape_chas(&chas_in.,7b,20,renter_nodis_nc_2012_16 Prenter_nodis_nc_2012_16);

data table7b;
	set Table7b_row1 Table7b_row2 Table7b_row3 Table7b_row4 Table7b_row5 Table7b_row6 Table7b_row7 Table7b_row8 Table7b_row9 Table7b_row10
		Table7b_row11 Table7b_row12 Table7b_row13 Table7b_row14 Table7b_row15 Table7b_row16 Table7b_row17 Table7b_row18 Table7b_row19 Table7b_row20;
run;

proc export data=table7b
   outfile="&outfolder.table7b.csv" dbms=csv replace;
run;


%mend export_chas_csv;

%export_chas_csv(county,35001);
%export_chas_csv(place,3502000);


/* End of Program */
