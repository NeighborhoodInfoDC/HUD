/**************************************************************************
 Program:  Sec8MF_data.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  08/25/07
 Version:  SAS 9.1
 Environment:  Alpha OpenVMS

 Description: Autocall macro to prepare HUD Sec 8 MF source data set 
 for updating the current project file.

 Modifications:
**************************************************************************/

%macro Sec8MF_data (sourcefile, suffix, new_file);

  data &new_file 
         (keep=contract_number recordno&suffix extract_date&suffix
               tracs_status&suffix expiration_date&suffix
               property_id&suffix program_type_name&suffix
               owner_company&suffix assisted_units_count&suffix
               total_unit_count&suffix address_line1_text&suffix
               contract_term&suffix rent_to_FMR_desc&suffix owner_name&suffix
               tracs_effective_date&suffix ui_status&suffix
               &idvars);

    set &sourcefile; 
    
    if assisted_units_count = 0 then assisted_units_count = .;

    format 
      tracs_status&suffix $s8stat. 
      extract_date&suffix expiration_date&suffix tracs_effective_date&suffix mmddyy10.;

    /*   Some variables are character and others are numeric, so I am not using arrays here */
    recordno&suffix = recordno; /*num*/
    extract_date&suffix = extract_date; /*num*/
    tracs_status&suffix = tracs_status; /*char*/
    expiration_date&suffix = tracs_overall_expiration_date; /*num*/
    property_id&suffix = property_id; /*num*/
    program_type_name&suffix = program_type_name; /*char*/
    owner_company&suffix = owner_company; /*char*/
    assisted_units_count&suffix = assisted_units_count; /*num*/
    total_unit_count&suffix = property_total_unit_count; /*num*/
    address_line1_text&suffix = address_line1_text; /*char*/  
    contract_term&suffix = contract_term_months_qty; /*num*/
    rent_to_FMR_desc&suffix = rent_to_FMR_description; /* char */
    tracs_effective_date&suffix = tracs_effective_date; /* num */

    /* create owner_name from owner_organization_name and owner_individual_full_name */ /*char*/
    if owner_individual_full_name = '' and owner_organization_name ne '' then 
      owner_name&suffix = owner_organization_name;
    else if owner_individual_full_name ne '' and owner_organization_name = '' then
      owner_name&suffix = owner_individual_full_name;

    /* create UI status variable */
    ui_status&suffix = .; /*num*/
    label ui_status&suffix = "UI contract status code &suffix";
    format ui_status&suffix s8ui4cat.;

    ** If overall expir date is missing, use current expiration date **;
    if missing( expiration_date&suffix ) then expiration_date&suffix = tracs_current_expiration_date;  

    ** If missing TRACS effective date, estimate from contract term and expir date. **;
    if missing( tracs_effective_date&suffix ) then do;
      tracs_effective_date&suffix = intnx( 'month', expiration_date&suffix, -contract_term_months_qty );
      put tracs_effective_date&suffix= mmddyy. expiration_date&suffix= mmddyy. contract_term_months_qty= ;
    end;

  run;

%mend Sec8MF_data;

