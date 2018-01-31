/**************************************************************************
 Program:  SEC8MF_HISTORY.SAS
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  08/25/07
 Version:  SAS 9.1
 Environment:  Alpha OpenVMS

 Description: Autocall macro to update Sec 8 MF history file.

 Modifications:
  09/14/07 PT  Dropped date_cur_ui_status, cur_ui_status and 
               cur_tracs_status from output file.
  01/31/08 PAT Added corrections for DC390014006, DC39H001005 and
               DC390005015.
**************************************************************************/

%macro Sec8MF_history( currentfile, basefile, outfile, state );

data _Sec8mf_history_update;

  set &currentfile
    (keep=contract_number contract_hist_rec cur_: 
     date_cur_contract /***date_cur_ui_status***/ recordno_cur_contract);

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
    /***cur_tracs_status=tracs_status
    cur_ui_status=ui_status***/;

  label
      cur_address_line1_text = "Property street address/first line of mailing address"
      cur_assisted_units_count = "Total number of assisted units for contract"
      cur_contract_term = "Term of contract (months)"
      cur_expiration_date = "Overall expiration date"
      cur_owner_company = "Type of owner company"
      cur_owner_name = "Name of owner"
      cur_program_type_name = "Program type, provided from TRACS"
      cur_property_id = "REMS-assigned identifier for each property"
      cur_rent_to_FMR_desc = "Rent to FMR ratio for assisted units"
      cur_total_unit_count = "Total number of units for property"
      cur_tracs_effective_date = "Effective date of contract as provided by TRACS"
      /***cur_tracs_status = "Contract status (from TRACS)"
      cur_ui_status = "UI coded contract status"***/
      date_cur_contract = "Date of most recent HUD update file for contract"
      /***date_cur_ui_status = "Date of most recent update of UI status for contract"***/
      recordno_cur_contract = "Record no. of most recent HUD update file for contract"
  ;

  drop cur_tracs_status cur_ui_status;

run;

** Update file **;

data _Sec8mf_history_final (compress=no);

  update &basefile _Sec8mf_history_update updatemode=missingcheck;
  by contract_number contract_hist_rec;

run;

data &outfile (sortedby=contract_number contract_hist_rec label="Sec 8 multifamily contracts, history, &state");

  merge 
    _Sec8mf_history_final (drop=&geovars)
    &currentfile (keep=contract_number &geovars);
  by contract_number;

    ** Data corrections **;

    select ( contract_number );
      when ( 'DC39H001005' /** SOUTHVIEW APTS I **/ ) do;
        assisted_units_count = 159;
        total_unit_count = 159;
      end;
      when ( 'DC390014006' /** Southview II **/ ) do;
        assisted_units_count = 98;
        total_unit_count = 98;
      end;
      when ( 'DC390005015' /** Huntington Village **/ ) do;
        if contract_hist_rec < 5 then do;
          assisted_units_count = 204;
          total_unit_count = 204;
        end;
      end;
      otherwise
        /** Do nothing **/;
    end;

run;

%mend Sec8MF_history;
