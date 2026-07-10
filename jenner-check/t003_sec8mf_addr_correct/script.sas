/**************************************************************************
 Bundle:  t003_sec8mf_addr_correct
 Source:  Macros/Sec8MF_addr_correct.sas  (NeighborhoodInfoDC/HUD)

 The %Sec8MF_addr_correct macro is reproduced verbatim from the
 repository. It is an autocall macro that Sec8MF_dmvw.sas drops inside a
 DATA step to fix a handful of known-bad HUD Section 8 multifamily street
 addresses (DC only), using a SELECT ( address_line1_text ) block. Here we
 supply a small mock contract table exercising both corrected addresses,
 a DC address that should pass through unchanged, and a non-DC row (so the
 outer "if state_code = 'DC'" guard is exercised too), then invoke the
 macro inside a DATA step exactly as Sec8MF_dmvw does.
**************************************************************************/

/** ---- Macro reproduced verbatim from Macros/Sec8MF_addr_correct.sas ---- **/

%macro Sec8MF_addr_correct;

  ** DC addresses only **;

  if state_code = "DC" then do;

    select ( address_line1_text );

      %** Add a new WHEN statement for each address to be corrected **;

      when ( "2518 NW 17th ST NW" )
        address_line1_text = "2518 17th ST NW";

      when ( "324 ANACOSTIA AVE SE" )
        address_line1_text = "324 ANACOSTIA ROAD SE";

      %** Do not change below this line **;

      otherwise /** No correction **/;

    end;

  end;

%mend Sec8MF_addr_correct;

/** ---- Mock Section 8 MF contract addresses ---- **/

data sec8mf_contracts;
  length state_code $2 address_line1_text $40;
  input state_code $ address_line1_text $char40.;
  datalines;
DC 2518 NW 17th ST NW
DC 324 ANACOSTIA AVE SE
DC 1500 MASSACHUSETTS AVE NW
MD 324 ANACOSTIA AVE SE
;
run;

/** ---- Apply the corrections inside a DATA step, as Sec8MF_dmvw does ---- **/

data sec8mf_corrected;
  set sec8mf_contracts;
  %Sec8MF_addr_correct
run;

proc print data=sec8mf_corrected; var state_code address_line1_text; run;
