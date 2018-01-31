/**************************************************************************
 Program:  Sec8MF_current.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  08/25/07
 Version:  SAS 9.1
 Environment:  Alpha OpenVMS

 Description: Create an updated current Sec 8 MF project file.
 
 Modifications:
  01/31/08 PAT Added corrections for DC390014006 and DC39H001005.
**************************************************************************/

%macro Sec8MF_current (currentfile, basefile, outfile, state);

  %let base=_&basefile;
  %let update=_x;
  %let filename_prefix = _tmp;

  ** Merge update file to the base file **;
  
  data &filename_prefix.&currentfile;

    merge 
      &basefile (drop=&geovars in=in1) 
      &currentfile (in=in2) 
      HUD.Sec8MF_geo_&state (keep=contract_number &geovars in=in3);
    by contract_number;

    if in1 or in2;

    if not in3 then do;
      %warn_put( 
        macro=Sec8MF_current, 
        msg="Contract not in geo file: " contract_number= property_id= address_line1_text_x= 
      )
    end;

    /* Need dates for all cases (contracts that fell out of the system do not have these;
      they could be coded as active below if these reference points are not included) */

      /* Create contract status for January 2003 base file to initialize values of the ui_status variable. 
      The code below sets these values using both a base file and an update file. However, for the 
      Jun 2003 file, the base file and update method cannot be used. For this file only, we can only 
      know whether it is active or expired- we can't tell if it is new or renewed.  */

    ** Create UI status variable **;

    status_change = 0;
    
    if tracs_status&update = 'T' then ui_status&update=5;
    else if ((expiration_date&update lt (extract_date&update-60)) and not(missing(expiration_date&update))) or 
      (tracs_status&update='X' /*"Expired"*/ ) then 
        ui_status&update=4; /* 4=expired contracts*/ 
    else if cur_expiration_date = . then ui_status&update=1; /* 1=new contracts */
    else if expiration_date&update gt cur_expiration_date then ui_status&update=2;/* 2=renewed contracts */
    else ui_status&update=cur_ui_status; /*Set to current status*/

    if ui_status&update ne cur_ui_status or expiration_date&update gt cur_expiration_date then do;
      date_prev_ui_status = date_cur_ui_status;      /* Status change */
      date_cur_ui_status = extract_date&update;
      prev_ui_status = cur_ui_status;
      cur_ui_status = ui_status&update;
      status_change = 1;
    end;

    contract_change = 0;       /** Flag to indicate whether contract has changed **/

    if expiration_date&update gt cur_expiration_date or date_cur_contract = . then do;
      contract_change = 1;          /* Contract was changed (new contracts & renewals) */
      date_prev_contract = date_cur_contract;      /* Update contract source file date */
      date_cur_contract = extract_date&update;
      recordno_prev_contract = recordno_cur_contract;    /* Update contract source file record no */
      recordno_cur_contract = recordno&update;
    end;
      
    /* Examining changes in values of other measures across the base file and update files */

    /* Numeric variables */

    array update_n (*) property_id&update expiration_date&update assisted_units_count&update 
      total_unit_count&update contract_term&update tracs_effective_date&update; 

    array cur_n (*) cur_property_id cur_expiration_date cur_assisted_units_count 
      cur_total_unit_count cur_contract_term cur_tracs_effective_date; 

    array prev_n (*) prev_property_id prev_expiration_date prev_assisted_units_count 
      prev_total_unit_count prev_contract_term prev_tracs_effective_date; 

    do i=1 to dim( prev_n );

      if contract_change then do;  /* if change in contract status */
        prev_n(i) = cur_n(i);            /* assign current to prev values */
        cur_n(i) = update_n(i);            /* assign updated value to current */
      end;
      else if cur_n(i) ne update_n(i) and not( missing( update_n(i) ) ) then do;  
        /* if no contract status change but change in value */
        %note_put( msg='Change in contract var: ' contract_number= cur_n(i)= update_n(i)= )  /* report change in log */
        cur_n(i) = update_n(i);                      /* assign updated value to current */
      end;

    end;

    /* Character variables */

    /** Need to specify lengths of array char vars or else length defaults to 8 **/

    length cur_tracs_status $ 1 cur_program_type_name $ 20 cur_owner_company $ 2 
      cur_address_line1_text $ 45 cur_rent_to_FMR_desc $ 40 cur_owner_name $ 255;

    length prev_tracs_status $ 1 prev_program_type_name $ 20 prev_owner_company $ 2 
      prev_address_line1_text $ 45 prev_rent_to_FMR_desc $ 40 prev_owner_name $ 255;

    array update_c (*) $ tracs_status&update program_type_name&update owner_company&update 
      address_line1_text&update rent_to_FMR_desc&update owner_name&update;

    array cur_c (*) $ cur_tracs_status cur_program_type_name cur_owner_company 
      cur_address_line1_text cur_rent_to_FMR_desc cur_owner_name;

    array prev_c (*) $ prev_tracs_status prev_program_type_name prev_owner_company 
      prev_address_line1_text prev_rent_to_FMR_desc prev_owner_name;

    do i=1 to dim( prev_c );

      if contract_change then do;  /* if change in contract status */
        prev_c(i) = cur_c(i);            /* assign current to prev values */
        cur_c(i) = update_c(i);            /* assign updated value to current */
      end;
      else if cur_c(i) ne update_c(i) and not( missing( update_c(i) ) ) then do;  
        /* if no contract status change but change in value */
        %note_put( msg='Change in contract var: ' contract_number= cur_c(i)= update_c(i)= )  /* report change in log */
        cur_c(i) = update_c(i);                      /* assign updated value to current */
      end;

    end;

    ** Update history file record number **;

    if contract_change then do;
      if missing( contract_hist_rec ) then contract_hist_rec = 1;
      else contract_hist_rec = contract_hist_rec + 1;
    end;

    ** Data corrections **;

    select ( contract_number );
      when ( 'DC39H001005' /** SOUTHVIEW APTS I **/ ) do;
        prev_assisted_units_count = 159;
        cur_total_unit_count = 159;
        prev_total_unit_count = 159;
      end;
      when ( 'DC390014006' /** Southview II **/ ) do;
        cur_assisted_units_count = 98;
        prev_assisted_units_count = 98;
        cur_total_unit_count = 98;
        prev_total_unit_count = 98;
      end;
      otherwise
        /** Do nothing **/;
    end;

    /* format new variables */
    format 
      extract_date&update
      expiration_date&update cur_expiration_date
      prev_expiration_date date_cur_ui_status date_prev_ui_status
      date_cur_contract date_prev_contract
      prev_tracs_effective_date cur_tracs_effective_date 
        mmddyy10. 
        
      prev_tracs_status cur_tracs_status $s8stat.
      ui_status&update cur_ui_status prev_ui_status s8ui4cat.
      prev_owner_company cur_owner_company $s8owmgt. 
      prev_program_type_name cur_program_type_name $s8pgmnm. ;

    label
      contract_number = "TRACS-assigned contract number"
      contract_hist_rec = "Sequence no. of current contract record in history file"

      contract_change = "Contract change in most recent update"
      status_change = "Status change in most recent update"

      cur_address_line1_text = "Property street address/first line of mailing address, current contract"
      cur_assisted_units_count = "Total number of assisted units for contract, current contract"
      cur_contract_term = "Term of contract (months), current contract"
      cur_expiration_date = "Overall expiration date, current contract"
      cur_owner_company = "Type of owner company, current contract"
      cur_owner_name = "Name of owner, current contract"
      cur_program_type_name = "Program type, provided from TRACS, current contract"
      cur_property_id = "REMS-assigned identifier for each property, current contract"
      cur_rent_to_FMR_desc = "Rent to FMR ratio for assisted units, current contract"
      cur_total_unit_count = "Total number of units for property, current contract"
      cur_tracs_effective_date = "Effective date of contract as provided by TRACS, current contract"
      cur_tracs_status = "Contract status (from TRACS), current contract"
      cur_ui_status = "UI coded contract status, current contract"
      date_cur_contract = "Date of most recent HUD update file for current contract"
      date_cur_ui_status = "Date of most recent update of UI status for current contract"
      recordno_cur_contract = "Record no. of most recent HUD update file for current contract"

      prev_address_line1_text = "Property street address/first line of mailing address, previous contract"
      prev_assisted_units_count = "Total number of assisted units for contract, previous contract"
      prev_contract_term = "Term of contract (months), previous contract"
      prev_expiration_date = "Overall expiration date, previous contract"
      prev_owner_company = "Type of owner company, previous contract"
      prev_owner_name = "Name of owner, previous contract"
      prev_program_type_name = "Program type, provided from TRACS, previous contract"
      prev_property_id = "REMS-assigned identifier for each property, previous contract"
      prev_rent_to_FMR_desc = "Rent to FMR ratio for assisted units, previous contract"
      prev_total_unit_count = "Total number of units for property, previous contract"
      prev_tracs_effective_date = "Effective date of contract as provided by TRACS, previous contract"
      prev_tracs_status = "Contract status (from TRACS), previous contract"
      prev_ui_status = "UI coded contract status, previous contract"
      date_prev_contract = "Date of most recent HUD update file for previous contract"
      date_prev_ui_status = "Date of most recent update of UI status for previous contract"
      recordno_prev_contract = "Record no. of most recent HUD update file for previous contract";

    keep contract_number cur_: prev_: contract_hist_rec contract_change status_change
      date_cur_contract date_cur_ui_status recordno_cur_contract
      date_prev_contract date_prev_ui_status recordno_prev_contract
      &geovars &idvars
   ;

  run;
  
  proc sort data=&filename_prefix.&currentfile
    out=&outfile 
         (label="Sec 8 multifamily contracts, current status, &state");
  by contract_number;
  
  run;

%mend Sec8MF_current;


