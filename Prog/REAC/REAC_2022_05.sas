/**************************************************************************
 Program:  REAC_yyyy_mm.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Donovan Harvey
 Created:  5/17/2022
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  HUD Issue #210
 
 Description:  Compile REAC scores data.
 Creates files for DC, MD, VA, and WV.
 
 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )
%DCData_lib( RealProp )


*--- EDIT PARAMETERS BELOW -----------------------------------------;

%REAC_read_update_file( 
  filedate = '05may2022'd,  /** Enter date of HUD database as SAS date value, ex: '25nov2014'd **/
  revisions = %str(New file.)
)
  
run;
