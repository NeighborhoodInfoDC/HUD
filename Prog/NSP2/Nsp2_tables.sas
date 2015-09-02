/**************************************************************************
 Program:  Nsp2_tables.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  05/21/09
 Version:  SAS 9.1
 Environment:  Windows
 
 Description:  Tables from NSP2 tract data.

 Modifications:
**************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";

** Define libraries **;
%DCData_lib( HUD )
%DCData_lib( NCDB )

data NSP2_all_hsgu;

  merge 
    Hud.NSP2_all (in=in1)
    Ncdb.NCDB_lf_2000_was 
      (keep=geo2000 tothsun0);
  by geo2000;
  
  if in1;
  
  Tracts = 1;
  
run;

proc freq data=Hud.NSP2_all;
  where cog = '1';
  tables nforeclose nvacancy / missing;
run;
  
proc chart data=Hud.NSP2_all;
  hbar nforeclose nvacancy;
run;

proc format;
  value index (notsorted)
    18-high = '18+'
    16-<18 = '16-17'
    0-<16 = 'Under\~16'
;

options missing='-' nodate nonumber;

title1;

ods rtf file="d:\DCData\Libraries\HUD\Prog\NSP2_tables.rtf" style=Styles.Rtf_arial_9pt;
  
proc tabulate data=NSP2_all_hsgu format=comma10.0 noseps missing;
  where cog = '1';
  class cntyname;
  class nvacancy nforeclose / preloadfmt order=data;
  var Tracts tothsun0;
  table 
    /** Rows **/
    all='\b COG Region' cntyname=' ',
    /** Columns **/
    Tracts='Number of Census Tracts' * sum=' ' * (
      all='Total'
      nforeclose='Foreclosure Risk Index'
      nvacancy='Vacancy Risk Index' 
    )
  ;
  table 
    /** Rows **/
    all='\b COG Region' cntyname=' ',
    /** Columns **/
    tothsun0='Total Housing Units in Tracts (2000)' * sum=' ' * (
      all='Total'
      nforeclose='Foreclosure Risk Index'
      nvacancy='Vacancy Risk Index' 
    )
  ;
  format nforeclose nvacancy index.;
    

run;

ods rtf close;
