/**************************************************************************
 Program:  Sec8MF_2014_10.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  12/23/14
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Compile Section 8 multifamily contract/project data.
 Creates files for DC, MD, VA, and WV.
 
 NB:  Change upload=Y for final batch run.

 Modifications:
  10/19/14 PAT Updated for SAS1.
  12/23/14 PAT New version incorporating %sec8mf_readbasetbls() and
               %Sec8MF_dmvw() macros.
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD, local=n )
%DCData_lib( RealProp, local=n )


*--- EDIT PARAMETERS BELOW -----------------------------------------;

  ** Enter date of HUD database as SAS date value, ex: '25nov2014'd **;

  %let s8filedate = '25nov2014'd;
  
  %let upload = N;
  
  %let revisions = %str(New file.);

*-------------------------------------------------------------------;


*--- MAIN PROGRAM --------------------------------------------------;

%sec8mf_readbasetbls( 
  filedate=&s8filedate,
  folder=&_dcdata_r_path\HUD
)

%Sec8MF_dmvw( 
  filedate=&s8filedate,
  upload=&upload,
  revisions=&revisions 
)

run;

proc compare base=HUD.Sec8mf_2014_10_dc compare=HUD.Sec8mf_2014_11_dc maxprint=(40,32000);
  id contract_number;
  var
    owner_organization_name
    owner_individual_full_name
    mgmt_agent_org_name
    mgmt_agent_full_name
    assisted_units_count
    tracs_effective_date
    tracs_overall_expiration_date
    rent_to_FMR_description
    tracs_status
    property_id
    program_type_name;
run;

