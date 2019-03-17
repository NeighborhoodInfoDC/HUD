/**************************************************************************
 Program:  Apsh_read_project.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  03/17/19
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 
 Description:  Autocall macro to read HUD APSH project data set.

 Modifications:
**************************************************************************/

%macro Apsh_read_project( year=, revisions= );

  filename inf  "L:\Libraries\HUD\Raw\APSH\&year.\PROJECT_&year..csv" lrecl=3000;

  data Apsh_project_&year._dc Apsh_project_&year._md Apsh_project_&year._va Apsh_project_&year._wv;

    ** Note: infile ignoredoseof option is needed to read input file completely **;
    
    infile inf dsd missover firstobs=2 ignoredoseof;

    input
      quarter : date9.
      gsl : $12.
      states : $40.
      entities : $80.
      sumlevel : $2.
      program_label : $40.
      program : $1.
      sub_program : $40.
      name : $80.
      code : $40.
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
      pct_wage_major
      pct_welfare_major
      pct_other_major
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
      pct_black_nonhsp
      pct_native_american_nonhsp
      pct_asian_pacific_nonhsp
      pct_white_nothsp
      pct_black_hsp
      pct_wht_hsp
      pct_oth_hsp
      pct_hispanic
      pct_multi
      months_waiting
      months_from_movein
      pct_utility_allow
      ave_util_allow
      pct_bed1
      pct_bed2
      pct_bed3
      pct_overhoused
      tpoverty
      tminority
      tpct_ownsfd
      fedhse : $8.
      cbsa : $5.
      place2kx : $5.
      latitude
      longitude 
      state : $2.
      pha_total_units
      ha_size : $1.
      std_addr : $80.
      std_city : $40.
      std_zip5 : $5.
      stctytrt : $11.
    ;
    
    ** Zero pad sumlevel **;
    
    sumlevel = put( input( sumlevel, 2. ), z2. );
    
    ** Subprogram should be all caps **;
    
    sub_program = upcase( sub_program );

    ** Recode missing values **;
    
    array a{*} _numeric_;
    
    do i = 1 to dim( a );
    
      select ( a{i} );
        when ( -1 ) a{i} = .u;  /** Unknown (missing) **/
        when ( -4 ) a{i} = .s;  /** Supressed **/
        when ( -5 ) a{i} = .x;  /** Nonreporting **/
        otherwise /** Skip **/;
      end;
    
    end;

    label
      quarter = "Extract date"
      states = "States"
      entities = "Entities"
      sumlevel = "Summary level"
      program = "Program"
      sub_program = "Sub program"
      name = "Project name"
      code = "Codes for various summary levels"
      total_units = "Subsidized units available"
      pct_occupied = "% units occupied"
      number_reported = "Number of households for which reports (form-50058, form-50059) were received"
      pct_reported = "Households for which reports were received, as % of occupied units"
      months_since_report = "Average months since report"
      pct_movein = "% moved in past year"
      people_per_unit = "Number of people per unit"
      people_total = "Total number of people in project"
      rent_per_month = "Average gross household contribution towards rent per month (includes payment toward rent and utilities) ($)"
      spending_per_month = "Average HUD Expenditure per month ($)"
      hh_income = "Average total household income per year ($)"
      person_income = "Average household income per person per year ($)"
      pct_lt5k        = "Household income per year: % $1 - $4,999"
      pct_5k_lt10k    = "Household income per year: % $5,000 - $9,999"
      pct_10k_lt15k   = "Household income per year: % $10,000 - $14,999"
      pct_15k_lt20k   = "Household income per year: % $15,000 - $19,999"
      pct_ge20k       = "Household income per year: % $20,000 or more"    
      pct_wage_major = "% Households where wages are major source of income"
      pct_welfare_major = "% Households where welfare is major source of income"
      pct_other_major = "% Households with other major source of income"
      pct_median = "Average household income as a percent of local area median family income"
      pct_lt50_median = "% very low income"
      pct_lt30_median = "% extremely low income"
      pct_2adults             = "% 2+ adults with children"
      pct_1adult              = "% 1 adult with children"
      pct_female_head         = "% female head"
      pct_female_head_child   = "% female head with children"
      pct_disabled_lt62            = "% among head, spouse, co-head, aged 61 and younger"
      pct_disabled_ge62            = "% among head, spouse, co-head, aged 62 and older"
      pct_disabled_all             = "% among all persons with a disability"
      pct_lt24_head                = "% 24 or less"
      pct_age25_50                 = "% 25 to 50"
      pct_age51_61                 = "% 51 to 61"
      pct_age62plus                = "% 62 or more"
      pct_age85plus                = "% 85 or more"
      pct_minority                 = "Race: % Minority"
      pct_black_nonhsp             = "Race: % Black Non Hispanic"
      pct_native_american_nonhsp   = "Race: % Native American Non Hispanic"
      pct_asian_pacific_nonhsp     = "Race: % Asian or Pacific Islander Non Hispanic"
      pct_white_nothsp             = "Race: % White Non Hispanic"
      pct_black_hsp                = "Race: % Black Hispanic"
      pct_wht_hsp                  = "Race: % White Hispanic"
      pct_oth_hsp                  = "Race: % Other Hispanic"
      pct_hispanic                 = "Ethnicity: % Hispanic"
      pct_multi                    = "Race: % Multiple Race"
      months_waiting       = "Average months on waiting list"
      months_from_movein   = "Average months since moved in"
      pct_utility_allow    = "% with utility allowance"
      ave_util_allow       = "Average utility allowance $$"
      pct_bed1             = "% 0 - 1 bedrooms"
      pct_bed2             = "% 2 bedrooms"
      pct_bed3             = "% 3+ bedrooms"
      pct_overhoused       = "% Overhoused: more bedrooms than people"
      tpoverty             = "Surrounding census tract: % in poverty"
      tminority            = "Surrounding census tract: % minority"
      tpct_ownsfd       = "Surrounding census tract: % single family owners"
      fedhse            = "Congressional District"
      cbsa              = "CBSA"
      place2kx          = "FIPS codes for city or census designated place"
      latitude          = "Latitude"
      longitude         = "Longitude"
      state             = "State postal abbreviation"
      pha_total_units   = "PHA total units"
      ha_size           = "PHA category"
      std_addr = "Project street address"
      std_city = "Project city"
      std_zip5 = "Project ZIP code"
      stctytrt = "Project census tract ID (ssccctttttt)"
    ;
    
    format 
      quarter mmddyy10. sumlevel $apsh_sumlevel. program $apsh_program. 
      sub_program $apsh_sub_program. ha_size $apsh_ha_size.;
    
    select ( state );
      when ( 'DC' )
        output Apsh_project_&year._dc;
      when ( 'MD' )
        output Apsh_project_&year._md;
      when ( 'VA' )
        output Apsh_project_&year._va;
      when ( 'WV' )
        output Apsh_project_&year._wv;
      otherwise
        /** Skip **/;
    end;
    
    drop i gsl program_label;

  run;

  filename inf clear;

  ** Finalize data sets **;

  %Finalize_data_set( 
    data=Apsh_project_&year._dc,
    out=Apsh_project_&year._dc,
    outlib=HUD,
    label="APSH projects, &year., DC",
    sortby=code,
    printobs=5,
    freqvars=sumlevel program sub_program ha_size,
    revisions=%str(&revisions)
  )

  %Finalize_data_set( 
    data=Apsh_project_&year._md,
    out=Apsh_project_&year._md,
    outlib=HUD,
    label="APSH projects, &year., MD",
    sortby=code,
    printobs=5,
    freqvars=sumlevel program sub_program ha_size,
    revisions=%str(&revisions)
  )

  %Finalize_data_set( 
    data=Apsh_project_&year._va,
    out=Apsh_project_&year._va,
    outlib=HUD,
    label="APSH projects, &year., VA",
    sortby=code,
    printobs=5,
    freqvars=sumlevel program sub_program ha_size,
    revisions=%str(&revisions)
  )

  %Finalize_data_set( 
    data=Apsh_project_&year._wv,
    out=Apsh_project_&year._wv,
    outlib=HUD,
    label="APSH projects, &year., WV",
    sortby=code,
    printobs=5,
    freqvars=sumlevel program sub_program ha_size,
    revisions=%str(&revisions)
  )

%mend Apsh_read_project;


