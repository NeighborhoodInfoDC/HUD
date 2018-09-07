/**************************************************************************
 Program:  REAC_yyyy_mm.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   K.Abazajian
 Created:  9/22/16
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

%MFIS_read_update_file( 
  filedate = '06jun2018'd,  /** Enter date of HUD database as SAS date value, ex: '25nov2014'd **/
  revisions = %str(New file.)
)
  
run;
