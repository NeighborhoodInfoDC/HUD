/**************************************************************************
 Program:  Sec8mf_history_new_file.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  08/25/07
 Version:  SAS 9.1
 Environment:  Alpha OpenVMS

 Description: Create new empty Sec8mf_history_dc file.

 Modifications:
**************************************************************************/

%include "[dcdata]Stdhead.sas";

** Define libraries **;
%DCData_lib( HUD )

data Hud.Sec8mf_history_dc;

  set Hud.SEC8MF_HISTORY_DC (obs=0);

  ssl = .;
  psa2004 = .;
  zip = .;
  x_coord = .;
  y_coord = .;

run;

%File_info( data=Hud.Sec8mf_history_dc )

