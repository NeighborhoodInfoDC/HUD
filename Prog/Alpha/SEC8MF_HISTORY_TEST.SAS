/**************************************************************************
 Program:  Sec8mf_history_test.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  06/05/05
 Version:  SAS 8.2
 Environment:  Alpha OpenVMS
 
 Description:  Test creating Sec. 8 multifamily project history file.

 Modifications:
**************************************************************************/

%include "[dcdata]Stdhead.sas";

** Define libraries **;
%DCData_lib( HUD )

%macro match_contracts( base=, comp= );

** Match by contract no. **;

proc sort data=Hud.&comp out=&comp;
  by contract_number;

proc sort data=Hud.&base out=&base;
  by contract_number;

proc compare base=&base compare=&comp maxprint=(40,32000)
    noprint out=match_contracts (drop=_obs_) outbase outcomp outnoequal;
  id contract_number;
  var property_id 
      tracs_effective_date tracs_overall_expiration_date tracs_current_expiration_date
      tracs_status_name contract_term_months_qty 
      assisted_units_count;

proc print data=match_contracts noobs;
  id contract_number;
  by contract_number;
  title2 "Comparison of contracts for &base (BASE) and &comp (COMPARE)";

run;

title2;

%mend match_contracts;

%macro match_prop_contr( base=, comp= );

** Match by property & contract no. **;

proc sort data=Hud.&comp out=&comp;
  by property_id contract_number;

proc sort data=Hud.&base out=&base;
  by property_id contract_number;

data match_prop_contr;

  merge 
    &base 
      (in=_in_base
       keep=property_id contract_number
            tracs_effective_date tracs_overall_expiration_date tracs_current_expiration_date
            tracs_status_name contract_term_months_qty
            assisted_units_count
       rename=(
         tracs_effective_date=tracs_effective_date_base
         tracs_overall_expiration_date=tracs_overall_expir_date_base
         tracs_current_expiration_date=tracs_current_expir_date_base
         tracs_status_name=tracs_status_name_base
         contract_term_months_qty=contract_term_months_qty_base
         assisted_units_count=assisted_units_count_base
         )      
       )
            
    &comp 
      (in=_in_comp
       keep=property_id contract_number
            tracs_effective_date tracs_overall_expiration_date tracs_current_expiration_date
            tracs_status_name contract_term_months_qty
            assisted_units_count
       rename=(
         tracs_effective_date=tracs_effective_date_comp
         tracs_overall_expiration_date=tracs_overall_expir_date_comp
         tracs_current_expiration_date=tracs_current_expir_date_comp
         tracs_status_name=tracs_status_name_comp
         contract_term_months_qty=contract_term_months_qty_comp
         assisted_units_count=assisted_units_count_comp
         )      
       )
  ;
  by property_id contract_number;
  
  in_base = _in_base;
  in_comp = _in_comp;

  if not( in_base and in_comp );
  
run;

data in_base_only;

  merge 
    &base 
    match_prop_contr 
      (keep=property_id contract_number in_base);
  by property_id contract_number;

  if in_base;

run;

proc print data=in_base_only noobs;
  id property_id contract_number;
  by property_id contract_number;
  var tracs_effective_date tracs_overall_expiration_date tracs_current_expiration_date
      tracs_status_name contract_term_months_qty
      assisted_units_count;
  title2 "Properties with deleted contracts - &base and &comp";
run;

data in_comp_only;

  merge
    &comp
    match_prop_contr
      (keep=property_id contract_number in_comp);
  by property_id contract_number;

  if in_comp;

run;

proc print data=in_comp_only noobs;
  id property_id contract_number;
  by property_id contract_number;
  var tracs_effective_date tracs_overall_expiration_date tracs_current_expiration_date
      tracs_status_name contract_term_months_qty
      assisted_units_count;
  title2 "Properties with new contracts - &base and &comp";
run;

title2;

%mend match_prop_contr;

%match_contracts( base=Sec8mf_2003_06_dc, comp=Sec8mf_2005_01_dc )
%match_contracts( base=Sec8mf_2005_01_dc, comp=Sec8mf_2005_05_dc )

%match_prop_contr( base=Sec8mf_2003_06_dc, comp=Sec8mf_2005_01_dc )
%match_prop_contr( base=Sec8mf_2005_01_dc, comp=Sec8mf_2005_05_dc )

