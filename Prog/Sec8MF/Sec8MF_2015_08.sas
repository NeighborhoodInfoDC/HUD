/**************************************************************************
 Program:  Sec8MF_yyyy_mm.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  9/2/2015
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

  %let s8filedate = '25aug2015'd;
  
  %let upload = Y;
  
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

