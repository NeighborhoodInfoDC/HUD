/**************************************************************************
 Program:  LIHTC_2016.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   M. Cohen
 Created:  6/21/18
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Read HUD LIHTC database and create separate files for
 projects in DC, MD, VA, and WV.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )


%Lihtc_read_update_file( year=2016, filedate='20jun2018'd )

