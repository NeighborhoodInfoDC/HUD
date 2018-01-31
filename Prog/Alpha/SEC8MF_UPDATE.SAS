/**************************************************************************
 Program:  SEC8MF_Update.SAS
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  08/25/07
 Version:  SAS 9.1
 Environment:  Alpha OpenVMS

 Description: Autocall macro to create update of current and 
 historical Sec 8 MF data sets.

 Modifications:
  01/31/08 PAT Modified history listing.
**************************************************************************/

%macro Sec8MF_Update( month=, year=, finalize=n, state=DC, revisions= );

%global geovars idvars;

%let geovars = ssl anc2002 cluster2000 cluster_tr2000 geo2000 geoblk2000 psa2004 ward2002 x_coord y_coord zip: ;
%let idvars = associated_: br: city_: congressional_: county_code hub_name_text is_: mgmt_: owner_: 
              ownership_: placed_base_: primary_financing property_: servicing_site_: state_code tracs_: zip4_code;

%let finalize = %upcase( &finalize );
%let state = %upcase( &state );

%let month = %sysfunc( putn( &month, z2. ) );

%if &finalize = Y %then %do;
  %let current_out = Hud.Sec8mf_current_&state;
  %let history_out = Hud.Sec8mf_history_&state;
%end;
%else %do;
  %let current_out = Sec8mf_current_&state._&year._&month;
  %let history_out = Sec8mf_history_&state._&year._&month;
%end;

  %if &revisions = %then %let revisions = %str(Updated with HUD.Sec8mf_&year._&month._&state..);
  %put revisions=&revisions;

** Prepare data for merging **;
	%Sec8MF_data( HUD.Sec8mf_&year._&month._&state, _x, _Sec8mf_&year._&month._&state )
/***
%FILE_INFO( DATA=_Sec8mf_&year._&month._&state, freqvars=tracs_status_x )
***/
** Update Sec. 8 current project file **;
	%Sec8MF_current( _Sec8mf_&year._&month._&state, HUD.Sec8mf_current_&state, &current_out, &state )

%if &finalize = Y %then %do;

  ** Update metadata **;

  %Dc_update_meta_file(
    ds_lib=HUD,
    ds_name=Sec8mf_current_&state,
    creator_process=Sec8mf_update_&state._&year._&month,
    restrictions=None,
    revisions=&revisions
  )

%end;

%File_info( data=&current_out, printobs=5, freqvars=cur_program_type_name ward2002 cluster_tr2000 )

proc freq data=&current_out;
  tables cur_tracs_status * cur_ui_status
    prev_tracs_status * cur_tracs_status
    prev_ui_status * cur_ui_status
    / missing list;
run;

proc print data=&current_out n='CONTRACTS WITH STATUS CHANGE = ';
  where status_change;
  id contract_number;
  var contract_change cur_tracs_effective_date date_prev_contract date_cur_contract prev_ui_status 
      cur_ui_status prev_tracs_status cur_tracs_status prev_expiration_date cur_expiration_date;
  title2 "STATUS CHANGES";
run;
title2;


** Update project history file **;

/*%File_info( data=_history_update )*/

%Sec8mf_history( &current_out, HUD.Sec8mf_history_&state, &history_out, &state )

%if &finalize = Y %then %do;

  ** Update metadata **;

  %Dc_update_meta_file(
    ds_lib=HUD,
    ds_name=Sec8mf_history_&state,
    creator_process=Sec8mf_update_&state._&year._&month,
    restrictions=None,
    revisions=&revisions
  )

%end;

%File_info( data=&history_out, printobs=5, freqvars=contract_hist_rec ward2002 cluster_tr2000 )

proc print data=&history_out;
  id contract_number contract_hist_rec;
  by contract_number;
  var property_id total_unit_count assisted_units_count contract_term 
      expiration_date tracs_effective_date 
      date_cur_contract;
  title2 "File = &history_out (ALL OBS)";
run;

title2;

%mend Sec8MF_Update;

