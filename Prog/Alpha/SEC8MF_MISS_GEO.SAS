/**************************************************************************
 Program:  Sec8mf_miss_geo.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  03/09/06
 Version:  SAS 8.2
 Environment:  Windows
 
 Description:  Autocall macro to fill in missing geocoded data for
 HUD Sec. 8 projects in DC.

 Modifications:
**************************************************************************/

/** Macro Sec8mf_miss_geo - Start Definition **/

%macro Sec8mf_miss_geo;

  ** Fill in missing geographic data for non-geocoded DC projects **;

  if state_code = "DC" and dcg_match_score <= 39 then do;
  
    select ( address_line1_text );
    
      when ( "21 K TER NW" ) do;
        x_coord = 398968.45;
        y_coord = 137265.59;
        ssl = "";
        anc2002 = "6C";
        psa2004 = "101";
        ward2002 = "6";
        cluster2000 = "08";
        geo2000 = "11001004700";
      end;
  
      when ( "3819 JAY ST NE" ) do;
        x_coord = 404663.28;
        y_coord = 137153.10;
        ssl = "";
        anc2002 = "7D";
        psa2004 = "601";
        ward2002 = "7";
        cluster2000 = "30";
        geo2000 = "11001009602";
      end;
  
      when ( "3598 HAYES ST NE" ) do;
        x_coord = 404191.20;
        y_coord = 137578.82;
        ssl = "";
        anc2002 = "7D";
        psa2004 = "601";
        ward2002 = "7";
        cluster2000 = "30";
        geo2000 = "11001009602";
      end;
  
      when ( "2704 Wade Road, S.E. #201" ) do;
        x_coord = 400249.41;
        y_coord = 132303.48;
        ssl = "5867 0899";
        anc2002 = "8C";
        psa2004 = "703";
        ward2002 = "8";
        cluster2000 = "37";
        geo2000 = "11001007401";
      end;
  
      when ( "2700-07 Douglas PL SE" ) do;
        x_coord = 400823.58;
        y_coord = 132041.31;
        ssl = "";
        anc2002 = "8A";
        psa2004 = "703";
        ward2002 = "8";
        cluster2000 = "37";
        geo2000 = "11001007406";
      end;
  
      when ( "2549 ELVANS RD SE" ) do;
        x_coord = 400756.76;
        y_coord = 131904.26;
        ssl = "";
        anc2002 = "8A";
        psa2004 = "703";
        ward2002 = "8";
        cluster2000 = "37";
        geo2000 = "11001007406";
      end;
  
      when ( "324 ANACOSTIA AVE SE" ) do;
        x_coord = 403941.59;
        y_coord = 135245.93;
        ssl = "";
        anc2002 = "7A";
        psa2004 = "603";
        ward2002 = "7";
        cluster2000 = "32";
        geo2000 = "11001007703";
      end;
  
      when ( "1112 FIRST TER NW" ) do;
        x_coord = 399026.38;
        y_coord = 137361.68;
        ssl = "";
        anc2002 = "6C";
        psa2004 = "101";
        ward2002 = "6";
        cluster2000 = "08";
        geo2000 = "11001004700";
      end;
  
      when ( "13TH & UPSHUR ST., NW" ) do;
        x_coord = 397424.89;
        y_coord = 141553.14;
        ssl = "";
        anc2002 = "4C";
        psa2004 = "404";
        ward2002 = "4";
        cluster2000 = "18";
        geo2000 = "11001002501";  /** Might be 25.02 **/
      end;
      
      otherwise 
        /** No correction **/;
        
    end;
    
    cluster_tr2000 = put( geo2000, $trct_cl. );
    
  end;

%mend Sec8mf_miss_geo;

/** End Macro Definition **/

