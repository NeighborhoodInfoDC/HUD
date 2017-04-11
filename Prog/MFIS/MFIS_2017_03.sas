/**************************************************************************
 Program:  MFIS_2017_03.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   
 Created:  
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Compile HUD-insured multifamily mortgage data.
 Creates files for DC, MD, VA, and WV.
 
 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )
%DCData_lib( RealProp )


*--- EDIT PARAMETERS BELOW -----------------------------------------;

%MFIS_read_update_file( 
  filedate = '31mar2017'd,  /** Enter date of HUD database as SAS date value, ex: '25nov2014'd **/
  revisions = %str(New file.)
)
  
run;
