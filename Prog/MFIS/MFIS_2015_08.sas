/**************************************************************************
 Program:  MFIS_yyyy_mm.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  9/2/2015
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Compile HUD-insured multifamily mortgage data.
 Creates files for DC, MD, VA, and WV.
 
 Modifications:
**************************************************************************/

/*%include "L:\SAS\Inc\StdLocal.sas";*/
%include "C:\DCData\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD, local=n )
%DCData_lib( RealProp, local=n )

%LET _REMOTE_BATCH_SUBMIT = 1;  %*** TEMPORARY ****;


*--- EDIT PARAMETERS BELOW -----------------------------------------;

%MFIS_read_update_file( 
  filedate = '31aug2015'd,  /** Enter date of HUD database as SAS date value, ex: '25nov2014'd **/
  finalize = Y
)
  
run;
