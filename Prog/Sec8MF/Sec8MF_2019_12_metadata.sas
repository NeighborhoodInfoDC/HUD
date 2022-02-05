/**************************************************************************
 Program:  Sec8MF_2019_12_metadata.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  02/05/22
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  201
 
 Description:  Resubmit metadata for Sec8MF_2019_12 data sets.

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )

%Delete_metadata_file( 
  ds_lib= HUD,
  ds_name= Sec8MF_2019_12_dc,
  meta_lib=_metadat
)

%Dc_update_meta_file(
  ds_lib=HUD,
  ds_name=Sec8MF_2019_12_dc,
  creator_process=Sec8MF_2019_12.sas,
  restrictions=None,
  revisions=%str(New file.)
)


%Dc_update_meta_file(
  ds_lib=HUD,
  ds_name=Sec8MF_2019_12_md,
  creator_process=Sec8MF_2019_12.sas,
  restrictions=None,
  revisions=%str(New file.)
)


%Dc_update_meta_file(
  ds_lib=HUD,
  ds_name=Sec8MF_2019_12_va,
  creator_process=Sec8MF_2019_12.sas,
  restrictions=None,
  revisions=%str(New file.)
)

%Dc_update_meta_file(
  ds_lib=HUD,
  ds_name=Sec8MF_2019_12_wv,
  creator_process=Sec8MF_2019_12.sas,
  restrictions=None,
  revisions=%str(New file.)
)

run;
