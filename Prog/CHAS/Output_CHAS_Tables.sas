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
%let outfolder = &_dcdata_r_path.\HUD\Raw\CHAS\Output\;


** Create CHAS summary variables from national file **;
%chas_summary_vars (years=2006_10, out=chas);
%chas_summary_vars (years=2012_16, out=chas);



%let drop_vars = T1: T2: T3: T4: T5: T7: T8: T9: T10: T11: T12: T13: T14: T15: T16: T17: T18:;

data chas_bernalillo;
	merge Chas_2006_10 (drop = &drop_vars.)
		  Chas_2012_16 (drop = &drop_vars.) ;
	by geoid;
	if sumlevel = "50" and ucounty = "35001";
	placeholder = .;
run;



%let chas_in = chas_bernalillo;

/* Supply */

%reshape_chas(&chas_in.,1a,1,owner_units_tot_2006_10 owner_units_tot_2012_16 placeholder placeholder owner_unit_aff50_2006_10 owner_unit_aff50_2012_16);
%reshape_chas(&chas_in.,1a,2,forsale_units_tot_2006_10 forsale_units_tot_2012_16 placeholder placeholder forsale_units_aff50_2006_10 forsale_units_aff50_2012_16);
%reshape_chas(&chas_in.,1a,3,renter_unit_tot_2006_10 renter_unit_tot_2012_16 renter_unit_aff30_2006_10 renter_unit_aff30_2012_16 renter_unit_aff50_2006_10 renter_unit_aff50_2012_16);
%reshape_chas(&chas_in.,1a,4,forrent_units_tot_2006_10 forrent_units_tot_2012_16 forrent_units_aff30_2006_10 forrent_units_aff30_2012_16 forrent_units_aff50_2006_10 forrent_units_aff50_2012_16);

data table1a;
	set Table1a_row1 Table1a_row2 Table1a_row3 Table1a_row4 ;
run;

proc export data=table1a
   outfile="&outfolder.table1a.csv" dbms=csv replace;
run;

%reshape_chas(&chas_in.,1b,1,Powner_units_tot_2006_10 Powner_units_tot_2012_16 placeholder placeholder Powner_unit_aff50_2006_10 Powner_unit_aff50_2012_16);
%reshape_chas(&chas_in.,1b,2,Pforsale_units_tot_2006_10 Pforsale_units_tot_2012_16 placeholder placeholder Pforsale_units_aff50_2006_10 Pforsale_units_aff50_2012_16);
%reshape_chas(&chas_in.,1b,3,Prenter_unit_tot_2006_10 Prenter_unit_tot_2012_16 Prenter_unit_aff30_2006_10 Prenter_unit_aff30_2012_16 Prenter_unit_aff50_2006_10 Prenter_unit_aff50_2012_16);
%reshape_chas(&chas_in.,1b,4,Pforrent_units_tot_2006_10 Pforrent_units_tot_2012_16 Pforrent_units_aff30_2006_10 Pforrent_units_aff30_2012_16 Pforrent_units_aff50_2006_10 Pforrent_units_aff50_2012_16);

data table1b;
	set Table1b_row1 Table1b_row2 Table1b_row3 Table1b_row4 ;
run;

proc export data=table1b
   outfile="&outfolder.table1b.csv" dbms=csv replace;
run;

%reshape_chas(&chas_in.,1c,1,renter_unit_tot_2006_10 renter_unit_tot_2012_16 renter_unit_aff30_2006_10 renter_unit_aff30_2012_16 renter_unit_aff50_2006_10 renter_unit_aff50_2012_16);
%reshape_chas(&chas_in.,1c,2,renter_01br_tot_2006_10 renter_01br_tot_2012_16 renter_01br_aff30_2006_10 renter_01br_aff30_2012_16 renter_01br_aff50_2006_10 renter_01br_aff50_2012_16);
%reshape_chas(&chas_in.,1c,3,renter_2br_tot_2006_10 renter_2br_tot_2012_16 renter_2br_aff30_2006_10 renter_2br_aff30_2012_16 renter_2br_aff50_2006_10 renter_2br_aff50_2012_16);
%reshape_chas(&chas_in.,1c,4,renter_3plusbr_tot_2006_10 renter_3plusbr_tot_2012_16 renter_3plusbr_aff30_2006_10 renter_3plusbr_aff30_2012_16 renter_3plusbr_aff50_2006_10 renter_3plusbr_aff50_2012_16);

data table1c;
	set Table1c_row1 Table1c_row2 Table1c_row3 Table1c_row4 ;
run;

proc export data=table1c
   outfile="&outfolder.table1c.csv" dbms=csv replace;
run;

%reshape_chas(&chas_in.,1d,1,Prenter_unit_tot_2006_10 Prenter_unit_tot_2012_16 Prenter_unit_aff30_2006_10 Prenter_unit_aff30_2012_16 Prenter_unit_aff50_2006_10 Prenter_unit_aff50_2012_16);
%reshape_chas(&chas_in.,1d,2,Prenter_01br_tot_2006_10 Prenter_01br_tot_2012_16 Prenter_01br_aff30_2006_10 Prenter_01br_aff30_2012_16 Prenter_01br_aff50_2006_10 Prenter_01br_aff50_2012_16);
%reshape_chas(&chas_in.,1d,3,Prenter_2br_tot_2006_10 Prenter_2br_tot_2012_16 Prenter_2br_aff30_2006_10 Prenter_2br_aff30_2012_16 Prenter_2br_aff50_2006_10 Prenter_2br_aff50_2012_16);
%reshape_chas(&chas_in.,1d,4,Prenter_3plusbr_tot_2006_10 Prenter_3plusbr_tot_2012_16 Prenter_3plusbr_aff30_2006_10 Prenter_3plusbr_aff30_2012_16 Prenter_3plusbr_aff50_2006_10 Prenter_3plusbr_aff50_2012_16);

data table1d;
	set Table1d_row1 Table1d_row2 Table1d_row3 Table1d_row4 ;
run;

proc export data=table1d
   outfile="&outfolder.table1d.csv" dbms=csv replace;
run;

%reshape_chas(&chas_in.,1e,1,owner_units_tot_2006_10 owner_units_tot_2012_16 placeholder placeholder owner_unit_aff50_2006_10 owner_unit_aff50_2012_16);
%reshape_chas(&chas_in.,1e,2,owner_01br_tot_2006_10 owner_01br_tot_2012_16 placeholder placeholder owner_01br_aff50_2006_10 owner_01br_aff50_2012_16);
%reshape_chas(&chas_in.,1e,3,owner_2br_tot_2006_10 owner_2br_tot_2012_16 placeholder placeholder owner_2br_aff50_2006_10 owner_2br_aff50_2012_16);
%reshape_chas(&chas_in.,1e,4,owner_3plusbr_tot_2006_10 owner_3plusbr_tot_2012_16 placeholder placeholder owner_3plusbr_aff50_2006_10 owner_3plusbr_aff50_2012_16);

data table1e;
	set Table1e_row1 Table1e_row2 Table1e_row3 Table1e_row4 ;
run;

proc export data=table1e
   outfile="&outfolder.table1e.csv" dbms=csv replace;
run;

%reshape_chas(&chas_in.,1f,1,Powner_units_tot_2006_10 Powner_units_tot_2012_16 placeholder placeholder Powner_unit_aff50_2006_10 Powner_unit_aff50_2012_16);
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

data table2a;
	set Table2a_row1 Table2a_row2 Table2a_row3 Table2a_row4 Table2a_row5;
run;

proc export data=table2a
   outfile="&outfolder.table2a.csv" dbms=csv replace;
run;

%reshape_chas(&chas_in.,2b,1,Prnt030_inc030_allbr_2006_10 Prnt3050_inc030_allbr_2006_10 Prnt5080_inc030_allbr_2006_10 Prnt80pl_inc030_allbr_2006_10 );
%reshape_chas(&chas_in.,2b,2,Prnt030_inc3050_allbr_2006_10 Prnt3050_inc3050_allbr_2006_10 Prnt5080_inc3050_allbr_2006_10 Prnt80pl_inc3050_allbr_2006_10 );
%reshape_chas(&chas_in.,2b,3,Prnt030_inc5080_allbr_2006_10 Prnt3050_inc5080_allbr_2006_10 Prnt5080_inc5080_allbr_2006_10 Prnt80pl_inc5080_allbr_2006_10 );
%reshape_chas(&chas_in.,2b,4,Prnt030_inc80100_allbr_2006_10 Prnt3050_inc80100_allbr_2006_10 Prnt5080_inc80100_allbr_2006_10 Prnt80pl_inc80100_allbr_2006_10 );
%reshape_chas(&chas_in.,2b,5,Prnt030_inc100pl_allbr_2006_10 Prnt3050_inc100pl_allbr_2006_10 Prnt5080_inc100pl_allbr_2006_10 Prnt80pl_inc100pl_allbr_2006_10 );

data table2b;
	set Table2b_row1 Table2b_row2 Table2b_row3 Table2b_row4 Table2b_row5;
run;

proc export data=table2b
   outfile="&outfolder.table2b.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2c,1,rnt030_inc030_allbr_2012_16 rnt3050_inc030_allbr_2012_16 rnt5080_inc030_allbr_2012_16 rnt80pl_inc030_allbr_2012_16 inc030_allbr_2012_16);
%reshape_chas(&chas_in.,2c,2,rnt030_inc3050_allbr_2012_16 rnt3050_inc3050_allbr_2012_16 rnt5080_inc3050_allbr_2012_16 rnt80pl_inc3050_allbr_2012_16 inc3050_allbr_2012_16);
%reshape_chas(&chas_in.,2c,3,rnt030_inc5080_allbr_2012_16 rnt3050_inc5080_allbr_2012_16 rnt5080_inc5080_allbr_2012_16 rnt80pl_inc5080_allbr_2012_16 inc5080_allbr_2012_16);
%reshape_chas(&chas_in.,2c,4,rnt030_inc80100_allbr_2012_16 rnt3050_inc80100_allbr_2012_16 rnt5080_inc80100_allbr_2012_16 rnt80pl_inc80100_allbr_2012_16 inc80100_allbr_2012_16);
%reshape_chas(&chas_in.,2c,5,rnt030_inc100pl_allbr_2012_16 rnt3050_inc100pl_allbr_2012_16 rnt5080_inc100pl_allbr_2012_16 rnt80pl_inc100pl_allbr_2012_16 inc100pl_allbr_2012_16);

data table2c;
	set Table2c_row1 Table2c_row2 Table2c_row3 Table2c_row4 Table2c_row5;
run;

proc export data=table2c
   outfile="&outfolder.table2c.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2d,1,Prnt030_inc030_allbr_2012_16 Prnt3050_inc030_allbr_2012_16 Prnt5080_inc030_allbr_2012_16 Prnt80pl_inc030_allbr_2012_16 );
%reshape_chas(&chas_in.,2d,2,Prnt030_inc3050_allbr_2012_16 Prnt3050_inc3050_allbr_2012_16 Prnt5080_inc3050_allbr_2012_16 Prnt80pl_inc3050_allbr_2012_16 );
%reshape_chas(&chas_in.,2d,3,Prnt030_inc5080_allbr_2012_16 Prnt3050_inc5080_allbr_2012_16 Prnt5080_inc5080_allbr_2012_16 Prnt80pl_inc5080_allbr_2012_16 );
%reshape_chas(&chas_in.,2d,4,Prnt030_inc80100_allbr_2012_16 Prnt3050_inc80100_allbr_2012_16 Prnt5080_inc80100_allbr_2012_16 Prnt80pl_inc80100_allbr_2012_16 );
%reshape_chas(&chas_in.,2d,5,Prnt030_inc100pl_allbr_2012_16 Prnt3050_inc100pl_allbr_2012_16 Prnt5080_inc100pl_allbr_2012_16 Prnt80pl_inc100pl_allbr_2012_16 );

data table2d;
	set Table2d_row1 Table2d_row2 Table2d_row3 Table2d_row4 Table2d_row5;
run;

proc export data=table2d
   outfile="&outfolder.table2d.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2e,1,rnt030_inc030_01br_2006_10 rnt3050_inc030_01br_2006_10 rnt5080_inc030_01br_2006_10 rnt80pl_inc030_01br_2006_10 inc030_01br_2006_10);
%reshape_chas(&chas_in.,2e,2,rnt030_inc3050_01br_2006_10 rnt3050_inc3050_01br_2006_10 rnt5080_inc3050_01br_2006_10 rnt80pl_inc3050_01br_2006_10 inc3050_01br_2006_10);
%reshape_chas(&chas_in.,2e,3,rnt030_inc5080_01br_2006_10 rnt3050_inc5080_01br_2006_10 rnt5080_inc5080_01br_2006_10 rnt80pl_inc5080_01br_2006_10 inc5080_01br_2006_10);
%reshape_chas(&chas_in.,2e,4,rnt030_inc80100_01br_2006_10 rnt3050_inc80100_01br_2006_10 rnt5080_inc80100_01br_2006_10 rnt80pl_inc80100_01br_2006_10 inc80100_01br_2006_10);
%reshape_chas(&chas_in.,2e,5,rnt030_inc100pl_01br_2006_10 rnt3050_inc100pl_01br_2006_10 rnt5080_inc100pl_01br_2006_10 rnt80pl_inc100pl_01br_2006_10 inc100pl_01br_2006_10);

data table2e;
	set Table2e_row1 Table2e_row2 Table2e_row3 Table2e_row4 Table2e_row5;
run;

proc export data=table2e
   outfile="&outfolder.table2e.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2f,1,Prnt030_inc030_01br_2006_10 Prnt3050_inc030_01br_2006_10 Prnt5080_inc030_01br_2006_10 Prnt80pl_inc030_01br_2006_10 );
%reshape_chas(&chas_in.,2f,2,Prnt030_inc3050_01br_2006_10 Prnt3050_inc3050_01br_2006_10 Prnt5080_inc3050_01br_2006_10 Prnt80pl_inc3050_01br_2006_10 );
%reshape_chas(&chas_in.,2f,3,Prnt030_inc5080_01br_2006_10 Prnt3050_inc5080_01br_2006_10 Prnt5080_inc5080_01br_2006_10 Prnt80pl_inc5080_01br_2006_10 );
%reshape_chas(&chas_in.,2f,4,Prnt030_inc80100_01br_2006_10 Prnt3050_inc80100_01br_2006_10 Prnt5080_inc80100_01br_2006_10 Prnt80pl_inc80100_01br_2006_10 );
%reshape_chas(&chas_in.,2f,5,Prnt030_inc100pl_01br_2006_10 Prnt3050_inc100pl_01br_2006_10 Prnt5080_inc100pl_01br_2006_10 Prnt80pl_inc100pl_01br_2006_10 );

data table2f;
	set Table2f_row1 Table2f_row2 Table2f_row3 Table2f_row4 Table2f_row5;
run;

proc export data=table2f
   outfile="&outfolder.table2f.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2g,1,rnt030_inc030_01br_2012_16 rnt3050_inc030_01br_2012_16 rnt5080_inc030_01br_2012_16 rnt80pl_inc030_01br_2012_16 inc030_01br_2012_16);
%reshape_chas(&chas_in.,2g,2,rnt030_inc3050_01br_2012_16 rnt3050_inc3050_01br_2012_16 rnt5080_inc3050_01br_2012_16 rnt80pl_inc3050_01br_2012_16 inc3050_01br_2012_16);
%reshape_chas(&chas_in.,2g,3,rnt030_inc5080_01br_2012_16 rnt3050_inc5080_01br_2012_16 rnt5080_inc5080_01br_2012_16 rnt80pl_inc5080_01br_2012_16 inc5080_01br_2012_16);
%reshape_chas(&chas_in.,2g,4,rnt030_inc80100_01br_2012_16 rnt3050_inc80100_01br_2012_16 rnt5080_inc80100_01br_2012_16 rnt80pl_inc80100_01br_2012_16 inc80100_01br_2012_16);
%reshape_chas(&chas_in.,2g,5,rnt030_inc100pl_01br_2012_16 rnt3050_inc100pl_01br_2012_16 rnt5080_inc100pl_01br_2012_16 rnt80pl_inc100pl_01br_2012_16 inc100pl_01br_2012_16);

data table2g;
	set Table2g_row1 Table2g_row2 Table2g_row3 Table2g_row4 Table2g_row5;
run;

proc export data=table2f
   outfile="&outfolder.table2f.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2h,1,Prnt030_inc030_01br_2012_16 Prnt3050_inc030_01br_2012_16 Prnt5080_inc030_01br_2012_16 Prnt80pl_inc030_01br_2012_16 );
%reshape_chas(&chas_in.,2h,2,Prnt030_inc3050_01br_2012_16 Prnt3050_inc3050_01br_2012_16 Prnt5080_inc3050_01br_2012_16 Prnt80pl_inc3050_01br_2012_16 );
%reshape_chas(&chas_in.,2h,3,Prnt030_inc5080_01br_2012_16 Prnt3050_inc5080_01br_2012_16 Prnt5080_inc5080_01br_2012_16 Prnt80pl_inc5080_01br_2012_16 );
%reshape_chas(&chas_in.,2h,4,Prnt030_inc80100_01br_2012_16 Prnt3050_inc80100_01br_2012_16 Prnt5080_inc80100_01br_2012_16 Prnt80pl_inc80100_01br_2012_16 );
%reshape_chas(&chas_in.,2h,5,Prnt030_inc100pl_01br_2012_16 Prnt3050_inc100pl_01br_2012_16 Prnt5080_inc100pl_01br_2012_16 Prnt80pl_inc100pl_01br_2012_16 );

data table2h;
	set Table2h_row1 Table2h_row2 Table2h_row3 Table2h_row4 Table2h_row5;
run;

proc export data=table2h
   outfile="&outfolder.table2h.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2i,1,rnt030_inc030_2br_2006_10 rnt3050_inc030_2br_2006_10 rnt5080_inc030_2br_2006_10 rnt80pl_inc030_2br_2006_10 inc030_2br_2006_10);
%reshape_chas(&chas_in.,2i,2,rnt030_inc3050_2br_2006_10 rnt3050_inc3050_2br_2006_10 rnt5080_inc3050_2br_2006_10 rnt80pl_inc3050_2br_2006_10 inc3050_2br_2006_10);
%reshape_chas(&chas_in.,2i,3,rnt030_inc5080_2br_2006_10 rnt3050_inc5080_2br_2006_10 rnt5080_inc5080_2br_2006_10 rnt80pl_inc5080_2br_2006_10 inc5080_2br_2006_10);
%reshape_chas(&chas_in.,2i,4,rnt030_inc80100_2br_2006_10 rnt3050_inc80100_2br_2006_10 rnt5080_inc80100_2br_2006_10 rnt80pl_inc80100_2br_2006_10 inc80100_2br_2006_10);
%reshape_chas(&chas_in.,2i,5,rnt030_inc100pl_2br_2006_10 rnt3050_inc100pl_2br_2006_10 rnt5080_inc100pl_2br_2006_10 rnt80pl_inc100pl_2br_2006_10 inc100pl_2br_2006_10);

data table2i;
	set Table2i_row1 Table2i_row2 Table2i_row3 Table2i_row4 Table2i_row5;
run;

proc export data=table2i
   outfile="&outfolder.table2i.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2j,1,Prnt030_inc030_2br_2006_10 Prnt3050_inc030_2br_2006_10 Prnt5080_inc030_2br_2006_10 Prnt80pl_inc030_2br_2006_10 );
%reshape_chas(&chas_in.,2j,2,Prnt030_inc3050_2br_2006_10 Prnt3050_inc3050_2br_2006_10 Prnt5080_inc3050_2br_2006_10 Prnt80pl_inc3050_2br_2006_10 );
%reshape_chas(&chas_in.,2j,3,Prnt030_inc5080_2br_2006_10 Prnt3050_inc5080_2br_2006_10 Prnt5080_inc5080_2br_2006_10 Prnt80pl_inc5080_2br_2006_10 );
%reshape_chas(&chas_in.,2j,4,Prnt030_inc80100_2br_2006_10 Prnt3050_inc80100_2br_2006_10 Prnt5080_inc80100_2br_2006_10 Prnt80pl_inc80100_2br_2006_10 );
%reshape_chas(&chas_in.,2j,5,Prnt030_inc100pl_2br_2006_10 Prnt3050_inc100pl_2br_2006_10 Prnt5080_inc100pl_2br_2006_10 Prnt80pl_inc100pl_2br_2006_10 );

data table2j;
	set Table2j_row1 Table2j_row2 Table2j_row3 Table2j_row4 Table2j_row5;
run;

proc export data=table2j
   outfile="&outfolder.table2j.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2k,1,rnt030_inc030_2br_2012_16 rnt3050_inc030_2br_2012_16 rnt5080_inc030_2br_2012_16 rnt80pl_inc030_2br_2012_16 inc030_2br_2012_16);
%reshape_chas(&chas_in.,2k,2,rnt030_inc3050_2br_2012_16 rnt3050_inc3050_2br_2012_16 rnt5080_inc3050_2br_2012_16 rnt80pl_inc3050_2br_2012_16 inc3050_2br_2012_16);
%reshape_chas(&chas_in.,2k,3,rnt030_inc5080_2br_2012_16 rnt3050_inc5080_2br_2012_16 rnt5080_inc5080_2br_2012_16 rnt80pl_inc5080_2br_2012_16 inc5080_2br_2012_16);
%reshape_chas(&chas_in.,2k,4,rnt030_inc80100_2br_2012_16 rnt3050_inc80100_2br_2012_16 rnt5080_inc80100_2br_2012_16 rnt80pl_inc80100_2br_2012_16 inc80100_2br_2012_16);
%reshape_chas(&chas_in.,2k,5,rnt030_inc100pl_2br_2012_16 rnt3050_inc100pl_2br_2012_16 rnt5080_inc100pl_2br_2012_16 rnt80pl_inc100pl_2br_2012_16 inc100pl_2br_2012_16);

data table2k;
	set Table2k_row1 Table2k_row2 Table2k_row3 Table2k_row4 Table2k_row5;
run;

proc export data=table2k
   outfile="&outfolder.table2k.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2l,1,Prnt030_inc030_2br_2012_16 Prnt3050_inc030_2br_2012_16 Prnt5080_inc030_2br_2012_16 Prnt80pl_inc030_2br_2012_16 );
%reshape_chas(&chas_in.,2l,2,Prnt030_inc3050_2br_2012_16 Prnt3050_inc3050_2br_2012_16 Prnt5080_inc3050_2br_2012_16 Prnt80pl_inc3050_2br_2012_16 );
%reshape_chas(&chas_in.,2l,3,Prnt030_inc5080_2br_2012_16 Prnt3050_inc5080_2br_2012_16 Prnt5080_inc5080_2br_2012_16 Prnt80pl_inc5080_2br_2012_16 );
%reshape_chas(&chas_in.,2l,4,Prnt030_inc80100_2br_2012_16 Prnt3050_inc80100_2br_2012_16 Prnt5080_inc80100_2br_2012_16 Prnt80pl_inc80100_2br_2012_16 );
%reshape_chas(&chas_in.,2l,5,Prnt030_inc100pl_2br_2012_16 Prnt3050_inc100pl_2br_2012_16 Prnt5080_inc100pl_2br_2012_16 Prnt80pl_inc100pl_2br_2012_16 );

data table2l;
	set Table2l_row1 Table2l_row2 Table2l_row3 Table2l_row4 Table2l_row5;
run;

proc export data=table2l
   outfile="&outfolder.table2l.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2m,1,rnt030_inc030_3br_2006_10 rnt3050_inc030_3br_2006_10 rnt5080_inc030_3br_2006_10 rnt80pl_inc030_3br_2006_10 inc030_3br_2006_10);
%reshape_chas(&chas_in.,2m,2,rnt030_inc3050_3br_2006_10 rnt3050_inc3050_3br_2006_10 rnt5080_inc3050_3br_2006_10 rnt80pl_inc3050_3br_2006_10 inc3050_3br_2006_10);
%reshape_chas(&chas_in.,2m,3,rnt030_inc5080_3br_2006_10 rnt3050_inc5080_3br_2006_10 rnt5080_inc5080_3br_2006_10 rnt80pl_inc5080_3br_2006_10 inc5080_3br_2006_10);
%reshape_chas(&chas_in.,2m,4,rnt030_inc80100_3br_2006_10 rnt3050_inc80100_3br_2006_10 rnt5080_inc80100_3br_2006_10 rnt80pl_inc80100_3br_2006_10 inc80100_3br_2006_10);
%reshape_chas(&chas_in.,2m,5,rnt030_inc100pl_3br_2006_10 rnt3050_inc100pl_3br_2006_10 rnt5080_inc100pl_3br_2006_10 rnt80pl_inc100pl_3br_2006_10 inc100pl_3br_2006_10);

data table2m;
	set Table2m_row1 Table2m_row2 Table2m_row3 Table2m_row4 Table2m_row5;
run;

proc export data=table2m
   outfile="&outfolder.table2m.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2n,1,Prnt030_inc030_3br_2006_10 Prnt3050_inc030_3br_2006_10 Prnt5080_inc030_3br_2006_10 Prnt80pl_inc030_3br_2006_10 );
%reshape_chas(&chas_in.,2n,2,Prnt030_inc3050_3br_2006_10 Prnt3050_inc3050_3br_2006_10 Prnt5080_inc3050_3br_2006_10 Prnt80pl_inc3050_3br_2006_10 );
%reshape_chas(&chas_in.,2n,3,Prnt030_inc5080_3br_2006_10 Prnt3050_inc5080_3br_2006_10 Prnt5080_inc5080_3br_2006_10 Prnt80pl_inc5080_3br_2006_10 );
%reshape_chas(&chas_in.,2n,4,Prnt030_inc80100_3br_2006_10 Prnt3050_inc80100_3br_2006_10 Prnt5080_inc80100_3br_2006_10 Prnt80pl_inc80100_3br_2006_10 );
%reshape_chas(&chas_in.,2n,5,Prnt030_inc100pl_3br_2006_10 Prnt3050_inc100pl_3br_2006_10 Prnt5080_inc100pl_3br_2006_10 Prnt80pl_inc100pl_3br_2006_10 );

data table2n;
	set Table2n_row1 Table2n_row2 Table2n_row3 Table2n_row4 Table2n_row5;
run;

proc export data=table2n
   outfile="&outfolder.table2n.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2o,1,rnt030_inc030_3br_2012_16 rnt3050_inc030_3br_2012_16 rnt5080_inc030_3br_2012_16 rnt80pl_inc030_3br_2012_16 inc030_3br_2012_16);
%reshape_chas(&chas_in.,2o,2,rnt030_inc3050_3br_2012_16 rnt3050_inc3050_3br_2012_16 rnt5080_inc3050_3br_2012_16 rnt80pl_inc3050_3br_2012_16 inc3050_3br_2012_16);
%reshape_chas(&chas_in.,2o,3,rnt030_inc5080_3br_2012_16 rnt3050_inc5080_3br_2012_16 rnt5080_inc5080_3br_2012_16 rnt80pl_inc5080_3br_2012_16 inc5080_3br_2012_16);
%reshape_chas(&chas_in.,2o,4,rnt030_inc80100_3br_2012_16 rnt3050_inc80100_3br_2012_16 rnt5080_inc80100_3br_2012_16 rnt80pl_inc80100_3br_2012_16 inc80100_3br_2012_16);
%reshape_chas(&chas_in.,2o,5,rnt030_inc100pl_3br_2012_16 rnt3050_inc100pl_3br_2012_16 rnt5080_inc100pl_3br_2012_16 rnt80pl_inc100pl_3br_2012_16 inc100pl_3br_2012_16);

data table2o;
	set Table2o_row1 Table2o_row2 Table2o_row3 Table2o_row4 Table2o_row5;
run;

proc export data=table2o
   outfile="&outfolder.table2o.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,2p,1,Prnt030_inc030_3br_2012_16 Prnt3050_inc030_3br_2012_16 Prnt5080_inc030_3br_2012_16 Prnt80pl_inc030_3br_2012_16 );
%reshape_chas(&chas_in.,2p,2,Prnt030_inc3050_3br_2012_16 Prnt3050_inc3050_3br_2012_16 Prnt5080_inc3050_3br_2012_16 Prnt80pl_inc3050_3br_2012_16 );
%reshape_chas(&chas_in.,2p,3,Prnt030_inc5080_3br_2012_16 Prnt3050_inc5080_3br_2012_16 Prnt5080_inc5080_3br_2012_16 Prnt80pl_inc5080_3br_2012_16 );
%reshape_chas(&chas_in.,2p,4,Prnt030_inc80100_3br_2012_16 Prnt3050_inc80100_3br_2012_16 Prnt5080_inc80100_3br_2012_16 Prnt80pl_inc80100_3br_2012_16 );
%reshape_chas(&chas_in.,2p,5,Prnt030_inc100pl_3br_2012_16 Prnt3050_inc100pl_3br_2012_16 Prnt5080_inc100pl_3br_2012_16 Prnt80pl_inc100pl_3br_2012_16 );

data table2p;
	set Table2p_row1 Table2p_row2 Table2p_row3 Table2p_row4 Table2p_row5;
run;

proc export data=table2p
   outfile="&outfolder.table2p.csv" dbms=csv replace;
run;


/* Supply vs. Demand */

%reshape_chas(&chas_in.,3a,1,renter_inc030_2006_10 Prenter_inc030_cb_2006_10 Prenter_inc030_scb_2006_10 Prenter_inc030_ncb_2006_10 );
%reshape_chas(&chas_in.,3a,2,renter_inc3050_2006_10 Prenter_inc3050_cb_2006_10 Prenter_inc3050_scb_2006_10 Prenter_inc3050_ncb_2006_10 );
%reshape_chas(&chas_in.,3a,3,renter_inc5080_2006_10 Prenter_inc5080_cb_2006_10 Prenter_inc5080_scb_2006_10 Prenter_inc5080_ncb_2006_10 );
%reshape_chas(&chas_in.,3a,4,renter_inc80100_2006_10 Prenter_inc80100_cb_2006_10 Prenter_inc80100_scb_2006_10 Prenter_inc80100_ncb_2006_10 );
%reshape_chas(&chas_in.,3a,5,renter_inc100pl_2006_10 Prenter_inc100pl_cb_2006_10 Prenter_inc100pl_scb_2006_10 Prenter_inc100pl_ncb_2006_10 );

data table3a;
	set table3a_row1 table3a_row2 table3a_row3 table3a_row4 table3a_row5;
run;

proc export data=table3a
   outfile="&outfolder.table3a.csv" dbms=csv replace;
run;

%reshape_chas(&chas_in.,3b,1,renter_inc030_2012_16 Prenter_inc030_cb_2012_16 Prenter_inc030_scb_2012_16 Prenter_inc030_ncb_2012_16 );
%reshape_chas(&chas_in.,3b,2,renter_inc3050_2012_16 Prenter_inc3050_cb_2012_16 Prenter_inc3050_scb_2012_16 Prenter_inc3050_ncb_2012_16 );
%reshape_chas(&chas_in.,3b,3,renter_inc5080_2012_16 Prenter_inc5080_cb_2012_16 Prenter_inc5080_scb_2012_16 Prenter_inc5080_ncb_2012_16 );
%reshape_chas(&chas_in.,3b,4,renter_inc80100_2012_16 Prenter_inc80100_cb_2012_16 Prenter_inc80100_scb_2012_16 Prenter_inc80100_ncb_2012_16 );
%reshape_chas(&chas_in.,3b,5,renter_inc100pl_2012_16 Prenter_inc100pl_cb_2012_16 Prenter_inc100pl_scb_2012_16 Prenter_inc100pl_ncb_2012_16 );

data table3b;
	set table3b_row1 table3b_row2 table3b_row3 table3b_row4 table3b_row5;
run;

proc export data=table3b
   outfile="&outfolder.table3b.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,3c,1,renter_eldfam_2006_10 Prenter_eldfam_cb_2006_10 Prenter_eldfam_scb_2006_10 Prenter_eldfam_noprob_2006_10 );
%reshape_chas(&chas_in.,3c,2,renter_smfam_2006_10 Prenter_smfam_cb_2006_10 Prenter_smfam_scb_2006_10 Prenter_smfam_noprob_2006_10 );
%reshape_chas(&chas_in.,3c,3,renter_lgfam_2006_10 Prenter_lgfam_cb_2006_10 Prenter_lgfam_scb_2006_10 Prenter_lgfam_noprob_2006_10 );
%reshape_chas(&chas_in.,3c,4,renter_eldnf_2006_10 Prenter_eldnf_cb_2006_10 Prenter_eldnf_scb_2006_10 Prenter_eldnf_noprob_2006_10 );
%reshape_chas(&chas_in.,3c,5,renter_othhh_2006_10 Prenter_othhh_cb_2006_10 Prenter_othhh_scb_2006_10 Prenter_othhh_noprob_2006_10 );

data table3c;
	set table3c_row1 table3c_row2 table3c_row3 table3c_row4 table3c_row5;
run;

proc export data=table3c
   outfile="&outfolder.table3c.csv" dbms=csv replace;
run;

%reshape_chas(&chas_in.,3d,1,renter_eldfam_2012_16 Prenter_eldfam_cb_2012_16 Prenter_eldfam_scb_2012_16 Prenter_eldfam_noprob_2012_16 );
%reshape_chas(&chas_in.,3d,2,renter_smfam_2012_16 Prenter_smfam_cb_2012_16 Prenter_smfam_scb_2012_16 Prenter_smfam_noprob_2012_16 );
%reshape_chas(&chas_in.,3d,3,renter_lgfam_2012_16 Prenter_lgfam_cb_2012_16 Prenter_lgfam_scb_2012_16 Prenter_lgfam_noprob_2012_16 );
%reshape_chas(&chas_in.,3d,4,renter_eldnf_2012_16 Prenter_eldnf_cb_2012_16 Prenter_eldnf_scb_2012_16 Prenter_eldnf_noprob_2012_16 );
%reshape_chas(&chas_in.,3d,5,renter_othhh_2012_16 Prenter_othhh_cb_2012_16 Prenter_othhh_scb_2012_16 Prenter_othhh_noprob_2012_16 );

data table3d;
	set table3d_row1 table3d_row2 table3d_row3 table3d_row4 table3d_row5;
run;

proc export data=table3d
   outfile="&outfolder.table3d.csv" dbms=csv replace;
run;

%reshape_chas(&chas_in.,3e,1,renter_noplumb_2006_10 Prenter_noplumb_cb_2006_10 Prenter_noplumb_scb_2006_10 );
%reshape_chas(&chas_in.,3e,2,renter_hasplumb_2006_10 Prenter_hasplumb_cb_2006_10 Prenter_hasplumb_scb_2006_10 );

data table3e;
	set table3e_row1 table3e_row2 ;
run;

proc export data=table3e
   outfile="&outfolder.table3e.csv" dbms=csv replace;
run;

%reshape_chas(&chas_in.,3f,1,renter_noplumb_2012_16 Prenter_noplumb_cb_2012_16 Prenter_noplumb_scb_2012_16 );
%reshape_chas(&chas_in.,3f,2,renter_hasplumb_2012_16 Prenter_hasplumb_cb_2012_16 Prenter_hasplumb_scb_2012_16 );

data table3f;
	set table3f_row1 table3f_row2 ;
run;

proc export data=table3f
   outfile="&outfolder.table3f.csv" dbms=csv replace;
run;

%reshape_chas(&chas_in.,3g,1,renter_onlycb_2006_10 Prenter_onlycb_2006_10 );

data table3g;
	set table3g_row1 ;
run;

proc export data=table3g
   outfile="&outfolder.table3g.csv" dbms=csv replace;
run;

%reshape_chas(&chas_in.,3h,1,renter_onlycb_2012_16 Prenter_onlycb_2012_16 );

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

data table4a;
	set Table4a_row1 Table4a_row2 Table4a_row3 Table4a_row4 Table4a_row5;
run;

proc export data=table4a
   outfile="&outfolder.table4a.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,4b,1,renter_inc030_2012_16 Prentr_inc030_lte1_2012_16 Prentr_inc030_lte15_2012_16 Prentr_inc030_gt15_2012_16);
%reshape_chas(&chas_in.,4b,2,renter_inc3050_2012_16 Prentr_inc3050_lte1_2012_16 Prentr_inc3050_lte15_2012_16 Prentr_inc3050_gt15_2012_16);
%reshape_chas(&chas_in.,4b,3,renter_inc5080_2012_16 Prentr_inc5080_lte1_2012_16 Prentr_inc5080_lte15_2012_16 Prentr_inc5080_gt15_2012_16);
%reshape_chas(&chas_in.,4b,4,renter_inc80100_2012_16 Prentr_inc80100_lte1_2012_16 Prentr_inc80100_lte15_2012_16 Prentr_inc80100_gt15_2012_16);
%reshape_chas(&chas_in.,4b,5,renter_inc100pl_2012_16 Prentr_inc100pl_lte1_2012_16 Prentr_inc100pl_lte15_2012_16 Prentr_inc100pl_gt15_2012_16);

data table4b;
	set Table4b_row1 Table4b_row2 Table4b_row3 Table4b_row4 Table4b_row5;
run;

proc export data=table4b
   outfile="&outfolder.table4b.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,4c,1,rentr_inc030_1fam_2006_10 Prentr_inc030_lte1_1fam_2006_10 Prentr_inc030_lte15_1fam_2006_10 Prentr_inc030_gt15_1fam_2006_10);
%reshape_chas(&chas_in.,4c,2,rentr_inc030_sfam_2006_10 Prentr_inc030_lte1_sfam_2006_10 Prentr_inc030_lte15_1fam_2006_10 Prentr_inc030_gt15_sfam_2006_10);
%reshape_chas(&chas_in.,4c,3,rentr_inc030_nfam_2006_10 Prentr_inc030_lte1_nfam_2006_10 Prentr_inc030_lte15_nfam_2006_10 Prentr_inc030_gt15_nfam_2006_10);

data table4c;
	set Table4c_row1 Table4c_row2 Table4c_row3 ;
run;

proc export data=table4c
   outfile="&outfolder.table4c.csv" dbms=csv replace;
run;


%reshape_chas(&chas_in.,4d,1,rentr_inc030_1fam_2012_16 Prentr_inc030_lte1_1fam_2012_16 Prentr_inc030_lte15_1fam_2012_16 Prentr_inc030_gt15_1fam_2012_16);
%reshape_chas(&chas_in.,4d,2,rentr_inc030_sfam_2012_16 Prentr_inc030_lte1_sfam_2012_16 Prentr_inc030_lte15_1fam_2012_16 Prentr_inc030_gt15_sfam_2012_16);
%reshape_chas(&chas_in.,4d,3,rentr_inc030_nfam_2012_16 Prentr_inc030_lte1_nfam_2012_16 Prentr_inc030_lte15_nfam_2012_16 Prentr_inc030_gt15_nfam_2012_16);

data table4d;
	set Table4d_row1 Table4d_row2 Table4d_row3 ;
run;

proc export data=table4d
   outfile="&outfolder.table4d.csv" dbms=csv replace;
run;
