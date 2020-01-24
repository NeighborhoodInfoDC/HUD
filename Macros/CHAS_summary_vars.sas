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


%macro chas_summary_vars (years, out);

%let years_dash = %sysfunc(translate(&years., '-', '_' ));

data &out._&years.;
	set hud.Chas_&years._ntnl;

	/* Supply */
	all_units_tot_&years. = sum(of T1_est1 T14A_est1 T14B_est1);
	occ_units_tot_&years. = T1_est1;
	owner_units_tot_&years. = T1_est2;
	forsale_units_tot_&years. = T14A_est1;
	own_forsale_units_tot_&years. = sum(of T1_est2 T14A_est1);
	renter_unit_tot_&years. = T1_est126;
	forrent_units_tot_&years. = T14B_est1;
	rent_forrent_units_tot_&years. = sum(of T1_est126 T14B_est1);

	renter_unit_aff30_&years. = T15C_est4;
	forrent_units_aff30_&years. = sum(of T17B_est3 T17B_est8 T17B_est13 T17B_est18);
	rental_comb_aff30_&years. = sum(of T15C_est4 T17B_est3 T17B_est8 T17B_est13 T17B_est18);

	renter_unit_aff50_&years. = sum(of T15C_est4 T15C_est25);
	forrent_units_aff50_&years. = sum(of T17B_est3 T17B_est4 T17B_est8 T17B_est9 T17B_est13 T17B_est14 T17B_est18 T17B_est19);
	rental_comb_aff50_&years. = sum(of T15C_est4 T15C_est25 T17B_est3 T17B_est4 T17B_est8 T17B_est9 T17B_est13 T17B_est14 T17B_est18 T17B_est19);
	owner_unit_aff50_&years. = sum(of T15A_est4 T15B_est4);
	forsale_units_aff50_&years. = sum(of T17A_est3 T17A_est8 T17A_est13 T17A_est18);
	sales_comb_aff50_&years. = sum(of T15A_est4 T15B_est4 T17A_est3 T17A_est8 T17A_est13 T17A_est18);

	tot_aff30_&years. = rental_comb_aff30_&years.;
	tot_aff50_&years. = sum(of rental_comb_aff50_&years. sales_comb_aff50_&years.);

	renter_01br_tot_&years. = sum(of T15C_est6 T15C_est10 T15C_est14 T15C_est18 T15C_est22 T15C_est27 T15C_est31 T15C_est35
						T15C_est39 T15C_est43 T15C_est48 T15C_est52 T15C_est56 T15C_est60 T15C_est64 T15C_est69 T15C_est73
						T15C_est77 T15C_est81 T15C_est85);
	renter_2br_tot_&years. = sum(of T15C_est7 T15C_est11 T15C_est15 T15C_est19 T15C_est23 T15C_est28 T15C_est32 T15C_est36 T15C_est40
						T15C_est44 T15C_est49 T15C_est53 T15C_est57 T15C_est61 T15C_est65 T15C_est70 T15C_est74 T15C_est78
						T15C_est82 T15C_est86);
	renter_3plusbr_tot_&years. = sum(of T15C_est8 T15C_est12 T15C_est16 T15C_est20 T15C_est24 T15C_est29 T15C_est33 T15C_est37 T15C_est41
						T15C_est45 T15C_est50 T15C_est54 T15C_est58 T15C_est62 T15C_est66 T15C_est71 T15C_est75 T15C_est79
						T15C_est83 T15C_est87);
	renter_01br_aff30_&years. = sum(of T15C_est6 T15C_est10 T15C_est14 T15C_est18 T15C_est22);
	renter_2br_aff30_&years. = sum(of T15C_est7 T15C_est11 T15C_est15 T15C_est19 T15C_est23);
	renter_3plusbr_aff30_&years. = sum(of T15C_est8 T15C_est12 T15C_est16 T15C_est20 T15C_est24);
	renter_allbr_aff30_&years. = T15C_est4;
	renter_01br_aff50_&years. = sum(of T15C_est6 T15C_est10 T15C_est14 T15C_est18 T15C_est22 T15C_est27 T15C_est31 T15C_est35 T15C_est39 T15C_est43 );
	renter_2br_aff50_&years. = sum(of T15C_est7 T15C_est11 T15C_est15 T15C_est19 T15C_est23 T15C_est28 T15C_est32 T15C_est36 T15C_est40 T15C_est44);
	renter_3plusbr_aff50_&years. = sum(of T15C_est8 T15C_est12 T15C_est16 T15C_est20 T15C_est24 T15C_est29 T15C_est33 T15C_est37 T15C_est41 T15C_est45);
	renter_allbr_aff50_&years. = sum(of T15C_est4 T15C_est25);

	owner_01br_tot_&years. = sum(of T15A_est6 T15A_est10 T15A_est14 T15A_est18 T15A_est22 T15A_est27 T15A_est31 T15A_est35 T15A_est39 T15A_est43 
						T15A_est48 T15A_est52 T15A_est56 T15A_est60 T15A_est64 T15A_est69 T15A_est73 T15A_est77 T15A_est81 T15A_est85
						T15B_est6 T15B_est10 T15B_est14 T15B_est18 T15B_est22 T15B_est27 T15B_est31 T15B_est35 T15B_est39 T15B_est43 
						T15B_est48 T15B_est52 T15B_est56 T15B_est60 T15B_est64 T15B_est69 T15B_est73 T15B_est77 T15B_est81 T15B_est85);
	owner_2br_tot_&years. = sum(of T15A_est7 T15A_est11 T15A_est15 T15A_est19 T15A_est23 T15A_est28 T15A_est32 T15A_est36 T15A_est40 T15A_est44
						T15A_est49 T15A_est53 T15A_est57 T15A_est61 T15A_est65 T15A_est70 T15A_est74 T15A_est78 T15A_est82 T15A_est86
						T15B_est7 T15B_est11 T15B_est15 T15B_est19 T15B_est23 T15B_est28 T15B_est32 T15B_est36 T15B_est40 T15B_est44
						T15B_est49 T15B_est53 T15B_est57 T15B_est61 T15B_est65 T15B_est70 T15B_est74 T15B_est78 T15B_est82 T15B_est86);
	owner_3plusbr_tot_&years. = sum(of T15A_est8 T15A_est12 T15A_est16 T15A_est20 T15A_est24 T15A_est29 T15A_est33 T15A_est37 T15A_est41 T15A_est45
						T15A_est50 T15A_est54 T15A_est58 T15A_est62 T15A_est66 T15A_est71 T15A_est75 T15A_est79 T15A_est83 T15A_est87
						T15B_est8 T15B_est12 T15B_est16 T15B_est20 T15B_est24 T15B_est29 T15B_est33 T15B_est37 T15B_est41 T15B_est45
						T15B_est50 T15B_est54 T15B_est58 T15B_est62 T15B_est66 T15B_est71 T15B_est75 T15B_est79 T15B_est83 T15B_est87);
	owner_01br_aff50_&years. = sum(of T15A_est6 T15A_est10 T15A_est14 T15A_est18 T15A_est22
						T15B_est6 T15B_est10 T15B_est14 T15B_est18 T15B_est22);
	owner_2br_aff50_&years. = sum(of T15A_est7 T15A_est11 T15A_est15 T15A_est19 T15A_est23
						T15B_est7 T15B_est11 T15B_est15 T15B_est19 T15B_est23);
	owner_3plusbr_aff50_&years. = sum(of T15A_est8 T15A_est12 T15A_est16 T15A_est20 T15A_est24
						T15B_est8 T15B_est12 T15B_est16 T15B_est20 T15B_est24);
	owner_allbr_aff50_&years. = sum(of T15A_est4 T15B_est4);
	

	label all_units_tot_&years. = "All housing units (occupied and vacant), &years_dash."
			occ_units_tot_&years. = "All occupied housing units, &years_dash."
			owner_units_tot_&years. = "Owner-occupied housing units, &years_dash."
			forsale_units_tot_&years. = "Vacant housing units for sale, &years_dash."
			own_forsale_units_tot_&years. = "Owner-occupied housing units and vacant housing units for sale, &years_dash."
			renter_unit_tot_&years. = "Renter-occupied housing units, &years_dash."
			forrent_units_tot_&years. = "Vacant housing units for rent, &years_dash."
			rent_forrent_units_tot_&years. = "Renter-occupied housing units and vacant housing units for rent, &years_dash."
			rental_comb_aff30_&years. = "Renter-occupied and for-rent units affordable at 30% AMI, &years_dash."
			rental_comb_aff50_&years. = "Renter-occupied and for-rent units affordable at 50% AMI, &years_dash."
			sales_comb_aff50_&years. = "Owner-occupied and for-rent units affordable at 50% AMI, &years_dash."
			tot_aff30_&years. = "Total units affordable at 30% AMI, &years_dash."
			tot_aff50_&years. = "Total units affordable at 50% AMI, &years_dash."
			renter_unit_aff30_&years. = "Renter-occupied housing units affordable at 30% AMI, &years_dash."
			forrent_units_aff30_&years. = "Vacant for rent housing units affordable at 30% AMI, &years_dash."
			renter_unit_aff50_&years. = "Renter-occupied housing units affordable at 50% AMI, &years_dash."
			forrent_units_aff50_&years. = "Vacant for rent housing units affordable at 50% AMI, &years_dash."
			owner_unit_aff50_&years. = "Owner-occupied housing units affordable at 50% AMI, &years_dash."
			forsale_units_aff50_&years. = "Vacant for sale housing units affordable at 50% AMI, &years_dash."
			renter_01br_tot_&years. = "Renter-occupied 0-1 bedroom housing units, &years_dash."
			renter_2br_tot_&years. = "Renter-occupied 2 bedroom housing units, &years_dash."
			renter_3plusbr_tot_&years. = "Renter-occupied 3+ bedroom housing units, &years_dash."
			renter_01br_aff30_&years. = "Renter-occupied 0-1 bedroom housing units affordable at 30% AMI, &years_dash."
			renter_2br_aff30_&years. = "Renter-occupied 2 bedroom housing units affordable at 30% AMI, &years_dash."
			renter_3plusbr_aff30_&years. = "Renter-occupied 3+ bedroom housing units affordable at 30% AMI, &years_dash."
			renter_allbr_aff30_&years. = "Renter-occupied housing units affordable at 30% AMI, &years_dash."
			renter_01br_aff50_&years. = "Renter-occupied 0-1 bedroom housing units affordable at 50% AMI, &years_dash."
			renter_2br_aff50_&years. = "Renter-occupied 2 bedroom housing units affordable at 50% AMI, &years_dash."
			renter_3plusbr_aff50_&years. = "Renter-occupied 3+ bedroom housing units affordable at 50% AMI, &years_dash."
			renter_allbr_aff50_&years. = "Renter-occupied housing units affordable at 50% AMI, &years_dash."
			owner_01br_tot_&years. = "Owner-occupied 0-1 bedroom housing units, &years_dash."
			owner_2br_tot_&years. = "Owner-occupied 2 bedroom housing units, &years_dash."
			owner_3plusbr_tot_&years. = "Owner-occupied 3+ bedroom housing units, &years_dash."
			owner_01br_aff50_&years. = "Owner-occupied 0-1 bedroom housing units affordable at 50% AMI, &years_dash."
			owner_2br_aff50_&years. = "Owner-occupied 2 bedroom housing units affordable at 50% AMI, &years_dash."
			owner_3plusbr_aff50_&years. = "Owner-occupied 3+ bedroom housing units affordable at 50% AMI, &years_dash."
			owner_allbr_aff50_&years. = "Owner-occupied housing units affordable at 50% AMI, &years_dash."
			;

	%Pct_calc( var=Powner_units_tot, label=% Owner-occupied housing units, num=owner_units_tot, den=occ_units_tot, years= &years. );
	%Pct_calc( var=Pforsale_units_tot, label=% Vacant housing units for sale, num=forsale_units_tot, den=own_forsale_units_tot, years= &years. );
	%Pct_calc( var=Prenter_unit_tot, label=% Renter-occupied housing units, num=renter_unit_tot, den=occ_units_tot, years= &years. );
	%Pct_calc( var=Pforrent_units_tot, label=% Vacant housing units for rent, num=forrent_units_tot, den=rent_forrent_units_tot, years= &years. );

	%Pct_calc( var=Prenter_unit_aff30, label=% Renter-occupied housing units affordable at 30% AMI, num=renter_unit_aff30, den=renter_unit_tot, years= &years. );
	%Pct_calc( var=Pforrent_units_aff30, label=% For-rent housing units affordable at 30% AMI, num=forrent_units_aff30, den=renter_unit_tot, years= &years. );

	%Pct_calc( var=Prenter_unit_aff50, label=% Renter-occupied housing units affordable at 50% AMI, num=renter_unit_aff50, den=renter_unit_tot, years= &years. );
	%Pct_calc( var=Pforrent_units_aff50, label=% For-rent housing units affordable at 50% AMI, num=forrent_units_aff50, den=renter_unit_tot, years= &years. );

	%Pct_calc( var=Powner_unit_aff50, label=% Owner-occupied housing units affordable at 50% AMI, num=owner_unit_aff50, den=owner_units_tot, years= &years. );
	%Pct_calc( var=Pforsale_units_aff50, label=% For-sale housing units affordable at 50% AMI, num=forsale_units_aff50, den=owner_units_tot, years= &years. );

	%Pct_calc( var=Prenter_01br_tot, label=% Renter-occupied 0-1 bedroom housing units, num=renter_01br_tot, den=renter_unit_tot, years= &years. );
	%Pct_calc( var=Prenter_2br_tot, label=% Renter-occupied 2 bedroom housing units, num=renter_2br_tot, den=renter_unit_tot, years= &years. );
	%Pct_calc( var=Prenter_3plusbr_tot, label=% Renter-occupied 3+ bedroom housing units, num=renter_3plusbr_tot, den=renter_unit_tot, years= &years. );

	%Pct_calc( var=Prenter_01br_aff30, label=% Renter-occupied 0-1 bedroom housing units affordable at 30% AMI, num=renter_01br_aff30, den=renter_unit_aff30, years= &years. );
	%Pct_calc( var=Prenter_2br_aff30, label=% Renter-occupied 2 bedroom housing units affordable at 30% AMI, num=renter_2br_aff30, den=renter_unit_aff30, years= &years. );
	%Pct_calc( var=Prenter_3plusbr_aff30, label=% Renter-occupied 3+ bedroom housing units affordable at 30% AMI, num=renter_3plusbr_aff30, den=renter_unit_aff30, years= &years. );

	%Pct_calc( var=Prenter_01br_aff50, label=% Renter-occupied 0-1 bedroom housing units affordable at 50% AMI, num=renter_01br_aff50, den=renter_unit_aff50, years= &years. );
	%Pct_calc( var=Prenter_2br_aff50, label=% Renter-occupied 2 bedroom housing units affordable at 50% AMI, num=renter_2br_aff50, den=renter_unit_aff50, years= &years. );
	%Pct_calc( var=Prenter_3plusbr_aff50, label=% Renter-occupied 3+ bedroom housing units affordable at 50% AMI, num=renter_3plusbr_aff50, den=renter_unit_aff50, years= &years. );

	%Pct_calc( var=Powner_01br_tot, label=% Owner-occupied 0-1 bedroom housing units, num=owner_01br_tot, den=owner_units_tot, years= &years. );
	%Pct_calc( var=Powner_2br_tot, label=% Owner-occupied 2 bedroom housing units, num=owner_2br_tot, den=owner_units_tot, years= &years. );
	%Pct_calc( var=Powner_3plusbr_tot, label=% Owner-occupied 3+ bedroom housing units, num=owner_3plusbr_tot, den=owner_units_tot, years= &years. );

	%Pct_calc( var=Powner_01br_aff50, label=% Owner-occupied 0-1 bedroom housing units affordable at 50% AMI, num=owner_01br_aff50, den=owner_unit_aff50, years= &years. );
	%Pct_calc( var=Powner_2br_aff50, label=% Owner-occupied 2 bedroom housing units affordable at 50% AMI, num=owner_2br_aff50, den=owner_unit_aff50, years= &years. );
	%Pct_calc( var=Powner_3plusbr_aff50, label=% Owner-occupied 3+ bedroom housing units affordable at 50% AMI, num=owner_3plusbr_aff50, den=owner_unit_aff50, years= &years. );


	/* Supply vs Demand */
	rnt030_inc030_allbr_&years. = T15C_est5;
	rnt3050_inc030_allbr_&years. = T15C_est26;
	rnt5080_inc030_allbr_&years. = T15C_est47;
	rnt80pl_inc030_allbr_&years. = T15C_est68;

	rnt030_inc3050_allbr_&years. = T15C_est9;
	rnt3050_inc3050_allbr_&years. = T15C_est30;
	rnt5080_inc3050_allbr_&years. = T15C_est51;
	rnt80pl_inc3050_allbr_&years. = T15C_est72;

	rnt030_inc5080_allbr_&years. = T15C_est13;
	rnt3050_inc5080_allbr_&years. = T15C_est34;
	rnt5080_inc5080_allbr_&years. = T15C_est55;
	rnt80pl_inc5080_allbr_&years. = T15C_est76;

	rnt030_inc80100_allbr_&years. = T15C_est17;
	rnt3050_inc80100_allbr_&years. = T15C_est38;
	rnt5080_inc80100_allbr_&years. = T15C_est59;
	rnt80pl_inc80100_allbr_&years. = T15C_est80;

	rnt030_inc100pl_allbr_&years. = T15C_est21;
	rnt3050_inc100pl_allbr_&years. = T15C_est42;
	rnt5080_inc100pl_allbr_&years. = T15C_est63;
	rnt80pl_inc100pl_allbr_&years. = T15C_est84;

	rnt030_inc030_01br_&years. = T15C_est6;
	rnt3050_inc030_01br_&years. = T15C_est27;
	rnt5080_inc030_01br_&years. = T15C_est48;
	rnt80pl_inc030_01br_&years. = T15C_est69;

	rnt030_inc3050_01br_&years. = T15C_est10;
	rnt3050_inc3050_01br_&years. = T15C_est31;
	rnt5080_inc3050_01br_&years. = T15C_est52;
	rnt80pl_inc3050_01br_&years. = T15C_est73;

	rnt030_inc5080_01br_&years. = T15C_est14;
	rnt3050_inc5080_01br_&years. = T15C_est35;
	rnt5080_inc5080_01br_&years. = T15C_est56;
	rnt80pl_inc5080_01br_&years. = T15C_est77;

	rnt030_inc80100_01br_&years. = T15C_est18;
	rnt3050_inc80100_01br_&years. = T15C_est39;
	rnt5080_inc80100_01br_&years. = T15C_est60;
	rnt80pl_inc80100_01br_&years. = T15C_est81;

	rnt030_inc100pl_01br_&years. = T15C_est22;
	rnt3050_inc100pl_01br_&years. = T15C_est43;
	rnt5080_inc100pl_01br_&years. = T15C_est64;
	rnt80pl_inc100pl_01br_&years. = T15C_est85;

	rnt030_inc030_2br_&years. = T15C_est7;
	rnt3050_inc030_2br_&years. = T15C_est28;
	rnt5080_inc030_2br_&years. = T15C_est49;
	rnt80pl_inc030_2br_&years. = T15C_est70;

	rnt030_inc3050_2br_&years. = T15C_est11;
	rnt3050_inc3050_2br_&years. = T15C_est32;
	rnt5080_inc3050_2br_&years. = T15C_est53;
	rnt80pl_inc3050_2br_&years. = T15C_est74;

	rnt030_inc5080_2br_&years. = T15C_est15;
	rnt3050_inc5080_2br_&years. = T15C_est36;
	rnt5080_inc5080_2br_&years. = T15C_est57;
	rnt80pl_inc5080_2br_&years. = T15C_est78;

	rnt030_inc80100_2br_&years. = T15C_est19;
	rnt3050_inc80100_2br_&years. = T15C_est40;
	rnt5080_inc80100_2br_&years. = T15C_est61;
	rnt80pl_inc80100_2br_&years. = T15C_est82;

	rnt030_inc100pl_2br_&years. = T15C_est23;
	rnt3050_inc100pl_2br_&years. = T15C_est44;
	rnt5080_inc100pl_2br_&years. = T15C_est65;
	rnt80pl_inc100pl_2br_&years. = T15C_est86;

	rnt030_inc030_3br_&years. = T15C_est8;
	rnt3050_inc030_3br_&years. = T15C_est29;
	rnt5080_inc030_3br_&years. = T15C_est50;
	rnt80pl_inc030_3br_&years. = T15C_est71;

	rnt030_inc3050_3br_&years. = T15C_est12;
	rnt3050_inc3050_3br_&years. = T15C_est33;
	rnt5080_inc3050_3br_&years. = T15C_est54;
	rnt80pl_inc3050_3br_&years. = T15C_est75;

	rnt030_inc5080_3br_&years. = T15C_est16;
	rnt3050_inc5080_3br_&years. = T15C_est37;
	rnt5080_inc5080_3br_&years. = T15C_est58;
	rnt80pl_inc5080_3br_&years. = T15C_est79;

	rnt030_inc80100_3br_&years. = T15C_est20;
	rnt3050_inc80100_3br_&years. = T15C_est41;
	rnt5080_inc80100_3br_&years. = T15C_est62;
	rnt80pl_inc80100_3br_&years. = T15C_est83;

	rnt030_inc100pl_3br_&years. = T15C_est24;
	rnt3050_inc100pl_3br_&years. = T15C_est45;
	rnt5080_inc100pl_3br_&years. = T15C_est66;
	rnt80pl_inc100pl_3br_&years. = T15C_est87;

	inc030_allbr_&years. = sum(of T15C_est5 T15C_est26 T15C_est47 T15C_est68);
	inc3050_allbr_&years. = sum(of T15C_est9 T15C_est30 T15C_est51 T15C_est72);
	inc5080_allbr_&years. = sum(of T15C_est13 T15C_est34 T15C_est55 T15C_est76);
	inc80100_allbr_&years. = sum(of T15C_est17 T15C_est38 T15C_est59 T15C_est80);
	inc100pl_allbr_&years. = sum(of T15C_est21 T15C_est42 T15C_est63 T15C_est84 );

	inc030_01br_&years. = sum(of T15C_est6 T15C_est27 T15C_est48 T15C_est69 );
	inc3050_01br_&years. = sum(of T15C_est10 T15C_est31 T15C_est52 T15C_est73);
	inc5080_01br_&years. = sum(of T15C_est14 T15C_est35 T15C_est56 T15C_est77);
	inc80100_01br_&years. = sum(of T15C_est18 T15C_est39 T15C_est60 T15C_est81);
	inc100pl_01br_&years. = sum(of T15C_est22 T15C_est43 T15C_est64 T15C_est85);

	inc030_2br_&years. = sum(of T15C_est7 T15C_est28 T15C_est49 T15C_est70);
	inc3050_2br_&years. = sum(of T15C_est11 T15C_est32 T15C_est53 T15C_est74);
	inc5080_2br_&years. = sum(of T15C_est15 T15C_est36 T15C_est57 T15C_est78);
	inc80100_2br_&years. = sum(of T15C_est19 T15C_est40 T15C_est61 T15C_est82);
	inc100pl_2br_&years. = sum(of T15C_est23 T15C_est44 T15C_est65 T15C_est86);

	inc030_3br_&years. = sum(of T15C_est8 T15C_est29 T15C_est50 T15C_est71);
	inc3050_3br_&years. = sum(of T15C_est12 T15C_est33 T15C_est54 T15C_est75);
	inc5080_3br_&years. = sum(of T15C_est16 T15C_est37 T15C_est58 T15C_est79 );
	inc80100_3br_&years. = sum(of T15C_est20 T15C_est41 T15C_est62 T15C_est83);
	inc100pl_3br_&years. = sum(of T15C_est24 T15C_est45 T15C_est66 T15C_est87);

	label
	rnt030_inc030_allbr_&years. = "Rent level 0-30%, household income 0-30%, &years_dash."
	rnt3050_inc030_allbr_&years. = "Rent level 30-50%, household income 0-30%, &years_dash."
	rnt5080_inc030_allbr_&years. = "Rent level 50-80%, household income 0-30%, &years_dash."
	rnt80pl_inc030_allbr_&years. = "Rent level 80%+, household income 0-30%, &years_dash."
	rnt030_inc3050_allbr_&years. = "Rent level 0-30%, household income 30-50%, &years_dash."
	rnt3050_inc3050_allbr_&years. = "Rent level 30-50%, household income 30-50%, &years_dash."
	rnt5080_inc3050_allbr_&years. = "Rent level 50-80%, household income 30-50%, &years_dash."
	rnt80pl_inc3050_allbr_&years. = "Rent level 80%+, household income 30-50%, &years_dash."
	rnt030_inc5080_allbr_&years. = "Rent level 0-30%, household income 50-80%, &years_dash."
	rnt3050_inc5080_allbr_&years. = "Rent level 30-50%, household income 50-80%, &years_dash."
	rnt5080_inc5080_allbr_&years. = "Rent level 50-80%, household income 50-80%, &years_dash."
	rnt80pl_inc5080_allbr_&years. = "Rent level 80%+, household income 50-80%, &years_dash."
	rnt030_inc80100_allbr_&years. = "Rent level 0-30%, household income 80-100%, &years_dash."
	rnt3050_inc80100_allbr_&years. = "Rent level 30-50%, household income 80-100%, &years_dash."
	rnt5080_inc80100_allbr_&years. = "Rent level 50-80%, household income 80-100%, &years_dash."
	rnt80pl_inc80100_allbr_&years. = "Rent level 80%+, household income 80-100%, &years_dash."
	rnt030_inc100pl_allbr_&years. = "Rent level 0-30%, household income 100%+, &years_dash."
	rnt3050_inc100pl_allbr_&years. = "Rent level 30-50%, household income 100%+, &years_dash."
	rnt5080_inc100pl_allbr_&years. = "Rent level 50-80%, household income 100%+, &years_dash."
	rnt80pl_inc100pl_allbr_&years. = "Rent level 80%+, household income 100%+, &years_dash."
	rnt030_inc030_01br_&years. = "Rent level 0-30%, household income 0-30%, 0-1 bedrooms, &years_dash."
	rnt3050_inc030_01br_&years. = "Rent level 30-50%, household income 0-30%, 0-1 bedrooms, &years_dash."
	rnt5080_inc030_01br_&years. = "Rent level 50-80%, household income 0-30%, 0-1 bedrooms, &years_dash."
	rnt80pl_inc030_01br_&years. = "Rent level 80%+, household income 0-30%, 0-1 bedrooms, &years_dash."
	rnt030_inc3050_01br_&years. = "Rent level 0-30%, household income 30-50%, 0-1 bedrooms, &years_dash."
	rnt3050_inc3050_01br_&years. = "Rent level 30-50%, household income 30-50%, 0-1 bedrooms, &years_dash."
	rnt5080_inc3050_01br_&years. = "Rent level 50-80%, household income 30-50%, 0-1 bedrooms, &years_dash."
	rnt80pl_inc3050_01br_&years. = "Rent level 80%+, household income 30-50%, 0-1 bedrooms, &years_dash."
	rnt030_inc5080_01br_&years. = "Rent level 0-30%, household income 50-80%, 0-1 bedrooms, &years_dash."
	rnt3050_inc5080_01br_&years. = "Rent level 30-50%, household income 50-80%, 0-1 bedrooms, &years_dash."
	rnt5080_inc5080_01br_&years. = "Rent level 50-80%, household income 50-80%, 0-1 bedrooms, &years_dash."
	rnt80pl_inc5080_01br_&years. = "Rent level 80%+, household income 50-80%, 0-1 bedrooms, &years_dash."
	rnt030_inc80100_01br_&years. = "Rent level 0-30%, household income 80-100%, 0-1 bedrooms, &years_dash."
	rnt3050_inc80100_01br_&years. = "Rent level 30-50%, household income 80-100%, 0-1 bedrooms, &years_dash."
	rnt5080_inc80100_01br_&years. = "Rent level 50-80%, household income 80-100%, 0-1 bedrooms, &years_dash."
	rnt80pl_inc80100_01br_&years. = "Rent level 80%+, household income 80-100%, 0-1 bedrooms, &years_dash."
	rnt030_inc100pl_01br_&years. = "Rent level 0-30%, household income 100%+, 0-1 bedrooms, &years_dash."
	rnt3050_inc100pl_01br_&years. = "Rent level 30-50%, household income 100%+, 0-1 bedrooms, &years_dash."
	rnt5080_inc100pl_01br_&years. = "Rent level 50-80%, household income 100%+, 0-1 bedrooms, &years_dash."
	rnt80pl_inc100pl_01br_&years. = "Rent level 80%+, household income 100%+, 0-1 bedrooms, &years_dash."
	rnt030_inc030_2br_&years. = "Rent level 0-30%, household income 0-30%, 2 bedrooms, &years_dash."
	rnt3050_inc030_2br_&years. = "Rent level 30-50%, household income 0-30%, 2 bedrooms, &years_dash."
	rnt5080_inc030_2br_&years. = "Rent level 50-80%, household income 0-30%, 2 bedrooms, &years_dash."
	rnt80pl_inc030_2br_&years. = "Rent level 80%+, household income 0-30%, 2 bedrooms, &years_dash."
	rnt030_inc3050_2br_&years. = "Rent level 0-30%, household income 30-50%, 2 bedrooms, &years_dash."
	rnt3050_inc3050_2br_&years. = "Rent level 30-50%, household income 30-50%, 2 bedrooms, &years_dash."
	rnt5080_inc3050_2br_&years. = "Rent level 50-80%, household income 30-50%, 2 bedrooms, &years_dash."
	rnt80pl_inc3050_2br_&years. = "Rent level 80%+, household income 30-50%, 2 bedrooms, &years_dash."
	rnt030_inc5080_2br_&years. = "Rent level 0-30%, household income 50-80%, 2 bedrooms, &years_dash."
	rnt3050_inc5080_2br_&years. = "Rent level 30-50%, household income 50-80%, 2 bedrooms, &years_dash."
	rnt5080_inc5080_2br_&years. = "Rent level 50-80%, household income 50-80%, 2 bedrooms, &years_dash."
	rnt80pl_inc5080_2br_&years. = "Rent level 80%+, household income 50-80%, 2 bedrooms, &years_dash."
	rnt030_inc80100_2br_&years. = "Rent level 0-30%, household income 80-100%, 2 bedrooms, &years_dash."
	rnt3050_inc80100_2br_&years. = "Rent level 30-50%, household income 80-100%, 2 bedrooms, &years_dash."
	rnt5080_inc80100_2br_&years. = "Rent level 50-80%, household income 80-100%, 2 bedrooms, &years_dash."
	rnt80pl_inc80100_2br_&years. = "Rent level 80%+, household income 80-100%, 2 bedrooms, &years_dash."
	rnt030_inc100pl_2br_&years. = "Rent level 0-30%, household income 100%+, 3+ bedrooms, &years_dash."
	rnt3050_inc100pl_2br_&years. = "Rent level 30-50%, household income 100%+, 3+ bedrooms, &years_dash."
	rnt5080_inc100pl_2br_&years. = "Rent level 50-80%, household income 100%+, 3+ bedrooms, &years_dash."
	rnt80pl_inc100pl_2br_&years. = "Rent level 80%+, household income 100%+, 3+ bedrooms, &years_dash."
	rnt030_inc030_3br_&years. = "Rent level 0-30%, household income 0-30%, 3+ bedrooms, &years_dash."
	rnt3050_inc030_3br_&years. = "Rent level 30-50%, household income 0-30%, 3+ bedrooms, &years_dash."
	rnt5080_inc030_3br_&years. = "Rent level 50-80%, household income 0-30%, 3+ bedrooms, &years_dash."
	rnt80pl_inc030_3br_&years. = "Rent level 80%+, household income 0-30%, 3+ bedrooms, &years_dash."
	rnt030_inc3050_3br_&years. = "Rent level 0-30%, household income 30-50%, 3+ bedrooms, &years_dash."
	rnt3050_inc3050_3br_&years. = "Rent level 30-50%, household income 30-50%, 3+ bedrooms, &years_dash."
	rnt5080_inc3050_3br_&years. = "Rent level 50-80%, household income 30-50%, 3+ bedrooms, &years_dash."
	rnt80pl_inc3050_3br_&years. = "Rent level 80%+, household income 30-50%, 3+ bedrooms, &years_dash."
	rnt030_inc5080_3br_&years. = "Rent level 0-30%, household income 50-80%, 3+ bedrooms, &years_dash."
	rnt3050_inc5080_3br_&years. ="Rent level 30-50%, household income 50-80%, 3+ bedrooms, &years_dash."
	rnt5080_inc5080_3br_&years. = "Rent level 50-80%, household income 50-80%, 3+ bedrooms, &years_dash."
	rnt80pl_inc5080_3br_&years. = "Rent level 80%+, household income 50-80%, 3+ bedrooms, &years_dash."
	rnt030_inc80100_3br_&years. = "Rent level 0-30%, household income 80-100%, 3+ bedrooms, &years_dash."
	rnt3050_inc80100_3br_&years. = "Rent level 30-50%, household income 80-100%, 3+ bedrooms, &years_dash."
	rnt5080_inc80100_3br_&years. = "Rent level 50-80%, household income 80-100%, 3+ bedrooms, &years_dash."
	rnt80pl_inc80100_3br_&years. = "Rent level 80%+, household income 80-100%, 3+ bedrooms, &years_dash."
	rnt030_inc100pl_3br_&years. = "Rent level 0-30%, household income 100%+, 3+ bedrooms, &years_dash."
	rnt3050_inc100pl_3br_&years. = "Rent level 30-50%, household income 100%+, 3+ bedrooms, &years_dash."
	rnt5080_inc100pl_3br_&years. = "Rent level 50-80%, household income 100%+, 3+ bedrooms, &years_dash."
	rnt80pl_inc100pl_3br_&years. = "Rent level 80%+, household income 100%+, 3+ bedrooms, &years_dash."
	inc030_allbr_&years. = "Renter household income 0-30%, &years_dash."
	inc3050_allbr_&years. = "Renter household income 30-50%, &years_dash."
	inc5080_allbr_&years. = "Renter household income 50-80%, &years_dash."
	inc80100_allbr_&years. = "Renter household income 80-100%, &years_dash."
	inc100pl_allbr_&years. = "Renter household income 100%+, &years_dash."
	inc030_01br_&years. = "Renter household income 0-30%, 0-1 bedrooms, &years_dash."
	inc3050_01br_&years. = "Renter household income 30-50%, 0-1 bedrooms, &years_dash."
	inc5080_01br_&years. = "Renter household income 50-80%, 0-1 bedrooms, &years_dash."
	inc80100_01br_&years. = "Renter household income 80-100%, 0-1 bedrooms, &years_dash."
	inc100pl_01br_&years. = "Renter household income 100%+, 0-1 bedrooms, &years_dash."
	inc030_2br_&years. = "Renter household income 0-30%, 2 bedrooms, &years_dash."
	inc3050_2br_&years. = "Renter household income 30-50%, 2 bedrooms, &years_dash."
	inc5080_2br_&years. = "Renter household income 50-80%, 2 bedrooms, &years_dash."
	inc80100_2br_&years. = "Renter household income 80-100%, 2 bedrooms, &years_dash."
	inc100pl_2br_&years. = "Renter household income 100%+, 2 bedrooms, &years_dash."
	inc030_3br_&years. = "Renter household income 0-30%, 3+ bedrooms, &years_dash."
	inc3050_3br_&years. = "Renter household income 30-50%, 3+ bedrooms, &years_dash."
	inc5080_3br_&years. = "Renter household income 50-80%, 3+ bedrooms, &years_dash."
	inc80100_3br_&years. = "Renter household income 80-100%, 3+ bedrooms, &years_dash."
	inc100pl_3br_&years. = "Renter household income 100%+, 3+ bedrooms, &years_dash."
	;

	%Pct_calc( var=Prnt030_inc030_allbr, label=% renter households with rent level 0-30% household income 0-30%, num=rnt030_inc030_allbr, den=inc030_allbr, years= &years. );
	%Pct_calc( var=Prnt3050_inc030_allbr, label=% renter households with rent level 30-50% household income 0-30%, num=rnt3050_inc030_allbr, den=inc030_allbr, years= &years. );
	%Pct_calc( var=Prnt5080_inc030_allbr, label=% renter households with rent level 50-80% household income 0-30%, num=rnt5080_inc030_allbr, den=inc030_allbr, years= &years. );
	%Pct_calc( var=Prnt80pl_inc030_allbr, label=% renter households with rent level 80%+ household income 0-30%, num=rnt80pl_inc030_allbr, den=inc030_allbr, years= &years. );

	%Pct_calc( var=Prnt030_inc3050_allbr, label=% renter households with rent level 0-30% household income 30-50%, num=rnt030_inc3050_allbr, den=inc3050_allbr, years= &years. );
	%Pct_calc( var=Prnt3050_inc3050_allbr, label=% renter households with rent level 30-50% household income 30-50%, num=rnt3050_inc3050_allbr, den=inc3050_allbr, years= &years. );
	%Pct_calc( var=Prnt5080_inc3050_allbr, label=% renter households with rent level 50-80% household income 30-50%, num=rnt5080_inc3050_allbr, den=inc3050_allbr, years= &years. );
	%Pct_calc( var=Prnt80pl_inc3050_allbr, label=% renter households with rent level 80%+ household income 30-50%, num=rnt80pl_inc3050_allbr, den=inc3050_allbr, years= &years. );

	%Pct_calc( var=Prnt030_inc5080_allbr, label=% renter households with rent level 0-30% household income 50-80%, num=rnt030_inc5080_allbr, den=inc5080_allbr, years= &years. );
	%Pct_calc( var=Prnt3050_inc5080_allbr, label=% renter households with rent level 30-50% household income 50-80%, num=rnt3050_inc5080_allbr, den=inc5080_allbr, years= &years. );
	%Pct_calc( var=Prnt5080_inc5080_allbr, label=% renter households with rent level 50-80% household income 50-80%, num=rnt5080_inc5080_allbr, den=inc5080_allbr, years= &years. );
	%Pct_calc( var=Prnt80pl_inc5080_allbr, label=% renter households with rent level 80%+ household income 50-80%, num=rnt80pl_inc5080_allbr, den=inc5080_allbr, years= &years. );

	%Pct_calc( var=Prnt030_inc80100_allbr, label=% renter households with rent level 0-30% household income 80-100%, num=rnt030_inc80100_allbr, den=inc80100_allbr, years= &years. );
	%Pct_calc( var=Prnt3050_inc80100_allbr, label=% renter households with rent level 30-50% household income 80-100%, num=rnt3050_inc80100_allbr, den=inc80100_allbr, years= &years. );
	%Pct_calc( var=Prnt5080_inc80100_allbr, label=% renter households with rent level 50-80% household income 80-100%, num=rnt5080_inc80100_allbr, den=inc80100_allbr, years= &years. );
	%Pct_calc( var=Prnt80pl_inc80100_allbr, label=% renter households with rent level 80%+ household income 80-100%, num=rnt80pl_inc80100_allbr, den=inc80100_allbr, years= &years. );

	%Pct_calc( var=Prnt030_inc100pl_allbr, label=% renter households with rent level 0-30% household income 100%+, num=rnt030_inc100pl_allbr, den=inc100pl_allbr, years= &years. );
	%Pct_calc( var=Prnt3050_inc100pl_allbr, label=% renter households with rent level 30-50% household income 100%+, num=rnt3050_inc100pl_allbr, den=inc100pl_allbr, years= &years. );
	%Pct_calc( var=Prnt5080_inc100pl_allbr, label=% renter households with rent level 50-80% household income 100%+, num=rnt5080_inc100pl_allbr, den=inc100pl_allbr, years= &years. );
	%Pct_calc( var=Prnt80pl_inc100pl_allbr, label=% renter households with rent level 80%+ household income 100%+, num=rnt80pl_inc100pl_allbr, den=inc100pl_allbr, years= &years. );

	%Pct_calc( var=Prnt030_inc030_01br, label=% renter households with rent level 0-30% household income 0-30% 0-1 bedrooms, num=rnt030_inc030_01br, den=inc030_01br, years= &years. );
	%Pct_calc( var=Prnt3050_inc030_01br, label=% renter households with rent level 30-50% household income 0-30% 0-1 bedrooms, num=rnt3050_inc030_01br, den=inc030_01br, years= &years. );
	%Pct_calc( var=Prnt5080_inc030_01br, label=% renter households with rent level 50-80% household income 0-30% 0-1 bedrooms, num=rnt5080_inc030_01br, den=inc030_01br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc030_01br, label=% renter households with rent level 80%+ household income 0-30% 0-1 bedrooms, num=rnt80pl_inc030_01br, den=inc030_01br, years= &years. );

	%Pct_calc( var=Prnt030_inc3050_01br, label=% renter households with rent level 0-30% household income 30-50% 0-1 bedrooms, num=rnt030_inc3050_01br, den=inc3050_01br, years= &years. );
	%Pct_calc( var=Prnt3050_inc3050_01br, label=% renter households with rent level 30-50% household income 30-50% 0-1 bedrooms, num=rnt3050_inc3050_01br, den=inc3050_01br, years= &years. );
	%Pct_calc( var=Prnt5080_inc3050_01br, label=% renter households with rent level 50-80% household income 30-50% 0-1 bedrooms, num=rnt5080_inc3050_01br, den=inc3050_01br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc3050_01br, label=% renter households with rent level 80%+ household income 30-50% 0-1 bedrooms, num=rnt80pl_inc3050_01br, den=inc3050_01br, years= &years. );

	%Pct_calc( var=Prnt030_inc5080_01br, label=% renter households with rent level 0-30% household income 50-80% 0-1 bedrooms, num=rnt030_inc5080_01br, den=inc5080_01br, years= &years. );
	%Pct_calc( var=Prnt3050_inc5080_01br, label=% renter households with rent level 30-50% household income 50-80% 0-1 bedrooms, num=rnt3050_inc5080_01br, den=inc5080_01br, years= &years. );
	%Pct_calc( var=Prnt5080_inc5080_01br, label=% renter households with rent level 50-80% household income 50-80% 0-1 bedrooms, num=rnt5080_inc5080_01br, den=inc5080_01br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc5080_01br, label=% renter households with rent level 80%+ household income 50-80% 0-1 bedrooms, num=rnt80pl_inc5080_01br, den=inc5080_01br, years= &years. );

	%Pct_calc( var=Prnt030_inc80100_01br, label=% renter households with rent level 0-30% household income 80-100% 0-1 bedrooms, num=rnt030_inc80100_01br, den=inc80100_01br, years= &years. );
	%Pct_calc( var=Prnt3050_inc80100_01br, label=% renter households with rent level 30-50% household income 80-100% 0-1 bedrooms, num=rnt3050_inc80100_01br, den=inc80100_01br, years= &years. );
	%Pct_calc( var=Prnt5080_inc80100_01br, label=% renter households with rent level 50-80% household income 80-100% 0-1 bedrooms, num=rnt5080_inc80100_01br, den=inc80100_01br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc80100_01br, label=% renter households with rent level 80%+ household income 80-100% 0-1 bedrooms, num=rnt80pl_inc80100_01br, den=inc80100_01br, years= &years. );

	%Pct_calc( var=Prnt030_inc100pl_01br, label=% renter households with rent level 0-30% household income 100%+ 0-1 bedrooms, num=rnt030_inc100pl_01br, den=inc100pl_01br, years= &years. );
	%Pct_calc( var=Prnt3050_inc100pl_01br, label=% renter households with rent level 30-50% household income 100%+ 0-1 bedrooms, num=rnt3050_inc100pl_01br, den=inc100pl_01br, years= &years. );
	%Pct_calc( var=Prnt5080_inc100pl_01br, label=% renter households with rent level 50-80% household income 100%+ 0-1 bedrooms, num=rnt5080_inc100pl_01br, den=inc100pl_01br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc100pl_01br, label=% renter households with rent level 80%+ household income 100%+ 0-1 bedrooms, num=rnt80pl_inc100pl_01br, den=inc100pl_01br, years= &years. );

	%Pct_calc( var=Prnt030_inc030_2br, label=% renter households with rent level 0-30% household income 0-30% 2 bedrooms, num=rnt030_inc030_2br, den=inc030_2br, years= &years. );
	%Pct_calc( var=Prnt3050_inc030_2br, label=% renter households with rent level 30-50% household income 0-30% 2 bedrooms, num=rnt3050_inc030_2br, den=inc030_2br, years= &years. );
	%Pct_calc( var=Prnt5080_inc030_2br, label=% renter households with rent level 50-80% household income 0-30% 2 bedrooms, num=rnt5080_inc030_2br, den=inc030_2br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc030_2br, label=% renter households with rent level 80%+ household income 0-30% 2 bedrooms, num=rnt80pl_inc030_2br, den=inc030_2br, years= &years. );

	%Pct_calc( var=Prnt030_inc3050_2br, label=% renter households with rent level 0-30% household income 30-50% 2 bedrooms, num=rnt030_inc3050_2br, den=inc3050_2br, years= &years. );
	%Pct_calc( var=Prnt3050_inc3050_2br, label=% renter households with rent level 30-50% household income 30-50% 2 bedrooms, num=rnt3050_inc3050_2br, den=inc3050_2br, years= &years. );
	%Pct_calc( var=Prnt5080_inc3050_2br, label=% renter households with rent level 50-80% household income 30-50% 2 bedrooms, num=rnt5080_inc3050_2br, den=inc3050_2br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc3050_2br, label=% renter households with rent level 80%+ household income 30-50% 2 bedrooms, num=rnt80pl_inc3050_2br, den=inc3050_2br, years= &years. );

	%Pct_calc( var=Prnt030_inc5080_2br, label=% renter households with rent level 0-30% household income 50-80% 2 bedrooms, num=rnt030_inc5080_2br, den=inc5080_2br, years= &years. );
	%Pct_calc( var=Prnt3050_inc5080_2br, label=% renter households with rent level 30-50% household income 50-80% 2 bedrooms, num=rnt3050_inc5080_2br, den=inc5080_2br, years= &years. );
	%Pct_calc( var=Prnt5080_inc5080_2br, label=% renter households with rent level 50-80% household income 50-80% 2 bedrooms, num=rnt5080_inc5080_2br, den=inc5080_2br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc5080_2br, label=% renter households with rent level 80%+ household income 50-80% 2 bedrooms, num=rnt80pl_inc5080_2br, den=inc5080_2br, years= &years. );

	%Pct_calc( var=Prnt030_inc80100_2br, label=% renter households with rent level 0-30% household income 80-100% 2 bedrooms, num=rnt030_inc80100_2br, den=inc80100_2br, years= &years. );
	%Pct_calc( var=Prnt3050_inc80100_2br, label=% renter households with rent level 30-50% household income 80-100% 2 bedrooms, num=rnt3050_inc80100_2br, den=inc80100_2br, years= &years. );
	%Pct_calc( var=Prnt5080_inc80100_2br, label=% renter households with rent level 50-80% household income 80-100% 2 bedrooms, num=rnt5080_inc80100_2br, den=inc80100_2br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc80100_2br, label=% renter households with rent level 80%+ household income 80-100% 2 bedrooms, num=rnt80pl_inc80100_2br, den=inc80100_2br, years= &years. );

	%Pct_calc( var=Prnt030_inc100pl_2br, label=% renter households with rent level 0-30% household income 100%+ 2 bedrooms, num=rnt030_inc100pl_2br, den=inc100pl_2br, years= &years. );
	%Pct_calc( var=Prnt3050_inc100pl_2br, label=% renter households with rent level 30-50% household income 100%+ 2 bedrooms, num=rnt3050_inc100pl_2br, den=inc100pl_2br, years= &years. );
	%Pct_calc( var=Prnt5080_inc100pl_2br, label=% renter households with rent level 50-80% household income 100%+ 2 bedrooms, num=rnt5080_inc100pl_2br, den=inc100pl_2br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc100pl_2br, label=% renter households with rent level 80%+ household income 100%+ 2 bedrooms, num=rnt80pl_inc100pl_2br, den=inc100pl_2br, years= &years. );

	%Pct_calc( var=Prnt030_inc030_3br, label=% renter households with rent level 0-30% household income 0-30% 3+ bedrooms, num=rnt030_inc030_3br, den=inc030_3br, years= &years. );
	%Pct_calc( var=Prnt3050_inc030_3br, label=% renter households with rent level 30-50% household income 0-30% 3+ bedrooms, num=rnt3050_inc030_3br, den=inc030_3br, years= &years. );
	%Pct_calc( var=Prnt5080_inc030_3br, label=% renter households with rent level 50-80% household income 0-30% 3+ bedrooms, num=rnt5080_inc030_3br, den=inc030_3br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc030_3br, label=% renter households with rent level 80%+ household income 0-30% 3+ bedrooms, num=rnt80pl_inc030_3br, den=inc030_3br, years= &years. );

	%Pct_calc( var=Prnt030_inc3050_3br, label=% renter households with rent level 0-30% household income 30-50% 3+ bedrooms, num=rnt030_inc3050_3br, den=inc3050_3br, years= &years. );
	%Pct_calc( var=Prnt3050_inc3050_3br, label=% renter households with rent level 30-50% household income 30-50% 3+ bedrooms, num=rnt3050_inc3050_3br, den=inc3050_3br, years= &years. );
	%Pct_calc( var=Prnt5080_inc3050_3br, label=% renter households with rent level 50-80% household income 30-50% 3+ bedrooms, num=rnt5080_inc3050_3br, den=inc3050_3br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc3050_3br, label=% renter households with rent level 80%+ household income 30-50% 3+ bedrooms, num=rnt80pl_inc3050_3br, den=inc3050_3br, years= &years. );

	%Pct_calc( var=Prnt030_inc5080_3br, label=% renter households with rent level 0-30% household income 50-80% 3+ bedrooms, num=rnt030_inc5080_3br, den=inc5080_3br, years= &years. );
	%Pct_calc( var=Prnt3050_inc5080_3br, label=% renter households with rent level 30-50% household income 50-80% 3+ bedrooms, num=rnt3050_inc5080_3br, den=inc5080_3br, years= &years. );
	%Pct_calc( var=Prnt5080_inc5080_3br, label=% renter households with rent level 50-80% household income 50-80% 3+ bedrooms, num=rnt5080_inc5080_3br, den=inc5080_3br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc5080_3br, label=% renter households with rent level 80%+ household income 50-80% 3+ bedrooms, num=rnt80pl_inc5080_3br, den=inc5080_3br, years= &years. );

	%Pct_calc( var=Prnt030_inc80100_3br, label=% renter households with rent level 0-30% household income 80-100% 3+ bedrooms, num=rnt030_inc80100_3br, den=inc80100_3br, years= &years. );
	%Pct_calc( var=Prnt3050_inc80100_3br, label=% renter households with rent level 30-50% household income 80-100% 3+ bedrooms, num=rnt3050_inc80100_3br, den=inc80100_3br, years= &years. );
	%Pct_calc( var=Prnt5080_inc80100_3br, label=% renter households with rent level 50-80% household income 80-100% 3+ bedrooms, num=rnt5080_inc80100_3br, den=inc80100_3br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc80100_3br, label=% renter households with rent level 80%+ household income 80-100% 3+ bedrooms, num=rnt80pl_inc80100_3br, den=inc80100_3br, years= &years. );

	%Pct_calc( var=Prnt030_inc100pl_3br, label=% renter households with rent level 0-30% household income 100%+ 3+ bedrooms, num=rnt030_inc100pl_3br, den=inc100pl_3br, years= &years. );
	%Pct_calc( var=Prnt3050_inc100pl_3br, label=% renter households with rent level 30-50% household income 100%+ 3+ bedrooms, num=rnt3050_inc100pl_3br, den=inc100pl_3br, years= &years. );
	%Pct_calc( var=Prnt5080_inc100pl_3br, label=% renter households with rent level 50-80% household income 100%+ 3+ bedrooms, num=rnt5080_inc100pl_3br, den=inc100pl_3br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc100pl_3br, label=% renter households with rent level 80%+ household income 100%+ 3+ bedrooms, num=rnt80pl_inc100pl_3br, den=inc100pl_3br, years= &years. );


	/* Demand - Affordability */
	renter_cb_&years. = sum(of T8_est73 T8_est76  T8_est89 T8_est99 T8_est102 T8_est112 T8_est115 T8_est125 T8_est128);
	renter_scb_&years. = sum(of T8_est76 T8_est89 T8_est102 T8_est115 T8_est128);
	renter_ncb_&years. = sum(of T8_est79 T8_est92 T8_est105 T8_est118 T8_est131);
	renter_noprob_&years. = sum(of T16_est91 T16_est95 T16_est99 T16_est103 T16_est107 T16_est112 T16_est116 T16_est120 T16_est124
							T16_est128 T16_est133 T16_est137 T16_est141 T16_est145 T16_est149 T16_est154 T16_est158 T16_est162 T16_est166 T16_est170);

	renter_inc030_&years. = T8_est69;
	renter_inc3050_&years. = T8_est82;
	renter_inc5080_&years. = T8_est95; 
	renter_inc80100_&years. = T8_est108;
	renter_inc100pl_&years. = T8_est121;

	renter_inc030_cb_&years. = sum(of T8_est73 T8_est76);
	renter_inc3050_cb_&years. = sum(of T8_est86 T8_est89);
	renter_inc5080_cb_&years. = sum(of T8_est99 T8_est102);
	renter_inc80100_cb_&years. = sum(of T8_est112 T8_est115);
	renter_inc100pl_cb_&years. = sum(of T8_est125 T8_est128);

	renter_inc030_scb_&years. = T8_est76;
	renter_inc3050_scb_&years. = T8_est89;
	renter_inc5080_scb_&years. = T8_est102;
	renter_inc80100_scb_&years. = T8_est115;
	renter_inc100pl_scb_&years. = T8_est128;

	renter_inc030_ncb_&years. = T8_est79;
	renter_inc3050_ncb_&years. = T8_est92;
	renter_inc5080_ncb_&years. = T8_est105; 
	renter_inc80100_ncb_&years. = T8_est118;
	renter_inc100pl_ncb_&years. = T8_est131;

	renter_eldfam_&years. = sum(of T16_est89 T16_est110 T16_est131 T16_est152);
	renter_smfam_&years. = sum(of T16_est93 T16_est114 T16_est135 T16_est156);
	renter_lgfam_&years. = sum(of T16_est97 T16_est118 T16_est139 T16_est160);
	renter_eldnf_&years. = sum(of T16_est101 T16_est122 T16_est143 T16_est164);
	renter_othhh_&years. = sum(of T16_est105 T16_est126 T16_est147 T16_est168);

	renter_eldfam_cb_&years. = sum(of T7_est137 T7_est138 T7_est163 T7_est164 T7_est189 T7_est190
						T7_est215 T7_est216 T7_est241 T7_est242);
	renter_smfam_cb_&years. = sum(of T7_est142 T7_est143 T7_est168 T7_est169 T7_est194 T7_est195
						T7_est220 T7_est221 T7_est246 T7_est247);
	renter_lgfam_cb_&years. = sum(of T7_est147 T7_est148 T7_est173 T7_est174 T7_est199 T7_est200
						T7_est225 T7_est226 T7_est251 T7_est252);
	renter_eldnf_cb_&years. = sum(of T7_est152 T7_est153 T7_est178 T7_est179 T7_est204 T7_est205
						T7_est230 T7_est231 T7_est256 T7_est257);
	renter_othhh_cb_&years. = sum(of T7_est157 T7_est158 T7_est183 T7_est184 T7_est209 T7_est210
						T7_est235 T7_est236 T7_est261 T7_est262);

	renter_eldfam_scb_&years. = sum(of T7_est138 T7_est164 T7_est190 T7_est216 T7_est242);
	renter_smfam_scb_&years. = sum(of T7_est143 T7_est169 T7_est195 T7_est221 T7_est247);
	renter_lgfam_scb_&years. = sum(of T7_est148 T7_est174 T7_est200 T7_est226 T7_est252);
	renter_eldnf_scb_&years. = sum(of T7_est153 T7_est179 T7_est205 T7_est231 T7_est257);
	renter_othhh_scb_&years. = sum(of T7_est158 T7_est184 T7_est210 T7_est236 T7_est262);

	renter_eldfam_noprob_&years. = sum(of T16_est91 T16_est112 T16_est133 T16_est154);
	renter_smfam_noprob_&years. = sum(of T16_est95 T16_est116 T16_est137 T16_est158);
	renter_lgfam_noprob_&years. = sum(of T16_est99 T16_est120 T16_est141 T16_est162);
	renter_eldnf_noprob_&years. = sum(of T16_est103 T16_est124 T16_est145 T16_est166);
	renter_othhh_noprob_&years. = sum(of T16_est107 T16_est128 T16_est149 T16_est170);


	renter_noplumb_&years. = sum(of T8_est71 T8_est74 T8_est77 T8_est80 T8_est84 T8_est87 T8_est90 T8_est93
					T8_est97 T8_est100 T8_est103 T8_est106 T8_est110 T8_est113 T8_est116 T8_est119
					T8_est123 T8_est126 T8_est129 T8_est132);
	renter_hasplumb_&years. = sum(of T8_est72 T8_est75 T8_est78 T8_est81 T8_est85 T8_est88 T8_est91 T8_est94
					T8_est98 T8_est101 T8_est104 T8_est107 T8_est111 T8_est114 T8_est117 T8_est120
					T8_est124 T8_est127 T8_est130 T8_est133);

	renter_noplumb_cb_&years. = sum(of T8_est74 T8_est77 T8_est87 T8_est90 T8_est100 T8_est103 T8_est113
					T8_est116 T8_est126 T8_est129);
	renter_hasplumb_cb_&years. = sum(of T8_est75 T8_est78 T8_est88 T8_est91 T8_est101 T8_est104 T8_est114
					T8_est117 T8_est127 T8_est130);

	renter_noplumb_scb_&years. = sum(of T8_est77 T8_est90 T8_est103 T8_est116 T8_est129);
	renter_hasplumb_scb_&years. = sum(of T8_est78 T8_est91 T8_est104 T8_est117 T8_est130);

	renter_onlycb_&years. = sum(of T3_est64 T3_est70);


	label
	renter_cb_&years. = "Renter occupied units, cost burdened, &years_dash."
	renter_scb_&years. = "Renter occupied units, severely cost burdened, &years_dash."
	renter_ncb_&years. = "Renter occupied units, no cost burden computed, &years_dash."
	renter_noprob_&years. = "Renter occupied units, no housing problems, &years_dash."
	renter_inc030_&years. = "Renter occupied units, household income 0-30%, &years_dash."
	renter_inc3050_&years. = "Renter occupied units, household income 30-50%, &years_dash."
	renter_inc5080_&years. = "Renter occupied units, household income 50-80%, &years_dash."
	renter_inc80100_&years. = "Renter occupied units, household income 80-100%, &years_dash."
	renter_inc100pl_&years. = "Renter occupied units, household income 100%+, &years_dash."
	renter_inc030_cb_&years. = "Renter occupied units, household income 0-30%, cost burdened, &years_dash."
	renter_inc3050_cb_&years. = "Renter occupied units, household income 30-50%, cost burdened, &years_dash."
	renter_inc5080_cb_&years. = "Renter occupied units, household income 50-80%, cost burdened, &years_dash."
	renter_inc80100_cb_&years. = "Renter occupied units, household income 80-100%, cost burdened, &years_dash."
	renter_inc100pl_cb_&years. = "Renter occupied units, household income 100%+%, cost burdened, &years_dash."
	renter_inc030_scb_&years. = "Renter occupied units, household income 0-30%, severely cost burdened, &years_dash."
	renter_inc3050_scb_&years. = "Renter occupied units, household income 30-50%, severely cost burdened, &years_dash."
	renter_inc5080_scb_&years. = "Renter occupied units, household income 50-80%, severely cost burdened, &years_dash."
	renter_inc80100_scb_&years. = "Renter occupied units, household income 80-100%, severely cost burdened, &years_dash."
	renter_inc100pl_scb_&years. = "Renter occupied units, household income 100%+, severely cost burdened, &years_dash."
	renter_inc030_ncb_&years. = "Renter occupied units, household income 0-30%, no cost burden computed, &years_dash."
	renter_inc3050_ncb_&years. = "Renter occupied units, household income 30-50%, no cost burden computed, &years_dash."
	renter_inc5080_ncb_&years. = "Renter occupied units, household income 50-80%, no cost burden computed, &years_dash."
	renter_inc80100_ncb_&years. = "Renter occupied units, household income 80-100%, no cost burden computed, &years_dash."
	renter_inc100pl_ncb_&years. = "Renter occupied units, household income 100%+, no cost burden computed, &years_dash."
	renter_eldfam_&years. = "Renter occupied units, elderly family (2 people), &years_dash."
	renter_smfam_&years. = "Renter occupied units, small family (2 non-elderly people or 3-4 person family), &years_dash."
	renter_lgfam_&years. = "Renter occupied units, large family (5+ people), &years_dash."
	renter_eldnf_&years. = "Renter occupied units, eldelry nonfamily (1-2 person households), &years_dash."
	renter_othhh_&years. = "Renter occupied units, other household type, &years_dash."
	renter_eldfam_cb_&years. = "Renter occupied units, elderly family (2 people), cost burdened, &years_dash."
	renter_smfam_cb_&years. = "Renter occupied units, small family (2 non-elderly people or 3-4 person family), cost burdened, &years_dash."
	renter_lgfam_cb_&years. = "Renter occupied units, large family (5+ people), cost burdened, &years_dash."
	renter_eldnf_cb_&years. = "Renter occupied units, eldelry nonfamily (1-2 person households), cost burdened, &years_dash."
	renter_othhh_cb_&years. = "Renter occupied units, other household type, cost burdened, &years_dash."
	renter_eldfam_scb_&years. = "Renter occupied units, elderly family (2 people), severely cost burdened, &years_dash."
	renter_smfam_scb_&years. = "Renter occupied units, small family (2 non-elderly people or 3-4 person family), severely cost burdened, &years_dash."
	renter_lgfam_scb_&years. = "Renter occupied units, large family (5+ people), severely cost burdened, &years_dash."
	renter_eldnf_scb_&years. = "Renter occupied units, eldelry nonfamily (1-2 person households), severely cost burdened, &years_dash."
	renter_othhh_scb_&years. = "Renter occupied units, other household type, severely cost burdened, &years_dash."
	renter_eldfam_noprob_&years. = "Renter occupied units, elderly family (2 people), no housing problems, &years_dash."
	renter_smfam_noprob_&years. = "Renter occupied units, small family (2 non-elderly people or 3-4 person family), no housing problems, &years_dash."
	renter_lgfam_noprob_&years. = "Renter occupied units, large family (5+ people), no housing problems, &years_dash."
	renter_eldnf_noprob_&years. = "Renter occupied units, eldelry nonfamily (1-2 person households), no housing problems, &years_dash."
	renter_othhh_noprob_&years. = "Renter occupied units, other household type, no housing problems, &years_dash."
	renter_noplumb_&years. = "Renter occupied units, lacks complete plumbing and kitchen facilities, &years_dash."
	renter_hasplumb_&years. = "Renter occupied units, has complete plumbing and kitchen facilities, &years_dash."
	renter_noplumb_cb_&years. = "Renter occupied units, lacks complete plumbing and kitchen facilities, cost burdened, &years_dash."
	renter_hasplumb_cb_&years. = "Renter occupied units, has complete plumbing and kitchen facilities, cost burdened, &years_dash."
	renter_noplumb_scb_&years. = "Renter occupied units, lacks complete plumbing and kitchen facilities, severely cost burdened, &years_dash."
	renter_hasplumb_scb_&years. = "Renter occupied units, has complete plumbing and kitchen facilities, severely cost burdened, &years_dash."
	renter_onlycb_&years. = "Renter occupied units,only cost burden is a problem, &years_dash."
	;

	%Pct_calc( var=Prenter_inc030_cb, label=% Renter occupied units household income 0-30% cost burdened, num=renter_inc030_cb, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_inc030_scb, label=% Renter occupied units household income 0-30% no cost burden computed, num=renter_inc030_scb, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_inc030_ncb, label=% Renter occupied units household income 0-30% no cost burden computed, num=renter_inc030_ncb, den=renter_inc030, years= &years. );

	%Pct_calc( var=Prenter_inc3050_cb, label=% Renter occupied units household income 30-50% cost burdened, num=renter_inc3050_cb, den=renter_inc3050, years= &years. );
	%Pct_calc( var=Prenter_inc3050_scb, label=% Renter occupied units household income 30-50% no cost burden computed, num=renter_inc3050_scb, den=renter_inc3050, years= &years. );
	%Pct_calc( var=Prenter_inc3050_ncb, label=% Renter occupied units household income 30-50% no cost burden computed, num=renter_inc3050_ncb, den=renter_inc3050, years= &years. );

	%Pct_calc( var=Prenter_inc5080_cb, label=% Renter occupied units household income 50-80% cost burdened, num=renter_inc5080_cb, den=renter_inc5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_scb, label=% Renter occupied units household income 50-80% no cost burden computed, num=renter_inc5080_scb, den=renter_inc5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_ncb, label=% Renter occupied units household income 50-80% no cost burden computed, num=renter_inc5080_ncb, den=renter_inc5080, years= &years. );

	%Pct_calc( var=Prenter_inc80100_cb, label=% Renter occupied units household income 80-410% cost burdened, num=renter_inc80100_cb, den=renter_inc80100, years= &years. );
	%Pct_calc( var=Prenter_inc80100_scb, label=% Renter occupied units household income 80-410% no cost burden computed, num=renter_inc80100_scb, den=renter_inc80100, years= &years. );
	%Pct_calc( var=Prenter_inc80100_ncb, label=% Renter occupied units household income 80-410% no cost burden computed, num=renter_inc80100_ncb, den=renter_inc80100, years= &years. );

	%Pct_calc( var=Prenter_inc100pl_cb, label=% Renter occupied units household income 100%+ cost burdened, num=renter_inc100pl_cb, den=renter_inc100pl, years= &years. );
	%Pct_calc( var=Prenter_inc100pl_scb, label=% Renter occupied units household income 100%+ no cost burden computed, num=renter_inc100pl_scb, den=renter_inc100pl, years= &years. );
	%Pct_calc( var=Prenter_inc100pl_ncb, label=% Renter occupied units household income 100%+ no cost burden computed, num=renter_inc100pl_ncb, den=renter_inc100pl, years= &years. );

	%Pct_calc( var=Prenter_eldfam_cb, label=% Renter occupied units elderly family cost burdened, num=renter_eldfam_cb, den=renter_eldfam, years= &years. );
	%Pct_calc( var=Prenter_eldfam_scb, label=% Renter occupied units elderly family cost burdened, num=renter_eldfam_scb, den=renter_eldfam, years= &years. );
	%Pct_calc( var=Prenter_eldfam_noprob, label=% Renter occupied units elderly family no housing problems, num=renter_eldfam, den=renter_noprob, years= &years. );

	%Pct_calc( var=Prenter_smfam_cb, label=% Renter occupied units small family cost burdened, num=renter_smfam_cb, den=renter_smfam, years= &years. );
	%Pct_calc( var=Prenter_smfam_scb, label=% Renter occupied units small family cost burdened, num=renter_smfam_scb, den=renter_smfam, years= &years. );
	%Pct_calc( var=Prenter_smfam_noprob, label=% Renter occupied units small family no housing problems, num=renter_smfam_noprob, den=renter_smfam, years= &years. );

	%Pct_calc( var=Prenter_lgfam_cb, label=% Renter occupied units large family cost burdened, num=renter_lgfam_cb, den=renter_lgfam, years= &years. );
	%Pct_calc( var=Prenter_lgfam_scb, label=% Renter occupied units large family cost burdened, num=renter_lgfam_scb, den=renter_lgfam, years= &years. );
	%Pct_calc( var=Prenter_lgfam_noprob, label=% Renter occupied units large family no housing problems, num=renter_lgfam_noprob, den=renter_lgfam, years= &years. );

	%Pct_calc( var=Prenter_eldnf_cb, label=% Renter occupied units elderly non-family cost burdened, num=renter_eldnf_cb, den=renter_eldnf, years= &years. );
	%Pct_calc( var=Prenter_eldnf_scb, label=% Renter occupied units elderly non-family cost burdened, num=renter_eldnf_scb, den=renter_eldnf, years= &years. );
	%Pct_calc( var=Prenter_eldnf_noprob, label=% Renter occupied units elderly non-family no housing problems, num=renter_eldnf_noprob, den=renter_eldnf, years= &years. );

	%Pct_calc( var=Prenter_othhh_cb, label=% Renter occupied units other household cost burdened, num=renter_othhh_cb, den=renter_othhh, years= &years. );
	%Pct_calc( var=Prenter_othhh_scb, label=% Renter occupied units other household cost burdened, num=renter_othhh_scb, den=renter_othhh, years= &years. );
	%Pct_calc( var=Prenter_othhh_noprob, label=% Renter occupied units other household no housing problems, num=renter_othhh_noprob, den=renter_othhh, years= &years. );

	%Pct_calc( var=Prenter_noplumb_cb, label=% Renter occupied units household lacks complete plumbing and kitchen facilities and cost burdened, num=renter_noplumb_cb, den=renter_noplumb, years= &years. );
	%Pct_calc( var=Prenter_noplumb_scb, label=% Renter occupied units household lacks complete plumbing and kitchen facilities and cost burdened, num=renter_noplumb_scb, den=renter_noplumb, years= &years. );

	%Pct_calc( var=Prenter_hasplumb_cb, label=% Renter occupied units household has complete plumbing and kitchen facilities and cost and cost burdened, num=renter_hasplumb_cb, den=renter_hasplumb, years= &years. );
	%Pct_calc( var=Prenter_hasplumb_scb, label=% Renter occupied units household has complete plumbing and kitchen facilities and cost and cost burdened, num=renter_hasplumb_scb, den=renter_hasplumb, years= &years. );

	%Pct_calc( var=Prenter_onlycb, label=% Renter occupied units where only cost burden is a problem, num=renter_onlycb, den=renter_unit_tot, years= &years. );


	/* Demand - Size */
	rentr_lte1_&years. = T10_est67;
	rentr_lte15_&years. = T10_est88;
	rentr_gt15_&years. = T10_est109;

	rentr_1fam_&years. = sum(of T10_est69 T10_est73 T10_est77 T10_est81 T10_est85 T10_est90 T10_est94 T10_est98
								T10_est102 T10_est106 T10_est111 T10_est115 T10_est119 T10_est123 T10_est127);
	rentr_sfam_&years. = sum(of T10_est70 T10_est74 T10_est78 T10_est82 T10_est86 T10_est91 T10_est95 T10_est99
								T10_est103 T10_est107 T10_est112 T10_est116 T10_est120 T10_est124 T10_est128);
	rentr_nfam_&years. = sum(of T10_est69 T10_est73 T10_est77 T10_est81 T10_est85 T10_est90 T10_est94 T10_est98
								T10_est102 T10_est106 T10_est111 T10_est115 T10_est119 T10_est123 T10_est127);

	rentr_inc030_lte1_&years. = T10_est68;
	rentr_inc3050_lte1_&years. = T10_est72;
	rentr_inc5080_lte1_&years. = T10_est76;
	rentr_inc80100_lte1_&years. = T10_est80;
	rentr_inc100pl_lte1_&years. = T10_est84;

	rentr_inc030_lte15_&years. = T10_est89;
	rentr_inc3050_lte15_&years. = T10_est93;
	rentr_inc5080_lte15_&years. = T10_est97;
	rentr_inc80100_lte15_&years. = T10_est101;
	rentr_inc100pl_lte15_&years. = T10_est105;

	rentr_inc030_gt15_&years. = T10_est110;
	rentr_inc3050_gt15_&years. = T10_est114;
	rentr_inc5080_gt15_&years. = T10_est118;
	rentr_inc80100_gt15_&years. = T10_est122;
	rentr_inc100pl_gt15_&years. = T10_est126;

	rentr_inc030_1fam_&years. = sum(of T10_est69 T10_est90 T10_est111);
	rentr_inc030_sfam_&years. = sum(of T10_est70 T10_est91 T10_est112);
	rentr_inc030_nfam_&years. = sum(of T10_est71 T10_est92 T10_est113);

	rentr_inc030_lte1_1fam_&years. = T10_est69;
	rentr_inc030_lte1_sfam_&years. = T10_est70;
	rentr_inc030_lte1_nfam_&years. = T10_est71;

	rentr_inc030_lte15_1fam_&years. = T10_est90;
	rentr_inc030_lte15_sfam_&years. = T10_est91;
	rentr_inc030_lte15_nfam_&years. = T10_est92;

	rentr_inc030_gt15_1fam_&years. = T10_est111;
	rentr_inc030_gt15_sfam_&years. = T10_est112;
	rentr_inc030_gt15_nfam_&years. = T10_est113;

	label
	rentr_lte1_&years. = "Renter occupied units, persons per room less than or equal 1, &years_dash."
	rentr_lte15_&years. = "Renter occupied units, persons per room greater than 1 less than or equal 1.5, &years_dash."
	rentr_gt15_&years. = "Renter occupied units, persons per room greater than 1.5, &years_dash."
	rentr_1fam_&years. = "Renter occupied units, one family, &years_dash."
	rentr_sfam_&years. = "Renter occupied units, one family with subfamily or more than 1 family, &years_dash."
	rentr_nfam_&years. = "Renter occupied units, non-family, &years_dash."
	rentr_inc030_lte1_&years. = "Renter occupied units, household income 0-30%, persons per room less than or equal 1, &years_dash."
	rentr_inc3050_lte1_&years. = "Renter occupied units, household income 30-50%, persons per room less than or equal 1, &years_dash."
	rentr_inc5080_lte1_&years. = "Renter occupied units, household income 50-80%, persons per room less than or equal 1, &years_dash."
	rentr_inc80100_lte1_&years. = "Renter occupied units, household income 80-100%, persons per room less than or equal 1, &years_dash."
	rentr_inc100pl_lte1_&years. = "Renter occupied units, household income 100%+, persons per room less than or equal 1, &years_dash."
	rentr_inc030_lte15_&years. = "Renter occupied units, household income 0-30%, persons per room greater than 1 less than or equal 1.5, &years_dash."
	rentr_inc3050_lte15_&years. = "Renter occupied units, household income 30-50%, persons per room greater than 1 less than or equal 1.5, &years_dash."
	rentr_inc5080_lte15_&years. = "Renter occupied units, household income 50-80%, persons per room greater than 1 less than or equal 1.5, &years_dash."
	rentr_inc80100_lte15_&years. = "Renter occupied units, household income 80-100%, persons per room greater than 1 less than or equal 1.5, &years_dash."
	rentr_inc100pl_lte15_&years. = "Renter occupied units, household income 100%+, persons per room greater than 1 less than or equal 1.5, &years_dash."
	rentr_inc030_gt15_&years. = "Renter occupied units, household income 0-30%, persons per room greater than 1.5, &years_dash."
	rentr_inc3050_gt15_&years. = "Renter occupied units, household income 30-50%, persons per room greater than 1.5, &years_dash."
	rentr_inc5080_gt15_&years. = "Renter occupied units, household income 50-80%, persons per room greater than 1.5, &years_dash."
	rentr_inc80100_gt15_&years. = "Renter occupied units, household income 80-100%, persons per room greater than 1.5, &years_dash."
	rentr_inc100pl_gt15_&years. = "Renter occupied units, household income 100%+, persons per room greater than 1.5, &years_dash."
	rentr_inc030_1fam_&years. = "Renter occupied units, household income 0-30%, one family, &years_dash."
	rentr_inc030_sfam_&years. = "Renter occupied units, household income 0-30%, one family with subfamily or more than 1 family, &years_dash."
	rentr_inc030_nfam_&years. = "Renter occupied units, household income 0-30%, non-family, &years_dash."
	rentr_inc030_lte1_1fam_&years. = "Renter occupied units, household income 0-30%, one family, persons per room less than or equal 1, &years_dash."
	rentr_inc030_lte1_sfam_&years. = "Renter occupied units, household income 0-30%, one family with subfamily or more than 1 family, persons per room less than or equal 1, &years_dash."
	rentr_inc030_lte1_nfam_&years. = "Renter occupied units, household income 0-30%, non-family, persons per room less than or equal 1, &years_dash."
	rentr_inc030_lte15_1fam_&years. = "Renter occupied units, household income 0-30%, one family, persons per room greater than 1 less than or equal 1.5, &years_dash."
	rentr_inc030_lte15_sfam_&years. = "Renter occupied units, household income 0-30%, one family with subfamily or more than 1 family, persons per room greater than 1 less than or equal 1.5, &years_dash."
	rentr_inc030_lte15_nfam_&years. = "Renter occupied units, household income 0-30%, non-family, persons per room greater than 1 less than or equal 1.5, &years_dash."
	rentr_inc030_gt15_1fam_&years. = "Renter occupied units, household income 0-30%, one family, persons per room greater than 1.5, &years_dash."
	rentr_inc030_gt15_sfam_&years. = "Renter occupied units, household income 0-30%, one family with subfamily or more than 1 family, persons per room greater 1.5, &years_dash."
	rentr_inc030_gt15_nfam_&years. = "Renter occupied units, household income 0-30%, non-family, persons per room greater than 1.5, &years_dash."
	;

	%Pct_calc( var=Prentr_inc030_lte1, label=% Renter occupied units household income 0-30% persons per room less than or equal 1, num=rentr_inc030_lte1, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prentr_inc030_lte15, label=% Renter occupied units household income 0-30% persons per room greater than 1 less than or equal 1.5, num=rentr_inc030_lte15, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prentr_inc030_gt15, label=% Renter occupied units household income 0-30% persons per room greater than 1.5, num=rentr_inc030_gt15, den=renter_inc030, years= &years. );

	%Pct_calc( var=Prentr_inc3050_lte1, label=% Renter occupied units household income 30-50% persons per room less than or equal 1, num=rentr_inc3050_lte1, den=renter_inc3050, years= &years. );
	%Pct_calc( var=Prentr_inc3050_lte15, label=% Renter occupied units household income 30-50% persons per room greater than 1 less than or equal 1.5, num=rentr_inc3050_lte15, den=renter_inc3050, years= &years. );
	%Pct_calc( var=Prentr_inc3050_gt15, label=% Renter occupied units household income 30-50% persons per room greater than 1.5, num=rentr_inc3050_gt15, den=renter_inc3050, years= &years. );

	%Pct_calc( var=Prentr_inc5080_lte1, label=% Renter occupied units household income 50-80% persons per room less than or equal 1, num=rentr_inc5080_lte1, den=renter_inc5080, years= &years. );
	%Pct_calc( var=Prentr_inc5080_lte15, label=% Renter occupied units household income 50-80% persons per room greater than 1 less than or equal 1.5, num=rentr_inc5080_lte15, den=renter_inc5080, years= &years. );
	%Pct_calc( var=Prentr_inc5080_gt15, label=% Renter occupied units household income 50-80% persons per room greater than 1.5, num=rentr_inc5080_gt15, den=renter_inc5080, years= &years. );

	%Pct_calc( var=Prentr_inc80100_lte1, label=% Renter occupied units household income 80-100% persons per room less than or equal 1, num=rentr_inc80100_lte1, den=renter_inc80100, years= &years. );
	%Pct_calc( var=Prentr_inc80100_lte15, label=% Renter occupied units household income 80-100% persons per room greater than 1 less than or equal 1.5, num=rentr_inc80100_lte15, den=renter_inc80100, years= &years. );
	%Pct_calc( var=Prentr_inc80100_gt15, label=% Renter occupied units household income 80-100% persons per room greater than 1.5, num=rentr_inc80100_gt15, den=renter_inc80100, years= &years. );

	%Pct_calc( var=Prentr_inc100pl_lte1, label=% Renter occupied units household income 100%+ persons per room less than or equal 1, num=rentr_inc100pl_lte1, den=renter_inc100pl, years= &years. );
	%Pct_calc( var=Prentr_inc100pl_lte15, label=% Renter occupied units household income 100%+ persons per room greater than 1 less than or equal 1.5, num=rentr_inc100pl_lte15, den=renter_inc100pl, years= &years. );
	%Pct_calc( var=Prentr_inc100pl_gt15, label=% Renter occupied units household income 100%+ persons per room greater than 1.5, num=rentr_inc100pl_gt15, den=renter_inc100pl, years= &years. );

	%Pct_calc( var=Prentr_inc030_lte1_1fam, label=% Renter occupied units household income 0-30% one family persons per room less than or equal 1, num=rentr_inc030_lte1_1fam, den=rentr_inc030_1fam, years= &years. );
	%Pct_calc( var=Prentr_inc030_lte15_1fam, label=% Renter occupied units household income 0-30% one family persons per room greater than 1 less than or equal 1.5, num=rentr_inc030_lte15_1fam, den=rentr_inc030_1fam, years= &years. );
	%Pct_calc( var=Prentr_inc030_gt15_1fam, label=% Renter occupied units household income 0-30% one family persons per room greater than 1.5, num=rentr_inc030_gt15_1fam, den=rentr_inc030_1fam, years= &years. );

	%Pct_calc( var=Prentr_inc030_lte1_sfam, label=% Renter occupied units household income 0-30% one family with subfamily persons per room less than or equal 1, num=rentr_inc030_lte1_sfam, den=rentr_inc030_sfam, years= &years. );
	%Pct_calc( var=Prentr_inc030_lte15_sfam, label=% Renter occupied units household income 0-30% one family with subfamily persons per room greater than 1 less than or equal 1.5, num=rentr_inc030_lte15_sfam, den=rentr_inc030_sfam, years= &years. );
	%Pct_calc( var=Prentr_inc030_gt15_sfam, label=% Renter occupied units household income 0-30% one family with subfamily persons per room greater than 1.5, num=rentr_inc030_gt15_sfam, den=rentr_inc030_sfam, years= &years. );

	%Pct_calc( var=Prentr_inc030_lte1_nfam, label=% Renter occupied units household income 0-30% non-family persons per room less than or equal 1, num=rentr_inc030_lte1_nfam, den=rentr_inc030_nfam, years= &years. );
	%Pct_calc( var=Prentr_inc030_lte15_nfam, label=% Renter occupied units household income 0-30% non-family persons per room greater than 1 less than or equal 1.5, num=rentr_inc030_lte15_nfam, den=rentr_inc030_nfam, years= &years. );
	%Pct_calc( var=Prentr_inc030_gt15_nfam, label=% Renter occupied units household income 0-30% non-family persons per room greater than 1.5, num=rentr_inc030_gt15_nfam, den=rentr_inc030_nfam, years= &years. );


	/* Demand - Age */

	renter_bt00_&years. = T12_est109;
	renter_bt8099_&years. = T12_est130;
	renter_bt6079_&years. = T12_est151;
	renter_bt4059_&years. = T12_est172;
	renter_bt39_&years. = T12_est193;

	renter_in50_&years. = sum(of T12_est110 T12_est131 T12_est152 T12_est173 T12_est194);
	renter_in5080_&years. = sum(of T12_est115 T12_est136 T12_est157 T12_est178 T12_est199);
	renter_in80120_&years. = sum(of T12_est120 T12_est141 T12_est162 T12_est183 T12_est204);
	renter_in120pl_&years. = sum(of T12_est125 T12_est146 T12_est167 T12_est188 T12_est209);

	renter_inc050_bt00_&years. = T12_est110;
	renter_inc050_bt8099_&years. = T12_est131;
	renter_inc050_bt6079_&years. = T12_est152;
	renter_inc050_bt4059_&years. = T12_est173;
	renter_inc050_bt39_&years. = T12_est194;

	renter_inc5080_bt00_&years. = T12_est115;
	renter_inc5080_bt8099_&years. = T12_est136;
	renter_inc5080_bt6079_&years. = T12_est157;
	renter_inc5080_bt4059_&years. = T12_est178;
	renter_inc5080_bt39_&years. = T12_est199;

	renter_inc80120_bt00_&years. = T12_est120;
	renter_inc80120_bt8099_&years. = T12_est141;
	renter_inc80120_bt6079_&years. = T12_est162;
	renter_inc80120_bt4059_&years. = T12_est183;
	renter_inc80120_bt39_&years. = T12_est204;

	renter_inc120pl_bt00_&years. = T12_est125;
	renter_inc120pl_bt8099_&years. = T12_est146;
	renter_inc120pl_bt6079_&years. = T12_est167;
	renter_inc120pl_bt4059_&years. = T12_est188;
	renter_inc120pl_bt39_&years. = T12_est209;

	renter_ncb_inc050_bt00_&years. = T12_est111 ;
	renter_ncb_inc050_bt8099_&years. = T12_est132 ;
	renter_ncb_inc050_bt6079_&years. = T12_est153;
	renter_ncb_inc050_bt4059_&years. = T12_est174;
	renter_ncb_inc050_bt39_&years. = T12_est195 ;

	renter_cb_inc050_bt00_&years. = sum(of T12_est112 T12_est113);
	renter_cb_inc050_bt8099_&years. = sum(of T12_est133 T12_est134);
	renter_cb_inc050_bt6079_&years. = sum(of T12_est154 T12_est155 );
	renter_cb_inc050_bt4059_&years. = sum(of T12_est175 T12_est176 );
	renter_cb_inc050_bt39_&years. = sum(of T12_est196 T12_est197 );

	renter_scb_inc050_bt00_&years. = T12_est113;
	renter_scb_inc050_bt8099_&years. = T12_est134 ;
	renter_scb_inc050_bt6079_&years. = T12_est155;
	renter_scb_inc050_bt4059_&years. = T12_est176 ;
	renter_scb_inc050_bt39_&years. = T12_est197 ;

	renter_cb_inc050_&years. = sum(of T12_est112 T12_est113 T12_est133 T12_est134 T12_est154 T12_est155 T12_est175 T12_est176 T12_est196 T12_est197);
	renter_scb_inc050_&years. = sum(of T12_est113 T12_est134 T12_est155 T12_est176 T12_est197);
	renter_ncb_inc050_&years. = sum(of T12_est111 T12_est132 T12_est153 T12_est174 T12_est195);


	label 
	renter_bt00_&years. = "Renter occupied units, built 2000 or later, &years_dash."
	renter_bt8099_&years. = "Renter occupied units, built 1980-1999, &years_dash."
	renter_bt6079_&years. = "Renter occupied units, built 1960-1979, &years_dash."
	renter_bt4059_&years. = "Renter occupied units, built 1940-1959, &years_dash."
	renter_bt39_&years. = "Renter occupied units, built 1940-1959, &years_dash."
	renter_in50_&years. = "Renter occupied units, household income 0-50%, &years_dash."
	renter_in5080_&years. = "Renter occupied units, household income 0-50%, &years_dash."
	renter_in80120_&years. = "Renter occupied units, household income 50-80%, &years_dash."
	renter_in120pl_&years. = "Renter occupied units, household income 120%+, &years_dash."
	renter_inc050_bt00_&years. = "Renter occupied units, household income 0-50%, built 2000 or later, &years_dash."
	renter_inc050_bt8099_&years. = "Renter occupied units, household income 0-50%, built 1980-1999, &years_dash."
	renter_inc050_bt6079_&years. = "Renter occupied units, household income 0-50%, built 1960-1979, &years_dash."
	renter_inc050_bt4059_&years. = "Renter occupied units, household income 0-50%, built 1940-1959, &years_dash."
	renter_inc050_bt39_&years. = "Renter occupied units, household income 0-50%, built 1939 or earlier, &years_dash."
	renter_inc5080_bt00_&years. = "Renter occupied units, household income 50-80%, built 2000 or later, &years_dash."
	renter_inc5080_bt8099_&years. = "Renter occupied units, household income 50-80%, built 1980-1999, &years_dash."
	renter_inc5080_bt6079_&years. = "Renter occupied units, household income 50-80%, built 1960-1979, &years_dash."
	renter_inc5080_bt4059_&years. = "Renter occupied units, household income 50-80%, built 1940-1959, &years_dash."
	renter_inc5080_bt39_&years. = "Renter occupied units, household income 50-80%, built 1939 or earlier, &years_dash."
	renter_inc80120_bt00_&years. = "Renter occupied units, household income 80-120%, built 2000 or later, &years_dash."
	renter_inc80120_bt8099_&years. = "Renter occupied units, household income 80-120%, built 1980-1999, &years_dash."
	renter_inc80120_bt6079_&years. = "Renter occupied units, household income 80-120%, built 1960-1979, &years_dash."
	renter_inc80120_bt4059_&years. = "Renter occupied units, household income 80-120%, built 1940-1959, &years_dash."
	renter_inc80120_bt39_&years. = "Renter occupied units, household income 80-120%, built 1939 or earlier, &years_dash."
	renter_inc120pl_bt00_&years. = "Renter occupied units, household income 120%+, built 2000 or later, &years_dash."
	renter_inc120pl_bt8099_&years. = "Renter occupied units, household income 120%+, built 1980-1999, &years_dash."
	renter_inc120pl_bt6079_&years. = "Renter occupied units, household income 120%+, built 1960-1979, &years_dash."
	renter_inc120pl_bt4059_&years. = "Renter occupied units, household income 120%+, built 1940-1959, &years_dash."
	renter_inc120pl_bt39_&years. = "Renter occupied units, household income 120%+, built 1939 or earlier, &years_dash."
	renter_ncb_inc050_bt00_&years. = "Renter occupied units, not cost burdened, household income 50-80%, built 1980-1999, &years_dash."
	renter_ncb_inc050_bt8099_&years. = "Renter occupied units, not cost burdened, household income 50-80%, built 1980-1999, &years_dash."
	renter_ncb_inc050_bt6079_&years. = "Renter occupied units, not cost burdened, household income 50-80%, built 1960-1979, &years_dash."
	renter_ncb_inc050_bt4059_&years. = "Renter occupied units, not cost burdened, household income 50-80%, built 1940-1959, &years_dash."
	renter_ncb_inc050_bt39_&years. = "Renter occupied units, not cost burdened, household income 50-80%, built 1939 or earlier, &years_dash."
	renter_cb_inc050_bt00_&years. = "Renter occupied units, cost burdened, household income 50-80%, built 1980-1999, &years_dash."
	renter_cb_inc050_bt8099_&years. = "Renter occupied units, cost burdened, household income 50-80%, built 1980-1999, &years_dash."
	renter_cb_inc050_bt6079_&years. = "Renter occupied units, cost burdened, household income 50-80%, built 1960-1979, &years_dash."
	renter_cb_inc050_bt4059_&years. = "Renter occupied units, cost burdened, household income 50-80%, built 1940-1959, &years_dash."
	renter_cb_inc050_bt39_&years. = "Renter occupied units, cost burdened, household income 50-80%, built 1939 or earlier, &years_dash."
	renter_scb_inc050_bt00_&years. = "Renter occupied units, severely cost burdened, household income 50-80%, built 1980-1999, &years_dash."
	renter_scb_inc050_bt8099_&years. = "Renter occupied units, severely cost burdened, household income 50-80%, built 1980-1999, &years_dash."
	renter_scb_inc050_bt6079_&years. = "Renter occupied units, severely cost burdened, household income 50-80%, built 1960-1979, &years_dash."
	renter_scb_inc050_bt4059_&years. = "Renter occupied units, severely cost burdened, household income 50-80%, built 1940-1959, &years_dash."
	renter_scb_inc050_bt39_&years. = "Renter occupied units, severely cost burdened, household income 50-80%, built 1939 or earlier, &years_dash."
	renter_cb_inc050_&years. = "Renter occupied units, household income 50-80%, cost burndened, &years_dash."
	renter_scb_inc050_&years. = "Renter occupied units, household income 50-80%, severely cost burndened, &years_dash."
	renter_ncb_inc050_&years. = "Renter occupied units, household income 50-80%, not cost burndened, &years_dash."
	;

	%Pct_calc( var=Prenter_inc050_bt00, label=% Renter occupied units household income 0-50% built 2000 or later, num=renter_inc050_bt00, den=renter_in50, years= &years. );
	%Pct_calc( var=Prenter_inc050_bt8099, label=% Renter occupied units household income 0-50% built 1980-1999, num=renter_inc050_bt8099, den=renter_in50, years= &years. );
	%Pct_calc( var=Prenter_inc050_bt6079, label=% Renter occupied units household income 0-50% built 1960-1979, num=renter_inc050_bt6079, den=renter_in50, years= &years. );
	%Pct_calc( var=Prenter_inc050_bt4059, label=% Renter occupied units household income 0-50% built 1940-1959, num=renter_inc050_bt4059, den=renter_in50, years= &years. );
	%Pct_calc( var=Prenter_inc050_bt39, label=% Renter occupied units household income 0-50% built 1939 or earlier, num=renter_inc050_bt39, den=renter_in50, years= &years. );

	%Pct_calc( var=Prenter_inc5080_bt00, label=% Renter occupied units household income 50-80% built 2000 or later, num=renter_inc5080_bt00, den=renter_in5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_bt8099, label=% Renter occupied units household income 50-80% built 1980-1999, num=renter_inc5080_bt8099, den=renter_in5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_bt6079, label=% Renter occupied units household income 50-80% built 1960-1979, num=renter_inc5080_bt6079, den=renter_in5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_bt4059, label=% Renter occupied units household income 50-80% built 1940-1959, num=renter_inc5080_bt4059, den=renter_in5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_bt39, label=% Renter occupied units household income 50-80% built 1939 or earlier, num=renter_inc5080_bt39, den=renter_in5080, years= &years. );

	%Pct_calc( var=Prenter_inc80120_bt00, label=% Renter occupied units household income 80-120% built 2000 or later, num=renter_inc80120_bt00, den=renter_in80120, years= &years. );
	%Pct_calc( var=Prenter_inc80120_bt8099, label=% Renter occupied units household income 80-120% built 1980-1999, num=renter_inc80120_bt8099, den=renter_in80120, years= &years. );
	%Pct_calc( var=Prenter_inc80120_bt6079, label=% Renter occupied units household income 80-120% built 1960-1979, num=renter_inc80120_bt6079, den=renter_in80120, years= &years. );
	%Pct_calc( var=Prenter_inc80120_bt4059, label=% Renter occupied units household income 80-120% built 1940-1959, num=renter_inc80120_bt4059, den=renter_in80120, years= &years. );
	%Pct_calc( var=Prenter_inc80120_bt39, label=% Renter occupied units household income 80-120% built 1939 or earlier, num=renter_inc80120_bt39, den=renter_in80120, years= &years. );

	%Pct_calc( var=Prenter_inc120pl_bt00, label=% Renter occupied units household income 120%+ built 2000 or later, num=renter_inc120pl_bt00, den=renter_in120pl, years= &years. );
	%Pct_calc( var=Prenter_inc120pl_bt8099, label=% Renter occupied units household income 120%+ built 1980-1999, num=renter_inc120pl_bt8099, den=renter_in120pl, years= &years. );
	%Pct_calc( var=Prenter_inc120pl_bt6079, label=% Renter occupied units household income 120%+ built 1960-1979, num=renter_inc120pl_bt6079, den=renter_in120pl, years= &years. );
	%Pct_calc( var=Prenter_inc120pl_bt4059, label=% Renter occupied units household income 120%+ built 1940-1959, num=renter_inc120pl_bt4059, den=renter_in120pl, years= &years. );
	%Pct_calc( var=Prenter_inc120pl_bt39, label=% Renter occupied units household income 120%+ built 1939 or earlier, num=renter_inc120pl_bt39, den=renter_in120pl, years= &years. );

	%Pct_calc( var=Prenter_ncb_in050_bt00, label=% Renter occupied units NOT cost burdened built 2000 or later, num=renter_ncb_inc050_bt00, den=renter_ncb_inc050, years= &years. );
	%Pct_calc( var=Prenter_ncb_in050_bt8099, label=% Renter occupied units NOT cost burdened built 1980-1999, num=renter_ncb_inc050_bt8099, den=renter_ncb_inc050, years= &years. );
	%Pct_calc( var=Prenter_ncb_in050_bt6079, label=% Renter occupied units NOT cost burdened built 1960-1979, num=renter_ncb_inc050_bt6079, den=renter_ncb_inc050, years= &years. );
	%Pct_calc( var=Prenter_ncb_in050_bt4059, label=% Renter occupied units NOT cost burdened built 1940-1959, num=renter_ncb_inc050_bt4059, den=renter_ncb_inc050, years= &years. );
	%Pct_calc( var=Prenter_ncb_in050_bt39, label=% Renter occupied units NOT cost burdened built 1939 or earlier, num=renter_ncb_inc050_bt39, den=renter_ncb_inc050, years= &years. );

	%Pct_calc( var=Prenter_cb_in050_bt00, label=% Renter occupied units cost burdened built 2000 or later, num=renter_cb_inc050_bt00, den=renter_cb_inc050, years= &years. );
	%Pct_calc( var=Prenter_cb_in050_bt8099, label=% Renter occupied units cost burdened built 1980-1999, num=renter_cb_inc050_bt8099, den=renter_cb_inc050, years= &years. );
	%Pct_calc( var=Prenter_cb_in050_bt6079, label=% Renter occupied units cost burdened built 1960-1979, num=renter_cb_inc050_bt6079, den=renter_cb_inc050, years= &years. );
	%Pct_calc( var=Prenter_cb_in050_bt4059, label=% Renter occupied units cost burdened built 1940-1959, num=renter_cb_inc050_bt4059, den=renter_cb_inc050, years= &years. );
	%Pct_calc( var=Prenter_cb_in050_bt39, label=% Renter occupied units cost burdened built 1939 or earlier, num=renter_cb_inc050_bt39, den=renter_cb_inc050, years= &years. );

	%Pct_calc( var=Prenter_scb_in050_bt00, label=% Renter occupied units severely cost burdened built 2000 or later, num=renter_scb_inc050_bt00, den=renter_scb_inc050, years= &years. );
	%Pct_calc( var=Prenter_scb_in050_bt8099, label=% Renter occupied units severely cost burdened built 1980-1999 or later, num=renter_scb_inc050_bt8099, den=renter_scb_inc050, years= &years. );
	%Pct_calc( var=Prenter_scb_in050_bt6079, label=% Renter occupied units severely cost burdened built 1960-1979, num=renter_scb_inc050_bt6079, den=renter_scb_inc050, years= &years. );
	%Pct_calc( var=Prenter_scb_in050_bt4059, label=% Renter occupied units severely cost burdened built 1940-1959, num=renter_scb_inc050_bt4059, den=renter_scb_inc050, years= &years. );
	%Pct_calc( var=Prenter_scb_in050_bt39, label=% Renter occupied units severely cost burdened built 1939 or earlier, num=renter_scb_inc050_bt39, den=renter_scb_inc050, years= &years. );


	/* Race */
	renter_wht_&years. = sum(of T1_est129 T1_est137 T1_est145 T1_est153 T1_est161 T1_est170 T1_est178 T1_est186 T1_est194 T1_est202
							T1_est211 T1_est219 T1_est227 T1_est235 T1_est243);
	renter_blk_&years. = sum(of T1_est130 T1_est138 T1_est146 T1_est154 T1_est162 T1_est171 T1_est179 T1_est187 T1_est195 T1_est203
							T1_est212 T1_est220 T1_est228 T1_est236 T1_est244);
	renter_api_&years. = sum(of T1_est131 T1_est133 T1_est139 T1_est141 T1_est147 T1_est149 T1_est155 T1_est157 T1_est163 T1_est165
							T1_est172 T1_est174 T1_est180 T1_est182 T1_est188 T1_est190 T1_est196 T1_est198 T1_est204 T1_est206 T1_est213
							T1_est215 T1_est221 T1_est223 T1_est229 T1_est231 T1_est237 T1_est239 T1_est245 T1_est247); 
	renter_aia_&years. = sum(of T1_est132 T1_est140 T1_est148 T1_est156 T1_est164 T1_est173 T1_est181 T1_est189 T1_est197 T1_est205
							T1_est214 T1_est222 T1_est230 T1_est238 T1_est246);
	renter_his_&years. = sum(of T1_est134 T1_est142 T1_est150 T1_est158 T1_est166 T1_est175 T1_est183 T1_est191 T1_est199 T1_est207
							T1_est216 T1_est224 T1_est232 T1_est240 T1_est248);
	renter_oth_&years. = sum(of T1_est135 T1_est143 T1_est151 T1_est159 T1_est167 T1_est176 T1_est184 T1_est192 T1_est200 T1_est208
							T1_est217 T1_est225 T1_est233 T1_est241 T1_est249);


	renter_inc030_wht_&years. = sum(of T1_est129 T1_est170 T1_est211);
	renter_inc3050_wht_&years. = sum(of T1_est137 T1_est178 T1_est219);
	renter_inc5080_wht_&years. = sum(of T1_est145 T1_est186 T1_est227);
	renter_inc80100_wht_&years. = sum(of T1_est153 T1_est194 T1_est235);
	renter_inc100pl_wht_&years. = sum(of T1_est161 T1_est202 T1_est243);

	renter_inc030_blk_&years. = sum(of T1_est130 T1_est171 T1_est212);
	renter_inc3050_blk_&years. = sum(of T1_est138 T1_est179 T1_est220);
	renter_inc5080_blk_&years. = sum(of T1_est146 T1_est187 T1_est228);
	renter_inc80100_blk_&years. = sum(of T1_est154 T1_est195 T1_est236);
	renter_inc100pl_blk_&years. = sum(of T1_est162 T1_est203 T1_est244);

	renter_inc030_api_&years. = sum(of T1_est131 T1_est133 T1_est172 T1_est174 T1_est213 T1_est215);
	renter_inc3050_api_&years. = sum(of T1_est139 T1_est141 T1_est180 T1_est182 T1_est221 T1_est223);
	renter_inc5080_api_&years. = sum(of T1_est147 T1_est149 T1_est188 T1_est190 T1_est229 T1_est231);
	renter_inc80100_api_&years. = sum(of T1_est155 T1_est157 T1_est196 T1_est198 T1_est237 T1_est239);
	renter_inc100pl_api_&years. = sum(of T1_est163 T1_est165 T1_est204 T1_est206 T1_est245 T1_est247);

	renter_inc030_aia_&years. = sum(of T1_est132 T1_est173 T1_est214);
	renter_inc3050_aia_&years. = sum(of T1_est140 T1_est181 T1_est222);
	renter_inc5080_aia_&years. = sum(of T1_est148 T1_est189 T1_est230);
	renter_inc80100_aia_&years. = sum(of T1_est156 T1_est197 T1_est238);
	renter_inc100pl_aia_&years. = sum(of T1_est164 T1_est205 T1_est246);

	renter_inc030_his_&years. = sum(of T1_est134 T1_est175 T1_est216);
	renter_inc3050_his_&years. = sum(of T1_est142 T1_est183 T1_est224);
	renter_inc5080_his_&years. = sum(of T1_est150 T1_est191 T1_est232);
	renter_inc80100_his_&years. = sum(of T1_est158 T1_est199 T1_est240);
	renter_inc100pl_his_&years. = sum(of T1_est166 T1_est207 T1_est248);

	renter_inc030_oth_&years. = sum(of T1_est135 T1_est176 T1_est217);
	renter_inc3050_oth_&years. = sum(of T1_est143 T1_est184 T1_est225);
	renter_inc5080_oth_&years. = sum(of T1_est151 T1_est192 T1_est233);
	renter_inc80100_oth_&years. = sum(of T1_est159 T1_est200 T1_est241);
	renter_inc100pl_oth_&years. = sum(of T1_est167 T1_est208 T1_est249);

	renter_inc030_1prob_wht_&years. = T1_est129;
	renter_inc030_0prob_wht_&years. = T1_est170;
	renter_inc030_nc_wht_&years. = T1_est211;

	renter_inc030_1prob_blk_&years. = T1_est130;
	renter_inc030_0prob_blk_&years. = T1_est171;
	renter_inc030_nc_blk_&years. = T1_est212;

	renter_inc030_1prob_api_&years. = sum(of T1_est131 T1_est133);
	renter_inc030_0prob_api_&years. = sum(of T1_est172 T1_est174);
	renter_inc030_nc_api_&years. = sum(of T1_est213 T1_est215);

	renter_inc030_1prob_aia_&years. = T1_est132;
	renter_inc030_0prob_aia_&years. = T1_est173;
	renter_inc030_nc_aia_&years. = T1_est214;

	renter_inc030_1prob_his_&years. = T1_est134;
	renter_inc030_0prob_his_&years. = T1_est175;
	renter_inc030_nc_his_&years. = T1_est216;

	renter_inc030_1prob_oth_&years. = T1_est135;
	renter_inc030_0prob_oth_&years. = T1_est176;
	renter_inc030_nc_oth_&years. = T1_est217;

	label
	renter_wht_&years. = "Renter occupied units, White alone non-Hispanic, &years_dash."
	renter_blk_&years. = "Renter occupied units, Black or African-American alone non-Hispanic, &years_dash."
	renter_api_&years. = "Renter occupied units, Asian or pacific islander alone non-Hispanic, &years_dash."
	renter_aia_&years. = "Renter occupied units, American Indian or Alaska Native alone non-Hispanic, &years_dash."
	renter_his_&years. = "Renter occupied units, Hispanic, &years_dash."
	renter_oth_&years. = "Renter occupied units, Other race, &years_dash."
	renter_inc030_wht_&years. = "Renter occupied units, household income 0-30%, White alone non-Hispanic, &years_dash."
	renter_inc3050_wht_&years. = "Renter occupied units, household income 30-50%, White alone non-Hispanic, &years_dash."
	renter_inc5080_wht_&years. = "Renter occupied units, household income 50-80%, White alone non-Hispanic, &years_dash."
	renter_inc80100_wht_&years. = "Renter occupied units, household income 80%-100%, White alone non-Hispanic, &years_dash."
	renter_inc100pl_wht_&years. = "Renter occupied units, household income 100%+, White alone non-Hispanic, &years_dash."
	renter_inc030_blk_&years. = "Renter occupied units, household income 0-30%, Black or African-American alone non-Hispanic, &years_dash."
	renter_inc3050_blk_&years. = "Renter occupied units, household income 30-50%, Black or African-American alone non-Hispanic, &years_dash."
	renter_inc5080_blk_&years. = "Renter occupied units, household income 50-80%, Black or African-American alone non-Hispanic, &years_dash."
	renter_inc80100_blk_&years. = "Renter occupied units, household income 80%-100%, Black or African-American alone non-Hispanic, &years_dash."
	renter_inc100pl_blk_&years. = "Renter occupied units, household income 100%+, Black or African-American alone non-Hispanic, &years_dash."
	renter_inc030_api_&years. = "Renter occupied units, household income 0-30%, Asian or pacific islander alone non-Hispanic, &years_dash."
	renter_inc3050_api_&years. = "Renter occupied units, household income 30-50%, Asian or pacific islander alone non-Hispanic, &years_dash."
	renter_inc5080_api_&years. = "Renter occupied units, household income 50-80%, Asian or pacific islander alone non-Hispanic, &years_dash."
	renter_inc80100_api_&years. = "Renter occupied units, household income 80%-100%, Asian or pacific islander alone non-Hispanic, &years_dash."
	renter_inc100pl_api_&years. = "Renter occupied units, household income 100%+, Asian or pacific islander alone non-Hispanic, &years_dash."
	renter_inc030_aia_&years. = "Renter occupied units, household income 0-30%, American Indian or Alaska Native alone non-Hispanic, &years_dash."
	renter_inc3050_aia_&years. = "Renter occupied units, household income 30-50%, American Indian or Alaska Native alone non-Hispanic, &years_dash."
	renter_inc5080_aia_&years. = "Renter occupied units, household income 50-80%, American Indian or Alaska Native alone non-Hispanic, &years_dash."
	renter_inc80100_aia_&years. = "Renter occupied units, household income 80%-100%, American Indian or Alaska Native alone non-Hispanic, &years_dash."
	renter_inc100pl_aia_&years. = "Renter occupied units, household income 100%+, American Indian or Alaska Native alone non-Hispanic, &years_dash."
	renter_inc030_his_&years. = "Renter occupied units, household income 0-30%, Hispanic, &years_dash."
	renter_inc3050_his_&years. = "Renter occupied units, household income 30-50%, Hispanic, &years_dash."
	renter_inc5080_his_&years. = "Renter occupied units, household income 50-80%, Hispanic, &years_dash."
	renter_inc80100_his_&years. = "Renter occupied units, household income 80%-100%, Hispanic, &years_dash."
	renter_inc100pl_his_&years. = "Renter occupied units, household income 100%+, Hispanic, &years_dash."
	renter_inc030_oth_&years. = "Renter occupied units, household income 0-30%, Other race, &years_dash."
	renter_inc3050_oth_&years. = "Renter occupied units, household income 30-50%, Other race, &years_dash."
	renter_inc5080_oth_&years. = "Renter occupied units, household income 50-80%, Other race, &years_dash."
	renter_inc80100_oth_&years. = "Renter occupied units, household income 80%-100%, Other race, &years_dash."
	renter_inc100pl_oth_&years. = "Renter occupied units, household income 100%+, Other race, &years_dash."
	renter_inc030_1prob_wht_&years. = "Renter occupied units, household income 0-30%, White alone non-Hispanic, 1 or more of the 4 housing unit problems, &years_dash."
	renter_inc030_0prob_wht_&years. = "Renter occupied units, household income 0-30%, White alone non-Hispanic, none of the 4 housing unit problems, &years_dash."
	renter_inc030_nc_wht_&years. = "Renter occupied units, household income 0-30%, White alone non-Hispanic, cost burden not computed, household has none of the other housing problems, &years_dash."
	renter_inc030_1prob_blk_&years. = "Renter occupied units, household income 0-30%, Black or African-American alone non-Hispanic, 1 or more of the 4 housing unit problems, &years_dash."
	renter_inc030_0prob_blk_&years. = "Renter occupied units, household income 0-30%, Black or African-American alone non-Hispanic, none of the 4 housing unit problems, &years_dash."
	renter_inc030_nc_blk_&years. = "Renter occupied units, household income 0-30%, Black or African-American alone non-Hispanic, cost burden not computed, household has none of the other housing problems, &years_dash."
	renter_inc030_1prob_api_&years. = "Renter occupied units, household income 0-30%, Asian or pacific islander alone non-Hispanic, 1 or more of the 4 housing unit problems, &years_dash."
	renter_inc030_0prob_api_&years. = "Renter occupied units, household income 0-30%, Asian or pacific islander alone non-Hispanic, none of the 4 housing unit problems, &years_dash."
	renter_inc030_nc_api_&years. = "Renter occupied units, household income 0-30%, Asian or pacific islander alone non-Hispanic, household has none of the other housing problems, &years_dash."
	renter_inc030_1prob_aia_&years. = "Renter occupied units, household income 0-30%, American Indian or Alaska Native alone non-Hispanic, 1 or more of the 4 housing unit problems, &years_dash."
	renter_inc030_0prob_aia_&years. = "Renter occupied units, household income 0-30%, American Indian or Alaska Native alone non-Hispanic, none of the 4 housing unit problems, &years_dash."
	renter_inc030_nc_aia_&years. = "Renter occupied units, household income 0-30%, American Indian or Alaska Native alone non-Hispanic, cost burden not computed, household has none of the other housing problems, &years_dash."
	renter_inc030_1prob_his_&years. = "Renter occupied units, household income 0-30%, Hispanic, 1 or more of the 4 housing unit problems, &years_dash."
	renter_inc030_0prob_his_&years. = "Renter occupied units, household income 0-30%, Hispanic, none of the 4 housing unit problems, &years_dash."
	renter_inc030_nc_his_&years. = "Renter occupied units, household income 0-30%, Hispanic, cost burden not computed, household has none of the other housing problems, &years_dash."
	renter_inc030_1prob_oth_&years. = "Renter occupied units, household income 0-30%, Other race, 1 or more of the 4 housing unit problems, &years_dash."
	renter_inc030_0prob_oth_&years. = "Renter occupied units, household income 0-30%,Other race, none of the 4 housing unit problems, &years_dash."
	renter_inc030_nc_oth_&years. = "Renter occupied units, household income 0-30%, Other race, cost burden not computed, household has none of the other housing problems, &years_dash."
	;

	%Pct_calc( var=Prenter_inc030_wht, label=% Renter occupied units household income 0-30% White alone non-Hispanic, num=renter_inc030_wht, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_inc030_blk, label=% Renter occupied units household income 0-30% Black or African-American alone non-Hispanic, num=renter_inc030_blk, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_inc030_api, label=% Renter occupied units household income 0-30% Asian or pacific islander alone non-Hispanic, num=renter_inc030_api, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_inc030_aia, label=% Renter occupied units household income 0-30% American Indian or Alaska Native alone non-Hispanic, num=renter_inc030_aia, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_inc030_his, label=% Renter occupied units household income 0-30% Hispanic, num=renter_inc030_his, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_inc030_oth, label=% Renter occupied units household income 0-30% Other race, num=renter_inc030_oth, den=renter_inc030, years= &years. );

	%Pct_calc( var=Prenter_inc3050_wht, label=% Renter occupied units household income 30-50% White alone non-Hispanic, num=renter_inc3050_wht, den=renter_inc3050, years= &years. );
	%Pct_calc( var=Prenter_inc3050_blk, label=% Renter occupied units household income 30-50% Black or African-American alone non-Hispanic, num=renter_inc3050_blk, den=renter_inc3050, years= &years. );
	%Pct_calc( var=Prenter_inc3050_api, label=% Renter occupied units household income 30-50% Asian or pacific islander alone non-Hispanic, num=renter_inc3050_api, den=renter_inc3050, years= &years. );
	%Pct_calc( var=Prenter_inc3050_aia, label=% Renter occupied units household income 30-50% American Indian or Alaska Native alone non-Hispanic, num=renter_inc3050_aia, den=renter_inc3050, years= &years. );
	%Pct_calc( var=Prenter_inc3050_his, label=% Renter occupied units household income 30-50% Hispanic, num=renter_inc3050_his, den=renter_inc3050, years= &years. );
	%Pct_calc( var=Prenter_inc3050_oth, label=% Renter occupied units household income 30-50% Other race, num=renter_inc3050_oth, den=renter_inc3050, years= &years. );

	%Pct_calc( var=Prenter_inc5080_wht, label=% Renter occupied units household income 50-80% White alone non-Hispanic, num=renter_inc5080_wht, den=renter_inc5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_blk, label=% Renter occupied units household income 50-80% Black or African-American alone non-Hispanic, num=renter_inc5080_blk, den=renter_inc5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_api, label=% Renter occupied units household income 50-80% Asian or pacific islander alone non-Hispanic, num=renter_inc5080_api, den=renter_inc5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_aia, label=% Renter occupied units household income 50-80% American Indian or Alaska Native alone non-Hispanic, num=renter_inc5080_aia, den=renter_inc5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_his, label=% Renter occupied units household income 50-80% Hispanic, num=renter_inc5080_his, den=renter_inc5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_oth, label=% Renter occupied units household income 50-80% Other race, num=renter_inc5080_oth, den=renter_inc5080, years= &years. );

	%Pct_calc( var=Prenter_inc80100_wht, label=% Renter occupied units household income 80-100% White alone non-Hispanic, num=renter_inc80100_wht, den=renter_inc80100, years= &years. );
	%Pct_calc( var=Prenter_inc80100_blk, label=% Renter occupied units household income 80-100% Black or African-American alone non-Hispanic, num=renter_inc80100_blk, den=renter_inc80100, years= &years. );
	%Pct_calc( var=Prenter_inc80100_api, label=% Renter occupied units household income 80-100% Asian or pacific islander alone non-Hispanic, num=renter_inc80100_api, den=renter_inc80100, years= &years. );
	%Pct_calc( var=Prenter_inc80100_aia, label=% Renter occupied units household income 80-100% American Indian or Alaska Native alone non-Hispanic, num=renter_inc80100_aia, den=renter_inc80100, years= &years. );
	%Pct_calc( var=Prenter_inc80100_his, label=% Renter occupied units household income 80-100% Hispanic, num=renter_inc80100_his, den=renter_inc80100, years= &years. );
	%Pct_calc( var=Prenter_inc80100_oth, label=% Renter occupied units household income 80-100% Other race, num=renter_inc80100_oth, den=renter_inc80100, years= &years. );

	%Pct_calc( var=Prenter_inc100pl_wht, label=% Renter occupied units household income 100%+ White alone non-Hispanic, num=renter_inc100pl_wht, den=renter_inc100pl, years= &years. );
	%Pct_calc( var=Prenter_inc100pl_blk, label=% Renter occupied units household income 100%+ Black or African-American alone non-Hispanic, num=renter_inc100pl_blk, den=renter_inc100pl, years= &years. );
	%Pct_calc( var=Prenter_inc100pl_api, label=% Renter occupied units household income 100%+ Asian or pacific islander alone non-Hispanic, num=renter_inc100pl_api, den=renter_inc100pl, years= &years. );
	%Pct_calc( var=Prenter_inc100pl_aia, label=% Renter occupied units household income 100%+ American Indian or Alaska Native alone non-Hispanic, num=renter_inc100pl_aia, den=renter_inc100pl, years= &years. );
	%Pct_calc( var=Prenter_inc100pl_his, label=% Renter occupied units household income 100%+ Hispanic, num=renter_inc100pl_his, den=renter_inc100pl, years= &years. );
	%Pct_calc( var=Prenter_inc100pl_oth, label=% Renter occupied units household income 100%+ Other race, num=renter_inc100pl_oth, den=renter_inc100pl, years= &years. );


	%Pct_calc( var=Prenter_inc030_1prob_wht, label=% Renter occupied units household income 0-30% White alone non-Hispanic 1 or more of the 4 housing unit problems, num=renter_inc030_1prob_wht, den=renter_inc030_wht, years= &years. );
	%Pct_calc( var=Prenter_inc030_0prob_wht, label=% Renter occupied units household income 0-30% White alone non-Hispanic none of the 4 housing unit problems, num=renter_inc030_0prob_wht, den=renter_inc030_wht, years= &years. );
	%Pct_calc( var=Prenter_inc030_nc_wht, label=% Renter occupied units household income 0-30% White alone non-Hispanic cost burden not computed, num=renter_inc030_nc_wht, den=renter_inc030_wht, years= &years. );

	%Pct_calc( var=Prenter_inc030_1prob_blk, label=% Renter occupied units household income 0-30% Black or African-American alone non-Hispanic 1 or more of the 4 housing unit problems, num=renter_inc030_1prob_blk, den=renter_inc030_blk, years= &years. );
	%Pct_calc( var=Prenter_inc030_0prob_blk, label=% Renter occupied units household income 0-30% Black or African-American alone non-Hispanic none of the 4 housing unit problems, num=renter_inc030_0prob_blk, den=renter_inc030_blk, years= &years. );
	%Pct_calc( var=Prenter_inc030_nc_blk, label=% Renter occupied units household income 0-30% Black or African-American alone non-Hispanic cost burden not computed, num=renter_inc030_nc_blk, den=renter_inc030_blk, years= &years. );

	%Pct_calc( var=Prenter_inc030_1prob_api, label=% Renter occupied units household income 0-30% Asian or pacific islander alone non-Hispanic 1 or more of the 4 housing unit problems, num=renter_inc030_1prob_api, den=renter_inc030_api, years= &years. );
	%Pct_calc( var=Prenter_inc030_0prob_api, label=% Renter occupied units household income 0-30% Asian or pacific islander alone non-Hispanic none of the 4 housing unit problems, num=renter_inc030_0prob_api, den=renter_inc030_api, years= &years. );
	%Pct_calc( var=Prenter_inc030_nc_api, label=% Renter occupied units household income 0-30% Asian or pacific islander alone non-Hispanic cost burden not computed, num=renter_inc030_nc_api, den=renter_inc030_api, years= &years. );
	
	%Pct_calc( var=Prenter_inc030_1prob_aia, label=% Renter occupied units household income 0-30% American Indian or Alaska Native alone non-Hispanic 1 or more of the 4 housing unit problems, num=renter_inc030_1prob_aia, den=renter_inc030_aia, years= &years. );
	%Pct_calc( var=Prenter_inc030_0prob_aia, label=% Renter occupied units household income 0-30% American Indian or Alaska Native alone non-Hispanic none of the 4 housing unit problems, num=renter_inc030_0prob_aia, den=renter_inc030_aia, years= &years. );
	%Pct_calc( var=Prenter_inc030_nc_aia, label=% Renter occupied units household income 0-30% American Indian or Alaska Native alone non-Hispanic cost burden not computed, num=renter_inc030_nc_aia, den=renter_inc030_aia, years= &years. );

	%Pct_calc( var=Prenter_inc030_1prob_his, label=% Renter occupied units household income 0-30% Hispanic 1 or more of the 4 housing unit problems, num=renter_inc030_1prob_his, den=renter_inc030_his, years= &years. );
	%Pct_calc( var=Prenter_inc030_0prob_his, label=% Renter occupied units household income 0-30% WHispanic none of the 4 housing unit problems, num=renter_inc030_0prob_his, den=renter_inc030_his, years= &years. );
	%Pct_calc( var=Prenter_inc030_nc_his, label=% Renter occupied units household income 0-30% Hispanic cost burden not computed, num=renter_inc030_nc_his, den=renter_inc030_his, years= &years. );

	%Pct_calc( var=Prenter_inc030_1prob_oth, label=% Renter occupied units household income 0-30% Other race 1 or more of the 4 housing unit problems, num=renter_inc030_1prob_oth, den=renter_inc030_oth, years= &years. );
	%Pct_calc( var=Prenter_inc030_0prob_oth, label=% Renter occupied units household income 0-30% Other race none of the 4 housing unit problems, num=renter_inc030_0prob_oth, den=renter_inc030_oth, years= &years. );
	%Pct_calc( var=Prenter_inc030_nc_oth, label=% Renter occupied units household income 0-30% Other race cost burden not computed, num=renter_inc030_nc_oth, den=renter_inc030_oth, years= &years. );



run;

%mend chas_summary_vars;


/* End of Macro */
