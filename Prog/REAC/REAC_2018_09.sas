/**************************************************************************
 Program:  REAC_2018_09.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   W. Oliver
 Created:  10/31/18
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
  filedate = '28sep2018'd,  /** Enter date of HUD database as SAS date value, ex: '25nov2014'd **/
  revisions = %str(New file.)
)
  
run;
