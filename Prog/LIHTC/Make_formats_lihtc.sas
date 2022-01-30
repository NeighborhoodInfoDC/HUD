/**************************************************************************
 Program:  Make_formats_lihtc.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  12/16/15
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Create formats for HUD LIHTC data sets.

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )

proc format library=HUD;

  value lihtc_reg
    1 = "Northeast"
    2 = "Midwest"
    3 = "South"
    4 = "West";

  value lihtc_inc_ceil 
    1 = "50% AMI"
    2 = "60% AMI"
    .n = "Not reported";
    
  value lihtc_yr_pis
    .u = 'Unknown'
    .c = 'Not confirmed';
    
  value lihtc_rentassist
    1 = "Federal"
    2 = "State"
    3 = "Both federal and state"
    4 = "Neither"
    5 = "Unknown whether federal or state";
    
  value lihtc_type
    1 = "New construction"
    2 = "Acquisition and rehab"
    3 = "Both new construction and acquisition/rehab"
    4 = "Existing";
    
  value lihtc_credit
    1 = "4 percent (30 percent present value)"
    2 = "9 percent (70 percent present value)"
    3 = "Both 4 percent and 9 percent"
    4 = "Tax credit exchange program (TCEP) only";
    
  value lihtc_metro
    1 = "Metro/non-central city"
    2 = "Metro/central city"
    3 = "Non-metro";

  value lihtc_dda
    0 = "Not in DDA"
    1 = "In metro DDA"
    2 = "In non-metro DDA"
    3 = "In metro GO zone DDA"
    4 = "In non-metro GO zone DDA";

  value lihtc_nlm_reason
    1 = "Completed extended-use period"
    2 = "Sale under qualified contract"
    3 = "Other";
    
  value $lihtc_record_stat
    'N' = "New"
    'U' = "Updated"
    'X' = "Existing (unchanged from previous DB version)";

run;

proc catalog catalog=HUD.Formats;
  modify lihtc_reg (desc="LIHTC census region") / entrytype=format;
  modify lihtc_inc_ceil (desc="LIHTC income ceiling") / entrytype=format;
  modify lihtc_yr_pis (desc="LIHTC year placed in service") / entrytype=format;
  modify lihtc_rentassist (desc="LIHTC rental assistance contract") / entrytype=format;
  modify lihtc_type (desc="LIHTC type of construction") / entrytype=format;
  modify lihtc_credit (desc="LIHTC type of credit") / entrytype=format;
  modify lihtc_metro (desc="LIHTC metro area") / entrytype=format;
  modify lihtc_dda (desc="LIHTC DDA status") / entrytype=format;
  modify lihtc_nlm_reason (desc="LIHTC reason prop. no longer monitored") / entrytype=format;
  modify lihtc_record_stat (desc="LIHTC rec. status compared to prev. db") / entrytype=formatc;
  contents;
quit;
