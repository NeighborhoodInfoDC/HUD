/**************************************************************************
 Program:  Sec8MF_dmvw.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  06/03/05
 Version:  SAS 9.2
 Environment:  Windows
 
 Description:  Autocall macro to compile Section 8 multifamily 
 contract/project data.
 Creates files for DC, MD, VA, and WV.

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
  12/23/14 PAT  Adapted for use with %Sec8MF_readbasetbls() macro.
                Replaced month=, year= parameters with filedate=.
                Renamed to %Sec8MF_dmvw().
  12/31/14 PAT  Added rent_to_fmr_description to freqvars=.
  09/02/15 PAT  Check for remote batch submit before updating metadata.
**************************************************************************/

/** Macro Sec8MF_dmvw - Start Definition **/

%macro Sec8MF_dmvw( 
  filedate=,   /** As of date of HUD database (SAS date value) **/
  s8folder=,   /** NO LONGER IN USE **/ 
  upload=N,    /** Upload and register file with metadata (Y/N) **/
  revisions=   /** Metadata revision description **/
  );

  %local month year;
  
  %let month = %sysfunc( putn( %sysfunc( month( &filedate ) ), z2. ) );
  %let year = %sysfunc( year( &filedate ) );

  %let upload = %upcase( &upload );

  %if %length( &month ) ~= 2 %then %do;
    %err_mput( macro=Sec8MF_dmvw, msg=Filedate= invalid month. Filedate=&filedate Month=&month )
    %goto exit_macro;
  %end;

  %if %length( &year ) ~= 4 %then %do;
    %err_mput( macro=Sec8MF_dmvw, msg=Filedate= invalid year. Filedate=&filedate Year=&year )
    %goto exit_macro;
  %end;

  ** Create separate data sets for DC, MD, VA, and WV **;

  data 
    HUD.Sec8MF_&year._&month._dc
      (label="Sec 8 multifamily contracts w/property data, &month-&year update, DC")
    HUD.Sec8MF_&year._&month._md
      (label="Sec 8 multifamily contracts w/property data, &month-&year update, MD")
    HUD.Sec8MF_&year._&month._va
      (label="Sec 8 multifamily contracts w/property data, &month-&year update, VA")
    HUD.Sec8MF_&year._&month._wv
      (label="Sec 8 multifamily contracts w/property data, &month-&year update, WV")
    ;

    set Sec8MF_&year._&month._us;
    
    where state_code in ( "DC", "MD", "VA", "WV" );
    
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
    
    ** Address corrections **;
    
    select ( address_line1_text );
      when ( "324 ANACOSTIA AVE SE" )
        address_line1_text = "324 ANACOSTIA ROAD SE";
      otherwise /** No correction **/
    end;
    
    ** Separate files by state **;
    
    select ( state_code );
      when ( "DC" ) output HUD.Sec8MF_&year._&month._dc;
      when ( "MD" ) output HUD.Sec8MF_&year._&month._md;
      when ( "VA" ) output HUD.Sec8MF_&year._&month._va;
      when ( "WV" ) output HUD.Sec8MF_&year._&month._wv;
      otherwise /** Do not save obs. **/;
    end;
    
  run;
  
  ** Sort data sets **;
  
  proc sort data=HUD.Sec8MF_&year._&month._dc;
    by contract_number;
    
  proc sort data=HUD.Sec8MF_&year._&month._md;
    by contract_number;

  proc sort data=HUD.Sec8MF_&year._&month._va;
    by contract_number;

  proc sort data=HUD.Sec8MF_&year._&month._wv;
    by contract_number;

  ** Output basic file info **;

  %File_info( data=HUD.Sec8MF_&year._&month._dc, 
              freqvars=tracs_status extract_date tracs_overall_expire_quarter
                       rent_to_FMR_description
                       contract_doc_type_code program_type_group_code program_type_name
                       property_category primary_financing owner_company mgmt_agent_company )

  %if &upload = Y %then %do;
  
    %if &_REMOTE_BATCH_SUBMIT %then %do;
  
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
      
    %end;
    %else %do;
    
      %note_mput( macro=Sec8MF_dmvw, msg=Metadata registration will be skipped because not running remote batch. )
      
    %end;
    
  %end;

  %exit_macro:

%mend Sec8MF_dmvw;

/** End Macro Definition **/

