/**************************************************************************
 Program:  Sec8MF_2022_10.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Donovan Harvey
 Created:  11/29/2022
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  
 
 Description:  Compile Section 8 multifamily contract/project data.
 Creates files for DC, MD, VA, and WV.
 
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )
%DCData_lib( RealProp )


*--- EDIT PARAMETERS BELOW -----------------------------------------;

  ** Enter date of HUD database as SAS date value, ex: '25nov2014'd **;

  %let s8filedate = '31oct2022'd;
  
  %let revisions = %str(New file.);

*-------------------------------------------------------------------;


*--- MAIN PROGRAM --------------------------------------------------;

%sec8mf_readbasetbls( 
  filedate=&s8filedate,
  folder=&_dcdata_r_path\HUD
)

%Sec8MF_dmvw( 
  filedate=&s8filedate,
  revisions=&revisions 
)

run;

