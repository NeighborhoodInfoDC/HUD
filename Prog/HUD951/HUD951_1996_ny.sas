************************************************************************
* Program:  HUD951_1996_ny.sas
* Library:  HUD
* Project:  DC Data Warehouse
* Author:   P. Tatian
* Created:  10/21/04
* Version:  SAS 8.2
* Environment:  Windows
* 
* Description:  Create NY extract from HUD 951 data file
* (30 July 1996).  For Deborah Chester (JPC).
*
* Modifications:
************************************************************************;

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";

** Define libraries **;
%DCData_lib( HUD )

libname cdrom v6 "E:\HUD-951 SAS files";

data 
  HUD.HUD951_1996_ny (label="HUD-subsidized housing projects (HUD-951), NY, 1996"
                      compress=no)
  ;

  set cdrom.PRJGEO;
  
  where state in ( "NY" );
  
  format addlat addlong avelat avelong medlat medlong 12.6;

run;

%File_info( data=HUD.HUD951_1996_ny, freqvars=state )

