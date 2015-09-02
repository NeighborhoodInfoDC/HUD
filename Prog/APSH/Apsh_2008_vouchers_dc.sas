/**************************************************************************
 Program:  Apsh_2008_vouchers_dc.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  02/21/11
 Version:  SAS 9.1
 Environment:  Windows
 
 Description:  Read APSH 2008 data on housing vouchers for DC.

 Modifications:
**************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";

** Define libraries **;
%DCData_lib( HUD )

*options obs=10;

filename fimport "D:\DCData\Libraries\HUD\Raw\APSH_2008\tract_vouchers_2008.txt" lrecl=2000;

data tract_vouchers_2008;

  infile fimport dsd stopover firstobs=2;

  input
    sumlevel : $1.
    program : $1.
    program_label : $8.
    sub_program : $2.
    name : $60.
    code : $11.
    total_units
    pct_occupied
    number_reported
    pct_reported
    months_since_report
    pct_movein
    people_per_unit
    people_total
    rent_per_month
    spending_per_month
    hh_income
    person_income
    pct_lt5k
    pct_5k_lt10k
    pct_10k_lt15k
    pct_15k_lt20k
    pct_ge20k
    pct_wage_maj
    pct_welf_maj
    pct_other_maj
    pct_median
    pct_lt50_median
    pct_lt30_median
    pct_2adults
    pct_1adult
    pct_female_head
    pct_female_head_child
    pct_disabled_lt62
    pct_disabled_ge62
    pct_disabled_all
    pct_lt24_head
    pct_age25_50
    pct_age51_61
    pct_age62plus
    pct_age85plus
    pct_minority
    pct_black
    pct_native_american
    pct_asian
    pct_hispanic
    months_waiting
    months_from_movein
    pct_utility_allow
    ave_util_allow
    pct_bed1
    pct_bed2
    pct_bed3
    pct_overhoused
    tminority
    tpoverty
    pct_ownsfd
    fedhse : $2.
    cbsa : $5.
    placefips : $7.
    latitude
    longitude
    state : $2.
    pha_total_units
    ha_size
  ;
  
  ** Keep only DC tracts **;
  
  if state = 'DC';
  
  ** Standard tract var **;
  
  Geo2000 = put( code, $geo00v. );
  
  format Geo2000 $geo00a.;

  ** Recode numeric var missing values **;
  
  array a{*} 
    total_units pct_occupied number_reported pct_reported
    months_since_report pct_movein people_per_unit people_total
    rent_per_month spending_per_month hh_income person_income
    pct_lt5k pct_5k_lt10k pct_10k_lt15k pct_15k_lt20k pct_ge20k
    pct_wage_maj pct_welf_maj pct_other_maj pct_median
    pct_lt50_median pct_lt30_median pct_2adults pct_1adult
    pct_female_head pct_female_head_child pct_disabled_lt62
    pct_disabled_ge62 pct_disabled_all pct_lt24_head
    pct_age25_50 pct_age51_61 pct_age62plus pct_age85plus
    pct_minority pct_black pct_native_american pct_asian
    pct_hispanic months_waiting months_from_movein
    pct_utility_allow ave_util_allow pct_bed1 pct_bed2 pct_bed3
    pct_overhoused tminority tpoverty pct_ownsfd
    latitude longitude pha_total_units ha_size
  ;
  
  do i = 1 to dim( a );
    select ( a{i} );
      when ( -1 ) a{i} = .n;  /** Not applicable **/
      when ( -2 ) a{i} = .u;  /** Unknown/Don't know **/
      when ( -3 ) a{i} = .g;  /** No geocode **/
      when ( -4 ) a{i} = .s;  /** Supressed **/
      when ( -5 ) a{i} = .r;  /** Non-reporting **/
      otherwise
        /** Do nothing **/;
    end;
  end;
  
  ** Recode character var missing values **;
  
  array b{*} sub_program fedhse;
  
  do i = 1 to dim( b );
    if b{i} = '-1' then b{i} = '';
  end;
  
  drop i;

run;

proc sort data=tract_vouchers_2008 out=Hud.Apsh_2008_vouchers_dc (label="A Picture of Subsidized Households, vouchers, tract-level, DC, 2008");
  by code;

/*
proc import out=tract_vouchers_2008
    datafile=fimport
    dbms=csv replace;
  datarow=2;
  getnames=yes;

run;
*/

%File_info( 
  data=Hud.Apsh_2008_vouchers_dc, 
  freqvars=state sumlevel program program_label sub_program fedhse cbsa placefips ha_size code geo2000 )

run;
