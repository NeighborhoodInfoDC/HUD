/**************************************************************************
 Program:  Temp.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  06/05/05
 Version:  SAS 8.2
 Environment:  Alpha OpenVMS
 
 Description:  Export Sec8MF_current file for transfer to PC.

 Modifications:
**************************************************************************/

%include "[dcdata]Stdhead.sas";

** Define libraries **;
%DCData_lib( HUD )

%let data = Sec8mf_current_dc_jul07;

filename tranfile "[dcdata.hud.data]&data..xpt";

proc cport data=Hud.&data file=tranfile;
run;

