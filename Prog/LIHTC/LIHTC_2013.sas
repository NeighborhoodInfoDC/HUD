/**************************************************************************
 Program:  LIHTC_2013.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  12/15/15
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Read HUD LIHTC database and create separate files for
projects in DC, MD, VA, and WV.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )

%let year = 2013;
%let rawfile = lihtcpub;

%let  filedate='18jun2015'd;                      /** File extract date (SAS date value) **/
%let  folder=&_dcdata_r_path\HUD\Raw\LIHTC;     /** Folder for input raw files **/ 
%let  finalize=N;                     /** Upload and register file with metadata (Y/N) **/
%let  revisions=%str(New file.);       /** Metadata revision description **/

%let recode_yesno = low_ceil non_prof basis bond mff_ra fmha_514 fmha_515 fmha_538 
                    home tcap cdbg fha hopevi tcep 
                    trgt_pop trgt_fam trgt_eld trgt_dis trgt_hml trgt_other qct;

%macro skip;
  filedate=,                      /** File extract date (SAS date value) **/
  folder=&_dcdata_r_path\HUD,     /** Folder for input raw files **/ 
  finalize=N,                     /** Upload and register file with metadata (Y/N) **/
  revisions=%str(New file.)       /** Metadata revision description **/
%mend skip;

libname rawlihtc "&folder\&year";

data LIHTC_&year;

  set rawlihtc.&rawfile
        (where=(PROJ_ST in ( 'DC', 'MD', 'VA', 'WV' ))
         rename=(HOME_IDISI=HOME_IDISID
                 TCAP_IDISI=TCAP_IDISID
                 CDBG_IDISI=CDBG_IDISID));
  
  retain Extract_date &filedate;
  
  ** Recode variables **;
  
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
    LONGITUDE = "Longitude: degrees decimal"
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
    BG2000 = "2000 Census Block Group Number"
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
    MFF_RA_ID = "HUD Multi-Family financing/rental assistance Property ID"
    FMHA_514 = "FmHA (RHS) Section 514 loan"
    RDNUM_514 = "FmHA (RHS) Section 514 loan number"
    FMHA_515 = "FmHA (RHS) Section 515 loan"
    RDNUM_515 = "FmHA (RHS) Section 515 loan number"
    FMHA_538 = "FmHA (RHS) Section 538 loan"
    RDNUM_538 = "FmHA (RHS) Section 538 loan number"
    HOME = "HOME Investment Partnership Program funds"
    HOME_AMT = "Dollar amount of HOME funds"
    HOME_IDISID = "HOME Investment Partnership Program funds IDIS ID"
    TCAP = "Tax Credit Assistance Program (TCAP) funds"
    TCAP_AMT = "TCAP Amount"
    TCAP_IDISID = "TCAP ISIS ID"
    CDBG = "Community Development Block Grant (CDBG) funds"
    CDBG_AMT = "Dollar amount of CDBG funds"
    CDBG_IDISID = "Community Development Block Grant (CDBG) funds IDIS ID"
    FHA = "FHA-insured loan"
    FHA_NUM = "FHA loan number"
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
    N_TOTAL = "Unknown var N_TOTAL";
  
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

  drop reg;
  
run;

%File_info( data=LIHTC_&year, printobs=5, freqvars=credit dda inc_ceil metro rentassist type yr_pis yr_alloc &recode_yesno nonprog )

/*
proc print data=LIHTC_&year (obs=50);
  where datanote ~= "";
  id HUD_ID;
  var datanote;
run;
*/
