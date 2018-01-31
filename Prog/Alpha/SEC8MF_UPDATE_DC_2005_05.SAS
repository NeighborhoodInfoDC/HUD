/**************************************************************************
 Program:  SEC8MF_Update_DC_2005_05.SAS
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  08/26/07
 Version:  SAS 9.1
 Environment:  Alpha OpenVMS
 
 Description:  

 Modifications:
**************************************************************************/

%include "[dcdata]Stdhead.sas";

** Define libraries **;
%DCData_lib( HUD )

%Sec8MF_update(
  month=05,
  year=2005,
  finalize=Y
)


