/**************************************************************************
 Program:  REAC_read_update_file.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   K. Abazajian
 Created:  09/22/16
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 
 Description:  Autocall macro to read HUD REAC update file.

 Modifications:
**************************************************************************/

/** Macro REAC_read_update_file - Start Definition **/

%macro REAC_read_update_file( 
  filedate=,                      /** File extract date (SAS date value) **/
  folder=&_dcdata_r_path\HUD,     /** Folder for input raw files **/ 
  finalize=Y,                     /** Upload and register file with metadata (Y/N) **/
  revisions=%str(New file.)       /** Metadata revision description **/
  );
  
  %let finalize = %upcase( &finalize );
  
  %if &finalize = Y and not &_REMOTE_BATCH_SUBMIT %then %do;
    %warn_mput( macro=REAC_read_update_file,
                msg=Not remote batch submit session. Finalize will be set to N. )
    %let finalize = N;
  %end;
 
  %local month year filedate_fmt ds_label;

  %let month = %sysfunc( month( &filedate ), z2. );
  %let year  = %sysfunc( year( &filedate ), z4. );
  %let filedate_fmt = %sysfunc( putn( &filedate, mmddyyd10. ) );
  %let ds_label = HUD REAC Scores, &filedate_fmt update; 
  
  %put &filedate;
	
  %if %sysevalf( &filedate => '06feb2019'd) %then %do;

  data rawscores;
  
    infile "&folder\raw\reac\&filedate_fmt.\reacphyinspecscorreldates.csv" dsd stopover lrecl=2000 firstobs=2;
	  input 
      rems_property_id : $9.
      inspec_id_1 : $6.
	  inspec_score_1 : $5.
      release_date_1 : $10.
      inspec_id_2 : $6.
      inspec_score_2 : $5.
      release_date_2 : $10.
	  inspec_id_3 : $6.
	  inspec_score_3 : $5.
	  release_date_3 : $10.
      property_name : $40.
      state_name : $15.
      city : $15.
      state_code : $2.
      ;
    if state_code in ( 'DC', 'MD', 'VA', 'WV' );
  
  run;
  %end;

  %if %sysevalf( &filedate => '31oct2019'd ) %then %do;

   data rawscores;
  
    infile "&folder\raw\reac\&filedate_fmt.\mf_inspection_report.csv" dsd stopover lrecl=2000 firstobs=2;
	  input 
      rems_property_id : $9.
	  has_active_financing_ind : $2.
	  has_active_assistance_ind : $2.
      inspec_id_1 : $6.
	  inspec_score_1 : $5.
      release_date_1 : $10.
      inspec_id_2 : $6.
      inspec_score_2 : $5.
      release_date_2 : $10.
	  inspec_id_3 : $6.
	  inspec_score_3 : $5.
	  release_date_3 : $10.
      property_name : $40.
      state_name : $15.
      city : $15.
      state_code : $2.
      ;
    if state_code in ( 'DC', 'MD', 'VA', 'WV' );
  
  run;
  %end;

  %else %do;

  data rawscores;
  
    infile "&folder\raw\reac\&filedate_fmt.\mf_inspection_report.csv" dsd stopover lrecl=2000 firstobs=2;
	  input 
	  property_name : $40.
	  state_name : $15.
	  city : $15.
	  state_code : $2.
	  rems_property_id : $9.
      inspec_id_1 : $6.
	  inspec_score_1 : $5.
      release_date_1 : $10.
      inspec_id_2 : $6.
      inspec_score_2 : $5.
      release_date_2 : $10.
	  inspec_id_3 : $6.
	  inspec_score_3 : $5.
	  release_date_3 : $10.  
      
      ;
    if state_code in ( 'DC', 'MD', 'VA', 'WV' );
  
  run;

    %end;

  data 
    REAC_&year._&month._dc (label="&ds_label, DC")
    REAC_&year._&month._md (label="&ds_label, MD")
    REAC_&year._&month._va (label="&ds_label, VA")
    REAC_&year._&month._wv (label="&ds_label, WV")
    ;
    
    set rawscores ;
    
    ** Separate files by state **;
    
    select ( state_code );
      when ( "DC" ) output REAC_&year._&month._dc;
      when ( "MD" ) output REAC_&year._&month._md;
      when ( "VA" ) output REAC_&year._&month._va;
      when ( "WV" ) output REAC_&year._&month._wv;
      otherwise /** Do not save obs. **/;
    end;

	  label
      rems_property_id = "REMS Property ID"
      inspec_id_1 = "Latest Inspection ID"
	  inspec_score_1 = "Latest Inspection Score"
      release_date_1 = "Latest Inspection Date"
      inspec_id_2 = "Second Latest Inspection ID"
      inspec_score_2 = "Secont Latest Inspection Score"
      release_date_2 = "Second Latest Inspection Date"
	  inspec_id_3 = "Third Latest Inspection ID"
	  inspec_score_3 = "Third Latest Inspection Score" 
	  release_date_3 = "Third Latest Inspection Date"
      property_name = "Property Name"
      state_name = "State"
      city = "City"
      state_code = "State Code";

     
  run;
  
  proc sort data=REAC_&year._&month._dc;
    by rems_property_id;
	run;
  ** Check for duplicates **;

  %Dup_check(
    data=REAC_&year._&month._dc,
    by=rems_property_id,
    id= Property_name,
    out=_dup_check,
    listdups=Y,
    count=dup_check_count,
    quiet=N,
    debug=N
  )


  %if &finalize = Y %then %do;
  
    proc datasets library=HUD memtype=(data) nolist;
      copy in=work out=HUD;
      select REAC_&year._&month._dc REAC_&year._&month._md 
             REAC_&year._&month._va REAC_&year._&month._wv;
    quit;
    %File_info( 
      data=HUD.REAC_&year._&month._dc, 
      printobs=5,
      stats=,
      freqvars=state_code  inspec_score_1  inspec_score_2  inspec_score_3
    )
  
    %Dc_update_meta_file(
      ds_lib=HUD,
      ds_name=REAC_&year._&month._dc,
      creator_process=REAC_&year._&month..sas,
      restrictions=None,
      revisions=&revisions
    )
    
    %Dc_update_meta_file(
      ds_lib=HUD,
      ds_name=REAC_&year._&month._md,
      creator_process=REAC_&year._&month..sas,
      restrictions=None,
      revisions=&revisions
    )
    
    %Dc_update_meta_file(
      ds_lib=HUD,
      ds_name=REAC_&year._&month._va,
      creator_process=REAC_&year._&month..sas,
      restrictions=None,
      revisions=&revisions
    )
    
    %Dc_update_meta_file(
      ds_lib=HUD,
      ds_name=REAC_&year._&month._wv,
      creator_process=REAC_&year._&month..sas,
      restrictions=None,
      revisions=&revisions
    )
  
    run;
      
  %end;
  %else %do;
    
    %note_mput( macro=REAC_read_update_file, msg=Data sets will not be finalized. )
    %File_info( 
      data=REAC_&year._&month._dc, 
      printobs=5,
      stats=,
      freqvars=state_code  inspec_score_1  inspec_score_2  inspec_score_3
    )
  
  %end;
    
  %exit_macro:

%mend REAC_read_update_file;

/** End Macro Definition **/
