/**************************************************************************
 Program:  Vouchers_sum_2004_all.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  12/06/07
 Version:  SAS 9.1
 Environment:  Local Windows session (desktop)
 
 Description:  Create all summary level files for voucher counts.

 Modifications:
  09/26/14 PAT Updated for SAS1 server.
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD, local=n )

%Create_all_summary_from_tracts( 

  register=Y,
  revisions=%str(New file.),
  creator_process=Vouchers_sum_2004_all.sas,
  restrictions=None,
  tract_yr=2000,

  lib=HUD,
  data_pre=Vouchers_sum_2004, 
  data_label=%str(Housing choice voucher summary, DC),
  count_vars=Total_:, 
  prop_vars=, 
  calc_vars=, 
  calc_vars_labels=
)

run;

