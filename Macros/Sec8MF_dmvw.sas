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
  upload=,    /** NO LONGER IN USE **/
  revisions=   /** Metadata revision description **/
  );

  %local month year outlib;
  
  %let month = %sysfunc( putn( %sysfunc( month( &filedate ) ), z2. ) );
  %let year = %sysfunc( year( &filedate ) );

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
    Sec8MF_&year._&month._dc
    Sec8MF_&year._&month._md
    Sec8MF_&year._&month._va
    Sec8MF_&year._&month._wv
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
      when ( "DC" ) output Sec8MF_&year._&month._dc;
      when ( "MD" ) output Sec8MF_&year._&month._md;
      when ( "VA" ) output Sec8MF_&year._&month._va;
      when ( "WV" ) output Sec8MF_&year._&month._wv;
      otherwise /** Do not save obs. **/;
    end;
    
  run;
  
  ** Finalize data sets **;
  
  %local stlist i v;

  %let stlist = dc md va wv;
  %let i = 1;
  %let v = %scan( &stlist, &i );

  %do %until ( &v = );

    %Finalize_data_set( 
      /** Finalize data set parameters **/
      data=Sec8MF_&year._&month._&v,
      out=Sec8MF_&year._&month._&v,
      outlib=HUD,
      label="Sec 8 multifamily contracts w/property data, &month-&year update, %upcase(&v)",
      sortby=contract_number,
      /** Metadata parameters **/
      restrictions=None,
      revisions=%str(&revisions),
      /** File info parameters **/
      printobs=0,
      freqvars=
        tracs_status extract_date tracs_overall_expire_quarter
        rent_to_FMR_description contract_doc_type_code
        program_type_group_code program_type_name property_category
        primary_financing owner_company mgmt_agent_company
    )

    %let i = %eval( &i + 1 );
    %let v = %scan( &stlist, &i );

  %end;

  %exit_macro:

%mend Sec8MF_dmvw;

/** End Macro Definition **/

