/**************************************************************************
 Program:  Sec8mf_history_dc_feb07.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  08/25/07
 Version:  SAS 9.1
 Environment:  Windows
 
 Description:  Create history file for Feb 2007 Sec. 8 MF update.
TEMPORARY VERSION.

 Modifications:
**************************************************************************/

%include "[dcdata]Stdhead.sas";

** Define libraries **;
%DCData_lib( HUD )

data Hud.Sec8mf_history_dc_feb07;

  set Hud.Sec8mf_current_dc_feb07
    (keep=contract_number cur_: 
     anc2002 cluster2000 cluster_tr2000 geo2000 geoblk2000 
     date_cur_contract date_cur_ui_status recordno_cur_contract)

  rename
    cur_address_line1_text=address_line1_text
    cur_assisted_units_count=assisted_units_count
    cur_contract_term=contract_term
    cur_expiration_date=expiration_date
    cur_owner_company=owner_company
    cur_owner_name=owner_name
    cur_program_type_name=program_type_name
    cur_property_id=property_id
    cur_rent_to_FMR_desc=rent_to_FMR_desc
    cur_total_unit_count=total_unit_count
    cur_tracs_effective_date=tracs_effective_date
    cur_tracs_status=tracs_status
    cur_ui_status=ui_status;
  
run;

%File_info( data=Hud.Sec8mf_history_2007_02 )

