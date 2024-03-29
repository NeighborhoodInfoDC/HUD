/**************************************************************************
 Program:  MFIS_read_update_file.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  09/19/15
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Autocall macro to read HUD MFIS update file.

 Modifications:
**************************************************************************/

/** Macro MFIS_read_update_file - Start Definition **/

%macro MFIS_read_update_file( 
  filedate=,                      /** File extract date (SAS date value) **/
  folder=&_dcdata_r_path\HUD,     /** Folder for input raw files **/ 
  finalize=,                      /** NO LONGER IN USE **/
  revisions=%str(New file.)       /** Metadata revision description **/
  );
  
  %local month year filedate_fmt filedate_fmt_b ds_label inf_path;

  %let month = %sysfunc( month( &filedate ), z2. );
  %let year  = %sysfunc( year( &filedate ), z4. );
  %let filedate_fmt = %sysfunc( putn( &filedate, mmddyyd10. ) );
  %let filedate_fmt_b = %sysfunc( putn( &filedate, mmddyyn8. ) );
  %let ds_label = HUD-insured mortgages, &filedate_fmt update; 
  
  ** Determine correct name for input file. **;
  
  %let inf_path = &folder\raw\mfis\rm-a_&filedate_fmt..csv;
  
  %if not %sysfunc( fileexist( &inf_path ) ) %then %let inf_path = &folder\raw\mfis\FHA_BF90_RM_A_&filedate_fmt_b..csv;
  
  data Active;
  
    infile "&inf_path" dsd stopover lrecl=2000 firstobs=2;
	%if %sysevalf( &filedate ) >= %sysevalf( '31jul2016'd ) %then %do;
	  input 
      HUD_project_number : $40.
      Property_name : $40.
      Property_street : $40.
      Property_city : $40.
      Property_state : $2.
      Property_zip : $5.
      Units : 8.
      Initial_endorsement_date : mmddyy10.
      Final_endorsement_date : mmddyy10. 
      Original_mortgage_amount : comma24.
      First_payment_date : mmddyy10.
      Maturity_date : mmddyy10.
      Term_in_months : 8.
      Interest_rate : 8.2    
      Current_principal_and_interest : comma24.2
      Amortized_principal_balance :  comma24.2
      Holder_name : $40.
      Holder_city : $40.
      Holder_state : $2.
      Servicer_name : $40.
      Servicer_city : $40.
      Servicer_state : $2.
      SOA_code : $3.
      _SOA_cat_sub_cat : $80.
      _TE : $2.
      _TC : $2.;
	length premise_id $ 16;
	premise_id = '';
	%end;
	%else %do;
	  input 
      HUD_project_number : $40.
      Premise_id : $16.
      Property_name : $40.
      Property_street : $40.
      Property_city : $40.
      Property_state : $2.
      Property_zip : $5.
      Units : 8.
      Initial_endorsement_date : mmddyy10.
      Final_endorsement_date : mmddyy10. 
      Original_mortgage_amount : comma24.
      First_payment_date : mmddyy10.
      Maturity_date : mmddyy10.
      Term_in_months : 8.
      Interest_rate : 8.2    
      Current_principal_and_interest : comma24.2
      Amortized_principal_balance :  comma24.2
      Holder_name : $40.
      Holder_city : $40.
      Holder_state : $2.
      Servicer_name : $40.
      Servicer_city : $40.
      Servicer_state : $2.
      SOA_code : $3.
      _SOA_cat_sub_cat : $80.
      _TE : $2.
      _TC : $2.;

	%end;
    if Property_state in ( 'DC', 'MD', 'VA', 'WV' );
  
  run;
  
  ** Determine correct name for input file. **;
  
  %let inf_path = &folder\raw\mfis\rm-t_&filedate_fmt..csv;
  
  %if not %sysfunc( fileexist( &inf_path ) ) %then %let inf_path = &folder\raw\mfis\FHA_BF90_RM_T_&filedate_fmt_b..csv;
  
  data Terminated;
  
    infile "&inf_path" dsd stopover lrecl=2000 firstobs=2;
	%if %sysevalf( &filedate ) >= %sysevalf( '31jul2016'd ) %then %do;
	  input 
      HUD_project_number : $40.
      Property_name : $40.
      Property_street : $40.
      Property_city : $40.
      Property_state : $2.
      Property_zip : $5.
      Units : 8.
      Initial_endorsement_date : mmddyy10.
      Final_endorsement_date : mmddyy10. 
      Original_mortgage_amount : comma24.
      First_payment_date : mmddyy10.
      Maturity_date : mmddyy10.
      Term_in_months : 8.
      Interest_rate : 8.2    
      Holder_name : $40.
      Holder_city : $40.
      Holder_state : $2.
      Servicer_name : $40.
      Servicer_city : $40.
      Servicer_state : $2.
      SOA_code : $3.
      _SOA_cat_sub_cat : $80.
      Term_type : $2.
      _Term_type_descr : $80.
      _Type : $80.
      Term_date : mmddyy10.
      _TE : $2.
      _TC : $2.
      MFIS_status : $1.;
		length premise_id $ 16;
		premise_id = '';
	  %end;
	  %else %do;
	  input 
      HUD_project_number : $40.
      Premise_id : $16.
      Property_name : $40.
      Property_street : $40.
      Property_city : $40.
      Property_state : $2.
      Property_zip : $5.
      Units : 8.
      Initial_endorsement_date : mmddyy10.
      Final_endorsement_date : mmddyy10. 
      Original_mortgage_amount : comma24.
      First_payment_date : mmddyy10.
      Maturity_date : mmddyy10.
      Term_in_months : 8.
      Interest_rate : 8.2    
      Holder_name : $40.
      Holder_city : $40.
      Holder_state : $2.
      Servicer_name : $40.
      Servicer_city : $40.
      Servicer_state : $2.
      SOA_code : $3.
      _SOA_cat_sub_cat : $80.
      Term_type : $2.
      _Term_type_descr : $80.
      _Type : $80.
      Term_date : mmddyy10.
      _TE : $2.
      _TC : $2.
      MFIS_status : $1.;
	%end;

    if Property_state in ( 'DC', 'MD', 'VA', 'WV' );
    
    if Term_type = 'G4' then do;
      Term_type = put( upcase( compbl( _Term_type_descr ) ), $mfis_desc2term_type. );
      PUT "G4: " Term_type= $MFIS_TERM_TYPE. _Term_type_descr=;
      if Term_type = "" then do;
        %warn_put( macro=MFIS_read_update_file, msg=_n_= "Term_type=G4 description not found. " _Term_type_descr= )
      end;
    end;
    
    length Claim_type $ 1;
    
    Claim_type = _Type;
    
    drop _Term_type_descr;

  run;
  
  ** Combine Active and Terminated projects, write state files **;
  
  data 
    MFIS_&year._&month._dc (label="&ds_label, DC")
    MFIS_&year._&month._md (label="&ds_label, MD")
    MFIS_&year._&month._va (label="&ds_label, VA")
    MFIS_&year._&month._wv (label="&ds_label, WV")
    ;
    
    set Active (in=inA) Terminated;
    
    if inA then do;
      MFIS_status = 'A';
      Term_date = .n;
    end;
    else do;
      Current_principal_and_interest = .n;
      Amortized_principal_balance = .n;
    end;

    length TE_bond_finc Tax_credit_finc 4.;
    
    if _TE = 'TE' then TE_bond_finc = 1;
    else TE_bond_finc = 0;
    
    if _TC = 'TC' then Tax_credit_finc = 1;
    else Tax_credit_finc = 0;
    
    retain Extract_date &filedate; 
    
    length SOA_cat_sub_cat $ 20;

    SOA_cat_sub_cat = put( upcase( compress( _SOA_cat_sub_cat, " .()-&" ) ), $mfis_soacat2cod. );
    
    if SOA_cat_sub_cat = "" then do;
      %warn_put( macro=MFIS_read_update_file, 
                 msg="SOA category description not found in code list. " _n_= _SOA_cat_sub_cat= SOA_code= )
    end;
    
    ** Separate files by state **;
    
    select ( Property_state );
      when ( "DC" ) output MFIS_&year._&month._dc;
      when ( "MD" ) output MFIS_&year._&month._md;
      when ( "VA" ) output MFIS_&year._&month._va;
      when ( "WV" ) output MFIS_&year._&month._wv;
      otherwise /** Do not save obs. **/;
    end;

	  label
      Extract_date = "Update file extract date"
      HUD_project_number = "HUD project ID number"
	  Premise_id = "HUD premise ID number"
      Property_name = "Property name"
      Property_street = "Property street address"
      Property_city = "Property city"
      Property_state = "Property state"
      Property_zip = "Property ZIP code"
      Units = "Number of total units or total beds for health and hospital care"
      Initial_endorsement_date = "Initial mortgage endorsement date"
      Final_endorsement_date = "Final mortgage endorsement date"
      Original_mortgage_amount = "Original mortgage amount ($)"
      First_payment_date = "First payment date"
      Maturity_date = "Mortgage maturity date"
      Term_in_months = "Mortgage term (months)"
      Interest_rate = "Interest rate (%)"
      Current_principal_and_interest = "Monthly principal and interest payment ($)"
      Amortized_principal_balance = "Amortized unpaid principal balance ($)"
      Holder_name = "Note holder name"
      Holder_city = "Note holder city"
      Holder_state = "Note holder state"
      Servicer_name = "Servicer name"
      Servicer_city = "Servicer city"
      Servicer_state = "Servicer state"
      SOA_code = "Section of the Act code"
      SOA_cat_sub_cat = "Section of the Act category/subcategory"
      TE_bond_finc = "Mortgage financed with tax exempt bonds"
      Tax_credit_finc = "Mortgage includes low income housing tax credits"
      Claim_type = "Termination claim type"
      MFIS_status = "Mortgage status"
      Term_date = "Termination date"
      Term_type = "Termination type";
    format Initial_endorsement_date Final_endorsement_date First_payment_date 
           Maturity_date Extract_date Term_date mmddyy10.
           TE_bond_finc Tax_credit_finc dyesno.
           SOA_code $mfis_soa. 
           SOA_cat_sub_cat $mfis_soacat.
           MFIS_status $mfis_status.
           Term_type $mfis_term_type.
           Claim_type $mfis_claim_type.;

     drop _TE _TC _SOA: _Type;
     
  run;
  
  ** Check for duplicates **;

  %Dup_check(
    data=MFIS_&year._&month._dc,
    by=HUD_project_number,
    id= Property_name,
    out=_dup_check,
    listdups=Y,
    count=dup_check_count,
    quiet=N,
    debug=N
  )
  
  ** Finalize data sets **;
  
  %local stlist i v;

  %let stlist = dc md va wv;
  %let i = 1;
  %let v = %scan( &stlist, &i );

  %do %until ( &v = );

    %Finalize_data_set( 
      /** Finalize data set parameters **/
      data=MFIS_&year._&month._&v,
      out=MFIS_&year._&month._&v,
      outlib=HUD,
      label="&ds_label, %upcase(&v)",
      sortby=HUD_project_number,
      /** Metadata parameters **/
      restrictions=None,
      revisions=%str(&revisions),
      /** File info parameters **/
      printobs=0,
      freqvars=
        property_state holder_state servicer_state SOA_code
        SOA_cat_sub_cat TE_bond_finc tax_credit_finc MFIS_status
        Term_type Claim_type extract_date
    )

    %let i = %eval( &i + 1 );
    %let v = %scan( &stlist, &i );

  %end;
    
  %exit_macro:

%mend MFIS_read_update_file;

/** End Macro Definition **/

