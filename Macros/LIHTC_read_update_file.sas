/**************************************************************************
 Program:  LIHTC_read_update_file.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  12/18/15
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Autocall macro to read LIHTC update file.

 Modifications: 
6.21.18 - MC Updated for 2016 File Structure
**************************************************************************/

/** Macro LIHTC_read_update_file - Start Definition **/

%macro LIHTC_read_update_file( 
  year=,                          /** Project placed in service through year **/
  filedate=,                      /** File extract date (SAS date value) **/
  folder=&_dcdata_r_path\HUD\Raw\LIHTC,     /** Folder for input raw files **/ 
  rawfile = lihtcpub,             /** Name of input data set **/
  finalize=Y,                     /** Upload and register file with metadata (Y/N) **/
  revisions=%str(New file.)       /** Metadata revision description **/
);

  %** Check parameters **;
  
  %if not( &year >= 1990 and &year <= %sysfunc( year( %sysfunc( today() ) ) ) ) %then %do;
    %err_mput( macro=LIHTC_read_update_file,
               msg=Must provide a valid placed in service through year: YEAR=&year.. )
    %goto exit_macro;
  %end;
 
  %if not( %sysevalf( &filedate >= '01jan1990'd ) and %sysevalf( &filedate <= %sysfunc( today() ) ) ) %then %do;
    %err_mput( macro=LIHTC_read_update_file,
               msg=Must provide a valid file extract date: FILEDATE=&filedate.. )
    %goto exit_macro;
  %end;
 
  %let finalize = %upcase( &finalize );
  
  %if &finalize = Y and not &_REMOTE_BATCH_SUBMIT %then %do;
    %warn_mput( macro=LIHTC_read_update_file,
                msg=Not remote batch submit session. Finalize will be set to N. )
    %let finalize = N;
  %end;
  
  %** Define local macro variables **;
  
  %local recode_yesno ds_label;

  %let recode_yesno = low_ceil non_prof basis bond mff_ra fmha_514 fmha_515 fmha_538 
                      home tcap cdbg fha hopevi tcep 
                      trgt_pop trgt_fam trgt_eld trgt_dis trgt_hml trgt_other qct;

  %let ds_label = Low income housing tax credit projects, placed in service through &year;

  libname rawlihtc "&folder\&year";

  data 
    LIHTC_&year._dc (label="&ds_label, DC")
    LIHTC_&year._md (label="&ds_label, MD")
    LIHTC_&year._va (label="&ds_label, VA")
    LIHTC_&year._wv (label="&ds_label, WV")
    ;

    set rawlihtc.&rawfile
          (where=(upcase(PROJ_ST) in ( 'DC', 'MD', 'VA', 'WV' )));
    
    retain Extract_date &filedate;
    
    ** Recode variables **;
    
    PROJ_ST = upcase( PROJ_ST );
    
    array rec_yn{*} &recode_yesno;
    
    do i = 1 to dim( rec_yn );
      select ( rec_yn{i} );
        when ( 1 )
          rec_yn{i} = 1;
        when ( 2 )
          rec_yn{i} = 0;
        otherwise
          rec_yn{i} = .n;  /** Not indicated **/
      end;
    end;
    
    if nonprog = . then nonprog = 0;
    
    select ( yr_pis );
      when ( 8888 ) 
        yr_pis = .c;
      when ( 9999 )
        yr_pis = .u;
      otherwise
        /** Do nothing **/;
    end;
    
    select ( yr_alloc );
      when ( 8888 ) 
        yr_alloc = .c;
      when ( 9999 )
        yr_alloc = .u;
      otherwise
        /** Do nothing **/;
    end;
    
    ** Output by state **;
    
    select ( PROJ_ST );
      when ( 'DC' )
        output LIHTC_&year._dc;
      when ( 'MD' )
        output LIHTC_&year._md;
      when ( 'VA' )
        output LIHTC_&year._va;
      when ( 'WV' )
        output LIHTC_&year._wv;
      otherwise do;
        %err_put( macro=LIHTC_read_update_file, msg="Invalid state: " PROJ_ST= )
      end;
    end;
    
    label  
      Extract_date = "Update file extract (as of) date"
      HUD_ID = "Unique Project Identifier"
      PROJECT = "Project name"
      PROJ_ADD = "Project street address"
      PROJ_CTY = "Project city"
      PROJ_ST = "Project state"
      PROJ_ZIP = "Project zip"
      STATE_ID = "State-defined Project ID"
      CONTACT = "Owner or owner's contact"
      COMPANY = "Name of contact company"
      CO_ADD = "Contact's business address"
      CO_CTY = "Contact's city"
      CO_ST = "Contact's state"
      CO_ZIP = "Contact's zip"
      CO_TEL = "Contact's telephone"
      LATITUDE = "Latitude: degrees decimal"
      LONGITUD = "Longitude: degrees decimal"
      REG = "Census Region"
      MSA = "MSA/PMSA Number (1999)"
      CBSA = "Core Based Statistical Area (CBSA) Lowest Level Code"
      PLACECE = "Census Place Code (1990)"
      PLACEFP = "FIPS Place Code (2000)"
      COSUBCUR = "County Subdivision Code (Minor Civil Division/Census Civil Division)"
      FIPS1990 = "Unique 1990 Census Tract ID"
      ST1990 = "1990 State FIPS Code"
      CNTY1990 = "1990 County FIPS Code"
      TRCT1990 = "1990 Census Tract Number"
      FIPS2000 = "Unique 2000 Census Tract ID"
      ST2000 = "2000 State FIPS Code"
      CNTY2000 = "2000 County FIPS Code"
      TRCT2000 = "2000 Census Tract Number"
      FIPS2010 = "Unique 2010 Census Tract ID"
      ST2010 = "2010 State FIPS Code"
      CNTY2010 = "2010 County FIPS Code"
      TRCT2010 = "2010 Census Tract Number"
      ALLOCAMT = "Annual dollar amount of tax credits allocated"
      N_UNITS = "Total number of units"
      LI_UNITS = "Total number of low income units"
      N_0BR = "Number of efficiencies"
      N_1BR = "Number of 1 bedroom units"
      N_2BR = "Number of 2 bedroom units"
      N_3BR = "Number of 3 bedroom units"
      N_4BR = "Number of 4 bedroom units"
      INC_CEIL = "Elected rent/income ceiling for low income units"
      LOW_CEIL = "Units set aside with rents lower than elected rent/income ceiling"
      CEILUNIT = "Number of units set aside with rents lower than elected rent/income ceiling"
      YR_PIS = "Year placed in service"
      YR_ALLOC = "Allocation year"
      NON_PROF = "Non-profit sponsor"
      BASIS = "Increase in eligible basis"
      BOND = "Tax-exempt bond received"
      MFF_RA = "HUD Multi-Family financing/rental assistance"
      FMHA_514 = "FmHA (RHS) Section 514 loan"
      FMHA_515 = "FmHA (RHS) Section 515 loan"
      FMHA_538 = "FmHA (RHS) Section 538 loan"
      HOME = "HOME Investment Partnership Program funds"
      HOME_AMT = "Dollar amount of HOME funds"
      TCAP = "Tax Credit Assistance Program (TCAP) funds"
      TCAP_AMT = "TCAP Amount"
      CDBG = "Community Development Block Grant (CDBG) funds"
      CDBG_AMT = "Dollar amount of CDBG funds"
      FHA = "FHA-insured loan"
      HOPEVI = "Forms part of a HOPEVI development"
      HPVI_AMT = "Dollar amount of HOPEVI funds for development or building costs"
      TCEP = "TCEP funds"
      TCEP_AMT = "TCEP amount"
      RENTASSIST = "Federal or state project-based rental assistance contract"
      /**{VARIABLE MISSING} RENTASSISTCONTRACT = "Federal Section 8 Contract Number"**/
      TRGT_POP = "Targets a specific population with specialized services or facilities"
      TRGT_FAM = "Targets a specific population - families"
      TRGT_ELD = "Targets a specific population - elderly"
      TRGT_DIS = "Targets a specific population - disabled"
      TRGT_HML = "Targets a specific population - homeless"
      TRGT_OTHER = "Targets a specific population - other"
      TRGT_SPC = "Targets a specific population - other as specified"
      TYPE = "Type of construction"
      CREDIT = "Type of credit percentage"
      N_UNITSR = "Total number of units or if total units missing or inconsistent, total low income units"
      LI_UNITR = "Total number of low income units or if total low income units missing, total units"
      METRO = "Is the census tract metro or non-metro?"
      DDA = "Is the census tract in a difficult development area (based on year placed in service)?"
      QCT = "Is the census tract a qualified census tract (based on year placed in service)?"
      NONPROG = "No longer monitored for LIHTC program due to expired use or other reason"
      DATANOTE = "Notes about data record changes processed for database update"
      X = "Unknown var X"
      Y = "Unknown var Y"
      Z = "Unknown var Z"
      YRMISFLG = "Unknown var YRMISFLG"
    
    format 
      credit lihtc_credit.
      dda lihtc_dda.
      inc_ceil lihtc_inc_ceil.
      metro lihtc_metro.
      rentassist lihtc_rentassist.
      type lihtc_type.
      yr_pis yr_alloc lihtc_yr_pis.
      &recode_yesno nonprog dyesno.
      extract_date mmddyy10.;

    drop reg i;
    
  run;

  proc sort data=LIHTC_&year._dc;
    by HUD_ID;

  proc sort data=LIHTC_&year._md;
    by HUD_ID;

  proc sort data=LIHTC_&year._va;
    by HUD_ID;

  proc sort data=LIHTC_&year._wv;
    by HUD_ID;

 ** Print data notes (DC only) **;

  proc print data=LIHTC_&year._dc;
    where datanote ~= "";
    id HUD_ID;
    var project nonprog datanote;
    title2 'Project data notes';
  run;
  title2;

  %if &finalize = Y %then %do;

  ** Check for duplicates (DC only) **;
  
  %Dup_check(
    data=LIHTC_&year._dc,
    by=HUD_ID,
    id=project
  )
  

  ** Finalize data sets **;
  
  %local stlist i v;

  %let stlist = dc md va wv;
  %let i = 1;
  %let v = %scan( &stlist, &i );

  %do %until ( &v = );

    %Finalize_data_set( 
      /** Finalize data set parameters **/
      data=LIHTC_&year._&v,
      out=LIHTC_&year._&v,
      outlib=HUD,
      label="&ds_label, %upcase(&v)",
      sortby=HUD_ID,
      /** Metadata parameters **/
      restrictions=None,
      revisions=%str(&revisions),
      /** File info parameters **/
      printobs=0,
      freqvars=
        credit dda inc_ceil metro rentassist type yr_pis yr_alloc &recode_yesno nonprog
    )

    %let i = %eval( &i + 1 );
    %let v = %scan( &stlist, &i );

  %end;
    
  %exit_macro:
  
  %note_mput( macro=LIHTC_read_update_file, msg=Exiting macro. )

%mend LIHTC_read_update_file;

/** End Macro Definition **/

