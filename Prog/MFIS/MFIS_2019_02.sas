/**************************************************************************
 Program:  MFIS_2019_02.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   P Tatian
 Created:  3/7/2019
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  115
 
 Description:  Compile HUD-insured multifamily mortgage data.
 Creates files for DC, MD, VA, and WV.
 
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )
%DCData_lib( RealProp )


*--- EDIT PARAMETERS BELOW -----------------------------------------;

%MFIS_read_update_file( 
  filedate = '28feb2019'd,  /** Enter date of HUD database as SAS date value, ex: '25nov2014'd **/
  revisions = %str(New file.)
)
  
run;
