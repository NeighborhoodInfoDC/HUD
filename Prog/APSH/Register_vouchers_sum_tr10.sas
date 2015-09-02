/**************************************************************************
 Program:  Register_vouchers_sum_2013_tr10.sas
 Library:  HUD
 Project:  DMPED
 Author:   M. Woluchem
 Created:  10/01/14
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Register HUD.Vouchers_sum_tr10 data set with
metadata system.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD, local=n )

%Dc_update_meta_file(
  ds_lib=HUD,
  ds_name=Vouchers_sum_tr10,
  creator_process=Vouchers_sum_tr10,
  restrictions=None,
  revisions=%str(New file.)
)

run;
