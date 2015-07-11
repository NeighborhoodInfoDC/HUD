/**************************************************************************
 Program:  Sec8MF_nat_merge.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  12/22/14
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description: SAS autocall macro to merge base property & contract files 
 from the MultifamilyAssistance and Section 8 Contracts Database.

 Modifications:
  12/23/15 PAT Adapted for DCData from sect8_merge.sas.
               Updated property and financing categories.      
**************************************************************************/

/** Macro Sec8MF_nat_merge - Start Definition **/

%macro Sec8MF_nat_merge( month=, year= );

  %if %length( &month ) ~= 2 %then %do;
    %err_mput( macro=Sec8MF_nat_merge, msg=Month= parameter must be 2-digit month.  Month=&month )
    %goto exit_macro;
  %end;

  %if %length( &year ) ~= 4 %then %do;
    %err_mput( macro=Sec8MF_nat_merge, msg=Year= parameter must be 4-digit year.  Year=&year )
    %goto exit_macro;
  %end;

  proc sort data=MF_Properties_&month._&year ;
  	by property_id;

  proc sort data=MF_S8Contracts_&month._&year ;
  	by property_id;

  run;

  data 
    Sec8MF_&year._&month._us (label="Sec 8 multifamily contracts w/property data, &month-&year update, US")
    ;

    merge 
      MF_S8Contracts_&month._&year
          (in=contracts
           drop=property_name_text)
      MF_Properties_&month._&year
          (in=properties
           drop=extract_date);
    by property_id;
    
    RecordNo = _n_;
    
    label RecordNo = "Record number (UI created)";
    
    ** Set out of range expiration dates to missing (.U) **;
    
    /*
    
    if . < tracs_current_expiration_date < '01jan1998'd then do;
      %warn_put( msg="Current expir. date out of range: " contract_number= address_line1_text= tracs_current_expiration_date= " Will be set to missing (.U)" )
      tracs_current_expiration_date = .u;
    end;
    
    if . < tracs_overall_expiration_date < '01jan1998'd then do;
      %warn_put( msg="Overall expir. date out of range: " contract_number= address_line1_text= tracs_overall_expiration_date= " Will be set to missing (.U)" )
      tracs_overall_expiration_date = .u;
    end;
    
    */
    
    ** Create coded TRACS status var to replace tracs_status_name **;
    
    length tracs_status $ 1;
    
    select ( tracs_status_name );
    
      when ( "Active" ) tracs_status = "A";
      when ( "Executed" ) tracs_status = "E";
      when ( "Expired" ) tracs_status = "X";
      when ( "Pending" ) tracs_status = "P";
      when ( "Suspended" ) tracs_status = "S";
      when ( "Terminated" ) tracs_status = "T";
      when ( "" ) tracs_status = "";
      otherwise do;
	  %warn_put( msg="Invalid value for tracs_status_name: " recordno= contract_number= tracs_status_name= )
      end;
	
    end;

    label tracs_status = "Contract status (from TRACS)";
    
    ** Recode program_type_group_code **;
    
    if program_type_group_code = 'Service Coordinator' then
      program_type_group_code = 'SC';
      
    ** Create coded property category var. to replace property_category_name **;
    
    length property_category $ 6;
    
    select ( property_category_name );
      when ( '202/811' ) property_category = '202811';
      when ( 'HUD Held' ) property_category = 'HUDHLD';
      when ( 'HUD Owned' ) property_category = 'HUDOWN';
      when ( 'Insured - Previously Subsidized' ) property_category = 'INSPRE';
      when ( 'Insured-Subsidized' ) property_category = 'INSSUB';
      when ( 'Other Subsidy Servicing Required (Only)' ) property_category = 'OTSSRO';
      when ( 'Subsidized - Previously 202/811' ) property_category = 'SUB202';
      when ( 'Subsidized - Previously Insured' ) property_category = 'SUBINS';
      when ( 'Subsidized, No HUD Financing' ) property_category = 'SUBNOH';
      when ( 'Subsidized-Green Retrofit' ) property_category = 'GREENR';
      when ( 'Use Restriction' ) property_category = 'USERES';
      when ( 'Flexible Subsidy' ) property_category = 'FLEXSB';
      when ( '' ) property_category = '      ';
      otherwise do;
	  %warn_put( msg="Invalid value for property_category_name: " recordno= contract_number= property_id= property_category_name= )
      end;
	
    end;

    label property_category = "Property category";
      
    ** Create coded primary financing var. to replace primary_financing_type **;
    
    length primary_financing $ 6;
    
    select ( primary_financing_type );
      when ( '202/811' ) primary_financing = '202811';
      when ( 'Flexible Subsidy' ) primary_financing = 'FLEXSB';
      when ( 'HUD Held' ) primary_financing = 'HUDHLD';
      when ( 'HUD Owned' ) primary_financing = 'HUDOWN';
      when ( 'Insured' ) primary_financing = 'INSURD';
      when ( 'Non-Insured' ) primary_financing = 'NONINS';
      when ( 'Green Retrofit' ) primary_financing = 'GREENR';
      when ( '' ) primary_financing = '      ';
      otherwise do;
	  %warn_put( msg="Invalid value for primary_financing_type: " recordno= contract_number= property_id= primary_financing_type= )
      end;
	
    end;

    label primary_financing = "Primary type of financing associated with property";
      
    ** Create coded owner co. type var. to replace owner_company_type **;
    
    length owner_company $ 2;
    
    select ( owner_company_type );
      when ( 'Limited Dividend' ) owner_company = 'LD';
      when ( 'Non-Profit' ) owner_company = 'NP';
      when ( 'Other' ) owner_company = 'OT';
      when ( 'Profit Motivated' ) owner_company = 'PM';
      when ( '' ) owner_company = '  ';
      otherwise do;
	  %warn_put( msg="Invalid value for owner_company_type: " recordno= contract_number= property_id= owner_company_type= )
      end;
	
    end;
    
    label owner_company = "Type of owner company";
      
    ** Create coded management co. type var. to replace mgmt_agent_company_type **;
    
    length mgmt_agent_company $ 2;
    
    select ( mgmt_agent_company_type );
      when ( 'Limited Dividend' ) mgmt_agent_company = 'LD';
      when ( 'Non-Profit' ) mgmt_agent_company = 'NP';
      when ( 'Other' ) mgmt_agent_company = 'OT';
      when ( 'Profit Motivated' ) mgmt_agent_company = 'PM';
      when ( '' ) mgmt_agent_company = '  ';
      otherwise do;
	  %warn_put( msg="Invalid value for mgmt_agent_company_type: " recordno= contract_number= property_id= mgmt_agent_company_type= )
      end;
	
    end;

    label mgmt_agent_company = "Management agent company type";
      
    drop tracs_status_name primary_financing_type 
         owner_company_type mgmt_agent_company_type
         program_type_group_name property_category_name;
    
    format 
      tracs_status $s8stat. 
      contract_doc_type_code $s8docty.
      tracs_overall_expire_quarter $s8exqtr.
      program_type_group_code $s8pgmgr.
      program_type_name $s8pgmnm.
      primary_financing $s8prfin.
      owner_company mgmt_agent_company $s8owmgt.
      property_category $s8prpct.
      is_: $yesno. ;

  run;
  
  proc sort data=Sec8MF_&year._&month._us;
    by contract_number;
    
  %exit_macro:

%mend Sec8MF_nat_merge;

/** End Macro Definition **/

