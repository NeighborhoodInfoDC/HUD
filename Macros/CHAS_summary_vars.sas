/**************************************************************************
 Program:  CHAS_summary_vars.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Rob Pitingolo
 Created:  12/05/2019
 Version:  SAS 9.4
 Environment:  Windows
 Description: Create summary variables from source CHAS data.
 Modifications: 

**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas"; 

** Define standard libraries **;
%DCData_lib( HUD )


data ch;
	set hud.Chas_2012_16_ntnl (where=(geoid = "05000US11001"));

	/* Supply indicators */
	all_units_tot = sum(of T1_est1 T14A_est1 T14B_est1);
	occ_units_tot = T1_est1;
	owner_units_tot = T1_est2;
	forsale_units_tot = T14A_est1;
	renter_unit_tot = T1_est126;
	forrent_units_tot = T14B_est1;

	renter_unit_aff30 = T15C_est4;
	forrent_units_aff30 = sum(of T17B_est3 T17B_est8 T17B_est13 T17B_est18);

	renter_unit_aff50 = sum(of T15C_est4 T15C_est25);
	forrent_units_aff50 = sum(of T17B_est3 T17B_est4 T17B_est8 T17B_est9 T17B_est13 T17B_est14 T17B_est18 T17B_est19);
	owner_unit_aff50 = sum(of T15A_est4 T15B_est4);
	forsale_units_aff50 = sum(of T17A_est3 T17A_est8 T17A_est13 T17A_est18);

	renter_01br_tot = sum(of T15C_est6 T15C_est10 T15C_est14 T15C_est18 T15C_est22 T15C_est27 T15C_est31 T15C_est35
						T15C_est39 T15C_est43 T15C_est48 T15C_est52 T15C_est56 T15C_est60 T15C_est64 T15C_est69 T15C_est73
						T15C_est77 T15C_est81 T15C_est85);
	renter_2br_tot = sum(of T15C_est7 T15C_est11 T15C_est15 T15C_est19 T15C_est23 T15C_est28 T15C_est32 T15C_est36 T15C_est40
						T15C_est44 T15C_est49 T15C_est53 T15C_est57 T15C_est61 T15C_est65 T15C_est70 T15C_est74 T15C_est78
						T15C_est82 T15C_est86);
	renter_3plusbr_tot = sum(of T15C_est8 T15C_est12 T15C_est16 T15C_est20 T15C_est24 T15C_est29 T15C_est33 T15C_est37 T15C_est41
						T15C_est45 T15C_est50 T15C_est54 T15C_est58 T15C_est62 T15C_est66 T15C_est71 T15C_est75 T15C_est79
						T15C_est83 T15C_est87);
	renter_01br_aff30 = sum(of T15C_est6 T15C_est10 T15C_est14 T15C_est18 T15C_est22);
	renter_2br_aff30 = sum(of T15C_est7 T15C_est11 T15C_est15 T15C_est19 T15C_est23);
	renter_3plusbr_aff30 = sum(of T15C_est8 T15C_est12 T15C_est16 T15C_est20 T15C_est24);
	renter_allbr_aff30 = T15C_est4;
	renter_01br_aff50 = sum(of T15C_est6 T15C_est10 T15C_est14 T15C_est18 T15C_est22 T15C_est27 T15C_est31 T15C_est35 T15C_est39 T15C_est43 );
	renter_2br_aff50 = sum(of T15C_est7 T15C_est11 T15C_est15 T15C_est19 T15C_est23 T15C_est28 T15C_est32 T15C_est36 T15C_est40 T15C_est44);
	renter_3plusbr_aff50 = sum(of T15C_est8 T15C_est12 T15C_est16 T15C_est20 T15C_est24 T15C_est29 T15C_est33 T15C_est37 T15C_est41 T15C_est45);
	renter_allbr_aff50 = sum(of T15C_est4 T15C_est25);

	owner_01br_tot = sum(of T15A_est6 T15A_est10 T15A_est14 T15A_est18 T15A_est22 T15A_est27 T15A_est31 T15A_est35 T15A_est39 T15A_est43 
						T15A_est48 T15A_est52 T15A_est56 T15A_est60 T15A_est64 T15A_est69 T15A_est73 T15A_est77 T15A_est81 T15A_est85
						T15B_est6 T15B_est10 T15B_est14 T15B_est18 T15B_est22 T15B_est27 T15B_est31 T15B_est35 T15B_est39 T15B_est43 
						T15B_est48 T15B_est52 T15B_est56 T15B_est60 T15B_est64 T15B_est69 T15B_est73 T15B_est77 T15B_est81 T15B_est85);
	owner_2br_tot = sum(of T15A_est7 T15A_est11 T15A_est15 T15A_est19 T15A_est23 T15A_est28 T15A_est32 T15A_est36 T15A_est40 T15A_est44
						T15A_est49 T15A_est53 T15A_est57 T15A_est61 T15A_est65 T15A_est70 T15A_est74 T15A_est78 T15A_est82 T15A_est86
						T15B_est7 T15B_est11 T15B_est15 T15B_est19 T15B_est23 T15B_est28 T15B_est32 T15B_est36 T15B_est40 T15B_est44
						T15B_est49 T15B_est53 T15B_est57 T15B_est61 T15B_est65 T15B_est70 T15B_est74 T15B_est78 T15B_est82 T15B_est86);
	owner_3plusbr_tot = sum(of T15A_est8 T15A_est12 T15A_est16 T15A_est20 T15A_est24 T15A_est29 T15A_est33 T15A_est37 T15A_est41 T15A_est45
						T15A_est50 T15A_est54 T15A_est58 T15A_est62 T15A_est66 T15A_est71 T15A_est75 T15A_est79 T15A_est83 T15A_est87
						T15B_est8 T15B_est12 T15B_est16 T15B_est20 T15B_est24 T15B_est29 T15B_est33 T15B_est37 T15B_est41 T15B_est45
						T15B_est50 T15B_est54 T15B_est58 T15B_est62 T15B_est66 T15B_est71 T15B_est75 T15B_est79 T15B_est83 T15B_est87);
	owner_01br_aff50 = sum(of T15A_est6 T15A_est10 T15A_est14 T15A_est18 T15A_est22
						T15B_est6 T15B_est10 T15B_est14 T15B_est18 T15B_est22);
	owner_2br_aff50 = sum(of T15A_est7 T15A_est11 T15A_est15 T15A_est19 T15A_est23
						T15B_est7 T15B_est11 T15B_est15 T15B_est19 T15B_est23);
	owner_3plusbr_aff50 = sum(of T15A_est8 T15A_est12 T15A_est16 T15A_est20 T15A_est24
						T15B_est8 T15B_est12 T15B_est16 T15B_est20 T15B_est24);
	owner_allbr_aff50 = sum(of T15A_est4 T15B_est4);
	

	label all_units_tot = "All housing units (occupied and vacant)"
			occ_units_tot = "All occupied housing units"
			owner_units_tot = "Owner-occupied housing units"
			forsale_units_tot = "Vacant housing units for sale"
			renter_unit_tot = "Renter-occupied housing units"
			forrent_units_tot = "Vacant housing units for rent"
			renter_unit_aff30 = "Renter-occupied housing units affordable at 30% AMI"
			forrent_units_aff30 = "Vacant for rent housing units affordable at 30% AMI"
			renter_unit_aff50 = "Renter-occupied housing units affordable at 50% AMI"
			forrent_units_aff50 = "Vacant for rent housing units affordable at 50% AMI"
			owner_unit_aff50 = "Owner-occupied housing units affordable at 50% AMI"
			forsale_units_aff50 = "Vacant for sale housing units affordable at 50% AMI"
			renter_01br_tot = "Renter-occupied 0-1 bedroom housing units"
			renter_2br_tot = "Renter-occupied 2 bedroom housing units"
			renter_3plusbr_tot = "Renter-occupied 3+ bedroom housing units"
			renter_01br_aff30 = "Renter-occupied 0-1 bedroom housing units affordable at 30% AMI"
			renter_2br_aff30 = "Renter-occupied 2 bedroom housing units affordable at 30% AMI"
			renter_3plusbr_aff30 = "Renter-occupied 3+ bedroom housing units affordable at 30% AMI"
			renter_allbr_aff30 = "Renter-occupied housing units affordable at 30% AMI"
			renter_01br_aff50 = "Renter-occupied 0-1 bedroom housing units affordable at 50% AMI"
			renter_2br_aff50 = "Renter-occupied 2 bedroom housing units affordable at 50% AMI"
			renter_3plusbr_aff50 = "Renter-occupied 3+ bedroom housing units affordable at 50% AMI"
			renter_allbr_aff50 = "Renter-occupied housing units affordable at 50% AMI"
			owner_01br_tot = "Owner-occupied 0-1 bedroom housing units"
			owner_2br_tot = "Owner-occupied 2 bedroom housing units"
			owner_3plusbr_tot = "Owner-occupied 3+ bedroom housing units"
			owner_01br_aff50 = "Owner-occupied 0-1 bedroom housing units affordable at 50% AMI"
			owner_2br_aff50 = "Owner-occupied 2 bedroom housing units affordable at 50% AMI"
			owner_3plusbr_aff50 = "Owner-occupied 3+ bedroom housing units affordable at 50% AMI"
			owner_allbr_aff50 = "Owner-occupied housing units affordable at 50% AMI"
			;



run;
