/**************************************************************************
 Program:  LIHTC_yyyy.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   
 Created:  
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  
 
 Description:  Read HUD LIHTC database and create separate files for
 projects in DC, MD, VA, and WV.

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )


%Lihtc_read_update_file( year=yyyy, filedate= )

