************************************************************************
* Program:  HUD951_1996.sas
* Library:  HUD
* Project:  DC Data Warehouse
* Author:   P. Tatian
* Created:  10/21/04
* Version:  SAS 8.2
* Environment:  Windows
* 
* Description:  Create DC, MD, VA, WV extracts from HUD 951 data file
* (30 July 1996).
*
* Modifications:
************************************************************************;

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";

** Define libraries **;
%DCData_lib( HUD )

libname cdrom v6 "E:\HUD-951 SAS files";

data 
  HUD.HUD951_1996_dc (label="HUD-subsidized housing projects (HUD-951), DC, 1996")
  HUD.HUD951_1996_md (label="HUD-subsidized housing projects (HUD-951), MD, 1996")
  HUD.HUD951_1996_va (label="HUD-subsidized housing projects (HUD-951), VA, 1996")
  HUD.HUD951_1996_wv (label="HUD-subsidized housing projects (HUD-951), WV, 1996")
  ;

  set cdrom.PRJGEO;
  
  where state in ( "DC", "MD", "VA", "WV" );
  
  select ( state );
    when ( "DC" )
      output HUD.HUD951_1996_dc;
    when ( "MD" )
      output HUD.HUD951_1996_md;
    when ( "VA" )
      output HUD.HUD951_1996_va;
    when ( "WV" )
      output HUD.HUD951_1996_wv;
  end;
  
  format addlat addlong avelat avelong medlat medlong 12.6;

run;

%File_info( data=HUD.HUD951_1996_dc, freqvars=state )

