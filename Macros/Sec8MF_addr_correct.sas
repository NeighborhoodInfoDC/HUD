/**************************************************************************
 Program:  Sec8MF_addr_correct.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  08/03/05
 Version:  SAS 8.2
 Environment:  Windows
 
 Description:  Autocall macro with address corrections for HUD
 Section 8 MF data.  Called by Sec8MF_Macro.sas.

 Modifications:
  12/23/14 PAT Added "324 ANACOSTIA AVE SE".
**************************************************************************/

/** Macro Sec8MF_addr_correct - Start Definition **/

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

/** End Macro Definition **/

