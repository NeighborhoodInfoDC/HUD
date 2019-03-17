/**************************************************************************
 Program:  APSH_project_2018.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  03/16/19
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 
 Description:  Read APSH project data.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )


%Apsh_read_project( year=2018, revisions=%str(New file.) )

