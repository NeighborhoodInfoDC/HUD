



%include "L:\SAS\Inc\StdLocal.sas"; 

** Define standard libraries **;
%DCData_lib( HUD 


/* Run summary vars */
%chas_summary_vars (2006_10, chas_test);
%chas_summary_vars (2012_16, chas_test);

%let outfolder = &_dcdata_r_path.\HUD\Raw\CHAS\Output\;

%let drop_vars = T1: T2: T3: T4: T5: T7: T8: T9: T10: T11: T12: T13: T14: T15: T16: T17: T18:;

data chas_all;
	merge Chas_test_2006_10 (drop = &drop_vars.)
		  Chas_test_2012_16 (drop = &drop_vars.) ;
	by geoid;
run;


%let chas_in = chas_all;

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


