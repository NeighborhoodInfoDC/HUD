/**************************************************************************
 Program:  Sec8MF_readbasetbls.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  12/22/14
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description: SAS autocall macro to combine base tables from the Multifamily
 Assistance and Section 8 Contracts Database to create a file
 that includes all Section 8 contracts data with their relevant
 properties information.

 INPUT FILES:            Comma-separated ASCII files 
                         (MF_Properties_with_Assistance___Sec8_Contracts
                         & MF_Assistance___Sec8_Contracts) exported from Access db
                         (MF_Assistance_&_Sec8_Contracts.mdb)

 Modifications:
  06/03/05 PT  New macro-based version.
  07/07/05 PT  Added check for duplicates.
  07/29/05 PT  Added variable labels.
  03/09/06 PT  Added STATECODE to non-matching obs. message.
  08/29/06 PT  Changed merge to new version %sect8_merge()
  10/19/14 PT  Changed folder for input files to Raw.
  12/23/14 PAT Adapted for DCData from Sec8MF_readbasetbls.sas.
  12/31/14 PAT Changed length of rent_to_fmr_description to $40. 
**************************************************************************/

/** Macro Sec8MF_readbasetbls - Start Definition **/

%macro sec8mf_readbasetbls( 
  filedate=,                      /** File extract date (SAS date value) **/
  folder=&_dcdata_r_path\HUD      /** Folder for input raw files **/ 
);

  %let month = %sysfunc( month( &filedate ), z2. );
  %let year  = %sysfunc( year( &filedate ), z4. );
  %let filedate_fmt = %sysfunc( putn( &filedate, mmddyy10. ) );
  
  %put _user_;

  %if %length( &month ) ~= 2 %then %do;
    %err_mput( macro=Sec8MF_readbasetbls, msg=Month= parameter must be 2-digit month.  Month=&month )
    %goto exit_macro;
  %end;

  %if %length( &year ) ~= 4 %then %do;
    %err_mput( macro=Sec8MF_readbasetbls, msg=Year= parameter must be 4-digit year.  Year=&year )
    %goto exit_macro;
  %end;

  **Step1. Read in the current month files**;

  * Universe of properties and related property-level information corresponding 
  * to the universe of active assistance and Section 8 contracts in 
  * Multifamily Housing;

  filename rp&month.&year "&folder\Raw\Sec8MF\&year-&month\MF_Properties_with_Assistance___Sec8_Contracts.txt";

  data MF_Properties_&month._&year
         (label="Sec 8 multifamily projects, property-level data, extract date &filedate_fmt");
  	infile rp&month.&year dlm=',' firstobs=2 flowover dsd lrecl=4000;
  	length
  		hub_name_text $30.
  		servicing_site_name_text $40.
  		property_id 8.
  		property_name_text $50.
  		property_phone_number $25.
  		address_line1_text $45.
  		address_line2_text $45.
  		city_name_text $28.
  		state_code $2.
  		zip_code $5.
  		zip4_code $4.
  		county_code $3.
  		county_name_text $30.
  		msa_code $4.
  		msa_name_text $30.
  		congressional_district_code $15.
  		placed_base_city_name_text $30.
  		property_total_unit_count 8.
  		property_category_name $60.
  		primary_financing_type $30.
  		associated_financing_number $18.
  		is_insured_ind $1.
  		is_202_811_ind $1.
  		is_hud_held_ind $1.
  		is_hud_owned_ind $1.
  		is_hospital_ind $1.
  		is_nursing_home_ind $1.
  		is_board_and_care_ind $1.
  		is_assisted_living_ind $1.
  		is_refinanced_ind $1.
  		is_221d3_ind $1.
  		is_221d4_ind $1.
  		is_236_ind $1.
  		is_non_insured_ind $1.
  		is_bmir_ind $1.
  		is_risk_sharing_ind $1.
  		is_mip_ind $1.
  		is_co_insured_ind $1.
  		ownership_effective_date 8.
  		owner_participant_id 8.
  		owner_company_type $20.
  		owner_individual_first_name $18.
  		owner_individual_middle_name $18.
  		owner_individual_last_name $20.
  		owner_individual_full_name $60.
  		owner_individual_title_text $100.
  		owner_organization_name $50.
  		owner_address_line1 $45.
  		owner_address_line2 $45.
  		owner_city_name $28.
  		owner_state_code $2.
  		owner_zip_code $5.
  		owner_zip4_code $4.
  		owner_main_phone_number_text $25.
  		owner_main_fax_number_text $25.
  		owner_email_text $100.
  		mgmt_agent_participant_id 8.
  		mgmt_agent_company_type $20.
  		mgmt_agent_indv_first_name $18.
  		mgmt_agent_indv_last_name $18.
  		mgmt_agent_indv_middle_name $18.
  		mgmt_agent_full_name $56.
  		mgmt_agent_indv_title_text $100.
  		mgmt_agent_org_name $50.
  		mgmt_agent_address_line1 $45.
  		mgmt_agent_address_line2 $45.
  		mgmt_agent_city_name $28.
  		mgmt_agent_state_code $2.
  		mgmt_agent_zip_code $5.
  		mgmt_agent_zip4_code $4.
  		mgmt_agent_main_phone_number $25.
  		mgmt_agent_main_fax_number $18.
  		mgmt_agent_email_text $100.;

  	input
  		hub_name_text $
  		servicing_site_name_text $
  		property_id
  		property_name_text $
  		property_phone_number $
  		address_line1_text $
  		address_line2_text $
  		city_name_text $
  		state_code $
  		zip_code $
  		zip4_code $
  		county_code $
  		county_name_text $
  		msa_code $
  		msa_name_text $
  		congressional_district_code $
  		placed_base_city_name_text $
  		property_total_unit_count
  		property_category_name $
  		primary_financing_type $
  		associated_financing_number $
  		is_insured_ind $
  		is_202_811_ind $
  		is_hud_held_ind $
  		is_hud_owned_ind $
  		is_hospital_ind $
  		is_nursing_home_ind $
  		is_board_and_care_ind $
  		is_assisted_living_ind $
  		is_refinanced_ind $
  		is_221d3_ind $
  		is_221d4_ind $
  		is_236_ind $
  		is_non_insured_ind $
  		is_bmir_ind $
  		is_risk_sharing_ind $
  		is_mip_ind $
  		is_co_insured_ind $
  		ownership_effective_date : mmddyy.
  		owner_participant_id
  		owner_company_type $
  		owner_individual_first_name $
  		owner_individual_middle_name $
  		owner_individual_last_name $
  		owner_individual_full_name $
  		owner_individual_title_text $
  		owner_organization_name $
  		owner_address_line1 $
  		owner_address_line2 $
  		owner_city_name $
  		owner_state_code $
  		owner_zip_code $
  		owner_zip4_code $
  		owner_main_phone_number_text $
  		owner_main_fax_number_text $
  		owner_email_text $
  		mgmt_agent_participant_id
  		mgmt_agent_company_type $
  		mgmt_agent_indv_first_name $
  		mgmt_agent_indv_last_name $
  		mgmt_agent_indv_middle_name $
  		mgmt_agent_full_name $
  		mgmt_agent_indv_title_text $
  		mgmt_agent_org_name $
  		mgmt_agent_address_line1 $
  		mgmt_agent_address_line2 $
  		mgmt_agent_city_name $
  		mgmt_agent_state_code $
  		mgmt_agent_zip_code $
  		mgmt_agent_zip4_code $
  		mgmt_agent_main_phone_number $
  		mgmt_agent_main_fax_number $
  		mgmt_agent_email_text $;

    extract_date = &filedate;

    label extract_date = "File extract date";
    
    ** Invalid state code **;
    
    if state_code = '00' then state_code = '';

    format ownership_effective_date extract_date mmddyy10.;

    ** Label variables **;
    
    label
      hub_name_text = "HUD office responsible for HUD servicing site for property"
      servicing_site_name_text = "HUD office responsible for management/servicing functions for property"
      property_id = "REMS-assigned identifier for each property"
      property_name_text = "Recorded name of property"
      property_phone_number = "Phone number at primary property address (generally on-site agent)"
      address_line1_text = "Property street address/first line of mailing address"
      address_line2_text = "Property suite number, PO box or other information for second line of address"
      city_name_text = "City name of property address"
      state_code = "State code of property address"
      zip_code = "Five digit zip code of property address"
      zip4_code = "Four digit zip code extension of property address"
      county_code = "Property three digit county code"
      county_name_text = "Property county name"
      msa_code = "Property standard metropolitan statistical area code"
      msa_name_text = "Property standard metropolitan statistical area name"
      congressional_district_code = "Property congressional district code(s) (For properties without 9-digit ZIP code, all possible districts listed)"
      placed_base_city_name_text = "Property standard place based city name"
      property_total_unit_count = "Total number of units for property"
      property_category_name = "Property category"
      primary_financing_type = "Primary type of financing associated with property"
      associated_financing_number = "FHA or 202/811 number (for properties with active financing)"
      is_insured_ind = "Any active financing instruments associated with property are insurance"
      is_202_811_ind = "Any active financing instruments associated with property are 202/811 grants/loans"
      is_hud_held_ind = "Any active financing instruments associated with property are HUD-held loans"
      is_hud_owned_ind = "Property is HUD-owned"
      is_hospital_ind = "Any active financing instruments associated with property are loans for a hospital"
      is_nursing_home_ind = "Any active financing instruments associated with property are loans for a nursing home"
      is_board_and_care_ind = "Any active financing instruments associated with property are loans for a board and care property"
      is_assisted_living_ind = "Any active financing instruments associated with property are loans for an assisted living property"
      is_refinanced_ind = "Any active financing instruments associated with property are loans that have been refinanced"
      is_221d3_ind = "Any active financing instruments associated with property are 221/d3 loans"
      is_221d4_ind = "Any active financing instruments associated with property are 221/d4 loans"
      is_236_ind = "Any active financing instruments associated with property are insured 236 loans"
      is_non_insured_ind = "Any active financing instruments associated with property are non-insured loans"
      is_bmir_ind = "Any active financing instruments associated with property are BMIR loans"
      is_risk_sharing_ind = "Any active financing instruments associated with property are risk sharing loans"
      is_mip_ind = "Any active financing instruments associated with property are MIP loans"
      is_co_insured_ind = "Any active financing associated with property is a co-insured loan"
      ownership_effective_date = "Most recent effective date associated with property owner"
      owner_participant_id = "Identifier for owner having most recent effective date for property"
      owner_company_type = "Type of owner company"
      owner_individual_first_name = "Owner first name"
      owner_individual_middle_name = "Owner middle name"
      owner_individual_last_name = "Owner last name"
      owner_individual_full_name = "Owner full name"
      owner_individual_title_text = "Owner title"
      owner_organization_name = "Registered organization name for owner of property"
      owner_address_line1 = "Owner street address/first line of mailing address"
      owner_address_line2 = "Owner suite number, PO box or other information for second line of address"
      owner_city_name = "City name of owner address"
      owner_state_code = "Two character state code of owner address"
      owner_zip_code = "Five digit zip code of owner address"
      owner_zip4_code = "Four digit zip code extension of owner address"
      owner_main_phone_number_text = "Owner main phone number"
      owner_main_fax_number_text = "Owner main fax number"
      owner_email_text = "Internet email address for owner"
      mgmt_agent_participant_id = "Identifier for management agent having most recent effective date for property"
      mgmt_agent_company_type = "Management agent company type"
      mgmt_agent_indv_first_name = "Management agent first name"
      mgmt_agent_indv_last_name = "Management agent last name"
      mgmt_agent_indv_middle_name = "Management agent middle name"
      mgmt_agent_full_name = "Management agent full name"
      mgmt_agent_indv_title_text = "Management agent title"
      mgmt_agent_org_name = "Registered organization name for management agent of property"
      mgmt_agent_address_line1 = "Management agent street address/first line of mailing address"
      mgmt_agent_address_line2 = "Management agent suite number, PO box or other information for second line of address"
      mgmt_agent_city_name = "City name of management agent address"
      mgmt_agent_state_code = "Two character state code of management agent address"
      mgmt_agent_zip_code = "Five digit zip code of management agent address"
      mgmt_agent_zip4_code = "Four digit zip code extension of management agent address"
      mgmt_agent_main_phone_number = "Management agent main phone number"
      mgmt_agent_main_fax_number = "Management agent main fax number"
      mgmt_agent_email_text = "Internet email address for management agent";
    
  run;

  * Universe of active assistance and Section 8 contracts in Multifamily Housing *;

  filename rc&month.&year "&folder\Raw\Sec8MF\&year-&month\MF_Assistance___Sec8_Contracts.txt";

  data MF_S8Contracts_&month._&year
       (label="Sec 8 multifamily projects, contract-level data, extract date &filedate_fmt");
  	infile rc&month.&year dlm=',' firstobs=2 flowover dsd lrecl=2000;
  	length
  		contract_number $11.
  		property_id 8.
  		property_name_text $50.
  		tracs_effective_date 8.
  		tracs_overall_expiration_date 8.
  		tracs_overall_exp_fiscal_year 8.
  		tracs_overall_expire_quarter $2.
  		tracs_current_expiration_date 8.
  		tracs_status_name $20.
  		contract_term_months_qty 8.
  		assisted_units_count 8.
  		is_hud_administered_ind $1.
  		is_acc_old_ind $1.
  		is_acc_performance_based_ind $1.
  		contract_doc_type_code $5.
  		program_type_name $20.
  		program_type_group_code $20.
  		program_type_group_name $20.
  		rent_to_fmr_ratio 8.
  		rent_to_fmr_description $40.
  		br0_count 8.
  		br1_count 8.
  		br2_count 8.
  		br3_count 8.
  		br4_count 8.
  		br5plus_count 8.
  		br0_fmr 8.
  		br1_fmr 8.
  		br2_fmr 8.
  		br3_fmr 8.
  		br4_fmr 8.;
  	input
  		contract_number $
  		property_id
  		property_name_text $
  		tracs_effective_date : mmddyy.
  		tracs_overall_expiration_date : mmddyy.
  		tracs_overall_exp_fiscal_year
  		tracs_overall_expire_quarter $
  		tracs_current_expiration_date : mmddyy.
  		tracs_status_name $
  		contract_term_months_qty
  		assisted_units_count
  		is_hud_administered_ind $
  		is_acc_old_ind $
  		is_acc_performance_based_ind $
  		contract_doc_type_code $
  		program_type_name $
  		program_type_group_code $
  		program_type_group_name $
  		rent_to_FMR_ratio
  		rent_to_FMR_description $
  		br0_count
  		br1_count
  		br2_count
  		br3_count
  		br4_count
  		br5plus_count
  		br0_fmr : comma.
  		br1_fmr : comma.
  		br2_fmr : comma.
  		br3_fmr : comma.
  		br4_fmr : comma.;

    extract_date = &filedate;

    label extract_date = "File extract date";
    
    ** Recode FMRs to .N (not applicable) if no units of that bedroom size **;
    
    array brfmr{*} br0_fmr br1_fmr br2_fmr br3_fmr br4_fmr;
    array brcnt{*} br0_count br1_count br2_count br3_count br4_count;
    
    do _i = 1 to dim( brfmr );
      if brfmr{_i} = 0 and brcnt{_i} = 0 then brfmr{_i} = .n;
      else if brfmr{_i} = 0 and brcnt{_i} > 0 then brfmr{_i} = .u;
    end;
    
    drop _i;

    format 
      tracs_effective_date tracs_current_expiration_date 
      tracs_overall_expiration_date extract_date  mmddyy10.;
    
    ** Label variables **;
    
    label
      contract_number = "TRACS-assigned contract number"
      property_id = "REMS-assigned identifier for each property"
      property_name_text = "Recorded name of property"
      tracs_effective_date = "Effective date of contract as provided by TRACS"
      tracs_overall_expiration_date = "Overall expiration date of contract"
      tracs_overall_exp_fiscal_year = "Fiscal year of tracs_overall_expiration_date"
      tracs_overall_expire_quarter = "Fiscal year quarter of contract expiration date (calculated from tracs_overall_expiration_date)"
      tracs_current_expiration_date = "Expiration date of current term of contract as provided by TRACS"
      tracs_status_name = "Status of contract in TRACS"
      contract_term_months_qty = "Term of contract (months)"
      assisted_units_count = "Total number of assisted units for contract"
      is_hud_administered_ind = "HUD is administrator of contract"
      is_acc_old_ind = "Contract is an old ACC contract (pre-performance-based)"
      is_acc_performance_based_ind = "Contract is a performance-based ACC"
      contract_doc_type_code = "Document type of contract, as provided by TRACS"
      program_type_name = "Name of program type, provided from TRACS"
      program_type_group_code = "Program type group code (derived from program_type_name and contract_doc_type_code)"
      program_type_group_name = "Program type group name (derived from program_type_group_code)"
      rent_to_FMR_ratio = "Ratio of rent gross amount to FMR gross amount"
      rent_to_FMR_description = "Rent to FMR ratio for assisted units"
      BR0_count = "Number of units/beds for efficiency units that receive(d) assistance under this contract"
      BR1_count = "Number of units/beds for one bedroom units that receive(d) assistance under this contract"
      BR2_count = "Number of units/beds for two bedroom units that receive(d) assistance under this contract"
      BR3_count = "Number of units/beds for three bedroom units that receive(d) assistance under this contract"
      BR4_count = "Number of units/beds for four bedroom units that receive(d) assistance under this contract"
      BR5plus_count = "Number of units/beds for five or more bedroom units that receive(d) assistance under this contract"
      BR0_FMR = "Fair Market Rent (FMR) for efficiency units (.N when bedroom count is zero)"
      BR1_FMR = "Fair Market Rent (FMR) for one bedroom units (.N when bedroom count is zero)"
      BR2_FMR = "Fair Market Rent (FMR) for two bedroom units (.N when bedroom count is zero)"
      BR3_FMR = "Fair Market Rent (FMR) for three bedroom units (.N when bedroom count is zero)"
      BR4_FMR = "Fair Market Rent (FMR) for four bedroom units (.N when bedroom count is zero)";
    
  run;

  **Step2. Merge two base tables into one complete database of Contracts and Properties (See Appendix A. for comment)**;
  
  %Sec8MF_nat_merge( month=&month, year=&year )  
  
  ** Check for duplicate contracts **;
  
  title2 'Duplicate Contracts';
  %Dup_check( data=MF_S8Contracts_&month._&year, by=contract_number, id=property_id property_name_text )
  run;
  
  title2 'Duplicate Properties';
  %Dup_check( data=MF_Properties_&month._&year, by=property_id, id=property_name_text state_code )
  run;

  title2;
  
  /***************************************
  ** Basic file info **;
  
  %File_info( data=MF_Properties_&month._&year )
  %File_info( data=MF_S8Contracts_&month._&year, freqvars=tracs_status_name )
  
  %File_info( data=Sec8MF_&year._&month._us, 
                freqvars=state_code tracs_status extract_date tracs_overall_expire_quarter
                         contract_doc_type_code program_type_group_code program_type_name
                         property_category primary_financing owner_company mgmt_agent_company )
  ******************************************/
  
  %exit_macro:

%mend Sec8MF_readbasetbls;

/** End Macro Definition **/

