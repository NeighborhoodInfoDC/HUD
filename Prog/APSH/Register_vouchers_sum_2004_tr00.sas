/**************************************************************************
 Program:  Register_vouchers_sum_2004_tr00.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  09/26/14
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Register HUD.Vouchers_sum_2004_tr00 data set with
metadata system.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD, local=n )

%Dc_update_meta_file(
  ds_lib=HUD,
  ds_name=Vouchers_sum_2004_tr00,
  creator_process=Vouchers_sum_2004_tr00,
  restrictions=Confidential,
  revisions=%str(New file.)
)

run;
