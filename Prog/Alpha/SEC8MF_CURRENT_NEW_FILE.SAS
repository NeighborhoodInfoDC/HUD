/**************************************************************************
 Program:  Sec8mf_current_new_file.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  08/25/07
 Version:  SAS 9.1
 Environment:  Alpha OpenVMS

 Description: Create new empty Sec8mf_current_dc file.

 Modifications:
**************************************************************************/

%include "[dcdata]Stdhead.sas";

** Define libraries **;
%DCData_lib( HUD )

data Hud.Sec8mf_current_dc;

  set Hud.SEC8MF_CURRENT_DC (obs=0);

  ssl = .;
  psa2004 = .;
  zip = .;
  x_coord = .;
  y_coord = .;

/***
  contract_rec = .;

   keep contract_number cur_: prev_: contract_rec contract_change status_change
      anc2002 cluster2000 cluster_tr2000 geo2000 geoblk2000 ward2002
      date_cur_contract date_cur_ui_status recordno_cur_contract
      date_prev_contract date_prev_ui_status recordno_prev_contract
   ;
***/
 
run;

%File_info( data=Hud.Sec8mf_current_dc )

