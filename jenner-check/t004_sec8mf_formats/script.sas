/**************************************************************************
 Bundle:  t004_sec8mf_formats
 Source:  Prog/Sec8MF/Sec8MF_formats.sas  (NeighborhoodInfoDC/HUD)

 The PROC FORMAT value definitions are reproduced verbatim from the
 repository. The only change from the upstream program is the format
 library target: HUD (the site DCData library) becomes WORK so the run
 is self-contained. Every value map and the PROC CATALOG descriptions
 are exactly as written upstream. After building the catalog we apply a
 few of the formats via PUT so the listing shows them resolving.
**************************************************************************/

proc format library=WORK;

  value $s8stat
    'A' = 'Active'
    'E' = 'Executed'
    'P' = 'Pending'
    'S' = 'Suspended'
    'T' = 'Terminated'
    'X' = 'Expired';

  value $s8exqtr
    'Q1' = 'Oct - Dec'
    'Q2' = 'Jan - Mar'
    'Q3' = 'Apr - Jun'
    'Q4' = 'Jul - Sep';

  /*
  value $yesno
    'Y' = 'Yes'
    'N' = 'No';
  */

  value $s8docty
    'ACC' = 'Annual Contributions Contract'
    'AHAP' = 'Housing Assistance Payments Contract'
    'APRAC' = 'APRAC'
    'HAP' = 'Housing Assistance Payments'
    'PAC' = 'PAC'
    'PRAC' = 'Project Rental Assistance Contract'
    'RAP' = 'Rental Assistance Program'
    'SCHAP' = 'Senior Citizen Homeowner Assistance Program'
    'SUP' = 'Rent Supplement';

  value $s8pgmnm
    '202/162 MR' = '202/162 MR'
    '202/162 NC' = '202/162 NC'
    '202/162 SR' = '202/162 SR'
    '202/8 NC' = '202/8 NC'
    '202/8 SR' = '202/8 SR'
    '515/8 NC' = '515/8 NC'
    '515/8 SR' = '515/8 SR'
    'HFDA/8 NC' = 'HFDA/8 NC'
    'HFDA/8 SR' = 'HFDA/8 SR'
    'LMSA' = 'LMSA'
    'Old 202' = 'Old 202'
    'PAC/202' = 'PAC/202'
    'PAC/811' = 'PAC/811'
    'PD/8 Existing' = 'PD/8 Existing'
    'PD/8 MR' = 'PD/8 MR'
    'PD/8 SR' = 'PD/8 SR'
    'PRAC/202' = 'PRAC/202'
    'PRAC/811' = 'PRAC/811'
    'Preservation' = 'Preservation'
    'RAP' = 'Rental Assistance Program'
    'Rent Supp' = 'Rent Supplement'
    'Sec 8 NC' = 'Sec 8 New Construction'
    'Sec 8 SR' = 'Sec 8 Substantial Rehabilitation'
    'UnasstPrj SCHAP' = 'UnasstPrj SCHAP';

  value $s8pgmgr
    '202' = 'Section 202'
    '515' = 'S8 FmHA'
    'HFDA' = 'S8 State Agency'
    'LMSA' = 'S8 Loan Management'
    'PAC' = 'PAC 202/811'
    'PD' = 'S8 Property Disposition'
    'PRAC' = 'PRAC 202/811'
    'PRES' = 'S8 Preservation'
    'RAP' = 'Sec. 236 Rental Assistance Program'
    'S8NC' = 'Other S8 New Construction'
    'S8SR' = 'Other S8 Rehabilitation'
    'SUPP' = 'Rent Supplement'
    'SC' = 'Service Coordinator'
    'UNK' = 'Unknown';

  value $s8prfin
    '202811' = '202/811'
    'FLEXSB' = 'Flexible Subsidy'
    'HUDHLD' = 'HUD Held'
    'HUDOWN' = 'HUD Owned'
    'INSURD' = 'Insured'
    'NONINS' = 'Non-Insured';

  value $s8owmgt
    'LD' = 'Limited Dividend'
    'NP' = 'Non-Profit'
    'OT' = 'Other'
    'PM' = 'Profit Motivated';

  value $s8prpct
    '202811' = '202/811'
    'HUDHLD' = 'HUD Held'
    'HUDOWN' = 'HUD Owned'
    'INSPRE' = 'Insured - Previously Subsidized'
    'INSSUB' = 'Insured - Subsidized'
    'OTSSRO' = 'Other Subsidy Servicing Required (Only)'
    'SUB202' = 'Subsidized - Previously 202/811'
    'SUBINS' = 'Subsidized - Previously Insured'
    'SUBNOH' = 'Subsidized, No HUD Financing'
    'USERES' = 'Use Restriction';

  value s8ui4cat
    1 = 'Active-New'
    2 = 'Active-Renewed'
    3 = 'Active'
    4 = 'Expired';

  value s8ui2cat
    1,2,3 = 'Active'
    4     = 'Expired';

run;

proc catalog catalog=WORK.formats;
  modify s8stat (desc="S8/MF TRACS contract status") /et=formatc;
  modify s8exqtr (desc="S8/MF Contract expiration quarter") /et=formatc;
  modify s8docty (desc="S8/MF Document type of contract") /et=formatc;
  modify s8pgmnm (desc="S8/MF Program name") /et=formatc;
  modify s8pgmgr (desc="S8/MF Program type group") /et=formatc;
  modify s8prfin (desc="S8/MF Property financing") /et=formatc;
  modify s8owmgt (desc="S8/MF Owner/manager company type") /et=formatc;
  modify s8prpct (desc="S8/MF Property category") /et=formatc;
  modify s8ui4cat (desc="S8/MF UI status code (4 categories)") /et=format;
  modify s8ui2cat (desc="S8/MF UI status code (2 categories)") /et=format;
  contents;
  quit;

run;

/** ---- Apply a few of the formats so the listing shows them resolving ---- **/

data demo;
  input tracs_status $ program_type_group $ ui_status;
  status_desc  = put(tracs_status, $s8stat.);
  program_desc = put(program_type_group, $s8pgmgr.);
  ui_desc      = put(ui_status, s8ui2cat.);
  datalines;
A 202 1
T LMSA 4
X PRAC 2
;
run;

proc print data=demo; var tracs_status status_desc program_type_group program_desc ui_status ui_desc; run;
