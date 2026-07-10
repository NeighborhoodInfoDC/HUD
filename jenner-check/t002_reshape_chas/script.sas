/**************************************************************************
 Bundle:  t002_reshape_chas
 Source:  Macros/Reshape_CHAS.sas  (NeighborhoodInfoDC/HUD)

 The %reshape_chas macro is reproduced verbatim from the repository. It
 uses %sysfunc(countw()) to count the variables in a space-delimited
 varlist, then %scan to pull each one and copy it into a positional
 c1..cN column, keeping only those. Here we supply a small mock CHAS
 summary data set (chas_dc, named via the global &chas_in as in
 Export_CHAS_csv.sas) and call the macro exactly as that export program
 does for row 3 of table 1a (a 6-variable list).
**************************************************************************/

/** ---- Macro reproduced verbatim from Macros/Reshape_CHAS.sas ---- **/

%macro reshape_chas (indata,table,row,varlist);

%let var_cnt=%sysfunc(countw(&varlist.));

data table&table._row&row.;
	set &chas_in.;

	%if &var_cnt. = 8 %then %do;
		%let c1 = %scan(&varlist., 1, " ") ;
		%let c2 = %scan(&varlist., 2, " ") ;
		%let c3 = %scan(&varlist., 3, " ") ;
		%let c4 = %scan(&varlist., 4, " ") ;
		%let c5 = %scan(&varlist., 5, " ") ;
		%let c6 = %scan(&varlist., 6, " ") ;
		%let c7 = %scan(&varlist., 7, " ") ;
		%let c8 = %scan(&varlist., 8, " ") ;
		c1 = &c1.;
		c2 = &c2.;
		c3 = &c3.;
		c4 = &c4.;
		c5 = &c5.;
		c6 = &c6.;
		c7 = &c7.;
		c8 = &c8.;
		keep c1 c2 c3 c4 c5 c6 c7 c8;
	%end;

	%else %if &var_cnt. = 7 %then %do;
		%let c1 = %scan(&varlist., 1, " ") ;
		%let c2 = %scan(&varlist., 2, " ") ;
		%let c3 = %scan(&varlist., 3, " ") ;
		%let c4 = %scan(&varlist., 4, " ") ;
		%let c5 = %scan(&varlist., 5, " ") ;
		%let c6 = %scan(&varlist., 6, " ") ;
		%let c7 = %scan(&varlist., 7, " ") ;
		c1 = &c1.;
		c2 = &c2.;
		c3 = &c3.;
		c4 = &c4.;
		c5 = &c5.;
		c6 = &c6.;
		c7 = &c7.;
		keep c1 c2 c3 c4 c5 c6 c7;
	%end;

	%else %if &var_cnt. = 6 %then %do;
		%let c1 = %scan(&varlist., 1, " ") ;
		%let c2 = %scan(&varlist., 2, " ") ;
		%let c3 = %scan(&varlist., 3, " ") ;
		%let c4 = %scan(&varlist., 4, " ") ;
		%let c5 = %scan(&varlist., 5, " ") ;
		%let c6 = %scan(&varlist., 6, " ") ;
		c1 = &c1.;
		c2 = &c2.;
		c3 = &c3.;
		c4 = &c4.;
		c5 = &c5.;
		c6 = &c6.;
		keep c1 c2 c3 c4 c5 c6 ;
	%end;

	%else %if &var_cnt. = 5 %then %do;
		%let c1 = %scan(&varlist., 1, " ") ;
		%let c2 = %scan(&varlist., 2, " ") ;
		%let c3 = %scan(&varlist., 3, " ") ;
		%let c4 = %scan(&varlist., 4, " ") ;
		%let c5 = %scan(&varlist., 5, " ") ;
		c1 = &c1.;
		c2 = &c2.;
		c3 = &c3.;
		c4 = &c4.;
		c5 = &c5.;
		keep c1 c2 c3 c4 c5 ;
	%end;

	%else %if &var_cnt. = 4 %then %do;
		%let c1 = %scan(&varlist., 1, " ") ;
		%let c2 = %scan(&varlist., 2, " ") ;
		%let c3 = %scan(&varlist., 3, " ") ;
		%let c4 = %scan(&varlist., 4, " ") ;
		c1 = &c1.;
		c2 = &c2.;
		c3 = &c3.;
		c4 = &c4.;
		keep c1 c2 c3 c4;
	%end;

	%else %if &var_cnt. = 3 %then %do;
		%let c1 = %scan(&varlist., 1, " ") ;
		%let c2 = %scan(&varlist., 2, " ") ;
		%let c3 = %scan(&varlist., 3, " ") ;
		c1 = &c1.;
		c2 = &c2.;
		c3 = &c3.;
		keep c1 c2 c3 ;
	%end;

	%else %if &var_cnt. = 2 %then %do;
		%let c1 = %scan(&varlist., 1, " ") ;
		%let c2 = %scan(&varlist., 2, " ") ;
		c1 = &c1.;
		c2 = &c2.;
		keep c1 c2;
	%end;

	%else %if &var_cnt. = 1 %then %do;
		%let c1 = %scan(&varlist., 1, " ") ;
		c1 = &c1.;
		keep c1 ;
	%end;

run;

%mend reshape_chas;

/** ---- Mock CHAS summary row (columns match the row-3 varlist below) ---- **/

data chas_dc;
  input renter_unit_tot_2006_10 renter_unit_tot_2012_16
        renter_unit_aff30_2006_10 renter_unit_aff30_2012_16
        renter_unit_aff50_2006_10 renter_unit_aff50_2012_16;
  datalines;
120400 128900 41200 39800 58700 61300
;
run;

/** ---- Invoke as Export_CHAS_csv.sas does (table 1a, row 3, 6 vars) ---- **/

%reshape_chas(&chas_in.,1a,3,renter_unit_tot_2006_10 renter_unit_tot_2012_16 renter_unit_aff30_2006_10 renter_unit_aff30_2012_16 renter_unit_aff50_2006_10 renter_unit_aff50_2012_16);

proc print data=table1a_row3; run;
