/**************************************************************************
 Program:  Sec8MF_current_dc_yyyy_mm.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   
 Created:  
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Update Sec8MF_current_dc and Sec8MF_history_dc files
 with latest Sec8MF_yyyy_mm update data.
 
 NB:  Change finalize=Y for final batch run.

 Modifications:
  10/19/14 PAT Updated for SAS1.
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD, local=n )

%Sec8MF_update(
  month=mm,
  year=yyyy,
  finalize=N
)

run;

