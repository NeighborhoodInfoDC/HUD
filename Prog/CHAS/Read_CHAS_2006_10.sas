/**************************************************************************
 Program:  Read_CHAS_2006_10.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Rob Pitingolo
 Created:  12/01/2019
 Version:  SAS 9.4
 Environment:  Windows
 Description: Reads in national CHAS data and labels variables from data dictionary.
			  Saves a national tract, county and place level dataset to the DC Data warehouse. 
 Modifications: 

**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas"; 

** Define standard libraries **;
%DCData_lib( HUD )

** Define raw libraries **;
%let rawpath = &_dcdata_r_path.\HUD\Raw\CHAS;
libname chasraw "&rawpath.";



%input_chas (yrs = 2006thru2010,
			 revisions = New file.);


/* End of program */


