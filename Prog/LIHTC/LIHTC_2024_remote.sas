/**************************************************************************
 Program:  LIHTC_2024_remote.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  9/3/2026
 Version:  SAS 9.4
 Environment:  Remote Windows session (SAS1)
 GitHub issue:  224
 
 Description:  Read HUD LIHTC database and create separate files for
 projects in DC, MD, VA, and WV.

**************************************************************************/

%include "F:\DCData\SAS\Inc\StdRemote.sas";

** Define libraries **;
%DCData_lib( HUD )


%Lihtc_read_update_file( 
  year=2024,   /** Replace yyyy with projects placed in service year **/
  filedate='27may2025'd    /** Add file extract date as a SAS date value (eg, '01jan2009'd) **/
)

