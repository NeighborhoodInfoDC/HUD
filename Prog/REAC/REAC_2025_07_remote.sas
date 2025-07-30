/**************************************************************************
 Program:  REAC_2025_07_remote.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Rodrigo G
 Created:  7/29/25
 Version:  SAS 9.4
 Environment:  Remote Windows session (SAS1)
 GitHub issue: 223 
 
 Description:  Compile REAC scores data.
 Creates files for DC, MD, VA, and WV.
 
**************************************************************************/

%include "F:\DCData\SAS\Inc\StdRemote.sas";

** Define libraries **;
%DCData_lib( HUD )
%DCData_lib( RealProp )


*--- EDIT PARAMETERS BELOW -----------------------------------------;

%REAC_read_update_file( 
  finalize = N,               /** Change to Y before final batch submit **/
  filedate = '01jul2025'd,    /** Enter date of HUD database as SAS date value, ex: '25nov2014'd **/
  revisions = %str(New file.)
)
  
run;
