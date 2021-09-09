/**************************************************************************
 Program:  APSH_project_2020.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  02/13/21
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  185
 
 Description:  Read APSH 2020 project data.

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )


%Apsh_read_project( year=2020, revisions=%str(New file.) )

