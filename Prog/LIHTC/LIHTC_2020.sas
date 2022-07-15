/**************************************************************************
 Program:  LIHTC_2020.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Donovan Harvey
 Created:  07/11/2022
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  Update-#212
 
 Description:  Read HUD LIHTC database and create separate files for
 projects in DC, MD, VA, and WV.

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )


%Lihtc_read_update_file( year=2020, filedate= '08apr2022'd)

