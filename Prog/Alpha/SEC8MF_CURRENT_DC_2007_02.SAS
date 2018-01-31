/**************************************************************************
 Program:  SEC8MF_CURRENT_DC_2007_02.SAS
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  06/05/05
 Version:  SAS 8.2
 Environment:  Alpha OpenVMS
 
 Description:  

 Modifications:
  02/11/07 PAT  Added code for terminations (5) to UI_STATUS.
**************************************************************************/

%include "[dcdata]Stdhead.sas";

** Define libraries **;
%DCData_lib( HUD )



********************************
*****        MACROS        *****
********************************;

*********************************************************************************************
** Macro Sect8data - Prepare the HUD source data set for updating the current project file
*********************************************************************************************;

%macro Sect8data (sourcefile, suffix, new_file);

  data &new_file 
         (keep=contract_number recordno&suffix extract_date&suffix
               tracs_status&suffix expiration_date&suffix
               property_id&suffix program_type_name&suffix
               owner_company&suffix assisted_units_count&suffix
               total_unit_count&suffix address_line1_text&suffix
               contract_term&suffix rent_to_FMR_desc&suffix owner_name&suffix
               tracs_effective_date&suffix ui_status&suffix  Geo2000
               GeoBlk2000 Cluster_tr2000 Ward2002 Anc2002 Cluster2000);

    set &sourcefile; 
    
    format 
      tracs_status&suffix $s8stat. 
      extract_date&suffix expiration_date&suffix tracs_effective_date&suffix mmddyy10.;

    /*   Some variables are character and others are numeric, so I am not using arrays here */
    recordno&suffix=recordno; /*num*/
    extract_date&suffix=extract_date; /*num*/
    tracs_status&suffix=tracs_status; /*char*/
    expiration_date&suffix=tracs_overall_expiration_date; /*num*/
    property_id&suffix=property_id; /*num*/
    program_type_name&suffix=program_type_name; /*char*/
    owner_company&suffix=owner_company; /*char*/
    assisted_units_count&suffix=assisted_units_count; /*num*/
    total_unit_count&suffix=property_total_unit_count; /*num*/
    address_line1_text&suffix=address_line1_text; /*char*/  
    contract_term&suffix=contract_term_months_qty; /*num*/
    rent_to_FMR_desc&suffix=rent_to_FMR_description; /* char */
    tracs_effective_date&suffix=tracs_effective_date; /* num */

    /* create owner_name from owner_organization_name and owner_individual_full_name */ /*char*/
    if owner_individual_full_name='' and owner_organization_name ne '' then 
      owner_name&suffix=owner_organization_name;
    else if owner_individual_full_name ne '' and owner_organization_name='' then
      owner_name&suffix=owner_individual_full_name;

    /* create UI status variable */
    ui_status&suffix=.; /*num*/
    label ui_status&suffix="UI contract status code &suffix";
    format ui_status&suffix s8ui4cat.;

  run;

%mend Sect8data;


*********************************************************************************************
** Macro Sect8update - Create an updated current project file with new data.
*********************************************************************************************;

%macro Sect8update (currentfile, basefile);

  %let base=_&basefile;
  %let update=_&currentfile;
  %let filename_prefix = Sec8mf_current_dc;

  /* merge update file to the base file */
  
  data &filename_prefix._&currentfile;

    merge HUD.&filename_prefix._&basefile &currentfile;
    by contract_number;

    /* Need dates for all cases (contracts that fell out of the system do not have these;
      they could be coded as active below if these reference points are not included) */

      /* Create contract status for January 2003 base file to initialize values of the ui_status variable. 
      The code below sets these values using both a base file and an update file. However, for the 
      Jun 2003 file, the base file and update method cannot be used. For this file only, we can only 
      know whether it is active or expired- we can't tell if it is new or renewed.  */

    /* Create UI status variable */

    status_change = 0;
    
    /*if update expir date is missing, use current expiration date */
    if expiration_date&update=. then expiration_date&update = cur_expiration_date;  

    if tracs_status&update = 'T' then ui_status&update=5;
    else if (expiration_date&update lt (extract_date&update-60)) or (tracs_status&update='X' /*"Expired"*/ ) then 
      ui_status&update=4; /* 4=expired contracts*/ 
    else if cur_expiration_date = . then ui_status&update=1; /* 1=new contracts */
    else if expiration_date&update gt cur_expiration_date then ui_status&update=2;/* 2=renewed contracts */
    else ui_status&update=cur_ui_status; /*Set to current status*/

    if ui_status&update ne cur_ui_status or expiration_date&update gt cur_expiration_date then do;
      date_prev_ui_status = date_cur_ui_status;      /* Status change */
      date_cur_ui_status = extract_date&update;
      prev_ui_status = cur_ui_status;
      cur_ui_status = ui_status&update;
      status_change = 1;
    end;

    contract_change = 0;       /** Flag to indicate whether contract has changed **/

    if expiration_date&update gt cur_expiration_date or date_cur_contract = . then do;
      contract_change = 1;          /* Contract was changed (new contracts & renewals) */
      date_prev_contract = date_cur_contract;      /* Update contract source file date */
      date_cur_contract = extract_date&update;
      recordno_prev_contract = recordno_cur_contract;    /* Update contract source file record no */
      recordno_cur_contract = recordno&update;
    end;
      
    /* Examining changes in values of other measures across the base file and update files */

    /* Numeric variables */

    array base_n (*) property_id&base expiration_date&base assisted_units_count&base 
      total_unit_count&base contract_term&base tracs_effective_date&base; 

    array update_n (*) property_id&update expiration_date&update assisted_units_count&update 
      total_unit_count&update contract_term&update tracs_effective_date&update; 

    array cur_n (*) cur_property_id cur_expiration_date cur_assisted_units_count 
      cur_total_unit_count cur_contract_term cur_tracs_effective_date; 

    array prev_n (*) prev_property_id prev_expiration_date prev_assisted_units_count 
      prev_total_unit_count prev_contract_term prev_tracs_effective_date; 

    do i=1 to dim( base_n );

      if contract_change then do;  /* if change in contract status */
        prev_n(i) = cur_n(i);            /* assign current to prev values */
        cur_n(i) = update_n(i);            /* assign updated value to current */
      end;
      else if cur_n(i) ne update_n(i) and not( missing( update_n(i) ) ) then do;  
        /* if no contract status change but change in value */
        %note_put( msg='Change in contract var: ' contract_number= cur_n(i)= update_n(i)= )  /* report change in log */
        cur_n(i) = update_n(i);                      /* assign updated value to current */
      end;

    end;

    /* Character variables */

    /** Need to specify lengths of array char vars or else length defaults to 8 **/

    length cur_tracs_status $ 1 cur_program_type_name $ 20 cur_owner_company $ 2 
      cur_address_line1_text $ 45 cur_rent_to_FMR_desc $ 40 cur_owner_name $ 255;

    length prev_tracs_status $ 1 prev_program_type_name $ 20 prev_owner_company $ 2 
      prev_address_line1_text $ 45 prev_rent_to_FMR_desc $ 40 prev_owner_name $ 255;

    array base_c (*) $ tracs_status&base program_type_name&base owner_company&base 
      address_line1_text&base rent_to_FMR_desc&base owner_name&base;

    array update_c (*) $ tracs_status&update program_type_name&update owner_company&update 
      address_line1_text&update rent_to_FMR_desc&update owner_name&update;

    array cur_c (*) $ cur_tracs_status cur_program_type_name cur_owner_company 
      cur_address_line1_text cur_rent_to_FMR_desc cur_owner_name;

    array prev_c (*) $ prev_tracs_status prev_program_type_name prev_owner_company 
      prev_address_line1_text prev_rent_to_FMR_desc prev_owner_name;

    do i=1 to dim( base_c );

      if contract_change then do;  /* if change in contract status */
        prev_c(i) = cur_c(i);            /* assign current to prev values */
        cur_c(i) = update_c(i);            /* assign updated value to current */
      end;
      else if cur_c(i) ne update_c(i) and not( missing( update_c(i) ) ) then do;  
        /* if no contract status change but change in value */
        %note_put( msg='Change in contract var: ' contract_number= cur_c(i)= update_c(i)= )  /* report change in log */
        cur_c(i) = update_c(i);                      /* assign updated value to current */
      end;

    end;

    /* format new variables */
    format 
      extract_date&base expiration_date&base extract_date&update
      expiration_date&update cur_expiration_date
      prev_expiration_date date_cur_ui_status date_prev_ui_status
      date_cur_contract date_prev_contract
      prev_tracs_effective_date cur_tracs_effective_date 
        mmddyy10. 
        
      prev_tracs_status cur_tracs_status $s8stat.
      ui_status&base ui_status&update cur_ui_status prev_ui_status s8ui4cat.
      prev_owner_company cur_owner_company $s8owmgt. 
      prev_program_type_name cur_program_type_name $s8pgmnm. ;

    drop i;

  run;
  
  proc sort data=&filename_prefix._&currentfile
    out=&filename_prefix._&currentfile 
         (label="Sec 8 multifamily contracts, current status (HUD update &currentfile), DC");
  by contract_number;
  
  proc sort data=&filename_prefix._&currentfile
    out=hud.&filename_prefix._&currentfile 
         (label="Sec 8 multifamily contracts, current status (HUD update &currentfile), DC");
  by contract_number;
  
  run;

%mend Sect8update;


%macro print_obs(l=,f=,n=);
	proc print data=&l..&f. (obs=&n);
	title2 "&f";
	run;
%mend print_obs;

%macro print_cont(l=,f=,n=);
	proc contents data=&l..&f. out=vars(keep=name);
	title2 "&f";
	run;
*	proc print data=vars noobs;
*	run;
%mend print_cont;

%macro all_files(state=,print=0, cont=NO,out_ds=);	
%let num_ds=1;
	%if &print > 0 %then %do;
		%do i=1 %to &numDs;
			%print_obs(l=&&lib&i ,f=&&ds&i ,n= 10);
		%end;
	%end;
	%if %upcase(&cont) = YES %then %do;
		%do i=1 %to &numDs;
			 %print_cont(l=&&lib&i ,f=&&ds&i ,n= 10);
		%end;
	%end;

	data Sec8mf_history_&state.;
	set 
	%do i=2 %to &numDs;
		&&lib&i...&&ds&i(in=ds&i
			keep=
			anc2002
			cluster2000
			cluster_tr2000
			status_change
			contract_change
			contract_number
			cur_address_line1_text
			cur_assisted_units_count
			cur_contract_term
			cur_expiration_date
			cur_owner_company
			cur_owner_name
			cur_program_type_name
			cur_property_id
			cur_rent_to_FMR_desc
			cur_total_unit_count
			cur_tracs_effective_date
			cur_tracs_status
			cur_ui_status
			date_cur_contract
			date_cur_ui_status
			date_prev_contract
			date_prev_ui_status
			geo2000
			geoblk2000
			prev_address_line1_text
			prev_assisted_units_count
			prev_contract_term
			prev_expiration_date
			prev_owner_company
			prev_owner_name
			prev_program_type_name
			prev_property_id
			prev_rent_to_FMR_desc
			prev_total_unit_count
			prev_tracs_effective_date
			prev_tracs_status
			prev_ui_status
			recordno_cur_contract
			recordno_prev_contract
			ward2002
		)
	%end;
	;

		%do m=1 %to &numDs;
			if ds&m=1 then do;
				extract_id=&m;
				%put here;
				extract=%trim("&&extract&m");
				drop ds&m;
			end;
		%end;

	run;
	
	proc contents data=Sec8mf_history_&state;
	run;

	proc sort data=Sec8mf_history_&state;
	by  contract_number extract_id;
	run;


	proc print data=Sec8mf_history_&state (obs=100);
	by contract_number;
	run;

	proc print data=Sec8mf_history_&state(obs=100);
	by contract_number;
	var contract_number geo2000 extract
		cur_ui_status
		cur_contract_term
		cur_expiration_date
		cur_owner_company
		cur_owner_name
		prev_ui_status
		prev_contract_term
		prev_expiration_date
		prev_owner_company
		prev_owner_name
	;
	run;

	proc sort data=Sec8mf_history_&state out=hud.&out_ds;
	by geo2000;
	run;

	proc contents;
	run;

%mend all_files;


/***
	*** ran AUG 2, 2006 - reran Oct 31, 2006 to create output data set instead of WORK version ***;
	%Sect8data (HUD.Sec8mf_2006_07_dc, _Jul06, Jul06)
	%Sect8update (Jul06, Feb06)

****/

%let state=DC;
options mprint mlogic  symbolgen;

**STEP 1) run Sect8data and Sect8update on the current file ****;
	%Sect8data (HUD.Sec8mf_2007_02_dc, _Feb07, Feb07)

%FILE_INFO( DATA=FEB07, freqvars=tracs_status_Feb07 ui_status_Feb07 )

	%Sect8update (Feb07, Sep06)

%File_info( data=HUD.SEC8MF_CURRENT_DC_FEB07, printobs=0 )

proc freq data=HUD.SEC8MF_CURRENT_DC_FEB07;
  tables cur_tracs_status * cur_ui_status
    prev_tracs_status * cur_tracs_status
    prev_ui_status * cur_ui_status
    / missing list;
run;

proc print data=HUD.SEC8MF_CURRENT_DC_FEB07 n='CONTRACTS WITH STATUS CHANGE = ';
  where status_change /*prev_ui_status ~= cur_ui_status*/;
  id contract_number;
  var contract_change cur_tracs_effective_date date_prev_contract date_cur_contract prev_ui_status 
      cur_ui_status prev_tracs_status cur_tracs_status prev_expiration_date cur_expiration_date;
  title2 "STATUS CHANGES";
run;
title2;

ENDSAS;

************  IGNORE EVERYTHING BELOW THIS LINE *************;

**STEP 2) Add sec8mf_current_MMMYY file created above to the following data _null_ statement ****;
	data dslist;
	input ds   $  1-25 lib $ 26-37;
	datalines;
	SEC8MF_CURRENT_DC_DUMMY  hud 
	SEC8MF_CURRENT_DC_JUN03  hud
	SEC8MF_CURRENT_DC_APR04  hud
	SEC8MF_CURRENT_DC_AUG04  hud
	SEC8MF_CURRENT_DC_OCT04  hud
	SEC8MF_CURRENT_DC_JAN05  hud
	SEC8MF_CURRENT_DC_MAY05  hud
	SEC8MF_CURRENT_DC_JUL05  hud
	SEC8MF_CURRENT_DC_FEB06  hud
	SEC8MF_CURRENT_DC_JUL06  hud
	SEC8MF_CURRENT_DC_SEP06  hud
	;
	run;


	data _null_;
	set dslist nobs=num;
		extract=compress(substr(ds,19));
	
		tp = 'ds' || trim(left(put(_n_,8.)));
		call symput(tp,ds);
	
		tp = 'lib' || trim(left(put(_n_,8.)));
		call symput(tp,compress(lib));
	
		tp = 'extract' || trim(left(put(_n_,8.)));
		call symput(tp,extract);
		call symput('numds',trim(left(put(num,8.))));
	run;

***STEP 3) Add new data set name to OUT_DS parameter below *****;
%all_files(state=DC,print=1,cont=YES,out_ds=Sec8mf_history_2006_09_DC);

***STEP 4)Change data set name in the CHECK_DS parameter below *****;
%let check_ds=Sec8mf_history_2006_09_DC;

proc sort data=hud.&check_ds.  out=check;
by contract_number  date_cur_contract;
run;

proc transpose data=check out=checkera prefix=change;
var  contract_change;
by contract_number;
run;

proc transpose data=check out=checkerb prefix=stat;
var  cur_ui_status;
by contract_number;
run;

data checker;
merge checkera checkerb;
by contract_number;
run;


data test(drop= i x);
set checker;
bad_case=0;
array col (&numds) $ stat1-stat&numds;
array change (&numds) $ change1-change&numds;
do i=1 to &numDs;
	if col(i)=. then bad_case=1;
	if col(i)=4 then do x=i to &numds;
		if col(x) ^= 4 and col(x) ^ = . then do;
			if change(x) ^=1 then bad_case=1;
			if col(x) = 2 then renewed=1;
			else bad_case=1;
		end;
		else do;
			expired=1;
		end;		 
	end;
end;
run;

proc freq;
table bad_case expired renewed/missing;
run;

proc print;
where bad_case=1;
format stat1-stat&numds ;
title "bad cases";
run;

proc print;
where renewed=1;
format stat1-stat&numds ;
title "renewed cases";
run;

proc print;
where expired=1;
format col1-col&numds ;
title "expired cases";
run;

proc print data=hud.&check_ds.;
where contract_number='DC390002001';
run;
endsas;

where contract_number in ('DC39M000098',
'DC39M000099',
'DC39S001001',
'DC39S951003',
'DC39S981001');


