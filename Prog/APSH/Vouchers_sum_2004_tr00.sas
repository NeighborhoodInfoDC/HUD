/**************************************************************************
 Program:  Vouchers_sum_2004_tr00.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  12/05/07
 Version:  SAS 9.1
 Environment:  Local Windows session (desktop)
 
 Description:  Read in data provided by HUD on housing vouchers in
 census tracts for Dec. 2004.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD, local=n )

libname Hudraw "&_dcdata_r_path\HUD\Raw\Vouchers2014";

data Vouchers_dc_tract (compress=no) Vouchers_dc_notract (compress=no);

  set Hudraw.scantract_suppressed
       (where=(FIPSST='11')
        rename=(total=Total_2004));
       
  if put( geo2000, $geo00v. ) = '' then do;
    %warn_put( msg="Invalid 2000 tract ID: " _n_= geo2000= total_2004= )
    geo2000 = '';
  end;
  
  if geo2000 = '' then output Vouchers_dc_notract;
  else output Vouchers_dc_tract;
  
  label geo2000 = 'Full census tract ID (2000): ssccctttttt';
  
  format geo2000 $geo00a.;
  
  keep geo2000 Total_2004;

run;

proc summary data=Vouchers_dc_tract nway completetypes;
  class geo2000 / preloadfmt;
  var Total_2004;
  output out=Vouchers_dc_tract_sum (compress=no) sum=Total_2004_org;

*proc print;

proc summary data=Vouchers_dc_notract nway;
  var Total_2004;
  output out=Vouchers_dc_notract_total (drop=_type_ _freq_ compress=no) sum=Total_2004_notract;

*proc print;

proc summary data=Vouchers_dc_tract nway;
  var Total_2004;
  output out=Vouchers_dc_tract_total (drop=_type_ _freq_ compress=no) sum=Total_2004_tract;

*proc print;

proc sort data=Vouchers_dc_tract_sum;
  by descending total_2004_org;

data Hud.Vouchers_sum_2004_tr00 (label="Housing choice voucher summary, DC, Census tract (2000)");

  retain _run_total_2004_notract;

  set Vouchers_dc_tract_sum;
  
  if _n_ = 1 then do;
    set Vouchers_dc_notract_total;
    set Vouchers_dc_tract_total;
    _run_total_2004_notract = Total_2004_notract;
  end;
  
  if Total_2004_org = . then Total_2004_org = 0;
  
  ** Allocate vouchers not identified by tract in proportion to those with tracts **;

  if Total_2004_org > 0 and _run_total_2004_notract > 0 then do;
    _add = min( ceil( Total_2004_notract * ( Total_2004_org / Total_2004_tract ) ), _run_total_2004_notract );
    Total_2004 = sum( Total_2004_org, _add );
    _run_total_2004_notract = _run_total_2004_notract - _add;
  end;
  else
    Total_2004 = Total_2004_org;

  label
    Total_2004 = "Voucher households, 12/2004";
    
  keep geo2000 Total_2004;

run;

proc sort data=Hud.Vouchers_sum_2004_tr00;
  by geo2000;
  
%File_info( data=Hud.Vouchers_sum_2004_tr00 )

