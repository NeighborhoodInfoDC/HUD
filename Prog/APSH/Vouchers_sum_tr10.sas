/**************************************************************************
 Program:  HUDVouchers.sas
 Library:  HUD
 Project:  DMPED
 Author:   M. Woluchem
 Created:  10/01/14
 Version:  SAS 9.1
 Environment:  Windows
 Description:  Prepares HUD voucher cata for DMPED parcel profile
 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD, local=n )

libname Hudraw "&_dcdata_r_path\HUD\Raw\APSH";

data vouchers_fmt;
set hudraw.hudvouchersbytract (rename=(subsidized_units_available=total_units));
keep geo2010 Total_units;
geo2010=put(code, 11.);
run;


data Vouchers_dc_tract (compress=no);

  set vouchers_fmt;
       
  if put( geo2010, $geo10v. ) = '' then do;
    %warn_put( msg="Invalid 2010 tract ID: " _n_= geo2010= total_units= )
    geo2010 = '';
  end;
  
  output Vouchers_dc_tract;
  
  label geo2010 = 'Full census tract ID (2010): ssccctttttt'
		total_units = 'Voucher Count';
  
  format geo2010 $geo10a.;
  
run;

proc sort data=Vouchers_dc_tract
	out=Hud.Vouchers_sum_tr10;
  by geo2010;
  
%File_info( data=Hud.Vouchers_sum_tr10 )

