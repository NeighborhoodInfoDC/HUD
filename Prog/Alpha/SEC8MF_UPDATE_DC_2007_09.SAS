/**************************************************************************
 Program:  SEC8MF_Update_DC_2007_09.SAS
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  11/20/07
 Version:  SAS 9.1
 Environment:  Alpha OpenVMS
 
 Description:  

 Modifications:
**************************************************************************/

%include "[dcdata]Stdhead.sas";

** Define libraries **;
%DCData_lib( HUD )

%Sec8MF_update(
  month=09,
  year=2007,
  finalize=Y
)


