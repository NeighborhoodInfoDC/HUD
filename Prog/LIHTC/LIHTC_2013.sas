/**************************************************************************
 Program:  LIHTC_2013.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  12/15/15
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Read HUD LIHTC database and create separate files for
 projects in DC, MD, VA, and WV.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )


%Lihtc_read_update_file( year=2013, filedate='18jun2015'd )

