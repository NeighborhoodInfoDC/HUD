/**************************************************************************
 Program:  Sec8MF_yyyy_mm_remote.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Rodrigo Garcia
 Created:  7/24/25
 Version:  SAS 9.4
 Environment:  Remote Windows session (SAS1)
 GitHub issue: #223 
 
 Description:  Compile Section 8 multifamily contract/project data.
 Creates files for DC, MD, VA, and WV.
 
**************************************************************************/

%include "F:\DCData\SAS\Inc\StdRemote.sas";

** Define libraries **;
%DCData_lib( HUD )
%DCData_lib( RealProp )


*--- EDIT PARAMETERS BELOW -----------------------------------------;

  ** Enter date of HUD database as SAS date value, ex: '25nov2014'd **;

  %let s8filedate = '01jul2025'd;
  
  %let revisions = %str(New file.);

*-------------------------------------------------------------------;


*--- MAIN PROGRAM --------------------------------------------------;

%sec8mf_readbasetbls( 
  filedate=&s8filedate,
  folder=&_dcdata_r_path\HUD
)

%Sec8MF_dmvw( 
  finalize = Y,               /** Change to Y before final batch submit **/
  filedate=&s8filedate,
  revisions=&revisions 
)

run;

