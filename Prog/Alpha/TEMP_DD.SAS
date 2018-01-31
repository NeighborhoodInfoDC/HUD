/**************************************************************************
 Program:  Temp.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  06/05/05
 Version:  SAS 8.2
 Environment:  Alpha OpenVMS
 
 Description:  

 Modifications:
**************************************************************************/

%include "[dcdata]Stdhead.sas";

** Define libraries **;
%DCData_lib( HUD )

proc print data=hud.Sec8mf_2006_07_dc(obs=300);

run;


endsas;
proc means data=hud.Sec8mf_2005_05_dc n sum;
  where  tracs_overall_expiration_date >= '01apr2005'd;
  var assisted_units_count;
  title2 'Current active';

proc means data=hud.Sec8mf_2005_05_dc n sum;
  where '01apr2005'd <= tracs_overall_expiration_date <= '31mar2006'd;
  var assisted_units_count;
  title2 'Expiring next four quarters';

proc means data=hud.Sec8mf_2005_05_dc n sum;
  where '01apr2004'd <= tracs_overall_expiration_date <= '31mar2005'd;
  var assisted_units_count;
  title2 'Expired last four quarters';

endsas;  

data _null_;

  set hud.Sec8mf_2005_05_dc;
  *where '01apr2005'd <= tracs_overall_expiration_date <= '31mar2006'd;
  where year( tracs_overall_expiration_date ) = 2005 and 
        qtr( tracs_overall_expiration_date ) = 1;

 FILE PRINT;
PUT _PAGE_;
PUT (_ALL_) (= /);
RUN;

