/**************************************************************************
 Program:  Sec8MF_2026_07_remote.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  7/8/2026
 Version:  SAS 9.4
 Environment:  Remote Windows session (SAS1)
 GitHub issue:  228
 
 Description:  Compile Section 8 multifamily contract/project data.
 Creates files for DC, MD, VA, and WV.
 
**************************************************************************/

%include "F:\DCData\SAS\Inc\StdRemote.sas";

** Define libraries **;
%DCData_lib( HUD )
%DCData_lib( RealProp )


*--- EDIT PARAMETERS BELOW -----------------------------------------;

  ** Enter date of HUD database as SAS date value, ex: '25nov2014'd **;

  %let s8filedate = '01jul2026'd;
  
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

