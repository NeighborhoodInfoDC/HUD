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


%let yrs = 2012_16;

data ch_test;
	set hud.Chas_&yrs._ntnl (where=(geoid = "05000US11001"));

	/* Supply indicators */
	all_units_tot_&yrs. = sum(of T1_est1 T14A_est1 T14B_est1);
	occ_units_tot_&yrs. = T1_est1;
	owner_units_tot_&yrs. = T1_est2;
	forsale_units_tot_&yrs. = T14A_est1;
	renter_unit_tot_&yrs. = T1_est126;
	forrent_units_tot_&yrs. = T14B_est1;

	renter_unit_aff30_&yrs. = T15C_est4;
	forrent_units_aff30_&yrs. = sum(of T17B_est3 T17B_est8 T17B_est13 T17B_est18);

	renter_unit_aff50_&yrs. = sum(of T15C_est4 T15C_est25);
	forrent_units_aff50_&yrs. = sum(of T17B_est3 T17B_est4 T17B_est8 T17B_est9 T17B_est13 T17B_est14 T17B_est18 T17B_est19);
	owner_unit_aff50_&yrs. = sum(of T15A_est4 T15B_est4);
	forsale_units_aff50_&yrs. = sum(of T17A_est3 T17A_est8 T17A_est13 T17A_est18);

	renter_01br_tot_&yrs. = sum(of T15C_est6 T15C_est10 T15C_est14 T15C_est18 T15C_est22 T15C_est27 T15C_est31 T15C_est35
						T15C_est39 T15C_est43 T15C_est48 T15C_est52 T15C_est56 T15C_est60 T15C_est64 T15C_est69 T15C_est73
						T15C_est77 T15C_est81 T15C_est85);
	renter_2br_tot_&yrs. = sum(of T15C_est7 T15C_est11 T15C_est15 T15C_est19 T15C_est23 T15C_est28 T15C_est32 T15C_est36 T15C_est40
						T15C_est44 T15C_est49 T15C_est53 T15C_est57 T15C_est61 T15C_est65 T15C_est70 T15C_est74 T15C_est78
						T15C_est82 T15C_est86);
	renter_3plusbr_tot_&yrs. = sum(of T15C_est8 T15C_est12 T15C_est16 T15C_est20 T15C_est24 T15C_est29 T15C_est33 T15C_est37 T15C_est41
						T15C_est45 T15C_est50 T15C_est54 T15C_est58 T15C_est62 T15C_est66 T15C_est71 T15C_est75 T15C_est79
						T15C_est83 T15C_est87);
	renter_01br_aff30_&yrs. = sum(of T15C_est6 T15C_est10 T15C_est14 T15C_est18 T15C_est22);
	renter_2br_aff30_&yrs. = sum(of T15C_est7 T15C_est11 T15C_est15 T15C_est19 T15C_est23);
	renter_3plusbr_aff30_&yrs. = sum(of T15C_est8 T15C_est12 T15C_est16 T15C_est20 T15C_est24);
	renter_allbr_aff30_&yrs. = T15C_est4;
	renter_01br_aff50_&yrs. = sum(of T15C_est6 T15C_est10 T15C_est14 T15C_est18 T15C_est22 T15C_est27 T15C_est31 T15C_est35 T15C_est39 T15C_est43 );
	renter_2br_aff50_&yrs. = sum(of T15C_est7 T15C_est11 T15C_est15 T15C_est19 T15C_est23 T15C_est28 T15C_est32 T15C_est36 T15C_est40 T15C_est44);
	renter_3plusbr_aff50_&yrs. = sum(of T15C_est8 T15C_est12 T15C_est16 T15C_est20 T15C_est24 T15C_est29 T15C_est33 T15C_est37 T15C_est41 T15C_est45);
	renter_allbr_aff50_&yrs. = sum(of T15C_est4 T15C_est25);

	owner_01br_tot_&yrs. = sum(of T15A_est6 T15A_est10 T15A_est14 T15A_est18 T15A_est22 T15A_est27 T15A_est31 T15A_est35 T15A_est39 T15A_est43 
						T15A_est48 T15A_est52 T15A_est56 T15A_est60 T15A_est64 T15A_est69 T15A_est73 T15A_est77 T15A_est81 T15A_est85
						T15B_est6 T15B_est10 T15B_est14 T15B_est18 T15B_est22 T15B_est27 T15B_est31 T15B_est35 T15B_est39 T15B_est43 
						T15B_est48 T15B_est52 T15B_est56 T15B_est60 T15B_est64 T15B_est69 T15B_est73 T15B_est77 T15B_est81 T15B_est85);
	owner_2br_tot_&yrs. = sum(of T15A_est7 T15A_est11 T15A_est15 T15A_est19 T15A_est23 T15A_est28 T15A_est32 T15A_est36 T15A_est40 T15A_est44
						T15A_est49 T15A_est53 T15A_est57 T15A_est61 T15A_est65 T15A_est70 T15A_est74 T15A_est78 T15A_est82 T15A_est86
						T15B_est7 T15B_est11 T15B_est15 T15B_est19 T15B_est23 T15B_est28 T15B_est32 T15B_est36 T15B_est40 T15B_est44
						T15B_est49 T15B_est53 T15B_est57 T15B_est61 T15B_est65 T15B_est70 T15B_est74 T15B_est78 T15B_est82 T15B_est86);
	owner_3plusbr_tot_&yrs. = sum(of T15A_est8 T15A_est12 T15A_est16 T15A_est20 T15A_est24 T15A_est29 T15A_est33 T15A_est37 T15A_est41 T15A_est45
						T15A_est50 T15A_est54 T15A_est58 T15A_est62 T15A_est66 T15A_est71 T15A_est75 T15A_est79 T15A_est83 T15A_est87
						T15B_est8 T15B_est12 T15B_est16 T15B_est20 T15B_est24 T15B_est29 T15B_est33 T15B_est37 T15B_est41 T15B_est45
						T15B_est50 T15B_est54 T15B_est58 T15B_est62 T15B_est66 T15B_est71 T15B_est75 T15B_est79 T15B_est83 T15B_est87);
	owner_01br_aff50_&yrs. = sum(of T15A_est6 T15A_est10 T15A_est14 T15A_est18 T15A_est22
						T15B_est6 T15B_est10 T15B_est14 T15B_est18 T15B_est22);
	owner_2br_aff50_&yrs. = sum(of T15A_est7 T15A_est11 T15A_est15 T15A_est19 T15A_est23
						T15B_est7 T15B_est11 T15B_est15 T15B_est19 T15B_est23);
	owner_3plusbr_aff50_&yrs. = sum(of T15A_est8 T15A_est12 T15A_est16 T15A_est20 T15A_est24
						T15B_est8 T15B_est12 T15B_est16 T15B_est20 T15B_est24);
	owner_allbr_aff50_&yrs. = sum(of T15A_est4 T15B_est4);
	

	label all_units_tot_&yrs. = "All housing units (occupied and vacant)"
			occ_units_tot_&yrs. = "All occupied housing units"
			owner_units_tot_&yrs. = "Owner-occupied housing units"
			forsale_units_tot_&yrs. = "Vacant housing units for sale"
			renter_unit_tot_&yrs. = "Renter-occupied housing units"
			forrent_units_tot_&yrs. = "Vacant housing units for rent"
			renter_unit_aff30_&yrs. = "Renter-occupied housing units affordable at 30% AMI"
			forrent_units_aff30_&yrs. = "Vacant for rent housing units affordable at 30% AMI"
			renter_unit_aff50_&yrs. = "Renter-occupied housing units affordable at 50% AMI"
			forrent_units_aff50_&yrs. = "Vacant for rent housing units affordable at 50% AMI"
			owner_unit_aff50_&yrs. = "Owner-occupied housing units affordable at 50% AMI"
			forsale_units_aff50_&yrs. = "Vacant for sale housing units affordable at 50% AMI"
			renter_01br_tot_&yrs. = "Renter-occupied 0-1 bedroom housing units"
			renter_2br_tot_&yrs. = "Renter-occupied 2 bedroom housing units"
			renter_3plusbr_tot_&yrs. = "Renter-occupied 3+ bedroom housing units"
			renter_01br_aff30_&yrs. = "Renter-occupied 0-1 bedroom housing units affordable at 30% AMI"
			renter_2br_aff30_&yrs. = "Renter-occupied 2 bedroom housing units affordable at 30% AMI"
			renter_3plusbr_aff30_&yrs. = "Renter-occupied 3+ bedroom housing units affordable at 30% AMI"
			renter_allbr_aff30_&yrs. = "Renter-occupied housing units affordable at 30% AMI"
			renter_01br_aff50_&yrs. = "Renter-occupied 0-1 bedroom housing units affordable at 50% AMI"
			renter_2br_aff50_&yrs. = "Renter-occupied 2 bedroom housing units affordable at 50% AMI"
			renter_3plusbr_aff50_&yrs. = "Renter-occupied 3+ bedroom housing units affordable at 50% AMI"
			renter_allbr_aff50_&yrs. = "Renter-occupied housing units affordable at 50% AMI"
			owner_01br_tot_&yrs. = "Owner-occupied 0-1 bedroom housing units"
			owner_2br_tot_&yrs. = "Owner-occupied 2 bedroom housing units"
			owner_3plusbr_tot_&yrs. = "Owner-occupied 3+ bedroom housing units"
			owner_01br_aff50_&yrs. = "Owner-occupied 0-1 bedroom housing units affordable at 50% AMI"
			owner_2br_aff50_&yrs. = "Owner-occupied 2 bedroom housing units affordable at 50% AMI"
			owner_3plusbr_aff50_&yrs. = "Owner-occupied 3+ bedroom housing units affordable at 50% AMI"
			owner_allbr_aff50_&yrs. = "Owner-occupied housing units affordable at 50% AMI"
			;

	/* Supply vs Demand */
	rent030_inc030_allbr_&yrs. = T15C_est5;
	rent3050_inc030_allbr_&yrs. = T15C_est26;
	rent5080_inc030_allbr_&yrs. = T15C_est47;
	rent80pl_inc030_allbr_&yrs. = T15C_est68;

	rent030_inc3050_allbr_&yrs. = T15C_est9;
	rent3050_inc30t0_allbr_&yrs. = T15C_est30;
	rent5080_inc3050_allbr_&yrs. = T15C_est51;
	rent80pl_inc3050_allbr_&yrs. = T15C_est72;

	rent030_inc5080_allbr_&yrs. = T15C_est13;
	rent3050_inc5080_allbr_&yrs. = T15C_est34;
	rent5080_inc5080_allbr_&yrs. = T15C_est55;
	rent80pl_inc5080_allbr_&yrs. = T15C_est76;

	rent030_inc80100_allbr_&yrs. = T15C_est17;
	rent3050_inc80100_allbr_&yrs. = T15C_est38;
	rent5080_inc80100_allbr_&yrs. = T15C_est59;
	rent80pl_inc80100_allbr_&yrs. = T15C_est80;

	rent030_inc100pl_allbr_&yrs. = T15C_est21;
	rent3050_inc100pl_allbr_&yrs. = T15C_est42;
	rent5080_inc100pl_allbr_&yrs. = T15C_est63;
	rent80pl_inc100pl_allbr_&yrs. = T15C_est84;

	rent030_inc030_01br_&yrs. = T15C_est6;
	rent3050_inc030_01br_&yrs. = T15C_est27;
	rent5080_inc030_01br_&yrs. = T15C_est48;
	rent80pl_inc030_01br_&yrs. = T15C_est69;

	rent030_inc3050_01br_&yrs. = T15C_est10;
	rent3050_inc3050_01br_&yrs. = T15C_est31;
	rent5080_inc3050_01br_&yrs. = T15C_est52;
	rent80pl_inc3050_01br_&yrs. = T15C_est73;

	rent030_inc5080_01br_&yrs. = T15C_est14;
	rent3050_inc5080_01br_&yrs. = T15C_est35;
	rent5080_inc5080_01br_&yrs. = T15C_est56;
	rent80pl_inc5080_01br_&yrs. = T15C_est77;

	rent030_inc80100_01br_&yrs. = T15C_est18;
	rent3050_inc80100_01br_&yrs. = T15C_est39;
	rent5080_inc80100_01br_&yrs. = T15C_est60;
	rent80pl_inc80100_01br_&yrs. = T15C_est81;

	rent030_inc100pl_01br_&yrs. = T15C_est22;
	rent3050_inc100pl_01br_&yrs. = T15C_est43;
	rent5080_inc100pl_01br_&yrs. = T15C_est64;
	rent80pl_inc100pl_01br_&yrs. = T15C_est85;

	rent030_inc030_2br_&yrs. = T15C_est7;
	rent3050_inc030_2br_&yrs. = T15C_est28;
	rent5080_inc030_2br_&yrs. = T15C_est49;
	rent80pl_inc030_2br_&yrs. = T15C_est70;

	rent030_inc3050_2br_&yrs. = T15C_est11;
	rent3050_inc3050_2br_&yrs. = T15C_est32;
	rent5080_inc3050_2br_&yrs. = T15C_est53;
	rent80pl_inc3050_2br_&yrs. = T15C_est74;

	rent030_inc5080_2br_&yrs. = T15C_est15;
	rent3050_inc5080_2br_&yrs. = T15C_est36;
	rent580_inc5080_2br_&yrs. = T15C_est57;
	rent80pl_inc5080_2br_&yrs. = T15C_est78;

	rent030_inc80100_2br_&yrs. = T15C_est19;
	rent3050_inc80100_2br_&yrs. = T15C_est40;
	rent5080_inc80100_2br_&yrs. = T15C_est61;
	rent80pl_inc80100_2br_&yrs. = T15C_est82;

	rent030_inc100pl_2br_&yrs. = T15C_est23;
	rent3050_inc100pl_2br_&yrs. = T15C_est44;
	rent5080_inc100pl_2br_&yrs. = T15C_est65;
	rent80pl_inc100pl_2br_&yrs. = T15C_est86;

	rent030_inc030_3br_&yrs. = T15C_est8;
	rent3050_inc030_3br_&yrs. = T15C_est29;
	rent5080_inc030_3br_&yrs. = T15C_est50;
	rent80pl_inc030_3br_&yrs. = T15C_est71;

	rent030_inc3050_3br_&yrs. = T15C_est12;
	rent3050_inc3050_3br_&yrs. = T15C_est33;
	rent5080_inc3050_3br_&yrs. = T15C_est54;
	rent80pl_inc3050_3br_&yrs. = T15C_est75;

	rent030_inc5080_3br_&yrs. = T15C_est16;
	rent3050_inc5080_3br_&yrs. = T15C_est37;
	rent5080_inc5080_3br_&yrs. = T15C_est58;
	rent80pl_inc5080_3br_&yrs. = T15C_est79;

	rent030_inc80100_3br_&yrs. = T15C_est20;
	rent3050_inc80100_3br_&yrs. = T15C_est41;
	rent5080_inc80100_3br_&yrs. = T15C_est62;
	rent80pl_inc80100_3br_&yrs. = T15C_est83;

	rent030_inc100pl_3br_&yrs. = T15C_est24;
	rent3050_inc100pl_3br_&yrs. = T15C_est45;
	rent5080_inc100pl_3br_&yrs. = T15C_est66;
	rent80pl_inc100pl_3br_&yrs. = T15C_est87;

	label
	rent030_inc030_allbr_&yrs. = "Rent level 0-30%, household income 0-30%"
	rent3050_inc030_allbr_&yrs. = "Rent level 30-50%, household income 0-30%"
	rent5080_inc030_allbr_&yrs. = "Rent level 50-80%, household income 0-30%"
	rent80pl_inc030_allbr_&yrs. = "Rent level 80%+, household income 0-30%"
	rent030_inc3050_allbr_&yrs. = "Rent level 0-30%, household income 30-50%"
	rent3050_inc30t0_allbr_&yrs. = "Rent level 30-50%, household income 30-50%"
	rent5080_inc3050_allbr_&yrs. = "Rent level 50-80%, household income 30-50%"
	rent80pl_inc3050_allbr_&yrs. = "Rent level 80%+, household income 30-50%"
	rent030_inc5080_allbr_&yrs. = "Rent level 0-30%, household income 50-80%"
	rent3050_inc5080_allbr_&yrs. = "Rent level 30-50%, household income 50-80%"
	rent5080_inc5080_allbr_&yrs. = "Rent level 50-80%, household income 50-80%"
	rent80pl_inc5080_allbr_&yrs. = "Rent level 80%+, household income 50-80%"
	rent030_inc80100_allbr_&yrs. = "Rent level 0-30%, household income 80-100%"
	rent3050_inc80100_allbr_&yrs. = "Rent level 30-50%, household income 80-100%"
	rent5080_inc80100_allbr_&yrs. = "Rent level 50-80%, household income 80-100%"
	rent80pl_inc80100_allbr_&yrs. = "Rent level 80%+, household income 80-100%"
	rent030_inc100pl_allbr_&yrs. = "Rent level 0-30%, household income 100%+"
	rent3050_inc100pl_allbr_&yrs. = "Rent level 30-50%, household income 100%+"
	rent5080_inc100pl_allbr_&yrs. = "Rent level 50-80%, household income 100%+"
	rent80pl_inc100pl_allbr_&yrs. = "Rent level 80%+, household income 100%+"
	rent030_inc030_01br_&yrs. = "Rent level 0-30%, household income 0-30%, 0-1 bedrooms"
	rent3050_inc030_01br_&yrs. = "Rent level 30-50%, household income 0-30%, 0-1 bedrooms"
	rent5080_inc030_01br_&yrs. = "Rent level 50-80%, household income 0-30%, 0-1 bedrooms"
	rent80pl_inc030_01br_&yrs. = "Rent level 80%+, household income 0-30%, 0-1 bedrooms"
	rent030_inc3050_01br_&yrs. = "Rent level 0-30%, household income 30-50%, 0-1 bedrooms"
	rent3050_inc3050_01br_&yrs. = "Rent level 30-50%, household income 30-50%, 0-1 bedrooms"
	rent5080_inc3050_01br_&yrs. = "Rent level 50-80%, household income 30-50%, 0-1 bedrooms"
	rent80pl_inc3050_01br_&yrs. = "Rent level 80%+, household income 30-50%, 0-1 bedrooms"
	rent030_inc5080_01br_&yrs. = "Rent level 0-30%, household income 50-80%, 0-1 bedrooms"
	rent3050_inc5080_01br_&yrs. = "Rent level 30-50%, household income 50-80%, 0-1 bedrooms"
	rent5080_inc5080_01br_&yrs. = "Rent level 50-80%, household income 50-80%, 0-1 bedrooms"
	rent80pl_inc5080_01br_&yrs. = "Rent level 80%+, household income 50-80%, 0-1 bedrooms"
	rent030_inc80100_01br_&yrs. = "Rent level 0-30%, household income 80-100%, 0-1 bedrooms"
	rent3050_inc80100_01br_&yrs. = "Rent level 30-50%, household income 80-100%, 0-1 bedrooms"
	rent5080_inc80100_01br_&yrs. = "Rent level 50-80%, household income 80-100%, 0-1 bedrooms"
	rent80pl_inc80100_01br_&yrs. = "Rent level 80%+, household income 80-100%, 0-1 bedrooms"
	rent030_inc100pl_01br_&yrs. = "Rent level 0-30%, household income 100%+, 0-1 bedrooms"
	rent3050_inc100pl_01br_&yrs. = "Rent level 30-50%, household income 100%+, 0-1 bedrooms"
	rent5080_inc100pl_01br_&yrs. = "Rent level 50-80%, household income 100%+, 0-1 bedrooms"
	rent80pl_inc100pl_01br_&yrs. = "Rent level 80%+, household income 100%+, 0-1 bedrooms"
	rent030_inc030_2br_&yrs. = "Rent level 0-30%, household income 0-30%, 2 bedrooms"
	rent3050_inc030_2br_&yrs. = "Rent level 30-50%, household income 0-30%, 2 bedrooms"
	rent5080_inc030_2br_&yrs. = "Rent level 50-80%, household income 0-30%, 2 bedrooms"
	rent80pl_inc030_2br_&yrs. = "Rent level 80%+, household income 0-30%, 2 bedrooms"
	rent030_inc3050_2br_&yrs. = "Rent level 0-30%, household income 30-50%, 2 bedrooms"
	rent3050_inc3050_2br_&yrs. = "Rent level 30-50%, household income 30-50%, 2 bedrooms"
	rent5080_inc3050_2br_&yrs. = "Rent level 50-80%, household income 30-50%, 2 bedrooms"
	rent80pl_inc3050_2br_&yrs. = "Rent level 80%+, household income 30-50%, 2 bedrooms"
	rent030_inc5080_2br_&yrs. = "Rent level 0-30%, household income 50-80%, 2 bedrooms"
	rent3050_inc5080_2br_&yrs. = "Rent level 30-50%, household income 50-80%, 2 bedrooms"
	rent580_inc5080_2br_&yrs. = "Rent level 50-80%, household income 50-80%, 2 bedrooms"
	rent80pl_inc5080_2br_&yrs. = "Rent level 80%+, household income 50-80%, 2 bedrooms"
	rent030_inc80100_2br_&yrs. = "Rent level 0-30%, household income 80-100%, 2 bedrooms"
	rent3050_inc80100_2br_&yrs. = "Rent level 30-50%, household income 80-100%, 2 bedrooms"
	rent5080_inc80100_2br_&yrs. = "Rent level 50-80%, household income 80-100%, 2 bedrooms"
	rent80pl_inc80100_2br_&yrs. = "Rent level 80%+, household income 80-100%, 2 bedrooms"
	rent030_inc100pl_2br_&yrs. = "Rent level 0-30%, household income 100%+, 3+ bedrooms"
	rent3050_inc100pl_2br_&yrs. = "Rent level 30-50%, household income 100%+, 3+ bedrooms"
	rent5080_inc100pl_2br_&yrs. = "Rent level 50-80%, household income 100%+, 3+ bedrooms"
	rent80pl_inc100pl_2br_&yrs. = "Rent level 80%+, household income 100%+, 3+ bedrooms"
	rent030_inc030_3br_&yrs. = "Rent level 0-30%, household income 0-30%, 3+ bedrooms"
	rent3050_inc030_3br_&yrs. = "Rent level 30-50%, household income 0-30%, 3+ bedrooms"
	rent5080_inc030_3br_&yrs. = "Rent level 50-80%, household income 0-30%, 3+ bedrooms"
	rent80pl_inc030_3br_&yrs. = "Rent level 80%+, household income 0-30%, 3+ bedrooms"
	rent030_inc3050_3br_&yrs. = "Rent level 0-30%, household income 30-50%, 3+ bedrooms"
	rent3050_inc3050_3br_&yrs. = "Rent level 30-50%, household income 30-50%, 3+ bedrooms"
	rent5080_inc3050_3br_&yrs. = "Rent level 50-80%, household income 30-50%, 3+ bedrooms"
	rent80pl_inc3050_3br_&yrs. = "Rent level 80%+, household income 30-50%, 3+ bedrooms"
	rent030_inc5080_3br_&yrs. = "Rent level 0-30%, household income 50-80%, 3+ bedrooms"
	rent3050_inc5080_3br_&yrs. ="Rent level 30-50%, household income 50-80%, 3+ bedrooms"
	rent5080_inc5080_3br_&yrs. = "Rent level 50-80%, household income 50-80%, 3+ bedrooms"
	rent80pl_inc5080_3br_&yrs. = "Rent level 80%+, household income 50-80%, 3+ bedrooms"
	rent030_inc80100_3br_&yrs. = "Rent level 0-30%, household income 80-100%, 3+ bedrooms"
	rent3050_inc80100_3br_&yrs. = "Rent level 30-50%, household income 80-100%, 3+ bedrooms"
	rent5080_inc80100_3br_&yrs. = "Rent level 50-80%, household income 80-100%, 3+ bedrooms"
	rent80pl_inc80100_3br_&yrs. = "Rent level 80%+, household income 80-100%, 3+ bedrooms"
	rent030_inc100pl_3br_&yrs. = "Rent level 0-30%, household income 100%+, 3+ bedrooms"
	rent3050_inc100pl_3br_&yrs. = "Rent level 30-50%, household income 100%+, 3+ bedrooms"
	rent5080_inc100pl_3br_&yrs. = "Rent level 50-80%, household income 100%+, 3+ bedrooms"
	rent80pl_inc100pl_3br_&yrs. = "Rent level 80%+, household income 100%+, 3+ bedrooms"
	;


run;
