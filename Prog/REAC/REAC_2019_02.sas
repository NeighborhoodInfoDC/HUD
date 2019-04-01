/**************************************************************************
 Program:  REAC_2019_02.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   M. Cohen
 Created:  4/1/19
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 
 Description:  Compile REAC scores data.
 Creates files for DC, MD, VA, and WV.
 
 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )
%DCData_lib( RealProp )


*--- EDIT PARAMETERS BELOW -----------------------------------------;

%REAC_read_update_file( 
  filedate = '06feb2019'd,  /** Enter date of HUD database as SAS date value, ex: '25nov2014'd **/
  revisions = %str(New file.)
)
  
run;
