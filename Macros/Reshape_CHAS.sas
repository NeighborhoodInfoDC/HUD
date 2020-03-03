/**************************************************************************
 Program:  Reshape_CHAS.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Rob Pitingolo
 Created:  01/22/2020
 Version:  SAS 9.4
 Environment:  Windows
 Description: Reshape CHAS summary data for output tables. 
 Modifications: 

**************************************************************************/

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


/* End of Macro*/
