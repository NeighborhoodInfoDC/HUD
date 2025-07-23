/**************************************************************************
 Program:  LIHTC_yyyy_remote.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   
 Created:  
 Version:  SAS 9.4
 Environment:  Remote Windows session (SAS1)
 GitHub issue:  
 
 Description:  Read HUD LIHTC database and create separate files for
 projects in DC, MD, VA, and WV.

**************************************************************************/

%include "F:\DCData\SAS\Inc\StdRemote.sas";

** Define libraries **;
%DCData_lib( HUD )


%Lihtc_read_update_file( 
  finalize=N,  /** Change to Y before final batch submit **/
  year=yyyy,   /** Replace yyyy with projects placed in service year **/
  filedate=    /** Add file extract date as a SAS date value (eg, '01jan2009'd) **/
)

