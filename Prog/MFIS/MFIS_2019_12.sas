/**************************************************************************
 Program:  MFIS_2019_12.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   W. Oliver
 Created:  1/28/2020
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  
 
 Description:  Compile HUD-insured multifamily mortgage data.
 Creates files for DC, MD, VA, and WV.
 
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )
%DCData_lib( RealProp )


*--- EDIT PARAMETERS BELOW -----------------------------------------;

%MFIS_read_update_file( 
  filedate = '31dec2019'd,  /** Enter date of HUD database as SAS date value, ex: '25nov2014'd **/
  revisions = %str(New file.)
)
  
run;
