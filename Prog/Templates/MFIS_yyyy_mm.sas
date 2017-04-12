/**************************************************************************
 Program:  MFIS_yyyy_mm.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   
 Created:  
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Compile HUD-insured multifamily mortgage data.
 Creates files for DC, MD, VA, and WV.
 
 Modifications:
	KA - updated macro reference to use new macro without PremiseID
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )
%DCData_lib( RealProp )


*--- EDIT PARAMETERS BELOW -----------------------------------------;

%MFIS_read_update_file_noPremID( 
  filedate = 'ddmmmyyyy'd,  /** Enter date of HUD database as SAS date value, ex: '25nov2014'd **/
  revisions = %str(New file.)
)

/* Use old macro for datasets before 7/1/16

%MFIS_read_update_file( 
  filedate = 'ddmmmyyyy'd,  
  revisions = %str(New file.)
)
*/  
run;
