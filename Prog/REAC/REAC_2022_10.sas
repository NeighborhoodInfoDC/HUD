/**************************************************************************
 Program:  REAC_2022_10.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Donovan Harvey
 Created:  11/29/2022
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  #214
 
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
  filedate = '11oct2022'd,  /** Enter date of HUD database as SAS date value, ex: '25nov2014'd **/
  revisions = %str(New file.)
)
  
run;
