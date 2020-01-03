/**************************************************************************
 Program:  Input_CHAS.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Rob Pitingolo
 Created:  12/03/2019
 Version:  SAS 9.4
 Environment:  Windows
 Description: Macro to read-in and process raw CHAS data. 
 Modifications: 

**************************************************************************/

%macro input_chas (yrs,revisions);

/* List of raw CHAS tables to read-in */
%let tablelist = Table1 Table2 Table3 Table4 Table5 Table7 Table8 Table9 Table10 Table11 Table12 Table13
				 Table14A Table14B Table15A Table15B Table15C Table16 Table17A Table17B Table18A Table18B Table18C ;

%macro geo_chas (gcode);
	%macro import_chas();
		%let tables = &tablelist.;
			%let i = 1;
				%do %until (%scan(&tables,&i,' ')=);
					%let table=%scan(&tables,&i,' ');
		
		/* Import raw data CSVs */	
		proc import datafile = "&rawpath.\&yrs.-&gcode.-csv\&gcode.\&table..csv"
			out = &table. dbms = dlm replace;
			delimiter = ",";
			getnames = yes;
		run;

		/* Sort by geoid for merging later*/
		proc sort data = &table.;
			by geoid;
		run;


		%let i=%eval(&i + 1);
				%end;
			%let i = 1;
				%do %until (%scan(&tables,&i,' ')=);
					%let table=%scan(&tables,&i,' ');
		%let i=%eval(&i + 1);
				%end;
	%mend import_chas;
	%import_chas;


	/* Merge all raw tables and label */
	data table_all_&gcode.;
		merge &tablelist.;
		by geoid;
		%if &gcode. = 140 %then %do;
			sumlevel = 140;
		%end;
	run;

%mend geo_chas;
%geo_chas (050);
%geo_chas (140);
%geo_chas (160);

 %if %upcase( &yrs ) = 2006THRU2010 %then %do;
	%let yrs_ = 2006_10;
 %end;
 %else %if %upcase( &yrs ) = 2012THRU2016 %then %do;
	%let yrs_ = 2012_16;
 %end;

data chas_&yrs_._ntnl;
	length geoid $18;
	set table_all_140 table_all_160 table_all_050;
	%label_chas;

	/* Create standard geo IDs */
	statec = put(st,z2.);
	cntyc = put(cnty,z3.);
	placec = put(place,z5.);

	if sumlevel =50 then do;
		ucounty = statec || cntyc;
	end;

	if sumlevel = 140  then do;
		geo2010 = substr(geoid,8,11);
		ucounty = substr(geoid,8,5);
	end;

	if sumlevel = 160 then do;
		uplace = statec || placec;
	end;

	drop statec cntyc placec;

	label geo2010 = Census tract (2010)
		  ucounty = County
		  uplace = Place
	;

	/* Drop now unneeded numeric geo IDs */
	drop cnty st place tract;

run;

/* Save final summary file */
%Finalize_data_set( 
data=chas_&yrs_._ntnl,
out=chas_&yrs_._ntnl,
outlib=HUD,
label="Comprehensive Housing Affordability Strategy tabulations, entire country, based on ACS &yrs_.",
sortby=geoid,
restrictions=None,
printobs=0,
revisions=&revisions.
);


%mend input_chas ;

/* End of Macro */
