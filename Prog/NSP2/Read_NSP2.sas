/**************************************************************************
 Program:  Read_NSP2.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  05/21/09
 Version:  SAS 9.1
 Environment:  Windows
 
 Description:  Read NSP2 tract data from HUD.

 Modifications:
**************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";

** Define libraries **;
%DCData_lib( HUD )

/** Macro Read_nsp2 - Start Definition **/

%macro Read_nsp2( state= );

  filename fimport "d:\DCData\Libraries\HUD\Raw\NSP2-&state..csv" lrecl=1000;

  /*
  proc import out=NSP2_DC
      datafile=fimport
      dbms=csv replace;
    datarow=2;
    getnames=yes;

  run;
  */

  data NSP2_&state;

    infile FIMPORT delimiter = ',' MISSOVER DSD  firstobs=2 ;
       informat geo2000 $11. ;
       informat sta $2. ;
       informat cntyname $40. ;
       informat nforeclose best32. ;
       informat nvacancy best32. ;
       informat fordq_num best32. ;
       informat fordq_rate comma32. ;
       informat vac_rate comma32. ;
       informat num_mort_tract comma32. ;
       informat pct_lchl comma32. ;
       informat pct_hcll comma32. ;
       informat pct_hchl comma32. ;
       informat ofheo_price_change comma32. ;
       informat pct_unem_2008 comma32. ;
       informat unem_ch0708 comma32. ;
       
    input
                geo2000 $
                sta $
                cntyname $
                nforeclose
                nvacancy
                fordq_num
                fordq_rate
                vac_rate
                num_mort_tract
                pct_lchl
                pct_hcll
                pct_hchl
                ofheo_price_change
                pct_unem_2008
                unem_ch0708
    ;
    
  run;
  
  proc sort data=NSP2_&state;
    by geo2000;

  run;

%mend Read_nsp2;

/** End Macro Definition **/

%Read_nsp2( state=DC )
%Read_nsp2( state=MD )
%Read_nsp2( state=VA )


data Hud.NSP2_all (label="HUD NSP2 tract data, DC/MD/VA");

  set NSP2_DC NSP2_MD NSP2_VA;
    by geo2000;
  
  length ucounty $ 5;
  
  ucounty = geo2000;
  
  msa2003 = put( ucounty, ctym03f. );
  
  length cog $ 1;
  
  if ucounty in ( '11001', '24021', '24031', '24033', '51013', '51059', '51107', 
                  '51153', '51510', '51600', '51610', '51683', '51685' )
    then cog = '1';
  else cog = '0';
  
  informat _all_ ;

run;

%File_info( data=Hud.NSP2_all, freqvars=sta msa2003 )

proc freq data=Hud.NSP2_all;
  tables msa2003 * cog * ucounty * cntyname / list nocum nopct;
run;


data HUD.NSP2_cog (compress=no);

  set Hud.NSP2_all;
  where cog = '1';
  
run;

