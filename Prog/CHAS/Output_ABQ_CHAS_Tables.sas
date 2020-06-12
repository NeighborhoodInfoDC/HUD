/**************************************************************************
 Program:  Output_CHAS_Tables.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Rob Pitingolo
 Created:  01/22/2020
 Version:  SAS 9.4
 Environment:  Windows
 Description: Output CSVs for CHAS tables that then get copied into worksheets. 
 Modifications: 

**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas"; 

** Define standard libraries **;
%DCData_lib( HUD );


** Folder to save output CSVs **;
%let outfolder = &_dcdata_r_path.\HUD\Prog\CHAS\CHASoutput\&Level.\;


** Create CHAS summary variables from national file **;
%chas_summary_vars (years=2006_10, out=chas);
%chas_summary_vars (years=2012_16, out=chas);


** Export data to CSV for each geography **;
%export_chas_csv(county,35001);
%export_chas_csv(place,3502000);



/* End of Program */
