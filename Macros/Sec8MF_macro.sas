/**************************************************************************
 Program:  Sec8MF_macro.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  06/03/05
 Version:  SAS 9.2
 Environment:  Windows
 
 Description:  Autocall macro to compile Section 8 multifamily 
 contract/project data.
 Creates files for DC, MD, VA, and WV.

*** NB:  TEMPORARY CHANGE TO GEOCODING BASE FILE IN %DC_GEOCODE().
***      NEEDS TO BE CHANGED BACK WHEN GEOCODING BASE UPDATED IN DCDATA.

 Modifications:
  08/03/05 PAT  Purge files after upload.
                Geocode DC data.
                Created new coded vars: primary_financing, owner_company, 
                mgmt_agent_company, property_category.
  03/07/06 PAT  Assigned format $s8docty to var. contract_doc_type_code.
  03/09/06 PAT  Added dcg_match_score to freq table.
                Added %Sec8mf_miss_geo macro to fill in 
                missing geocoded data.
  09/14/07 PAT  Added address correction for 324 ANACOSTIA AVE SE.
  10/19/14 PAT  Updated for SAS1.
                Eliminated geocoding steps.
**************************************************************************/

/** Macro Sec8MF_macro - Start Definition **/

%macro Sec8MF_macro( month=, year=, s8folder=, upload=Y, revisions= );

  %let upload = %upcase( &upload );

  %if %length( &month ) ~= 2 %then %do;
    %err_mput( macro=Sec8MF_macro, msg=Month= parameter must be 2-digit month.  Month=&month )
    %goto exit_macro;
  %end;

  %if %length( &year ) ~= 4 %then %do;
    %err_mput( macro=Sec8MF_macro, msg=Year= parameter must be 4-digit year.  Year=&year )
    %goto exit_macro;
  %end;

  ** Library definition **;
  libname s8&month.&year "&s8folder\Raw\&year-&month";

  data 
    Sec8MF_&year._&month._dc
    HUD.Sec8MF_&year._&month._md
      (label="Sec 8 multifamily contracts w/property data, &month-&year update, MD")
    HUD.Sec8MF_&year._&month._va
      (label="Sec 8 multifamily contracts w/property data, &month-&year update, VA")
    HUD.Sec8MF_&year._&month._wv
      (label="Sec 8 multifamily contracts w/property data, &month-&year update, WV")
    ;

    merge 
      s8&month.&year..MF_S8Contracts_&month._&year
          (in=contracts
           drop=property_name_text)
      s8&month.&year..MF_Properties_&month._&year
          (in=properties
           where=(state_code in ( "DC", "MD", "VA", "WV" )) 
           drop=county_name_text msa_name_text extract_date);
    by property_id;
    
    if state_code in ( "DC", "MD", "VA", "WV" );
    
    RecordNo = _n_;
    
    label RecordNo = "Record number (UI created)";
    
    ** Address corrections **;
    
    %Sec8MF_addr_correct
    
    ** Set out of range expiration dates to missing (.U) **;
    
    if . < tracs_current_expiration_date < '01jan1998'd then do;
      %warn_put( msg="Current expir. date out of range: " contract_number= address_line1_text= tracs_current_expiration_date= " Will be set to missing (.U)" )
      tracs_current_expiration_date = .u;
    end;
    
    if . < tracs_overall_expiration_date < '01jan1998'd then do;
      %warn_put( msg="Overall expir. date out of range: " contract_number= address_line1_text= tracs_overall_expiration_date= " Will be set to missing (.U)" )
      tracs_overall_expiration_date = .u;
    end;
    
    ** Create coded TRACS status var to replace tracs_status_name **;
    
    length tracs_status $ 1;
    
    select ( tracs_status_name );
    
      when ( "Active" ) tracs_status = "A";
      when ( "Executed" ) tracs_status = "E";
      when ( "Expired" ) tracs_status = "X";
      when ( "Pending" ) tracs_status = "P";
      when ( "Suspended" ) tracs_status = "S";
      when ( "Terminated" ) tracs_status = "T";
      when ( "" ) tracs_status = "";
      otherwise do;
	  %warn_put( msg="Invalid value for tracs_status_name: " recordno= contract_number= tracs_status_name= )
      end;
	
    end;

    label tracs_status = "Contract status (from TRACS)";
    
    ** Recode program_type_group_code **;
    
    if program_type_group_code = 'Service Coordinator' then
      program_type_group_code = 'SC';
      
    ** Create coded property category var. to replace property_category_name **;
    
    length property_category $ 6;
    
    select ( property_category_name );
      when ( '202/811' ) property_category = '202811';
      when ( 'HUD Held' ) property_category = 'HUDHLD';
      when ( 'HUD Owned' ) property_category = 'HUDOWN';
      when ( 'Insured - Previously Subsidized' ) property_category = 'INSPRE';
      when ( 'Insured-Subsidized' ) property_category = 'INSSUB';
      when ( 'Other Subsidy Servicing Required (Only)' ) property_category = 'OTSSRO';
      when ( 'Subsidized - Previously 202/811' ) property_category = 'SUB202';
      when ( 'Subsidized - Previously Insured' ) property_category = 'SUBINS';
      when ( 'Subsidized, No HUD Financing' ) property_category = 'SUBNOH';
      when ( 'Subsidized-Green Retrofit' ) property_category = 'GREENR';
      when ( 'Use Restriction' ) property_category = 'USERES';
      when ( '' ) property_category = '      ';
      otherwise do;
	  %warn_put( msg="Invalid value for property_category_name: " recordno= contract_number= property_id= property_category_name= )
      end;
	
    end;

    label property_category = "Property category";
      
    ** Create coded primary financing var. to replace primary_financing_type **;
    
    length primary_financing $ 6;
    
    select ( primary_financing_type );
      when ( '202/811' ) primary_financing = '202811';
      when ( 'Flexible Subsidy' ) primary_financing = 'FLEXSB';
      when ( 'HUD Held' ) primary_financing = 'HUDHLD';
      when ( 'HUD Owned' ) primary_financing = 'HUDOWN';
      when ( 'Insured' ) primary_financing = 'INSURD';
      when ( 'Non-Insured' ) primary_financing = 'NONINS';
      when ( 'Green Retrofit' ) primary_financing = 'GREENR';
      when ( '' ) primary_financing = '      ';
      otherwise do;
	  %warn_put( msg="Invalid value for primary_financing_type: " recordno= contract_number= property_id= primary_financing_type= )
      end;
	
    end;

    label primary_financing = "Primary type of financing associated with property";
      
    ** Create coded owner co. type var. to replace owner_company_type **;
    
    length owner_company $ 2;
    
    select ( owner_company_type );
      when ( 'Limited Dividend' ) owner_company = 'LD';
      when ( 'Non-Profit' ) owner_company = 'NP';
      when ( 'Other' ) owner_company = 'OT';
      when ( 'Profit Motivated' ) owner_company = 'PM';
      when ( '' ) owner_company = '  ';
      otherwise do;
	  %warn_put( msg="Invalid value for owner_company_type: " recordno= contract_number= property_id= owner_company_type= )
      end;
	
    end;

    label owner_company = "Type of owner company";
      
    ** Create coded management co. type var. to replace mgmt_agent_company_type **;
    
    length mgmt_agent_company $ 2;
    
    select ( mgmt_agent_company_type );
      when ( 'Limited Dividend' ) mgmt_agent_company = 'LD';
      when ( 'Non-Profit' ) mgmt_agent_company = 'NP';
      when ( 'Other' ) mgmt_agent_company = 'OT';
      when ( 'Profit Motivated' ) mgmt_agent_company = 'PM';
      when ( '' ) mgmt_agent_company = '  ';
      otherwise do;
	  %warn_put( msg="Invalid value for mgmt_agent_company_type: " recordno= contract_number= property_id= mgmt_agent_company_type= )
      end;
	
    end;

    label mgmt_agent_company = "Management agent company type";
      
    ** Address corrections **;
    
    select ( address_line1_text );
      when ( "324 ANACOSTIA AVE SE" )
        address_line1_text = "324 ANACOSTIA ROAD SE";
      otherwise /** No correction **/
    end;
    
    ** Separate files by state **;
    
    select ( state_code );
      when ( "DC" ) output Sec8MF_&year._&month._dc;
      when ( "MD" ) output HUD.Sec8MF_&year._&month._md;
      when ( "VA" ) output HUD.Sec8MF_&year._&month._va;
      when ( "WV" ) output HUD.Sec8MF_&year._&month._wv;
      otherwise /** Do not save obs. **/;
    end;
    
    drop tracs_status_name primary_financing_type 
         owner_company_type mgmt_agent_company_type
         program_type_group_name property_category_name;
    
    format 
      tracs_status $s8stat. 
      contract_doc_type_code $s8docty.
      tracs_overall_expire_quarter $s8exqtr.
      program_type_group_code $s8pgmgr.
      program_type_name $s8pgmnm.
      primary_financing $s8prfin.
      owner_company mgmt_agent_company $s8owmgt.
      property_category $s8prpct.
      is_: $yesno. ;

  run;
  
  /*********************

  ** Geocode DC data **;

  %syslput year = &year;
  %syslput month = &month;
  %syslput revisions = &revisions;

  rsubmit;
  
  proc upload status=no
    data=Sec8MF_&year._&month._dc 
    out=Sec8MF_&year._&month._dc;
  
  %DC_geocode(
    data=Sec8MF_&year._&month._dc,
    out=Sec8MF_&year._&month._dc_geo,
    staddr=address_line1_text,
    zip=zip_code,
    id=contract_number property_id,
    ds_label=,
    listunmatched=Y
  )

  proc download status=no
    data=Sec8MF_&year._&month._dc_geo 
    out=Sec8MF_&year._&month._dc_geo;

  run;

  endrsubmit;
  */
  
  ** Fill in missing geographic info **;
  
  data HUD.Sec8MF_&year._&month._dc 
         (label="Sec 8 multifamily contracts w/property data, &month-&year update, DC");
  
    set Sec8MF_&year._&month._dc /*Sec8MF_&year._&month._dc_geo*/;
    
    /*%Sec8mf_miss_geo*/
    
  run;
  
  proc sort data=HUD.Sec8MF_&year._&month._dc;
    by contract_number;
    
  /**************/

  /*** TEMPORARY ***
  proc sort data=Sec8MF_&year._&month._dc out=HUD.Sec8MF_&year._&month._dc;
    by contract_number;
  /******/

  proc sort data=HUD.Sec8MF_&year._&month._md;
    by contract_number;

  proc sort data=HUD.Sec8MF_&year._&month._va;
    by contract_number;

  proc sort data=HUD.Sec8MF_&year._&month._wv;
    by contract_number;

  %File_info( data=HUD.Sec8MF_&year._&month._dc, 
              freqvars=/*dcg_match_score ward2002 cluster2000 cluster_tr2000*/
                       tracs_status extract_date tracs_overall_expire_quarter
                       contract_doc_type_code program_type_group_code program_type_name
                       property_category primary_financing owner_company mgmt_agent_company )

  %if &upload = Y %then %do;
  
    /*******
    rsubmit;
    
    proc upload status=no
      inlib=HUD 
      outlib=HUD memtype=(data);
      select Sec8MF_&year._&month._: ;
    run;
    
    x "purge [dcdata.hud.data]Sec8MF_&year._&month._*.*";
    *****/

    %Dc_update_meta_file(
      ds_lib=HUD,
      ds_name=Sec8MF_&year._&month._dc,
      creator_process=Sec8MF_&year._&month..sas,
      restrictions=None,
      revisions=&revisions
    )
    
    %Dc_update_meta_file(
      ds_lib=HUD,
      ds_name=Sec8MF_&year._&month._md,
      creator_process=Sec8MF_&year._&month..sas,
      restrictions=None,
      revisions=&revisions
    )
    
    %Dc_update_meta_file(
      ds_lib=HUD,
      ds_name=Sec8MF_&year._&month._va,
      creator_process=Sec8MF_&year._&month..sas,
      restrictions=None,
      revisions=&revisions
    )
    
    %Dc_update_meta_file(
      ds_lib=HUD,
      ds_name=Sec8MF_&year._&month._wv,
      creator_process=Sec8MF_&year._&month..sas,
      restrictions=None,
      revisions=&revisions
    )
    
    run;
    
    /*endrsubmit;*/

  %end;

  %exit_macro:

%mend Sec8MF_macro;

/** End Macro Definition **/

