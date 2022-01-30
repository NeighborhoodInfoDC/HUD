/**************************************************************************
 Program:  LIHTC_2019.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  1/30/2022
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  199
 
 Description:  Read HUD LIHTC database and create separate files for
 projects in DC, MD, VA, and WV.

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )


%Lihtc_read_update_file( year=2019, filedate='16apr2021'd )

