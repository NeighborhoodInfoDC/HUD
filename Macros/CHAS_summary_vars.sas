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
	set hud.Chas_&years._ntnl (where=(geoid="16000US3502000" | geoid="05000US35001"));

	/* Supply */
	all_units_tot_&years. = sum(of T1_est1 T14A_est1 T14B_est1);
	occ_units_tot_&years. = T1_est1;
	owner_units_tot_&years. = sum(of T15A_est1 T15B_est1);
	forsale_units_tot_&years. = T14A_est1;
	own_forsale_units_tot_&years. = sum(of T15A_est1 T15B_est1 T14A_est1);
	renter_unit_tot_&years. = T15C_est1;
	forrent_units_tot_&years. = T14B_est1;
	rent_forrent_units_tot_&years. = sum(of T15C_est1 T14B_est1);
	rent_hasplumb_&years. = T15C_est3;
	own_hasplumb_&years. = sum(of T15A_est3 T15B_est3);

	Mall_units_tot_&years. =  %moe_sum(var= T1_moe1 T14A_moe1 T14B_moe1);
	Mocc_units_tot_&years. = T1_moe1;
	Mowner_units_tot_&years. = %moe_sum(var= T15A_moe1 T15B_moe1);
	Mforsale_units_tot_&years. = T14A_moe1;
	Mown_forsale_units_tot_&years. =  %moe_sum(var= T15A_moe1 T15B_moe1 T14A_moe1);
	Mrenter_unit_tot_&years. = T15C_moe1;
	Mforrent_units_tot_&years. = T14B_moe1;
	Mrent_forrent_units_tot_&years. = %moe_sum(var= T15C_moe1 T14B_moe1);
	Mrent_hasplumb_&years. = T15C_moe3;
	Mown_hasplumb_&years. = %moe_sum(var= T15A_moe3 T15B_moe3);

	renter_unit_aff30_&years. = T15C_est4;
	forrent_units_aff30_&years. = sum(of T17B_est3 T17B_est8 T17B_est13 T17B_est18);
	rental_comb_aff30_&years. = sum(of T15C_est4 T17B_est3 T17B_est8 T17B_est13 T17B_est18);

	Mrenter_unit_aff30_&years. = T15C_moe4;
	Mforrent_units_aff30_&years. = %moe_sum(var= T17B_moe3 T17B_moe8 T17B_moe13 T17B_moe18);
	Mrental_comb_aff30_&years. = %moe_sum(var= T15C_moe4 T17B_moe3 T17B_moe8 T17B_moe13 T17B_moe18);

	renter_unit_aff50_&years. = sum(of T15C_est4 T15C_est25);
	forrent_units_aff50_&years. = sum(of T17B_est3 T17B_est4 T17B_est8 T17B_est9 T17B_est13 T17B_est14 T17B_est18 T17B_est19);
	rental_comb_aff50_&years. = sum(of T15C_est4 T15C_est25 T17B_est3 T17B_est4 T17B_est8 T17B_est9 T17B_est13 T17B_est14 T17B_est18 T17B_est19);
	owner_unit_aff50_&years. = sum(of T15A_est4 T15B_est4);
	forsale_units_aff50_&years. = sum(of T17A_est3 T17A_est8 T17A_est13 T17A_est18);
	sales_comb_aff50_&years. = sum(of T15A_est4 T15B_est4 T17A_est3 T17A_est8 T17A_est13 T17A_est18);

	Mrenter_unit_aff50_&years. = %moe_sum(var= T15C_moe4 T15C_moe25);
	Mforrent_units_aff50_&years. = %moe_sum(var= T17B_moe3 T17B_moe4 T17B_moe8 T17B_moe9 T17B_moe13 T17B_moe14 T17B_moe18 T17B_moe19);
	Mrental_comb_aff50_&years. = %moe_sum(var= T15C_moe4 T15C_moe25 T17B_moe3 T17B_moe4 T17B_moe8 T17B_moe9 T17B_moe13 T17B_moe14 T17B_moe18 T17B_moe19);
	Mowner_unit_aff50_&years. = %moe_sum(var= T15A_moe4 T15B_moe4);
	Mforsale_units_aff50_&years. = %moe_sum(var= T17A_moe3 T17A_moe8 T17A_moe13 T17A_moe18);
	Msales_comb_aff50_&years. = %moe_sum(var= T15A_moe4 T15B_moe4 T17A_moe3 T17A_moe8 T17A_moe13 T17A_moe18);

	tot_aff30_&years. = rental_comb_aff30_&years.;
	tot_aff50_&years. = sum(of rental_comb_aff50_&years. sales_comb_aff50_&years.);

	Mtot_aff30_&years. = %moe_sum(var= T15C_moe4 T17B_moe3 T17B_moe8 T17B_moe13 T17B_moe18);
	Mtot_aff50_&years. = %moe_sum(var= T15C_moe4 T15C_moe25 T17B_moe3 T17B_moe4 T17B_moe8 T17B_moe9 T17B_moe13 T17B_moe14 T17B_moe18 T17B_moe19
								 T15A_moe4 T15B_moe4 T17A_moe3 T17A_moe8 T17A_moe13 T17A_moe18);

	occ_aff30_&years. =  T15C_est4;
	occ_aff50_&years. = sum(of T15C_est4 T15C_est25 T15A_est4 T15B_est4);

	Mocc_aff30_&years. =  T15C_moe4;
	Mocc_aff50_&years. = %moe_sum(var= T15C_moe4 T15C_moe25 T15A_moe4 T15B_moe4);

	renter_01br_tot_&years. = sum(of T15C_est6 T15C_est10 T15C_est14 T15C_est18 T15C_est22 T15C_est27 T15C_est31 T15C_est35 T15C_est39 T15C_est43
							T15C_est48 T15C_est52 T15C_est56 T15C_est60 T15C_est64 T15C_est69 T15C_est73 T15C_est77 T15C_est81 T15C_est85);
	renter_2br_tot_&years. = sum(of T15C_est7 T15C_est11 T15C_est15 T15C_est19 T15C_est23 T15C_est28 T15C_est32 T15C_est36 T15C_est40 T15C_est44
							T15C_est49 T15C_est53 T15C_est57 T15C_est61 T15C_est65 T15C_est70 T15C_est74 T15C_est78 T15C_est82 T15C_est86);
	renter_3plusbr_tot_&years. = sum(of T15C_est8 T15C_est12 T15C_est16 T15C_est20 T15C_est24 T15C_est29 T15C_est33 T15C_est37 T15C_est41 T15C_est45
							T15C_est50 T15C_est54 T15C_est58 T15C_est62 T15C_est66 T15C_est71 T15C_est75 T15C_est79 T15C_est83 T15C_est87);
	renter_01br_aff30_&years. = sum(of T15C_est6 T15C_est10 T15C_est14 T15C_est18 T15C_est22);
	renter_2br_aff30_&years. = sum(of T15C_est7 T15C_est11 T15C_est15 T15C_est19 T15C_est23);
	renter_3plusbr_aff30_&years. = sum(of T15C_est8 T15C_est12 T15C_est16 T15C_est20 T15C_est24);
	renter_allbr_aff30_&years. = T15C_est4;
	renter_01br_aff50_&years. = sum(of T15C_est6 T15C_est10 T15C_est14 T15C_est18 T15C_est22 T15C_est27 T15C_est31 T15C_est35 T15C_est39 T15C_est43 );
	renter_2br_aff50_&years. = sum(of T15C_est7 T15C_est11 T15C_est15 T15C_est19 T15C_est23 T15C_est28 T15C_est32 T15C_est36 T15C_est40 T15C_est44);
	renter_3plusbr_aff50_&years. = sum(of T15C_est8 T15C_est12 T15C_est16 T15C_est20 T15C_est24 T15C_est29 T15C_est33 T15C_est37 T15C_est41 T15C_est45);
	renter_allbr_aff50_&years. = sum(of T15C_est4 T15C_est25);

	Mrenter_01br_tot_&years. = %moe_sum(var= T15C_moe6 T15C_moe10 T15C_moe14 T15C_moe18 T15C_moe22 T15C_moe27 T15C_moe31 T15C_moe35
						T15C_moe39 T15C_moe43 T15C_moe48 T15C_moe52 T15C_moe56 T15C_moe60 T15C_moe64 T15C_moe69 T15C_moe73
						T15C_moe77 T15C_moe81 T15C_moe85);
	Mrenter_2br_tot_&years. = %moe_sum(var= T15C_moe7 T15C_moe11 T15C_moe15 T15C_moe19 T15C_moe23 T15C_moe28 T15C_moe32 T15C_moe36 T15C_moe40
						T15C_moe44 T15C_moe49 T15C_moe53 T15C_moe57 T15C_moe61 T15C_moe65 T15C_moe70 T15C_moe74 T15C_moe78
						T15C_moe82 T15C_moe86);
	Mrenter_3plusbr_tot_&years. = %moe_sum(var= T15C_moe8 T15C_moe12 T15C_moe16 T15C_moe20 T15C_moe24 T15C_moe29 T15C_moe33 T15C_moe37 T15C_moe41
						T15C_moe45 T15C_moe50 T15C_moe54 T15C_moe58 T15C_moe62 T15C_moe66 T15C_moe71 T15C_moe75 T15C_moe79
						T15C_moe83 T15C_moe87);
	Mrenter_01br_aff30_&years. = %moe_sum(var= T15C_moe6 T15C_moe10 T15C_moe14 T15C_moe18 T15C_moe22);
	Mrenter_2br_aff30_&years. = %moe_sum(var= T15C_moe7 T15C_moe11 T15C_moe15 T15C_moe19 T15C_moe23);
	Mrenter_3plusbr_aff30_&years. = %moe_sum(var= T15C_moe8 T15C_moe12 T15C_moe16 T15C_moe20 T15C_moe24);
	Mrenter_allbr_aff30_&years. = T15C_moe4;
	Mrenter_01br_aff50_&years. = %moe_sum(var= T15C_moe6 T15C_moe10 T15C_moe14 T15C_moe18 T15C_moe22 T15C_moe27 T15C_moe31 T15C_moe35 T15C_moe39 T15C_moe43 );
	Mrenter_2br_aff50_&years. = %moe_sum(var= T15C_moe7 T15C_moe11 T15C_moe15 T15C_moe19 T15C_moe23 T15C_moe28 T15C_moe32 T15C_moe36 T15C_moe40 T15C_moe44);
	Mrenter_3plusbr_aff50_&years. = %moe_sum(var= T15C_moe8 T15C_moe12 T15C_moe16 T15C_moe20 T15C_moe24 T15C_moe29 T15C_moe33 T15C_moe37 T15C_moe41 T15C_moe45);
	Mrenter_allbr_aff50_&years. = %moe_sum(var= T15C_est4 T15C_est25);

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

	Mowner_01br_tot_&years. = %moe_sum(var= T15A_moe6 T15A_moe10 T15A_moe14 T15A_moe18 T15A_moe22 T15A_moe27 T15A_moe31 T15A_moe35 T15A_moe39 T15A_moe43 
						T15A_moe48 T15A_moe52 T15A_moe56 T15A_moe60 T15A_moe64 T15A_moe69 T15A_moe73 T15A_moe77 T15A_moe81 T15A_moe85
						T15B_moe6 T15B_moe10 T15B_moe14 T15B_moe18 T15B_moe22 T15B_moe27 T15B_moe31 T15B_moe35 T15B_moe39 T15B_moe43 
						T15B_moe48 T15B_moe52 T15B_moe56 T15B_moe60 T15B_moe64 T15B_moe69 T15B_moe73 T15B_moe77 T15B_moe81 T15B_moe85);
	Mowner_2br_tot_&years. = %moe_sum(var= T15A_moe7 T15A_moe11 T15A_moe15 T15A_moe19 T15A_moe23 T15A_moe28 T15A_moe32 T15A_moe36 T15A_moe40 T15A_moe44
						T15A_moe49 T15A_moe53 T15A_moe57 T15A_moe61 T15A_moe65 T15A_moe70 T15A_moe74 T15A_moe78 T15A_moe82 T15A_moe86
						T15B_moe7 T15B_moe11 T15B_moe15 T15B_moe19 T15B_moe23 T15B_moe28 T15B_moe32 T15B_moe36 T15B_moe40 T15B_moe44
						T15B_moe49 T15B_moe53 T15B_moe57 T15B_moe61 T15B_moe65 T15B_moe70 T15B_moe74 T15B_moe78 T15B_moe82 T15B_moe86);
	Mowner_3plusbr_tot_&years. = %moe_sum(var= T15A_moe8 T15A_moe12 T15A_moe16 T15A_moe20 T15A_moe24 T15A_moe29 T15A_moe33 T15A_moe37 T15A_moe41 T15A_moe45
						T15A_moe50 T15A_moe54 T15A_moe58 T15A_moe62 T15A_moe66 T15A_moe71 T15A_moe75 T15A_moe79 T15A_moe83 T15A_moe87
						T15B_moe8 T15B_moe12 T15B_moe16 T15B_moe20 T15B_moe24 T15B_moe29 T15B_moe33 T15B_moe37 T15B_moe41 T15B_moe45
						T15B_moe50 T15B_moe54 T15B_moe58 T15B_moe62 T15B_moe66 T15B_moe71 T15B_moe75 T15B_moe79 T15B_moe83 T15B_moe87);
	Mowner_01br_aff50_&years. = %moe_sum(var= T15A_moe6 T15A_moe10 T15A_moe14 T15A_moe18 T15A_moe22
						T15B_moe6 T15B_moe10 T15B_moe14 T15B_moe18 T15B_moe22);
	Mowner_2br_aff50_&years. = %moe_sum(var= T15A_moe7 T15A_moe11 T15A_moe15 T15A_moe19 T15A_moe23
						T15B_moe7 T15B_moe11 T15B_moe15 T15B_moe19 T15B_moe23);
	Mowner_3plusbr_aff50_&years. = %moe_sum(var= T15A_moe8 T15A_moe12 T15A_moe16 T15A_moe20 T15A_moe24
						T15B_moe8 T15B_moe12 T15B_moe16 T15B_moe20 T15B_moe24);
	Mowner_allbr_aff50_&years. = %moe_sum(var= T15A_moe4 T15B_moe4);
	

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

			Mall_units_tot_&years. = "All housing units (occupied and vacant), MOE, &years_dash."
			Mocc_units_tot_&years. = "All occupied housing units, MOE, &years_dash."
			Mowner_units_tot_&years. = "Owner-occupied housing units, MOE, &years_dash."
			Mforsale_units_tot_&years. = "Vacant housing units for sale, MOE, &years_dash."
			Mown_forsale_units_tot_&years. = "Owner-occupied housing units and vacant housing units for sale, MOE, &years_dash."
			Mrenter_unit_tot_&years. = "Renter-occupied housing units, MOE, &years_dash."
			Mforrent_units_tot_&years. = "Vacant housing units for rent, MOE, &years_dash."
			Mrent_forrent_units_tot_&years. = "Renter-occupied housing units and vacant housing units for rent, MOE, &years_dash."
			Mrental_comb_aff30_&years. = "Renter-occupied and for-rent units affordable at 30% AMI, MOE, &years_dash."
			Mrental_comb_aff50_&years. = "Renter-occupied and for-rent units affordable at 50% AMI, MOE, &years_dash."
			Msales_comb_aff50_&years. = "Owner-occupied and for-rent units affordable at 50% AMI, MOE, &years_dash."
			Mtot_aff30_&years. = "Total units affordable at 30% AMI, MOE, &years_dash."
			Mtot_aff50_&years. = "Total units affordable at 50% AMI, MOE, &years_dash."
			Mrenter_unit_aff30_&years. = "Renter-occupied housing units affordable at 30% AMI, MOE, &years_dash."
			Mforrent_units_aff30_&years. = "Vacant for rent housing units affordable at 30% AMI, MOE, &years_dash."
			Mrenter_unit_aff50_&years. = "Renter-occupied housing units affordable at 50% AMI, MOE, &years_dash."
			Mforrent_units_aff50_&years. = "Vacant for rent housing units affordable at 50% AMI, MOE, &years_dash."
			Mowner_unit_aff50_&years. = "Owner-occupied housing units affordable at 50% AMI, MOE, &years_dash."
			Mforsale_units_aff50_&years. = "Vacant for sale housing units affordable at 50% AMI, MOE, &years_dash."
			Mrenter_01br_tot_&years. = "Renter-occupied 0-1 bedroom housing units, MOE, &years_dash."
			Mrenter_2br_tot_&years. = "Renter-occupied 2 bedroom housing units, MOE, &years_dash."
			Mrenter_3plusbr_tot_&years. = "Renter-occupied 3+ bedroom housing units, MOE, &years_dash."
			Mrenter_01br_aff30_&years. = "Renter-occupied 0-1 bedroom housing units affordable at 30% AMI, MOE, &years_dash."
			Mrenter_2br_aff30_&years. = "Renter-occupied 2 bedroom housing units affordable at 30% AMI, MOE, &years_dash."
			Mrenter_3plusbr_aff30_&years. = "Renter-occupied 3+ bedroom housing units affordable at 30% AMI, MOE, &years_dash."
			Mrenter_allbr_aff30_&years. = "Renter-occupied housing units affordable at 30% AMI, MOE, &years_dash."
			Mrenter_01br_aff50_&years. = "Renter-occupied 0-1 bedroom housing units affordable at 50% AMI, MOE, &years_dash."
			Mrenter_2br_aff50_&years. = "Renter-occupied 2 bedroom housing units affordable at 50% AMI, MOE, &years_dash."
			Mrenter_3plusbr_aff50_&years. = "Renter-occupied 3+ bedroom housing units affordable at 50% AMI, MOE, &years_dash."
			Mrenter_allbr_aff50_&years. = "Renter-occupied housing units affordable at 50% AMI, MOE, &years_dash."
			Mowner_01br_tot_&years. = "Owner-occupied 0-1 bedroom housing units, MOE, &years_dash."
			Mowner_2br_tot_&years. = "Owner-occupied 2 bedroom housing units, MOE, &years_dash."
			Mowner_3plusbr_tot_&years. = "Owner-occupied 3+ bedroom housing units, MOE, &years_dash."
			Mowner_01br_aff50_&years. = "Owner-occupied 0-1 bedroom housing units affordable at 50% AMI, MOE, &years_dash."
			Mowner_2br_aff50_&years. = "Owner-occupied 2 bedroom housing units affordable at 50% AMI, MOE, &years_dash."
			Mowner_3plusbr_aff50_&years. = "Owner-occupied 3+ bedroom housing units affordable at 50% AMI, MOE, &years_dash."
			Mowner_allbr_aff50_&years. = "Owner-occupied housing units affordable at 50% AMI, MOE, &years_dash."
			;

	%Pct_calc( var=Powner_units_tot, label=% Owner-occupied housing units, num=owner_units_tot, den=occ_units_tot, years= &years. );
	%Pct_calc( var=Pforsale_units_tot, label=% Vacant housing units for sale, num=forsale_units_tot, den=own_forsale_units_tot, years= &years. );
	%Pct_calc( var=Prenter_unit_tot, label=% Renter-occupied housing units, num=renter_unit_tot, den=occ_units_tot, years= &years. );
	%Pct_calc( var=Pforrent_units_tot, label=% Vacant housing units for rent, num=forrent_units_tot, den=rent_forrent_units_tot, years= &years. );

    %Moe_prop_a( var=Oowner_units_tot_&years., mult=100, num=owner_units_tot_&years., den=occ_units_tot_&years., 
                       num_moe=Mowner_units_tot_&years., den_moe=Mocc_units_tot_&years., label_moe = % Owner-occupied housing units &years_dash. MOE);
	%Moe_prop_a( var=Oforsale_units_tot_&years., mult=100, num=forsale_units_tot_&years., den=own_forsale_units_tot_&years., 
                       num_moe=Mforsale_units_tot_&years., den_moe=Mown_forsale_units_tot_&years., label_moe =% Vacant housing units for sale  MOE);
	%Moe_prop_a( var=Orenter_unit_tot_&years., mult=100, num=renter_unit_tot_&years., den=occ_units_tot_&years., 
                       num_moe=Mrenter_unit_tot_&years., den_moe=Mocc_units_tot_&years., label_moe =% Renter-occupied housing units  MOE);
	%Moe_prop_a( var=Oforrent_units_tot_&years., mult=100, num=forrent_units_tot_&years., den=rent_forrent_units_tot_&years., 
                       num_moe=Mforrent_units_tot_&years., den_moe=Mrent_forrent_units_tot_&years., label_moe =% Vacant housing units for rent  MOE);

	%Pct_calc( var=Prent_hasplumb, label=% Renter-occupied housing units with kitchen and plumbing, num=rent_hasplumb, den=occ_units_tot, years= &years. );
	%Pct_calc( var=Pown_hasplumb, label=% Owner-occupied housing units with kitchen and plumbing, num=own_hasplumb, den=occ_units_tot, years= &years. );
	
	%Moe_prop_a( var=Orent_hasplumb_&years., mult=100, num=rent_hasplumb_&years., den=occ_units_tot_&years., 
                       num_moe=Mrent_hasplumb_&years., den_moe=Mocc_units_tot_&years., label_moe =  MOE); 
	%Moe_prop_a( var=Oown_hasplumb_&years., mult=100, num=own_hasplumb_&years., den=occ_units_tot_&years., 
                       num_moe=Mown_hasplumb_&years., den_moe=Mocc_units_tot_&years., label_moe =  MOE);

	%Pct_calc( var=Prenter_unit_aff30, label=% Renter-occupied housing units affordable at 30% AMI, num=renter_unit_aff30, den=occ_aff30, years= &years. );
	%Pct_calc( var=Pforrent_units_aff30, label=% For-rent housing units affordable at 30% AMI, num=forrent_units_aff30, den=occ_aff30, years= &years. );

	%Moe_prop_a( var=Orenter_unit_aff30_&years., mult=100, num=renter_unit_aff30_&years., den=occ_aff30_&years., 
                       num_moe=Mrenter_unit_aff30_&years., den_moe=Mocc_aff30_&years., label_moe = % Renter-occupied housing units affordable at 30% AMI MOE);
	%Moe_prop_a( var=Oforrent_units_aff30_&years., mult=100, num=forrent_units_aff30_&years., den=occ_aff30_&years., 
                       num_moe=Mforrent_units_aff30_&years., den_moe=Mocc_aff30_&years., label_moe = % For-rent housing units affordable at 30% AMI MOE);

	%Pct_calc( var=Prenter_unit_aff50, label=% Renter-occupied housing units affordable at 50% AMI, num=renter_unit_aff50, den=occ_aff50, years= &years. );
	%Pct_calc( var=Pforrent_units_aff50, label=% For-rent housing units affordable at 50% AMI, num=forrent_units_aff50, den=occ_aff50, years= &years. );

	%Moe_prop_a( var=Orenter_unit_aff50_&years., mult=100, num=renter_unit_aff50_&years., den=occ_aff50_&years., 
                       num_moe=Mrenter_unit_aff50_&years., den_moe=Mocc_aff50_&years., label_moe = % Renter-occupied housing units affordable at 50% AMI MOE);
	%Moe_prop_a( var=Oforrent_units_aff50_&years., mult=100, num=forrent_units_aff50_&years., den=occ_aff50_&years., 
                       num_moe=Mforrent_units_aff50_&years., den_moe=Mocc_aff50_&years., label_moe = % For-rent housing units affordable at 50% AMI MOE);

	%Pct_calc( var=Powner_unit_aff50, label=% Owner-occupied housing units affordable at 50% AMI, num=owner_unit_aff50, den=occ_aff50, years= &years. );
	%Pct_calc( var=Pforsale_units_aff50, label=% For-sale housing units affordable at 50% AMI, num=forsale_units_aff50, den=occ_aff50, years= &years. );

	%Moe_prop_a( var=Oowner_unit_aff50_&years., mult=100, num=owner_unit_aff50_&years., den=occ_aff50_&years., 
                       num_moe=Mowner_unit_aff50_&years., den_moe=Mocc_aff50_&years., label_moe = % Owner-occupied housing units affordable at 50% AMI MOE);
	%Moe_prop_a( var=Oforsale_units_aff50_&years., mult=100, num=forsale_units_aff50_&years., den=occ_aff50_&years., 
                       num_moe=Mforsale_units_aff50_&years., den_moe=Mocc_aff50_&years., label_moe = % For-sale housing units affordable at 50% AMI MOE);

	%Pct_calc( var=Prenter_01br_tot, label=% Renter-occupied 0-1 bedroom housing units, num=renter_01br_tot, den=rent_hasplumb, years= &years. );
	%Pct_calc( var=Prenter_2br_tot, label=% Renter-occupied 2 bedroom housing units, num=renter_2br_tot, den=rent_hasplumb, years= &years. );
	%Pct_calc( var=Prenter_3plusbr_tot, label=% Renter-occupied 3+ bedroom housing units, num=renter_3plusbr_tot, den=rent_hasplumb, years= &years. );

	%Moe_prop_a( var=Orenter_01br_tot_&years., mult=100, num=renter_unit_tot_&years., den=rent_hasplumb_&years., 
                       num_moe=Mrenter_unit_tot_&years., den_moe=Mrent_hasplumb_&years., label_moe = % Renter-occupied 0-1 bedroom housing units MOE);
	%Moe_prop_a( var=Orenter_2br_tot_&years., mult=100, num=renter_2br_tot_&years., den=rent_hasplumb_&years., 
                       num_moe=Mrenter_2br_tot_&years., den_moe=Mrent_hasplumb_&years., label_moe = % Renter-occupied 2 bedroom housing units MOE);
	%Moe_prop_a( var=Orenter_3plusbr_tot_&years., mult=100, num=renter_3plusbr_tot_&years., den=rent_hasplumb_&years., 
                       num_moe=Mrenter_3plusbr_tot_&years., den_moe=Mrent_hasplumb_&years., label_moe = % Renter-occupied 3+ bedroom housing units MOE);

	%Pct_calc( var=Prenter_01br_aff30, label=% Renter-occupied 0-1 bedroom housing units affordable at 30% AMI, num=renter_01br_aff30, den=renter_unit_aff30, years= &years. );
	%Pct_calc( var=Prenter_2br_aff30, label=% Renter-occupied 2 bedroom housing units affordable at 30% AMI, num=renter_2br_aff30, den=renter_unit_aff30, years= &years. );
	%Pct_calc( var=Prenter_3plusbr_aff30, label=% Renter-occupied 3+ bedroom housing units affordable at 30% AMI, num=renter_3plusbr_aff30, den=renter_unit_aff30, years= &years. );

	%Moe_prop_a( var=Orenter_01br_aff30_&years., mult=100, num=renter_01br_aff30_&years., den=renter_unit_aff30_&years., 
                       num_moe=Mrenter_01br_aff30_&years., den_moe=Mrenter_unit_aff30_&years., label_moe = % Renter-occupied 0-1 bedroom housing units affordable at 30% AMI MOE);
	%Moe_prop_a( var=Orenter_2br_aff30_&years., mult=100, num=renter_2br_aff30_&years., den=renter_unit_aff30_&years., 
                       num_moe=Mrenter_2br_aff30_&years., den_moe=Mrenter_unit_aff30_&years., label_moe = % Renter-occupied 2 bedroom housing units affordable at 30% AMI MOE);
	%Moe_prop_a( var=Orenter_3plusbr_aff30_&years., mult=100, num=renter_3plusbr_aff30_&years., den=renter_unit_aff30_&years., 
                       num_moe=Mrenter_3plusbr_aff30_&years., den_moe=Mrenter_unit_aff30_&years., label_moe = % Renter-occupied 3+ bedroom housing units affordable at 30% AMI MOE);

	%Pct_calc( var=Prenter_01br_aff50, label=% Renter-occupied 0-1 bedroom housing units affordable at 50% AMI, num=renter_01br_aff50, den=renter_unit_aff50, years= &years. );
	%Pct_calc( var=Prenter_2br_aff50, label=% Renter-occupied 2 bedroom housing units affordable at 50% AMI, num=renter_2br_aff50, den=renter_unit_aff50, years= &years. );
	%Pct_calc( var=Prenter_3plusbr_aff50, label=% Renter-occupied 3+ bedroom housing units affordable at 50% AMI, num=renter_3plusbr_aff50, den=renter_unit_aff50, years= &years. );

	%Moe_prop_a( var=Orenter_01br_aff50_&years., mult=100, num=renter_01br_aff50_&years., den=renter_unit_aff50_&years., 
                       num_moe=Mrenter_01br_aff50_&years., den_moe=Mrenter_unit_aff50_&years., label_moe = % Renter-occupied 0-1 bedroom housing units affordable at 50% AMI MOE);
	%Moe_prop_a( var=Orenter_2br_aff50_&years., mult=100, num=renter_2br_aff50_&years., den=renter_unit_aff50_&years., 
                       num_moe=Mrenter_2br_aff50_&years., den_moe=Mrenter_unit_aff50_&years., label_moe = % Renter-occupied 2 bedroom housing units affordable at 50% AMI MOE);
	%Moe_prop_a( var=Orenter_3plusbr_aff50_&years., mult=100, num=renter_3plusbr_aff50_&years., den=renter_unit_aff50_&years., 
                       num_moe=Mrenter_3plusbr_aff50_&years., den_moe=Mrenter_unit_aff50_&years., label_moe = % Renter-occupied 3+ bedroom housing units affordable at 50% AMI MOE);

	%Pct_calc( var=Powner_01br_tot, label=% Owner-occupied 0-1 bedroom housing units, num=owner_01br_tot, den=own_hasplumb, years= &years. );
	%Pct_calc( var=Powner_2br_tot, label=% Owner-occupied 2 bedroom housing units, num=owner_2br_tot, den=own_hasplumb, years= &years. );
	%Pct_calc( var=Powner_3plusbr_tot, label=% Owner-occupied 3+ bedroom housing units, num=owner_3plusbr_tot, den=own_hasplumb, years= &years. );

	%Moe_prop_a( var=Oowner_01br_tot_&years., mult=100, num=owner_01br_tot_&years., den=own_hasplumb_&years., 
                       num_moe=Mowner_01br_tot_&years., den_moe=Mown_hasplumb_&years., label_moe = % Owner-occupied 0-1 bedroom housing units MOE);
	%Moe_prop_a( var=Oowner_2br_tot_&years., mult=100, num=owner_2br_tot_&years., den=own_hasplumb_&years., 
                       num_moe=Mowner_2br_tot_&years., den_moe=Mown_hasplumb_&years., label_moe = % Owner-occupied 2 bedroom housing units MOE);
	%Moe_prop_a( var=Oowner_3plusbr_tot_&years., mult=100, num=owner_3plusbr_tot_&years., den=own_hasplumb_&years., 
                       num_moe=Mowner_3plusbr_tot_&years., den_moe=Mown_hasplumb_&years., label_moe = % Owner-occupied 3+ bedroom housing units MOE);

	%Pct_calc( var=Powner_01br_aff50, label=% Owner-occupied 0-1 bedroom housing units affordable at 50% AMI, num=owner_01br_aff50, den=owner_unit_aff50, years= &years. );
	%Pct_calc( var=Powner_2br_aff50, label=% Owner-occupied 2 bedroom housing units affordable at 50% AMI, num=owner_2br_aff50, den=owner_unit_aff50, years= &years. );
	%Pct_calc( var=Powner_3plusbr_aff50, label=% Owner-occupied 3+ bedroom housing units affordable at 50% AMI, num=owner_3plusbr_aff50, den=owner_unit_aff50, years= &years. );

	%Moe_prop_a( var=Oowner_01br_aff50_&years., mult=100, num=owner_01br_aff50_&years., den=owner_unit_aff50_&years., 
                       num_moe=Mowner_01br_aff50_&years., den_moe=Mowner_unit_aff50_&years., label_moe = % Owner-occupied 0-1 bedroom housing units affordable at 50% AMI MOE);
	%Moe_prop_a( var=Oowner_2br_aff50_&years., mult=100, num=owner_2br_aff50_&years., den=owner_unit_aff50_&years., 
                       num_moe=Mowner_2br_aff50_&years., den_moe=Mowner_unit_aff50_&years., label_moe = % Owner-occupied 2 bedroom housing units affordable at 50% AMI MOE);
	%Moe_prop_a( var=Oowner_3plusbr_aff50_&years., mult=100, num=owner_3plusbr_aff50_&years., den=owner_unit_aff50_&years., 
                       num_moe=Mowner_3plusbr_aff50_&years., den_moe=Mowner_unit_aff50_&years., label_moe = % Owner-occupied 3+ bedroom housing units affordable at 50% AMI MOE);

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

	rnt030_allbr_&years. = sum(of T15C_est5 T15C_est9 T15C_est13 T15C_est17 T15C_est21);
	rnt3050_allbr_&years. = sum(of T15C_est26 T15C_est30 T15C_est34 T15C_est38 T15C_est42);
	rnt5080_allbr_&years. = sum(of T15C_est47 T15C_est51 T15C_est55 T15C_est59 T15C_est63);
	rnt80pl_allbr_&years. = sum(of T15C_est68 T15C_est72 T15C_est76 T15C_est80 T15C_est84);

	rnt030_01br_&years. = sum(of T15C_est6 T15C_est10 T15C_est14 T15C_est18 T15C_est22);
	rnt3050_01br_&years. = sum(of T15C_est27 T15C_est31 T15C_est35 T15C_est39 T15C_est43);
	rnt5080_01br_&years. = sum(of T15C_est48 T15C_est52 T15C_est56 T15C_est60 T15C_est64);
	rnt80pl_01br_&years. = sum(of T15C_est69 T15C_est73 T15C_est77 T15C_est81 T15C_est85);

	rnt030_2br_&years. = sum(of T15C_est7 T15C_est11 T15C_est15 T15C_est19 T15C_est23);
	rnt3050_2br_&years. = sum(of T15C_est28 T15C_est32 T15C_est36 T15C_est40 T15C_est44);
	rnt5080_2br_&years. = sum(of T15C_est49 T15C_est53 T15C_est57 T15C_est61 T15C_est65);
	rnt80pl_2br_&years. = sum(of T15C_est70 T15C_est74 T15C_est78 T15C_est82 T15C_est86);

	rnt030_3br_&years. = sum(of T15C_est8 T15C_est12 T15C_est16 T15C_est20 T15C_est24);
	rnt3050_3br_&years. = sum(of T15C_est29 T15C_est33 T15C_est37 T15C_est41 T15C_est45);
	rnt5080_3br_&years. = sum(of T15C_est50 T15C_est54 T15C_est58 T15C_est62 T15C_est66);
	rnt80pl_3br_&years. = sum(of T15C_est71 T15C_est75 T15C_est79 T15C_est83 T15C_est87);

	Mrnt030_inc030_allbr_&years. = T15C_moe5;
	Mrnt3050_inc030_allbr_&years. = T15C_moe26;
	Mrnt5080_inc030_allbr_&years. = T15C_moe47;
	Mrnt80pl_inc030_allbr_&years. = T15C_moe68;

	Mrnt030_inc3050_allbr_&years. = T15C_moe9;
	Mrnt3050_inc3050_allbr_&years. = T15C_moe30;
	Mrnt5080_inc3050_allbr_&years. = T15C_moe51;
	Mrnt80pl_inc3050_allbr_&years. = T15C_moe72;

	Mrnt030_inc5080_allbr_&years. = T15C_moe13;
	Mrnt3050_inc5080_allbr_&years. = T15C_moe34;
	Mrnt5080_inc5080_allbr_&years. = T15C_moe55;
	Mrnt80pl_inc5080_allbr_&years. = T15C_moe76;

	Mrnt030_inc80100_allbr_&years. = T15C_moe17;
	Mrnt3050_inc80100_allbr_&years. = T15C_moe38;
	Mrnt5080_inc80100_allbr_&years. = T15C_moe59;
	Mrnt80pl_inc80100_allbr_&years. = T15C_moe80;

	Mrnt030_inc100pl_allbr_&years. = T15C_moe21;
	Mrnt3050_inc100pl_allbr_&years. = T15C_moe42;
	Mrnt5080_inc100pl_allbr_&years. = T15C_moe63;
	Mrnt80pl_inc100pl_allbr_&years. = T15C_moe84;

	Mrnt030_inc030_01br_&years. = T15C_moe6;
	Mrnt3050_inc030_01br_&years. = T15C_moe27;
	Mrnt5080_inc030_01br_&years. = T15C_moe48;
	Mrnt80pl_inc030_01br_&years. = T15C_moe69;

	Mrnt030_inc3050_01br_&years. = T15C_moe10;
	Mrnt3050_inc3050_01br_&years. = T15C_moe31;
	Mrnt5080_inc3050_01br_&years. = T15C_moe52;
	Mrnt80pl_inc3050_01br_&years. = T15C_moe73;

	Mrnt030_inc5080_01br_&years. = T15C_moe14;
	Mrnt3050_inc5080_01br_&years. = T15C_moe35;
	Mrnt5080_inc5080_01br_&years. = T15C_moe56;
	Mrnt80pl_inc5080_01br_&years. = T15C_moe77;

	Mrnt030_inc80100_01br_&years. = T15C_moe18;
	Mrnt3050_inc80100_01br_&years. = T15C_moe39;
	Mrnt5080_inc80100_01br_&years. = T15C_moe60;
	Mrnt80pl_inc80100_01br_&years. = T15C_moe81;

	Mrnt030_inc100pl_01br_&years. = T15C_moe22;
	Mrnt3050_inc100pl_01br_&years. = T15C_moe43;
	Mrnt5080_inc100pl_01br_&years. = T15C_moe64;
	Mrnt80pl_inc100pl_01br_&years. = T15C_moe85;

	Mrnt030_inc030_2br_&years. = T15C_moe7;
	Mrnt3050_inc030_2br_&years. = T15C_moe28;
	Mrnt5080_inc030_2br_&years. = T15C_moe49;
	Mrnt80pl_inc030_2br_&years. = T15C_moe70;

	Mrnt030_inc3050_2br_&years. = T15C_moe11;
	Mrnt3050_inc3050_2br_&years. = T15C_moe32;
	Mrnt5080_inc3050_2br_&years. = T15C_moe53;
	Mrnt80pl_inc3050_2br_&years. = T15C_moe74;

	Mrnt030_inc5080_2br_&years. = T15C_moe15;
	Mrnt3050_inc5080_2br_&years. = T15C_moe36;
	Mrnt5080_inc5080_2br_&years. = T15C_moe57;
	Mrnt80pl_inc5080_2br_&years. = T15C_moe78;

	Mrnt030_inc80100_2br_&years. = T15C_moe19;
	Mrnt3050_inc80100_2br_&years. = T15C_moe40;
	Mrnt5080_inc80100_2br_&years. = T15C_moe61;
	Mrnt80pl_inc80100_2br_&years. = T15C_moe82;

	Mrnt030_inc100pl_2br_&years. = T15C_moe23;
	Mrnt3050_inc100pl_2br_&years. = T15C_moe44;
	Mrnt5080_inc100pl_2br_&years. = T15C_moe65;
	Mrnt80pl_inc100pl_2br_&years. = T15C_moe86;

	Mrnt030_inc030_3br_&years. = T15C_moe8;
	Mrnt3050_inc030_3br_&years. = T15C_moe29;
	Mrnt5080_inc030_3br_&years. = T15C_moe50;
	Mrnt80pl_inc030_3br_&years. = T15C_moe71;

	Mrnt030_inc3050_3br_&years. = T15C_moe12;
	Mrnt3050_inc3050_3br_&years. = T15C_moe33;
	Mrnt5080_inc3050_3br_&years. = T15C_moe54;
	Mrnt80pl_inc3050_3br_&years. = T15C_moe75;

	Mrnt030_inc5080_3br_&years. = T15C_moe16;
	Mrnt3050_inc5080_3br_&years. = T15C_moe37;
	Mrnt5080_inc5080_3br_&years. = T15C_moe58;
	Mrnt80pl_inc5080_3br_&years. = T15C_moe79;

	Mrnt030_inc80100_3br_&years. = T15C_moe20;
	Mrnt3050_inc80100_3br_&years. = T15C_moe41;
	Mrnt5080_inc80100_3br_&years. = T15C_moe62;
	Mrnt80pl_inc80100_3br_&years. = T15C_moe83;

	Mrnt030_inc100pl_3br_&years. = T15C_moe24;
	Mrnt3050_inc100pl_3br_&years. = T15C_moe45;
	Mrnt5080_inc100pl_3br_&years. = T15C_moe66;
	Mrnt80pl_inc100pl_3br_&years. = T15C_moe87;

	Minc030_allbr_&years. = %moe_sum(var= T15C_moe5 T15C_moe26 T15C_moe47 T15C_moe68);
	Minc3050_allbr_&years. = %moe_sum(var= T15C_moe9 T15C_moe30 T15C_moe51 T15C_moe72);
	Minc5080_allbr_&years. = %moe_sum(var= T15C_moe13 T15C_moe34 T15C_moe55 T15C_moe76);
	Minc80100_allbr_&years. = %moe_sum(var= T15C_moe17 T15C_moe38 T15C_moe59 T15C_moe80);
	Minc100pl_allbr_&years. = %moe_sum(var= T15C_moe21 T15C_moe42 T15C_moe63 T15C_moe84 );

	Minc030_01br_&years. = %moe_sum(var= T15C_moe6 T15C_moe27 T15C_moe48 T15C_moe69 );
	Minc3050_01br_&years. = %moe_sum(var= T15C_moe10 T15C_moe31 T15C_moe52 T15C_moe73);
	Minc5080_01br_&years. = %moe_sum(var= T15C_moe14 T15C_moe35 T15C_moe56 T15C_moe77);
	Minc80100_01br_&years. = %moe_sum(var= T15C_moe18 T15C_moe39 T15C_moe60 T15C_moe81);
	Minc100pl_01br_&years. = %moe_sum(var= T15C_moe22 T15C_moe43 T15C_moe64 T15C_moe85);

	Minc030_2br_&years. = %moe_sum(var= T15C_moe7 T15C_moe28 T15C_moe49 T15C_moe70);
	Minc3050_2br_&years. = %moe_sum(var= T15C_moe11 T15C_moe32 T15C_moe53 T15C_moe74);
	Minc5080_2br_&years. = %moe_sum(var= T15C_moe15 T15C_moe36 T15C_moe57 T15C_moe78);
	Minc80100_2br_&years. = %moe_sum(var= T15C_moe19 T15C_moe40 T15C_moe61 T15C_moe82);
	Minc100pl_2br_&years. = %moe_sum(var= T15C_moe23 T15C_moe44 T15C_moe65 T15C_moe86);

	Minc030_3br_&years. = %moe_sum(var= T15C_moe8 T15C_moe29 T15C_moe50 T15C_moe71);
	Minc3050_3br_&years. = %moe_sum(var= T15C_moe12 T15C_moe33 T15C_moe54 T15C_moe75);
	Minc5080_3br_&years. = %moe_sum(var= T15C_moe16 T15C_moe37 T15C_moe58 T15C_moe79 );
	Minc80100_3br_&years. = %moe_sum(var= T15C_moe20 T15C_moe41 T15C_moe62 T15C_moe83);
	Minc100pl_3br_&years. = %moe_sum(var= T15C_moe24 T15C_moe45 T15C_moe66 T15C_moe87);

	Mrnt030_allbr_&years. = %moe_sum(var= T15C_moe5 T15C_moe9 T15C_moe13 T15C_moe17 T15C_moe21);
	Mrnt3050_allbr_&years. = %moe_sum(var= T15C_moe26 T15C_moe30 T15C_moe34 T15C_moe38 T15C_moe42);
	Mrnt5080_allbr_&years. = %moe_sum(var= T15C_moe47 T15C_moe51 T15C_moe55 T15C_moe59 T15C_moe63);
	Mrnt80pl_allbr_&years. = %moe_sum(var= T15C_moe68 T15C_moe72 T15C_moe76 T15C_moe80 T15C_moe84);

	Mrnt030_01br_&years. = %moe_sum(var= T15C_moe6 T15C_moe10 T15C_moe14 T15C_moe18 T15C_moe22);
	Mrnt3050_01br_&years. = %moe_sum(var= T15C_moe27 T15C_moe31 T15C_moe35 T15C_moe39 T15C_moe43);
	Mrnt5080_01br_&years. = %moe_sum(var= T15C_moe48 T15C_moe52 T15C_moe56 T15C_moe60 T15C_moe64);
	Mrnt80pl_01br_&years. = %moe_sum(var= T15C_moe69 T15C_moe73 T15C_moe77 T15C_moe81 T15C_moe85);

	Mrnt030_2br_&years. = %moe_sum(var= T15C_moe7 T15C_moe11 T15C_moe15 T15C_moe19 T15C_moe23);
	Mrnt3050_2br_&years. = %moe_sum(var= T15C_moe28 T15C_moe32 T15C_moe36 T15C_moe40 T15C_moe44);
	Mrnt5080_2br_&years. = %moe_sum(var= T15C_moe49 T15C_moe53 T15C_moe57 T15C_moe61 T15C_moe65);
	Mrnt80pl_2br_&years. = %moe_sum(var= T15C_moe70 T15C_moe74 T15C_moe78 T15C_moe82 T15C_moe86);

	Mrnt030_3br_&years. = %moe_sum(var= T15C_moe8 T15C_moe12 T15C_moe16 T15C_moe20 T15C_moe24);
	Mrnt3050_3br_&years. = %moe_sum(var= T15C_moe29 T15C_moe33 T15C_moe37 T15C_moe41 T15C_moe45);
	Mrnt5080_3br_&years. = %moe_sum(var= T15C_moe50 T15C_moe54 T15C_moe58 T15C_moe62 T15C_moe66);
	Mrnt80pl_3br_&years. = %moe_sum(var= T15C_moe71 T15C_moe75 T15C_moe79 T15C_moe83 T15C_moe87);

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
	rnt030_allbr_&years. = "Rent level 0-30%, &years_dash."
	rnt3050_allbr_&years. = "Rent level 30-50%, &years_dash."
	rnt5080_allbr_&years. = "Rent level 50-80%, &years_dash."
	rnt80pl_allbr_&years. = "Rent level 80%+, &years_dash."
	rnt030_01br_&years. = "Rent level 0-30%, 0-1 bedrooms, &years_dash."
	rnt3050_01br_&years. = "Rent level 30-50%, 0-1 bedrooms, &years_dash."
	rnt5080_01br_&years. = "Rent level 50-80%, 0-1 bedrooms, &years_dash."
	rnt80pl_01br_&years. = "Rent level 80%+, 0-1 bedrooms, &years_dash."
	rnt030_2br_&years. = "Rent level 0-30%, 2 bedrooms, &years_dash."
	rnt3050_2br_&years. = "Rent level 30-50%, 2 bedrooms, &years_dash."
	rnt5080_2br_&years. = "Rent level 50-80%, 2 bedrooms, &years_dash."
	rnt80pl_2br_&years. = "Rent level 80%+, 2 bedrooms, &years_dash."
	rnt030_3br_&years. = "Rent level 0-30%, 3+ bedrooms, &years_dash."
	rnt3050_3br_&years. = "Rent level 30-50%, 3+ bedrooms, &years_dash."
	rnt5080_3br_&years. = "Rent level 80%+, 3+ bedrooms, &years_dash."
	rnt80pl_3br_&years. = "Rent level 80%+, 3+ bedrooms, &years_dash."

	Mrnt030_inc030_allbr_&years. = "Rent level 0-30%, household income 0-30%, MOE, &years_dash."
	Mrnt3050_inc030_allbr_&years. = "Rent level 30-50%, household income 0-30%, MOE, &years_dash."
	Mrnt5080_inc030_allbr_&years. = "Rent level 50-80%, household income 0-30%, MOE, &years_dash."
	Mrnt80pl_inc030_allbr_&years. = "Rent level 80%+, household income 0-30%, MOE, &years_dash."
	Mrnt030_inc3050_allbr_&years. = "Rent level 0-30%, household income 30-50%, MOE, &years_dash."
	Mrnt3050_inc3050_allbr_&years. = "Rent level 30-50%, household income 30-50%, MOE, &years_dash."
	Mrnt5080_inc3050_allbr_&years. = "Rent level 50-80%, household income 30-50%, MOE, &years_dash."
	Mrnt80pl_inc3050_allbr_&years. = "Rent level 80%+, household income 30-50%, MOE, &years_dash."
	Mrnt030_inc5080_allbr_&years. = "Rent level 0-30%, household income 50-80%, MOE, &years_dash."
	Mrnt3050_inc5080_allbr_&years. = "Rent level 30-50%, household income 50-80%, MOE, &years_dash."
	Mrnt5080_inc5080_allbr_&years. = "Rent level 50-80%, household income 50-80%, MOE, &years_dash."
	Mrnt80pl_inc5080_allbr_&years. = "Rent level 80%+, household income 50-80%, MOE, &years_dash."
	Mrnt030_inc80100_allbr_&years. = "Rent level 0-30%, household income 80-100%, MOE, &years_dash."
	Mrnt3050_inc80100_allbr_&years. = "Rent level 30-50%, household income 80-100%, MOE, &years_dash."
	Mrnt5080_inc80100_allbr_&years. = "Rent level 50-80%, household income 80-100%, MOE, &years_dash."
	Mrnt80pl_inc80100_allbr_&years. = "Rent level 80%+, household income 80-100%, MOE, &years_dash."
	Mrnt030_inc100pl_allbr_&years. = "Rent level 0-30%, household income 100%+, MOE, &years_dash."
	Mrnt3050_inc100pl_allbr_&years. = "Rent level 30-50%, household income 100%+, MOE, &years_dash."
	Mrnt5080_inc100pl_allbr_&years. = "Rent level 50-80%, household income 100%+, MOE, &years_dash."
	Mrnt80pl_inc100pl_allbr_&years. = "Rent level 80%+, household income 100%+, MOE, &years_dash."
	Mrnt030_inc030_01br_&years. = "Rent level 0-30%, household income 0-30%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt3050_inc030_01br_&years. = "Rent level 30-50%, household income 0-30%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt5080_inc030_01br_&years. = "Rent level 50-80%, household income 0-30%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt80pl_inc030_01br_&years. = "Rent level 80%+, household income 0-30%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt030_inc3050_01br_&years. = "Rent level 0-30%, household income 30-50%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt3050_inc3050_01br_&years. = "Rent level 30-50%, household income 30-50%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt5080_inc3050_01br_&years. = "Rent level 50-80%, household income 30-50%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt80pl_inc3050_01br_&years. = "Rent level 80%+, household income 30-50%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt030_inc5080_01br_&years. = "Rent level 0-30%, household income 50-80%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt3050_inc5080_01br_&years. = "Rent level 30-50%, household income 50-80%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt5080_inc5080_01br_&years. = "Rent level 50-80%, household income 50-80%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt80pl_inc5080_01br_&years. = "Rent level 80%+, household income 50-80%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt030_inc80100_01br_&years. = "Rent level 0-30%, household income 80-100%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt3050_inc80100_01br_&years. = "Rent level 30-50%, household income 80-100%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt5080_inc80100_01br_&years. = "Rent level 50-80%, household income 80-100%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt80pl_inc80100_01br_&years. = "Rent level 80%+, household income 80-100%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt030_inc100pl_01br_&years. = "Rent level 0-30%, household income 100%+, 0-1 bedrooms, MOE, &years_dash."
	Mrnt3050_inc100pl_01br_&years. = "Rent level 30-50%, household income 100%+, 0-1 bedrooms, MOE, &years_dash."
	Mrnt5080_inc100pl_01br_&years. = "Rent level 50-80%, household income 100%+, 0-1 bedrooms, MOE, &years_dash."
	Mrnt80pl_inc100pl_01br_&years. = "Rent level 80%+, household income 100%+, 0-1 bedrooms, MOE, &years_dash."
	Mrnt030_inc030_2br_&years. = "Rent level 0-30%, household income 0-30%, 2 bedrooms, MOE, &years_dash."
	Mrnt3050_inc030_2br_&years. = "Rent level 30-50%, household income 0-30%, 2 bedrooms, MOE, &years_dash."
	Mrnt5080_inc030_2br_&years. = "Rent level 50-80%, household income 0-30%, 2 bedrooms, MOE, &years_dash."
	Mrnt80pl_inc030_2br_&years. = "Rent level 80%+, household income 0-30%, 2 bedrooms, MOE, &years_dash."
	Mrnt030_inc3050_2br_&years. = "Rent level 0-30%, household income 30-50%, 2 bedrooms, MOE, &years_dash."
	Mrnt3050_inc3050_2br_&years. = "Rent level 30-50%, household income 30-50%, 2 bedrooms, MOE, &years_dash."
	Mrnt5080_inc3050_2br_&years. = "Rent level 50-80%, household income 30-50%, 2 bedrooms, MOE, &years_dash."
	Mrnt80pl_inc3050_2br_&years. = "Rent level 80%+, household income 30-50%, 2 bedrooms, MOE, &years_dash."
	Mrnt030_inc5080_2br_&years. = "Rent level 0-30%, household income 50-80%, 2 bedrooms, MOE, &years_dash."
	Mrnt3050_inc5080_2br_&years. = "Rent level 30-50%, household income 50-80%, 2 bedrooms, MOE, &years_dash."
	Mrnt5080_inc5080_2br_&years. = "Rent level 50-80%, household income 50-80%, 2 bedrooms, MOE, &years_dash."
	Mrnt80pl_inc5080_2br_&years. = "Rent level 80%+, household income 50-80%, 2 bedrooms, MOE, &years_dash."
	Mrnt030_inc80100_2br_&years. = "Rent level 0-30%, household income 80-100%, 2 bedrooms, MOE, &years_dash."
	Mrnt3050_inc80100_2br_&years. = "Rent level 30-50%, household income 80-100%, 2 bedrooms, MOE, &years_dash."
	Mrnt5080_inc80100_2br_&years. = "Rent level 50-80%, household income 80-100%, 2 bedrooms, MOE, &years_dash."
	Mrnt80pl_inc80100_2br_&years. = "Rent level 80%+, household income 80-100%, 2 bedrooms, MOE, &years_dash."
	Mrnt030_inc100pl_2br_&years. = "Rent level 0-30%, household income 100%+, 3+ bedrooms, MOE, &years_dash."
	Mrnt3050_inc100pl_2br_&years. = "Rent level 30-50%, household income 100%+, 3+ bedrooms, MOE, &years_dash."
	Mrnt5080_inc100pl_2br_&years. = "Rent level 50-80%, household income 100%+, 3+ bedrooms, MOE, &years_dash."
	Mrnt80pl_inc100pl_2br_&years. = "Rent level 80%+, household income 100%+, 3+ bedrooms, MOE, &years_dash."
	Mrnt030_inc030_3br_&years. = "Rent level 0-30%, household income 0-30%, 3+ bedrooms, MOE, &years_dash."
	Mrnt3050_inc030_3br_&years. = "Rent level 30-50%, household income 0-30%, 3+ bedrooms, MOE, &years_dash."
	Mrnt5080_inc030_3br_&years. = "Rent level 50-80%, household income 0-30%, 3+ bedrooms, MOE, &years_dash."
	Mrnt80pl_inc030_3br_&years. = "Rent level 80%+, household income 0-30%, 3+ bedrooms, MOE, &years_dash."
	Mrnt030_inc3050_3br_&years. = "Rent level 0-30%, household income 30-50%, 3+ bedrooms, MOE, &years_dash."
	Mrnt3050_inc3050_3br_&years. = "Rent level 30-50%, household income 30-50%, 3+ bedrooms, MOE, &years_dash."
	Mrnt5080_inc3050_3br_&years. = "Rent level 50-80%, household income 30-50%, 3+ bedrooms, MOE, &years_dash."
	Mrnt80pl_inc3050_3br_&years. = "Rent level 80%+, household income 30-50%, 3+ bedrooms, MOE, &years_dash."
	Mrnt030_inc5080_3br_&years. = "Rent level 0-30%, household income 50-80%, 3+ bedrooms, MOE, &years_dash."
	Mrnt3050_inc5080_3br_&years. ="Rent level 30-50%, household income 50-80%, 3+ bedrooms, MOE, &years_dash."
	Mrnt5080_inc5080_3br_&years. = "Rent level 50-80%, household income 50-80%, 3+ bedrooms, MOE, &years_dash."
	Mrnt80pl_inc5080_3br_&years. = "Rent level 80%+, household income 50-80%, 3+ bedrooms, MOE, &years_dash."
	Mrnt030_inc80100_3br_&years. = "Rent level 0-30%, household income 80-100%, 3+ bedrooms, MOE, &years_dash."
	Mrnt3050_inc80100_3br_&years. = "Rent level 30-50%, household income 80-100%, 3+ bedrooms, MOE, &years_dash."
	Mrnt5080_inc80100_3br_&years. = "Rent level 50-80%, household income 80-100%, 3+ bedrooms, MOE, &years_dash."
	Mrnt80pl_inc80100_3br_&years. = "Rent level 80%+, household income 80-100%, 3+ bedrooms, MOE, &years_dash."
	Mrnt030_inc100pl_3br_&years. = "Rent level 0-30%, household income 100%+, 3+ bedrooms, MOE, &years_dash."
	Mrnt3050_inc100pl_3br_&years. = "Rent level 30-50%, household income 100%+, 3+ bedrooms, MOE, &years_dash."
	Mrnt5080_inc100pl_3br_&years. = "Rent level 50-80%, household income 100%+, 3+ bedrooms, MOE, &years_dash."
	Mrnt80pl_inc100pl_3br_&years. = "Rent level 80%+, household income 100%+, 3+ bedrooms, MOE, &years_dash."
	Minc030_allbr_&years. = "Renter household income 0-30%, MOE, &years_dash."
	Minc3050_allbr_&years. = "Renter household income 30-50%, MOE, &years_dash."
	Minc5080_allbr_&years. = "Renter household income 50-80%, MOE, &years_dash."
	Minc80100_allbr_&years. = "Renter household income 80-100%, MOE, &years_dash."
	Minc100pl_allbr_&years. = "Renter household income 100%+, MOE, &years_dash."
	Minc030_01br_&years. = "Renter household income 0-30%, 0-1 bedrooms, MOE, &years_dash."
	Minc3050_01br_&years. = "Renter household income 30-50%, 0-1 bedrooms, MOE, &years_dash."
	Minc5080_01br_&years. = "Renter household income 50-80%, 0-1 bedrooms, MOE, &years_dash."
	Minc80100_01br_&years. = "Renter household income 80-100%, 0-1 bedrooms, MOE, &years_dash."
	Minc100pl_01br_&years. = "Renter household income 100%+, 0-1 bedrooms, MOE, &years_dash."
	Minc030_2br_&years. = "Renter household income 0-30%, 2 bedrooms, MOE, &years_dash."
	Minc3050_2br_&years. = "Renter household income 30-50%, 2 bedrooms, MOE, &years_dash."
	Minc5080_2br_&years. = "Renter household income 50-80%, 2 bedrooms, MOE, &years_dash."
	Minc80100_2br_&years. = "Renter household income 80-100%, 2 bedrooms, MOE, &years_dash."
	Minc100pl_2br_&years. = "Renter household income 100%+, 2 bedrooms, MOE, &years_dash."
	Minc030_3br_&years. = "Renter household income 0-30%, 3+ bedrooms, MOE, &years_dash."
	Minc3050_3br_&years. = "Renter household income 30-50%, 3+ bedrooms, MOE, &years_dash."
	Minc5080_3br_&years. = "Renter household income 50-80%, 3+ bedrooms, MOE, &years_dash."
	Minc80100_3br_&years. = "Renter household income 80-100%, 3+ bedrooms, MOE, &years_dash."
	Minc100pl_3br_&years. = "Renter household income 100%+, 3+ bedrooms, MOE, &years_dash."
	Mrnt030_allbr_&years. = "Rent level 0-30%, MOE, &years_dash."
	Mrnt3050_allbr_&years. = "Rent level 30-50%, MOE, &years_dash."
	Mrnt5080_allbr_&years. = "Rent level 50-80%, MOE, &years_dash."
	Mrnt80pl_allbr_&years. = "Rent level 80%+, MOE, &years_dash."
	Mrnt030_01br_&years. = "Rent level 0-30%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt3050_01br_&years. = "Rent level 30-50%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt5080_01br_&years. = "Rent level 50-80%, 0-1 bedrooms, MOE, &years_dash."
	Mrnt80pl_01br_&years. = "Rent level 80%+, 0-1 bedrooms, MOE, &years_dash."
	Mrnt030_2br_&years. = "Rent level 0-30%, 2 bedrooms, MOE, &years_dash."
	Mrnt3050_2br_&years. = "Rent level 30-50%, 2 bedrooms, MOE, &years_dash."
	Mrnt5080_2br_&years. = "Rent level 50-80%, 2 bedrooms, MOE, &years_dash."
	Mrnt80pl_2br_&years. = "Rent level 80%+, 2 bedrooms, MOE, &years_dash."
	Mrnt030_3br_&years. = "Rent level 0-30%, 3+ bedrooms, MOE, &years_dash."
	Mrnt3050_3br_&years. = "Rent level 30-50%, 3+ bedrooms, MOE, &years_dash."
	Mrnt5080_3br_&years. = "Rent level 80%+, 3+ bedrooms, MOE, &years_dash."
	Mrnt80pl_3br_&years. = "Rent level 80%+, 3+ bedrooms, MOE, &years_dash."
	;

	%Pct_calc( var=Prnt030_allbr, label=% renter households with rent level 0-30%, num=rnt030_allbr, den=rent_hasplumb, years= &years. );
	%Pct_calc( var=Prnt3050_allbr, label=% renter households with rent level 30-50%, num=rnt3050_allbr, den=rent_hasplumb, years= &years. );
	%Pct_calc( var=Prnt5080_allbr, label=% renter households with rent level 50-80%, num=rnt5080_allbr, den=rent_hasplumb, years= &years. );
	%Pct_calc( var=Prnt80pl_allbr, label=% renter households with rent level 80%+, num=rnt80pl_allbr, den=rent_hasplumb, years= &years. );

	%Moe_prop_a( var=Ornt030_allbr_&years., mult=100, num=rnt030_allbr_&years., den=rent_hasplumb_&years., 
                       num_moe=Mrnt030_allbr_&years., den_moe=Mrent_hasplumb_&years., label_moe = % renter households with rent level 0-30% MOE);
	%Moe_prop_a( var=Ornt3050_allbr_&years., mult=100, num=rnt3050_allbr_&years., den=rent_hasplumb_&years., 
                       num_moe=Mrnt3050_allbr_&years., den_moe=Mrent_hasplumb_&years., label_moe = % renter households with rent level 30-50% MOE);
	%Moe_prop_a( var=Ornt5080_allbr_&years., mult=100, num=rnt5080_allbr_&years., den=rent_hasplumb_&years., 
                       num_moe=Mrnt5080_allbr_&years., den_moe=Mrent_hasplumb_&years., label_moe = % renter households with rent level 50-80% MOE);
	%Moe_prop_a( var=Ornt80pl_allbr_&years., mult=100, num=rnt80pl_allbr_&years., den=rent_hasplumb_&years., 
                       num_moe=Mrnt80pl_allbr_&years., den_moe=Mrent_hasplumb_&years., label_moe = % renter households with rent level 80%+ MOE);

	%Pct_calc( var=Prnt030_inc030_allbr, label=% renter households with rent level 0-30% household income 0-30%, num=rnt030_inc030_allbr, den=inc030_allbr, years= &years. );
	%Pct_calc( var=Prnt3050_inc030_allbr, label=% renter households with rent level 30-50% household income 0-30%, num=rnt3050_inc030_allbr, den=inc030_allbr, years= &years. );
	%Pct_calc( var=Prnt5080_inc030_allbr, label=% renter households with rent level 50-80% household income 0-30%, num=rnt5080_inc030_allbr, den=inc030_allbr, years= &years. );
	%Pct_calc( var=Prnt80pl_inc030_allbr, label=% renter households with rent level 80%+ household income 0-30%, num=rnt80pl_inc030_allbr, den=inc030_allbr, years= &years. );

	%Moe_prop_a( var=Ornt030_inc030_allbr_&years., mult=100, num=rnt030_inc030_allbr_&years., den=inc030_allbr_&years., 
                       num_moe=Mrnt030_inc030_allbr_&years., den_moe=Minc030_allbr_&years., label_moe = % renter households with rent level 0-30% household income 0-30% MOE);
	%Moe_prop_a( var=Ornt3050_inc030_allbr_&years., mult=100, num=rnt3050_inc030_allbr_&years., den=inc030_allbr_&years., 
                       num_moe=Mrnt3050_inc030_allbr_&years., den_moe=Minc030_allbr_&years., label_moe = % renter households with rent level 30-50% household income 0-30% MOE);
	 %Moe_prop_a( var=Ornt5080_inc030_allbr_&years., mult=100, num=rnt5080_inc030_allbr_&years., den=inc030_allbr_&years., 
                       num_moe=Mrnt5080_inc030_allbr_&years., den_moe=Minc030_allbr_&years., label_moe = % renter households with rent level 50-80% household income 0-30% MOE);
	%Moe_prop_a( var=Ornt80pl_inc030_allbr_&years., mult=100, num=rnt80pl_inc030_allbr_&years., den=inc030_allbr_&years., 
                       num_moe=Mrnt80pl_inc030_allbr_&years., den_moe=Minc030_allbr_&years., label_moe = % renter households with rent level 80%+ household income 0-30% MOE);

	
	%Pct_calc( var=Prnt030_inc3050_allbr, label=% renter households with rent level 0-30% household income 30-50%, num=rnt030_inc3050_allbr, den=inc3050_allbr, years= &years. );
	%Pct_calc( var=Prnt3050_inc3050_allbr, label=% renter households with rent level 30-50% household income 30-50%, num=rnt3050_inc3050_allbr, den=inc3050_allbr, years= &years. );
	%Pct_calc( var=Prnt5080_inc3050_allbr, label=% renter households with rent level 50-80% household income 30-50%, num=rnt5080_inc3050_allbr, den=inc3050_allbr, years= &years. );
	%Pct_calc( var=Prnt80pl_inc3050_allbr, label=% renter households with rent level 80%+ household income 30-50%, num=rnt80pl_inc3050_allbr, den=inc3050_allbr, years= &years. );

	%Moe_prop_a( var=Ornt030_inc3050_allbr_&years., mult=100, num=rnt030_inc3050_allbr_&years., den=inc3050_allbr_&years., 
                       num_moe=Mrnt030_inc3050_allbr_&years., den_moe=Minc3050_allbr_&years., label_moe = % renter households with rent level 0-30% household income 30-50% MOE);
	%Moe_prop_a( var=Ornt3050_inc3050_allbr_&years., mult=100, num=rnt3050_inc3050_allbr_&years., den=inc3050_allbr_&years., 
                       num_moe=Mrnt3050_inc3050_allbr_&years., den_moe=Minc3050_allbr_&years., label_moe = % renter households with rent level 30-50% household income 30-50% MOE);
	 %Moe_prop_a( var=Ornt5080_inc3050_allbr_&years., mult=100, num=rnt5080_inc3050_allbr_&years., den=inc3050_allbr_&years., 
                       num_moe=Mrnt5080_inc3050_allbr_&years., den_moe=Minc3050_allbr_&years., label_moe = % renter households with rent level 50-80% household income 30-50% MOE);
	%Moe_prop_a( var=Ornt80pl_inc3050_allbr_&years., mult=100, num=rnt80pl_inc3050_allbr_&years., den=inc3050_allbr_&years., 
                       num_moe=Mrnt80pl_inc3050_allbr_&years., den_moe=Minc3050_allbr_&years., label_moe = % renter households with rent level 80%+ household income 30-50% MOE);

	%Pct_calc( var=Prnt030_inc5080_allbr, label=% renter households with rent level 0-30% household income 50-80%, num=rnt030_inc5080_allbr, den=inc5080_allbr, years= &years. );
	%Pct_calc( var=Prnt3050_inc5080_allbr, label=% renter households with rent level 30-50% household income 50-80%, num=rnt3050_inc5080_allbr, den=inc5080_allbr, years= &years. );
	%Pct_calc( var=Prnt5080_inc5080_allbr, label=% renter households with rent level 50-80% household income 50-80%, num=rnt5080_inc5080_allbr, den=inc5080_allbr, years= &years. );
	%Pct_calc( var=Prnt80pl_inc5080_allbr, label=% renter households with rent level 80%+ household income 50-80%, num=rnt80pl_inc5080_allbr, den=inc5080_allbr, years= &years. );

	%Moe_prop_a( var=Ornt030_inc5080_allbr_&years., mult=100, num=rnt030_inc5080_allbr_&years., den=inc5080_allbr_&years., 
                       num_moe=Mrnt030_inc5080_allbr_&years., den_moe=Minc5080_allbr_&years., label_moe = % renter households with rent level 0-30% household income 50-80% MOE);
	%Moe_prop_a( var=Ornt3050_inc5080_allbr_&years., mult=100, num=rnt3050_inc5080_allbr_&years., den=inc5080_allbr_&years., 
                       num_moe=Mrnt3050_inc5080_allbr_&years., den_moe=Minc5080_allbr_&years., label_moe = % renter households with rent level 30-50% household income 50-80% MOE);
	 %Moe_prop_a( var=Ornt5080_inc5080_allbr_&years., mult=100, num=rnt5080_inc5080_allbr_&years., den=inc5080_allbr_&years., 
                       num_moe=Mrnt5080_inc5080_allbr_&years., den_moe=Minc5080_allbr_&years., label_moe = % renter households with rent level 50-80% household income 50-80% MOE);
	%Moe_prop_a( var=Ornt80pl_inc5080_allbr_&years., mult=100, num=rnt80pl_inc5080_allbr_&years., den=inc5080_allbr_&years., 
                       num_moe=Mrnt80pl_inc5080_allbr_&years., den_moe=Minc5080_allbr_&years., label_moe = % renter households with rent level 80%+ household income 50-80% MOE);

	%Pct_calc( var=Prnt030_inc80100_allbr, label=% renter households with rent level 0-30% household income 80-100%, num=rnt030_inc80100_allbr, den=inc80100_allbr, years= &years. );
	%Pct_calc( var=Prnt3050_inc80100_allbr, label=% renter households with rent level 30-50% household income 80-100%, num=rnt3050_inc80100_allbr, den=inc80100_allbr, years= &years. );
	%Pct_calc( var=Prnt5080_inc80100_allbr, label=% renter households with rent level 50-80% household income 80-100%, num=rnt5080_inc80100_allbr, den=inc80100_allbr, years= &years. );
	%Pct_calc( var=Prnt80pl_inc80100_allbr, label=% renter households with rent level 80%+ household income 80-100%, num=rnt80pl_inc80100_allbr, den=inc80100_allbr, years= &years. );

	%Moe_prop_a( var=Ornt030_inc80100_allbr_&years., mult=100, num=rnt030_inc80100_allbr_&years., den=inc80100_allbr_&years., 
                       num_moe=Mrnt030_inc80100_allbr_&years., den_moe=Minc80100_allbr_&years., label_moe = % renter households with rent level 0-30% household income 80-100% MOE);
	%Moe_prop_a( var=Ornt3050_inc80100_allbr_&years., mult=100, num=rnt3050_inc80100_allbr_&years., den=inc80100_allbr_&years., 
                       num_moe=Mrnt3050_inc80100_allbr_&years., den_moe=Minc80100_allbr_&years., label_moe = % renter households with rent level 30-50% household income 80-100% MOE);
	 %Moe_prop_a( var=Ornt5080_inc80100_allbr_&years., mult=100, num=rnt5080_inc80100_allbr_&years., den=inc80100_allbr_&years., 
                       num_moe=Mrnt5080_inc80100_allbr_&years., den_moe=Minc80100_allbr_&years., label_moe = % renter households with rent level 50-80% household income 80-100% MOE);
	%Moe_prop_a( var=Ornt80pl_inc80100_allbr_&years., mult=100, num=rnt80pl_inc80100_allbr_&years., den=inc80100_allbr_&years., 
                       num_moe=Mrnt80pl_inc80100_allbr_&years., den_moe=Minc80100_allbr_&years., label_moe = % renter households with rent level 80%+ household income 80-100% MOE);

	%Pct_calc( var=Prnt030_inc100pl_allbr, label=% renter households with rent level 0-30% household income 100%+, num=rnt030_inc100pl_allbr, den=inc100pl_allbr, years= &years. );
	%Pct_calc( var=Prnt3050_inc100pl_allbr, label=% renter households with rent level 30-50% household income 100%+, num=rnt3050_inc100pl_allbr, den=inc100pl_allbr, years= &years. );
	%Pct_calc( var=Prnt5080_inc100pl_allbr, label=% renter households with rent level 50-80% household income 100%+, num=rnt5080_inc100pl_allbr, den=inc100pl_allbr, years= &years. );
	%Pct_calc( var=Prnt80pl_inc100pl_allbr, label=% renter households with rent level 80%+ household income 100%+, num=rnt80pl_inc100pl_allbr, den=inc100pl_allbr, years= &years. );

	%Moe_prop_a( var=Ornt030_inc100pl_allbr_&years., mult=100, num=rnt030_inc100pl_allbr_&years., den=inc100pl_allbr_&years., 
                       num_moe=Mrnt030_inc100pl_allbr_&years., den_moe=Minc100pl_allbr_&years., label_moe = % renter households with rent level 0-30% household income 100%+ MOE);
	%Moe_prop_a( var=Ornt3050_inc100pl_allbr_&years., mult=100, num=rnt3050_inc100pl_allbr_&years., den=inc100pl_allbr_&years., 
                       num_moe=Mrnt3050_inc100pl_allbr_&years., den_moe=Minc100pl_allbr_&years., label_moe = % renter households with rent level 30-50% household income 100%+ MOE);
	 %Moe_prop_a( var=Ornt5080_inc100pl_allbr_&years., mult=100, num=rnt5080_inc100pl_allbr_&years., den=inc100pl_allbr_&years., 
                       num_moe=Mrnt5080_inc100pl_allbr_&years., den_moe=Minc100pl_allbr_&years., label_moe = % renter households with rent level 50-80% household income 100%+ MOE);
	%Moe_prop_a( var=Ornt80pl_inc100pl_allbr_&years., mult=100, num=rnt80pl_inc100pl_allbr_&years., den=inc100pl_allbr_&years., 
                       num_moe=Mrnt80pl_inc100pl_allbr_&years., den_moe=Minc100pl_allbr_&years., label_moe = % renter households with rent level 80%+ household income 100%+ MOE);

	%Pct_calc( var=Prnt030_01br, label=% renter households with rent level 0-30% 0-1 bedrooms, num=rnt030_01br, den=renter_01br_tot, years= &years. );
	%Pct_calc( var=Prnt3050_01br, label=% renter households with rent level 30-50% 0-1 bedrooms, num=rnt3050_01br, den=renter_01br_tot, years= &years. );
	%Pct_calc( var=Prnt5080_01br, label=% renter households with rent level 50-80% 0-1 bedrooms, num=rnt5080_01br, den=renter_01br_tot, years= &years. );
	%Pct_calc( var=Prnt80pl_01br, label=% renter households with rent level 80%+ 0-1 bedrooms, num=rnt80pl_01br, den=renter_01br_tot, years= &years. );

	%Moe_prop_a( var=Ornt030_01br_&years., mult=100, num=rnt030_01br_&years., den=renter_01br_tot_&years., 
                       num_moe=Mrnt030_01br_&years., den_moe=Mrenter_01br_tot_&years., label_moe = % renter households with rent level 0-30% 0-1 bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_01br_&years., mult=100, num=rnt3050_01br_&years., den=renter_01br_tot_&years., 
                       num_moe=Mrnt3050_01br_&years., den_moe=Mrenter_01br_tot_&years., label_moe = % renter households with rent level 30-50% 0-1 bedrooms MOE);
	%Moe_prop_a( var=Ornt5080_01br_&years., mult=100, num=rnt5080_01br_&years., den=renter_01br_tot_&years., 
                       num_moe=Mrnt5080_01br_&years., den_moe=Mrenter_01br_tot_&years., label_moe = % renter households with rent level 50-80% 0-1 bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_01br_&years., mult=100, num=rnt80pl_01br_&years., den=renter_01br_tot_&years., 
                       num_moe=Mrnt80pl_01br_&years., den_moe=Mrenter_01br_tot_&years., label_moe = % renter households with rent level 80%+ 0-1 bedrooms MOE);

	%Pct_calc( var=Prnt030_inc030_01br, label=% renter households with rent level 0-30% household income 0-30% 0-1 bedrooms, num=rnt030_inc030_01br, den=inc030_01br, years= &years. );
	%Pct_calc( var=Prnt3050_inc030_01br, label=% renter households with rent level 30-50% household income 0-30% 0-1 bedrooms, num=rnt3050_inc030_01br, den=inc030_01br, years= &years. );
	%Pct_calc( var=Prnt5080_inc030_01br, label=% renter households with rent level 50-80% household income 0-30% 0-1 bedrooms, num=rnt5080_inc030_01br, den=inc030_01br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc030_01br, label=% renter households with rent level 80%+ household income 0-30% 0-1 bedrooms, num=rnt80pl_inc030_01br, den=inc030_01br, years= &years. );

	%Moe_prop_a( var=Ornt030_inc030_01br_&years., mult=100, num=rnt030_inc030_01br_&years., den=inc030_01br_&years., 
                       num_moe=Mrnt030_inc030_01br_&years., den_moe=Minc030_01br_&years., label_moe = % renter households with rent level 0-30% household income 0-30% 0-1 bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_inc030_01br_&years., mult=100, num=rnt3050_inc030_01br_&years., den=inc030_01br_&years., 
                       num_moe=Mrnt3050_inc030_01br_&years., den_moe=Minc030_01br_&years., label_moe = % renter households with rent level 30-50% household income 0-30% 0-1 bedrooms MOE);
	 %Moe_prop_a( var=Ornt5080_inc030_01br_&years., mult=100, num=rnt5080_inc030_01br_&years., den=inc030_01br_&years., 
                       num_moe=Mrnt5080_inc030_01br_&years., den_moe=Minc030_01br_&years., label_moe = % renter households with rent level 50-80% household income 0-30% 0-1 bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_inc030_01br_&years., mult=100, num=rnt80pl_inc030_01br_&years., den=inc030_01br_&years., 
                       num_moe=Mrnt80pl_inc030_01br_&years., den_moe=Minc030_01br_&years., label_moe = % renter households with rent level 80%+ household income 0-30% 0-1 bedrooms MOE);

	%Pct_calc( var=Prnt030_inc3050_01br, label=% renter households with rent level 0-30% household income 30-50% 0-1 bedrooms, num=rnt030_inc3050_01br, den=inc3050_01br, years= &years. );
	%Pct_calc( var=Prnt3050_inc3050_01br, label=% renter households with rent level 30-50% household income 30-50% 0-1 bedrooms, num=rnt3050_inc3050_01br, den=inc3050_01br, years= &years. );
	%Pct_calc( var=Prnt5080_inc3050_01br, label=% renter households with rent level 50-80% household income 30-50% 0-1 bedrooms, num=rnt5080_inc3050_01br, den=inc3050_01br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc3050_01br, label=% renter households with rent level 80%+ household income 30-50% 0-1 bedrooms, num=rnt80pl_inc3050_01br, den=inc3050_01br, years= &years. );

	%Moe_prop_a( var=Ornt030_inc3050_01br_&years., mult=100, num=rnt030_inc3050_01br_&years., den=inc3050_01br_&years., 
                       num_moe=Mrnt030_inc3050_01br_&years., den_moe=Minc3050_01br_&years., label_moe = % renter households with rent level 0-30% household income 30-50% 0-1 bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_inc3050_01br_&years., mult=100, num=rnt3050_inc3050_01br_&years., den=inc3050_01br_&years., 
                       num_moe=Mrnt3050_inc3050_01br_&years., den_moe=Minc3050_01br_&years., label_moe = % renter households with rent level 30-50% household income 30-50% 0-1 bedrooms MOE);
	 %Moe_prop_a( var=Ornt5080_inc3050_01br_&years., mult=100, num=rnt5080_inc3050_01br_&years., den=inc3050_01br_&years., 
                       num_moe=Mrnt5080_inc3050_01br_&years., den_moe=Minc3050_01br_&years., label_moe = % renter households with rent level 50-80% household income 30-50% 0-1 bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_inc3050_01br_&years., mult=100, num=rnt80pl_inc3050_01br_&years., den=inc3050_01br_&years., 
                       num_moe=Mrnt80pl_inc3050_01br_&years., den_moe=Minc3050_01br_&years., label_moe = % renter households with rent level 80%+ household income 30-50% 0-1 bedrooms MOE);

	%Pct_calc( var=Prnt030_inc5080_01br, label=% renter households with rent level 0-30% household income 50-80% 0-1 bedrooms, num=rnt030_inc5080_01br, den=inc5080_01br, years= &years. );
	%Pct_calc( var=Prnt3050_inc5080_01br, label=% renter households with rent level 30-50% household income 50-80% 0-1 bedrooms, num=rnt3050_inc5080_01br, den=inc5080_01br, years= &years. );
	%Pct_calc( var=Prnt5080_inc5080_01br, label=% renter households with rent level 50-80% household income 50-80% 0-1 bedrooms, num=rnt5080_inc5080_01br, den=inc5080_01br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc5080_01br, label=% renter households with rent level 80%+ household income 50-80% 0-1 bedrooms, num=rnt80pl_inc5080_01br, den=inc5080_01br, years= &years. );

	%Moe_prop_a( var=Ornt030_inc5080_01br_&years., mult=100, num=rnt030_inc5080_01br_&years., den=inc5080_01br_&years., 
                       num_moe=Mrnt030_inc5080_01br_&years., den_moe=Minc5080_01br_&years., label_moe = % renter households with rent level 0-30% household income 50-80% 0-1 bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_inc5080_01br_&years., mult=100, num=rnt3050_inc5080_01br_&years., den=inc5080_01br_&years., 
                       num_moe=Mrnt3050_inc5080_01br_&years., den_moe=Minc5080_01br_&years., label_moe = % renter households with rent level 30-50% household income 50-80% 0-1 bedrooms MOE);
	 %Moe_prop_a( var=Ornt5080_inc5080_01br_&years., mult=100, num=rnt5080_inc5080_01br_&years., den=inc5080_01br_&years., 
                       num_moe=Mrnt5080_inc5080_01br_&years., den_moe=Minc5080_01br_&years., label_moe = % renter households with rent level 50-80% household income 50-80% 0-1 bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_inc5080_01br_&years., mult=100, num=rnt80pl_inc5080_01br_&years., den=inc5080_01br_&years., 
                       num_moe=Mrnt80pl_inc5080_01br_&years., den_moe=Minc5080_01br_&years., label_moe = % renter households with rent level 80%+ household income 50-80% 0-1 bedrooms MOE);

	%Pct_calc( var=Prnt030_inc80100_01br, label=% renter households with rent level 0-30% household income 80-100% 0-1 bedrooms, num=rnt030_inc80100_01br, den=inc80100_01br, years= &years. );
	%Pct_calc( var=Prnt3050_inc80100_01br, label=% renter households with rent level 30-50% household income 80-100% 0-1 bedrooms, num=rnt3050_inc80100_01br, den=inc80100_01br, years= &years. );
	%Pct_calc( var=Prnt5080_inc80100_01br, label=% renter households with rent level 50-80% household income 80-100% 0-1 bedrooms, num=rnt5080_inc80100_01br, den=inc80100_01br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc80100_01br, label=% renter households with rent level 80%+ household income 80-100% 0-1 bedrooms, num=rnt80pl_inc80100_01br, den=inc80100_01br, years= &years. );

	%Moe_prop_a( var=Ornt030_inc80100_01br_&years., mult=100, num=rnt030_inc80100_01br_&years., den=inc80100_01br_&years., 
                       num_moe=Mrnt030_inc80100_01br_&years., den_moe=Minc80100_01br_&years., label_moe = % renter households with rent level 0-30% household income 80-100% 0-1 bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_inc80100_01br_&years., mult=100, num=rnt3050_inc80100_01br_&years., den=inc80100_01br_&years., 
                       num_moe=Mrnt3050_inc80100_01br_&years., den_moe=Minc80100_01br_&years., label_moe = % renter households with rent level 30-50% household income 80-100% 0-1 bedrooms MOE);
	 %Moe_prop_a( var=Ornt5080_inc80100_01br_&years., mult=100, num=rnt5080_inc80100_01br_&years., den=inc80100_01br_&years., 
                       num_moe=Mrnt5080_inc80100_01br_&years., den_moe=Minc80100_01br_&years., label_moe = % renter households with rent level 50-80% household income 80-100% 0-1 bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_inc80100_01br_&years., mult=100, num=rnt80pl_inc80100_01br_&years., den=inc80100_01br_&years., 
                       num_moe=Mrnt80pl_inc80100_01br_&years., den_moe=Minc80100_01br_&years., label_moe = % renter households with rent level 80%+ household income 80-100% 0-1 bedrooms MOE);

	%Pct_calc( var=Prnt030_inc100pl_01br, label=% renter households with rent level 0-30% household income 100%+ 0-1 bedrooms, num=rnt030_inc100pl_01br, den=inc100pl_01br, years= &years. );
	%Pct_calc( var=Prnt3050_inc100pl_01br, label=% renter households with rent level 30-50% household income 100%+ 0-1 bedrooms, num=rnt3050_inc100pl_01br, den=inc100pl_01br, years= &years. );
	%Pct_calc( var=Prnt5080_inc100pl_01br, label=% renter households with rent level 50-80% household income 100%+ 0-1 bedrooms, num=rnt5080_inc100pl_01br, den=inc100pl_01br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc100pl_01br, label=% renter households with rent level 80%+ household income 100%+ 0-1 bedrooms, num=rnt80pl_inc100pl_01br, den=inc100pl_01br, years= &years. );

	%Moe_prop_a( var=Ornt030_inc100pl_01br_&years., mult=100, num=rnt030_inc100pl_01br_&years., den=inc100pl_01br_&years., 
                       num_moe=Mrnt030_inc100pl_01br_&years., den_moe=Minc100pl_01br_&years., label_moe = % renter households with rent level 0-30% household income 100%+ 0-1 bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_inc100pl_01br_&years., mult=100, num=rnt3050_inc100pl_01br_&years., den=inc100pl_01br_&years., 
                       num_moe=Mrnt3050_inc100pl_01br_&years., den_moe=Minc100pl_01br_&years., label_moe = % renter households with rent level 30-50% household income 100%+ 0-1 bedrooms MOE);
	 %Moe_prop_a( var=Ornt5080_inc100pl_01br_&years., mult=100, num=rnt5080_inc100pl_01br_&years., den=inc100pl_01br_&years., 
                       num_moe=Mrnt5080_inc100pl_01br_&years., den_moe=Minc100pl_01br_&years., label_moe = % renter households with rent level 50-80% household income 100%+ 0-1 bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_inc100pl_01br_&years., mult=100, num=rnt80pl_inc100pl_01br_&years., den=inc100pl_01br_&years., 
                       num_moe=Mrnt80pl_inc100pl_01br_&years., den_moe=Minc100pl_01br_&years., label_moe = % renter households with rent level 80%+ household income 100%+ 0-1 bedrooms MOE);

	%Pct_calc( var=Prnt030_2br, label=% renter households with rent level 0-30% 2 bedrooms, num=rnt030_2br, den=renter_2br_tot, years= &years. );
	%Pct_calc( var=Prnt3050_2br, label=% renter households with rent level 30-50% 2 bedrooms, num=rnt3050_2br, den=renter_2br_tot, years= &years. );
	%Pct_calc( var=Prnt5080_2br, label=% renter households with rent level 50-80% 2 bedrooms, num=rnt5080_2br, den=renter_2br_tot, years= &years. );
	%Pct_calc( var=Prnt80pl_2br, label=% renter households with rent level 80%+ 2 bedrooms, num=rnt80pl_2br, den=renter_2br_tot, years= &years. );

	%Moe_prop_a( var=Ornt030_2br_&years., mult=100, num=rnt030_2br_&years., den=renter_2br_tot_&years., 
                       num_moe=Mrnt030_2br_&years., den_moe=Mrenter_2br_tot_&years., label_moe = % renter households with rent level 0-30% 2 bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_2br_&years., mult=100, num=rnt3050_2br_&years., den=renter_2br_tot_&years., 
                       num_moe=Mrnt3050_2br_&years., den_moe=Mrenter_2br_tot_&years., label_moe = % renter households with rent level 30-50% 2 bedrooms MOE);
	%Moe_prop_a( var=Ornt5080_2br_&years., mult=100, num=rnt5080_2br_&years., den=renter_2br_tot_&years., 
                       num_moe=Mrnt5080_2br_&years., den_moe=Mrenter_2br_tot_&years., label_moe = % renter households with rent level 50-80% 2 bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_2br_&years., mult=100, num=rnt80pl_2br_&years., den=renter_2br_tot_&years., 
                       num_moe=Mrnt80pl_2br_&years., den_moe=Mrenter_2br_tot_&years., label_moe = % renter households with rent level 80%+ 2 bedrooms MOE);

	%Pct_calc( var=Prnt030_inc030_2br, label=% renter households with rent level 0-30% household income 0-30% 2 bedrooms, num=rnt030_inc030_2br, den=inc030_2br, years= &years. );
	%Pct_calc( var=Prnt3050_inc030_2br, label=% renter households with rent level 30-50% household income 0-30% 2 bedrooms, num=rnt3050_inc030_2br, den=inc030_2br, years= &years. );
	%Pct_calc( var=Prnt5080_inc030_2br, label=% renter households with rent level 50-80% household income 0-30% 2 bedrooms, num=rnt5080_inc030_2br, den=inc030_2br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc030_2br, label=% renter households with rent level 80%+ household income 0-30% 2 bedrooms, num=rnt80pl_inc030_2br, den=inc030_2br, years= &years. );

	%Moe_prop_a( var=Ornt030_inc030_2br_&years., mult=100, num=rnt030_inc030_2br_&years., den=rnt030_inc030_2br_&years., 
                       num_moe=Mrnt030_inc030_2br_&years., den_moe=Mrnt030_inc030_2br_&years., label_moe = % renter households with rent level 0-30% household income 0-30% 2 bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_inc030_2br_&years., mult=100, num=rnt3050_inc030_2br_&years., den=inc030_2br_&years., 
                       num_moe=Mrnt3050_inc030_2br_&years., den_moe=Minc030_2br_&years., label_moe = % renter households with rent level 30-50% household income 0-30% 2 bedrooms MOE);
	 %Moe_prop_a( var=Ornt5080_inc030_2br_&years., mult=100, num=rnt5080_inc030_2br_&years., den=inc030_2br_&years., 
                       num_moe=Mrnt5080_inc030_2br_&years., den_moe=Minc030_2br_&years., label_moe = % renter households with rent level 50-80% household income 0-30% 2 bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_inc030_2br_&years., mult=100, num=rnt80pl_inc030_2br_&years., den=inc030_2br_&years., 
                       num_moe=Mrnt80pl_inc030_2br_&years., den_moe=Minc030_2br_&years., label_moe = % renter households with rent level 80%+ household income 0-30% 2 bedrooms MOE);

	%Pct_calc( var=Prnt030_inc3050_2br, label=% renter households with rent level 0-30% household income 30-50% 2 bedrooms, num=rnt030_inc3050_2br, den=inc3050_2br, years= &years. );
	%Pct_calc( var=Prnt3050_inc3050_2br, label=% renter households with rent level 30-50% household income 30-50% 2 bedrooms, num=rnt3050_inc3050_2br, den=inc3050_2br, years= &years. );
	%Pct_calc( var=Prnt5080_inc3050_2br, label=% renter households with rent level 50-80% household income 30-50% 2 bedrooms, num=rnt5080_inc3050_2br, den=inc3050_2br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc3050_2br, label=% renter households with rent level 80%+ household income 30-50% 2 bedrooms, num=rnt80pl_inc3050_2br, den=inc3050_2br, years= &years. );

	%Moe_prop_a( var=Ornt030_inc3050_2br_&years., mult=100, num=rnt030_inc3050_2br_&years., den=inc3050_2br_&years., 
                       num_moe=Mrnt030_inc3050_2br_&years., den_moe=Minc3050_2br_&years., label_moe = % renter households with rent level 0-30% household income 30-50% 2 bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_inc3050_2br_&years., mult=100, num=rnt3050_inc3050_2br_&years., den=inc3050_2br_&years., 
                       num_moe=Mrnt3050_inc3050_2br_&years., den_moe=Minc3050_2br_&years., label_moe = % renter households with rent level 30-50% household income 30-50% 2 bedrooms MOE);
	 %Moe_prop_a( var=Ornt5080_inc3050_2br_&years., mult=100, num=rnt5080_inc3050_2br_&years., den=inc3050_2br_&years., 
                       num_moe=Mrnt5080_inc3050_2br_&years., den_moe=Minc3050_2br_&years., label_moe = % renter households with rent level 50-80% household income 30-50% 2 bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_inc3050_2br_&years., mult=100, num=rnt80pl_inc3050_2br_&years., den=inc3050_2br_&years., 
                       num_moe=Mrnt80pl_inc3050_2br_&years., den_moe=Minc3050_2br_&years., label_moe = % renter households with rent level 80%+ household income 30-50% 2 bedrooms MOE);

	%Pct_calc( var=Prnt030_inc5080_2br, label=% renter households with rent level 0-30% household income 50-80% 2 bedrooms, num=rnt030_inc5080_2br, den=inc5080_2br, years= &years. );
	%Pct_calc( var=Prnt3050_inc5080_2br, label=% renter households with rent level 30-50% household income 50-80% 2 bedrooms, num=rnt3050_inc5080_2br, den=inc5080_2br, years= &years. );
	%Pct_calc( var=Prnt5080_inc5080_2br, label=% renter households with rent level 50-80% household income 50-80% 2 bedrooms, num=rnt5080_inc5080_2br, den=inc5080_2br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc5080_2br, label=% renter households with rent level 80%+ household income 50-80% 2 bedrooms, num=rnt80pl_inc5080_2br, den=inc5080_2br, years= &years. );

	%Moe_prop_a( var=Ornt030_inc5080_2br_&years., mult=100, num=rnt030_inc5080_2br_&years., den=inc5080_2br_&years., 
                       num_moe=Mrnt030_inc5080_2br_&years., den_moe=Minc5080_2br_&years., label_moe = % renter households with rent level 0-30% household income 50-80% 2 bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_inc5080_2br_&years., mult=100, num=rnt3050_inc5080_2br_&years., den=inc5080_2br_&years., 
                       num_moe=Mrnt3050_inc5080_2br_&years., den_moe=Minc5080_2br_&years., label_moe = % renter households with rent level 30-50% household income 50-80% 2 bedrooms MOE);
	 %Moe_prop_a( var=Ornt5080_inc5080_2br_&years., mult=100, num=rnt5080_inc5080_2br_&years., den=inc5080_2br_&years., 
                       num_moe=Mrnt5080_inc5080_2br_&years., den_moe=Minc5080_2br_&years., label_moe = % renter households with rent level 50-80% household income 50-80% 2 bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_inc5080_2br_&years., mult=100, num=rnt80pl_inc5080_2br_&years., den=inc5080_2br_&years., 
                       num_moe=Mrnt80pl_inc5080_2br_&years., den_moe=Minc5080_2br_&years., label_moe = % renter households with rent level 80%+ household income 50-80% 2 bedrooms MOE);

	%Pct_calc( var=Prnt030_inc80100_2br, label=% renter households with rent level 0-30% household income 80-100% 2 bedrooms, num=rnt030_inc80100_2br, den=inc80100_2br, years= &years. );
	%Pct_calc( var=Prnt3050_inc80100_2br, label=% renter households with rent level 30-50% household income 80-100% 2 bedrooms, num=rnt3050_inc80100_2br, den=inc80100_2br, years= &years. );
	%Pct_calc( var=Prnt5080_inc80100_2br, label=% renter households with rent level 50-80% household income 80-100% 2 bedrooms, num=rnt5080_inc80100_2br, den=inc80100_2br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc80100_2br, label=% renter households with rent level 80%+ household income 80-100% 2 bedrooms, num=rnt80pl_inc80100_2br, den=inc80100_2br, years= &years. );

	%Moe_prop_a( var=Ornt030_inc80100_2br_&years., mult=100, num=rnt030_inc80100_2br_&years., den=inc80100_2br_&years., 
                       num_moe=Mrnt030_inc80100_2br_&years., den_moe=Minc80100_2br_&years., label_moe = % renter households with rent level 0-30% household income 80-100% 2 bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_inc80100_2br_&years., mult=100, num=rnt3050_inc80100_2br_&years., den=inc80100_2br_&years., 
                       num_moe=Mrnt3050_inc80100_2br_&years., den_moe=Minc80100_2br_&years., label_moe = % renter households with rent level 30-50% household income 80-100% 2 bedrooms MOE);
	 %Moe_prop_a( var=Ornt5080_inc80100_2br_&years., mult=100, num=rnt5080_inc80100_2br_&years., den=inc80100_2br_&years., 
                       num_moe=Mrnt5080_inc80100_2br_&years., den_moe=Minc80100_2br_&years., label_moe = % renter households with rent level 50-80% household income 80-100% 2 bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_inc80100_2br_&years., mult=100, num=rnt80pl_inc80100_2br_&years., den=inc80100_2br_&years., 
                       num_moe=Mrnt80pl_inc80100_2br_&years., den_moe=Minc80100_2br_&years., label_moe = % renter households with rent level 80%+ household income 80-100% 2 bedrooms MOE);

	%Pct_calc( var=Prnt030_inc100pl_2br, label=% renter households with rent level 0-30% household income 100%+ 2 bedrooms, num=rnt030_inc100pl_2br, den=inc100pl_2br, years= &years. );
	%Pct_calc( var=Prnt3050_inc100pl_2br, label=% renter households with rent level 30-50% household income 100%+ 2 bedrooms, num=rnt3050_inc100pl_2br, den=inc100pl_2br, years= &years. );
	%Pct_calc( var=Prnt5080_inc100pl_2br, label=% renter households with rent level 50-80% household income 100%+ 2 bedrooms, num=rnt5080_inc100pl_2br, den=inc100pl_2br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc100pl_2br, label=% renter households with rent level 80%+ household income 100%+ 2 bedrooms, num=rnt80pl_inc100pl_2br, den=inc100pl_2br, years= &years. );

	%Moe_prop_a( var=Ornt030_inc100pl_2br_&years., mult=100, num=rnt030_inc100pl_2br_&years., den=inc100pl_2br_&years., 
                       num_moe=Mrnt030_inc100pl_2br_&years., den_moe=Minc100pl_2br_&years., label_moe = % renter households with rent level 0-30% household income 100%+ 2 bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_inc100pl_2br_&years., mult=100, num=rnt3050_inc100pl_2br_&years., den=inc100pl_2br_&years., 
                       num_moe=Mrnt3050_inc100pl_2br_&years., den_moe=Minc100pl_2br_&years., label_moe = % renter households with rent level 30-50% household income 100%+ 2 bedrooms MOE);
	 %Moe_prop_a( var=Ornt5080_inc100pl_2br_&years., mult=100, num=rnt5080_inc100pl_2br_&years., den=inc100pl_2br_&years., 
                       num_moe=Mrnt5080_inc100pl_2br_&years., den_moe=Minc100pl_2br_&years., label_moe = % renter households with rent level 50-80% household income 100%+ 2 bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_inc100pl_2br_&years., mult=100, num=rnt80pl_inc100pl_2br_&years., den=inc100pl_2br_&years., 
                       num_moe=Mrnt80pl_inc100pl_2br_&years., den_moe=Minc100pl_2br_&years., label_moe = % renter households with rent level 80%+ household income 100%+ 2 bedrooms MOE);

	%Pct_calc( var=Prnt030_inc030_3br, label=% renter households with rent level 0-30% household income 0-30% 3+ bedrooms, num=rnt030_inc030_3br, den=inc030_3br, years= &years. );
	%Pct_calc( var=Prnt3050_inc030_3br, label=% renter households with rent level 30-50% household income 0-30% 3+ bedrooms, num=rnt3050_inc030_3br, den=inc030_3br, years= &years. );
	%Pct_calc( var=Prnt5080_inc030_3br, label=% renter households with rent level 50-80% household income 0-30% 3+ bedrooms, num=rnt5080_inc030_3br, den=inc030_3br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc030_3br, label=% renter households with rent level 80%+ household income 0-30% 3+ bedrooms, num=rnt80pl_inc030_3br, den=inc030_3br, years= &years. );

	%Pct_calc( var=Prnt030_3br, label=% renter households with rent level 0-30% 3+ bedrooms, num=rnt030_3br, den=renter_3plusbr_tot, years= &years. );
	%Pct_calc( var=Prnt3050_3br, label=% renter households with rent level 30-50% 3+ bedrooms, num=rnt3050_3br, den=renter_3plusbr_tot, years= &years. );
	%Pct_calc( var=Prnt5080_3br, label=% renter households with rent level 50-80% 3+ bedrooms, num=rnt5080_3br, den=renter_3plusbr_tot, years= &years. );
	%Pct_calc( var=Prnt80pl_3br, label=% renter households with rent level 80%+ 3+ bedrooms, num=rnt80pl_3br, den=renter_3plusbr_tot, years= &years. );

	%Moe_prop_a( var=Ornt030_3br_&years., mult=100, num=rnt030_3br_&years., den=renter_3plusbr_tot_&years., 
                       num_moe=Mrnt030_3br_&years., den_moe=Mrenter_3plusbr_tot_&years., label_moe = % renter households with rent level 0-30% 3+ bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_3br_&years., mult=100, num=rnt3050_3br_&years., den=renter_3plusbr_tot_&years., 
                       num_moe=Mrnt3050_3br_&years., den_moe=Mrenter_3plusbr_tot_&years., label_moe = % renter households with rent level 30-50% 3+ bedrooms MOE);
	%Moe_prop_a( var=Ornt5080_3br_&years., mult=100, num=rnt5080_3br_&years., den=renter_3plusbr_tot_&years., 
                       num_moe=Mrnt5080_3br_&years., den_moe=Mrenter_3plusbr_tot_&years., label_moe = % renter households with rent level 50-80% 3+ bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_3br_&years., mult=100, num=rnt80pl_3br_&years., den=renter_3plusbr_tot_&years., 
                       num_moe=Mrnt80pl_3br_&years., den_moe=Mrenter_3plusbr_tot_&years., label_moe = % renter households with rent level 80%+ 3+ bedrooms MOE);

	%Moe_prop_a( var=Ornt030_inc030_3br_&years., mult=100, num=rnt030_inc030_3br_&years., den=inc030_3br_&years., 
                       num_moe=Mrnt030_inc030_3br_&years., den_moe=Minc030_3br_&years., label_moe = % renter households with rent level 0-30% household income 0-30% 3+ bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_inc030_3br_&years., mult=100, num=rnt3050_inc030_3br_&years., den=inc030_3br_&years., 
                       num_moe=Mrnt3050_inc030_3br_&years., den_moe=Minc030_3br_&years., label_moe = % renter households with rent level 30-50% household income 0-30% 3+ bedrooms MOE);
	 %Moe_prop_a( var=Ornt5080_inc030_3br_&years., mult=100, num=rnt5080_inc030_3br_&years., den=inc030_3br_&years., 
                       num_moe=Mrnt5080_inc030_3br_&years., den_moe=Minc030_3br_&years., label_moe = % renter households with rent level 50-80% household income 0-30% 3+ bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_inc030_3br_&years., mult=100, num=rnt80pl_inc030_3br_&years., den=inc030_3br_&years., 
                       num_moe=Mrnt80pl_inc030_3br_&years., den_moe=Minc030_3br_&years., label_moe = % renter households with rent level 80%+ household income 0-30% 3+ bedrooms MOE);

	%Pct_calc( var=Prnt030_inc3050_3br, label=% renter households with rent level 0-30% household income 30-50% 3+ bedrooms, num=rnt030_inc3050_3br, den=inc3050_3br, years= &years. );
	%Pct_calc( var=Prnt3050_inc3050_3br, label=% renter households with rent level 30-50% household income 30-50% 3+ bedrooms, num=rnt3050_inc3050_3br, den=inc3050_3br, years= &years. );
	%Pct_calc( var=Prnt5080_inc3050_3br, label=% renter households with rent level 50-80% household income 30-50% 3+ bedrooms, num=rnt5080_inc3050_3br, den=inc3050_3br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc3050_3br, label=% renter households with rent level 80%+ household income 30-50% 3+ bedrooms, num=rnt80pl_inc3050_3br, den=inc3050_3br, years= &years. );

	%Moe_prop_a( var=Ornt030_inc3050_3br_&years., mult=100, num=rnt030_inc3050_3br_&years., den=inc3050_3br_&years., 
                       num_moe=Mrnt030_inc3050_3br_&years., den_moe=Minc3050_3br_&years., label_moe = % renter households with rent level 0-30% household income 30-50% 3+ bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_inc3050_3br_&years., mult=100, num=rnt3050_inc3050_3br_&years., den=inc3050_3br_&years., 
                       num_moe=Mrnt3050_inc3050_3br_&years., den_moe=Minc3050_3br_&years., label_moe = % renter households with rent level 30-50% household income 30-50% 3+ bedrooms MOE);
	 %Moe_prop_a( var=Ornt5080_inc3050_3br_&years., mult=100, num=rnt5080_inc3050_3br_&years., den=inc3050_3br_&years., 
                       num_moe=Mrnt5080_inc3050_3br_&years., den_moe=Minc3050_3br_&years., label_moe = % renter households with rent level 50-80% household income 30-50% 3+ bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_inc3050_3br_&years., mult=100, num=rnt80pl_inc3050_3br_&years., den=inc3050_3br_&years., 
                       num_moe=Mrnt80pl_inc3050_3br_&years., den_moe=Minc3050_3br_&years., label_moe = % renter households with rent level 80%+ household income 30-50% 3+ bedrooms MOE);

	%Pct_calc( var=Prnt030_inc5080_3br, label=% renter households with rent level 0-30% household income 50-80% 3+ bedrooms, num=rnt030_inc5080_3br, den=inc5080_3br, years= &years. );
	%Pct_calc( var=Prnt3050_inc5080_3br, label=% renter households with rent level 30-50% household income 50-80% 3+ bedrooms, num=rnt3050_inc5080_3br, den=inc5080_3br, years= &years. );
	%Pct_calc( var=Prnt5080_inc5080_3br, label=% renter households with rent level 50-80% household income 50-80% 3+ bedrooms, num=rnt5080_inc5080_3br, den=inc5080_3br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc5080_3br, label=% renter households with rent level 80%+ household income 50-80% 3+ bedrooms, num=rnt80pl_inc5080_3br, den=inc5080_3br, years= &years. );

	%Moe_prop_a( var=Ornt030_inc5080_3br_&years., mult=100, num=rnt030_inc5080_3br_&years., den=inc5080_3br_&years., 
                       num_moe=Mrnt030_inc5080_3br_&years., den_moe=Minc5080_3br_&years., label_moe = % renter households with rent level 0-30% household income 50-80% 3+ bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_inc5080_3br_&years., mult=100, num=rnt3050_inc5080_3br_&years., den=inc5080_3br_&years., 
                       num_moe=Mrnt3050_inc5080_3br_&years., den_moe=Minc5080_3br_&years., label_moe = % renter households with rent level 30-50% household income 50-80% 3+ bedrooms MOE);
	 %Moe_prop_a( var=Ornt5080_inc5080_3br_&years., mult=100, num=rnt5080_inc5080_3br_&years., den=inc5080_3br_&years., 
                       num_moe=Mrnt5080_inc5080_3br_&years., den_moe=Minc5080_3br_&years., label_moe = % renter households with rent level 50-80% household income 50-80% 3+ bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_inc5080_3br_&years., mult=100, num=rnt80pl_inc5080_3br_&years., den=inc5080_3br_&years., 
                       num_moe=Mrnt80pl_inc5080_3br_&years., den_moe=Minc5080_3br_&years., label_moe = % renter households with rent level 80%+ household income 50-80% 3+ bedrooms MOE);

	%Pct_calc( var=Prnt030_inc80100_3br, label=% renter households with rent level 0-30% household income 80-100% 3+ bedrooms, num=rnt030_inc80100_3br, den=inc80100_3br, years= &years. );
	%Pct_calc( var=Prnt3050_inc80100_3br, label=% renter households with rent level 30-50% household income 80-100% 3+ bedrooms, num=rnt3050_inc80100_3br, den=inc80100_3br, years= &years. );
	%Pct_calc( var=Prnt5080_inc80100_3br, label=% renter households with rent level 50-80% household income 80-100% 3+ bedrooms, num=rnt5080_inc80100_3br, den=inc80100_3br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc80100_3br, label=% renter households with rent level 80%+ household income 80-100% 3+ bedrooms, num=rnt80pl_inc80100_3br, den=inc80100_3br, years= &years. );

	%Moe_prop_a( var=Ornt030_inc80100_3br_&years., mult=100, num=rnt030_inc80100_3br_&years., den=inc80100_3br_&years., 
                       num_moe=Mrnt030_inc80100_3br_&years., den_moe=Minc80100_3br_&years., label_moe = % renter households with rent level 0-30% household income 80-100% 3+ bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_inc80100_3br_&years., mult=100, num=rnt3050_inc80100_3br_&years., den=inc80100_3br_&years., 
                       num_moe=Mrnt3050_inc80100_3br_&years., den_moe=Minc80100_3br_&years., label_moe = % renter households with rent level 30-50% household income 80-100% 3+ bedrooms MOE);
	 %Moe_prop_a( var=Ornt5080_inc80100_3br_&years., mult=100, num=rnt5080_inc80100_3br_&years., den=inc80100_3br_&years., 
                       num_moe=Mrnt5080_inc80100_3br_&years., den_moe=Minc80100_3br_&years., label_moe = % renter households with rent level 50-80% household income 80-100% 3+ bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_inc80100_3br_&years., mult=100, num=rnt80pl_inc80100_3br_&years., den=inc80100_3br_&years., 
                       num_moe=Mrnt80pl_inc80100_3br_&years., den_moe=Minc80100_3br_&years., label_moe = % renter households with rent level 80%+ household income 80-100% 3+ bedrooms MOE);

	%Pct_calc( var=Prnt030_inc100pl_3br, label=% renter households with rent level 0-30% household income 100%+ 3+ bedrooms, num=rnt030_inc100pl_3br, den=inc100pl_3br, years= &years. );
	%Pct_calc( var=Prnt3050_inc100pl_3br, label=% renter households with rent level 30-50% household income 100%+ 3+ bedrooms, num=rnt3050_inc100pl_3br, den=inc100pl_3br, years= &years. );
	%Pct_calc( var=Prnt5080_inc100pl_3br, label=% renter households with rent level 50-80% household income 100%+ 3+ bedrooms, num=rnt5080_inc100pl_3br, den=inc100pl_3br, years= &years. );
	%Pct_calc( var=Prnt80pl_inc100pl_3br, label=% renter households with rent level 80%+ household income 100%+ 3+ bedrooms, num=rnt80pl_inc100pl_3br, den=inc100pl_3br, years= &years. );

	%Moe_prop_a( var=Ornt030_inc100pl_3br_&years., mult=100, num=rnt030_inc100pl_3br_&years., den=inc100pl_3br_&years., 
                       num_moe=Mrnt030_inc100pl_3br_&years., den_moe=Minc100pl_3br_&years., label_moe = % renter households with rent level 0-30% household income 100%+ 3+ bedrooms MOE);
	%Moe_prop_a( var=Ornt3050_inc100pl_3br_&years., mult=100, num=rnt3050_inc100pl_3br_&years., den=inc100pl_3br_&years., 
                       num_moe=Mrnt3050_inc100pl_3br_&years., den_moe=Minc100pl_3br_&years., label_moe = % renter households with rent level 30-50% household income 100%+ 3+ bedrooms MOE);
	 %Moe_prop_a( var=Ornt5080_inc100pl_3br_&years., mult=100, num=rnt5080_inc100pl_3br_&years., den=inc100pl_3br_&years., 
                       num_moe=Mrnt5080_inc100pl_3br_&years., den_moe=Minc100pl_3br_&years., label_moe = % renter households with rent level 50-80% household income 100%+ 3+ bedrooms MOE);
	%Moe_prop_a( var=Ornt80pl_inc100pl_3br_&years., mult=100, num=rnt80pl_inc100pl_3br_&years., den=inc100pl_3br_&years., 
                       num_moe=Mrnt80pl_inc100pl_3br_&years., den_moe=Minc100pl_3br_&years., label_moe = % renter households with rent level 80%+ household income 100%+ 3+ bedrooms MOE);

	/* Demand - Affordability */
	renter_cb_&years. = sum(of T8_est73 T8_est76  T8_est89 T8_est99 T8_est102 T8_est112 T8_est115 T8_est125 T8_est128);
	renter_scb_&years. = sum(of T8_est76 T8_est89 T8_est102 T8_est115 T8_est128);
	renter_ncb_&years. = sum(of T8_est79 T8_est92 T8_est105 T8_est118 T8_est131);
	renter_nop_&years. = sum(of T16_est91 T16_est95 T16_est99 T16_est103 T16_est107 T16_est112 T16_est116 T16_est120 T16_est124
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

	renter_030_eldfam_&years. = T16_est89 ;
	renter_030_smfam_&years. = T16_est93 ;
	renter_030_lgfam_&years. = T16_est97 ;
	renter_030_eldnf_&years. = T16_est101 ;
	renter_030_othhh_&years. = T16_est105 ;

	renter_030_eldfam_cb_&years. = sum(of T7_est137 T7_est138 );
	renter_030_smfam_cb_&years. = sum(of T7_est142 T7_est143 );
	renter_030_lgfam_cb_&years. = sum(of T7_est147 T7_est148 );
	renter_030_eldnf_cb_&years. = sum(of T7_est152 T7_est153 );
	renter_030_othhh_cb_&years. = sum(of T7_est157 T7_est158);

	renter_030_eldfam_scb_&years. = T7_est138;
	renter_030_smfam_scb_&years. = T7_est143 ;
	renter_030_lgfam_scb_&years. = T7_est148 ;
	renter_030_eldnf_scb_&years. = T7_est153 ;
	renter_030_othhh_scb_&years. = T7_est158 ;

	renter_030_eldfam_nop_&years. = T16_est91 ;
	renter_030_smfam_nop_&years. = T16_est95 ;
	renter_030_lgfam_nop_&years. = T16_est99;
	renter_030_eldnf_nop_&years. = T16_est103 ;
	renter_030_othhh_nop_&years. = T16_est107 ;

	renter_030_noplumb_&years. = sum(of T8_est71 T8_est74 T8_est77 T8_est80 );
	renter_030_hasplumb_&years. = sum(of T8_est72 T8_est75 T8_est78 T8_est81 );

	renter_030_noplumb_cb_&years. = sum(of T8_est74 T8_est77 );
	renter_030_hasplumb_cb_&years. = sum(of T8_est75 T8_est78 );

	renter_030_noplumb_scb_&years. = T8_est77 ;
	renter_030_hasplumb_scb_&years. = T8_est78 ;

	renter_030_onlycb_&years. = sum(of T3_est65 T3_est71);

	Mrenter_cb_&years. = %moe_sum(var= T8_moe73 T8_moe76  T8_moe89 T8_moe99 T8_moe102 T8_moe112 T8_moe115 T8_moe125 T8_moe128);
	Mrenter_scb_&years. = %moe_sum(var= T8_moe76 T8_moe89 T8_moe102 T8_moe115 T8_moe128);
	Mrenter_ncb_&years. = %moe_sum(var= T8_moe79 T8_moe92 T8_moe105 T8_moe118 T8_moe131);
	Mrenter_nop_&years. = %moe_sum(var= T16_moe91 T16_moe95 T16_moe99 T16_moe103 T16_moe107 T16_moe112 T16_moe116 T16_moe120 T16_moe124
							T16_moe128 T16_moe133 T16_moe137 T16_moe141 T16_moe145 T16_moe149 T16_moe154 T16_moe158 T16_moe162 T16_moe166 T16_moe170);

	Mrenter_inc030_&years. = T8_moe69;
	Mrenter_inc3050_&years. = T8_moe82;
	Mrenter_inc5080_&years. = T8_moe95; 
	Mrenter_inc80100_&years. = T8_moe108;
	Mrenter_inc100pl_&years. = T8_moe121;

	Mrenter_inc030_cb_&years. = %moe_sum(var= T8_moe73 T8_moe76);
	Mrenter_inc3050_cb_&years. = %moe_sum(var= T8_moe86 T8_moe89);
	Mrenter_inc5080_cb_&years. = %moe_sum(var= T8_moe99 T8_moe102);
	Mrenter_inc80100_cb_&years. = %moe_sum(var= T8_moe112 T8_moe115);
	Mrenter_inc100pl_cb_&years. = %moe_sum(var= T8_moe125 T8_moe128);

	Mrenter_inc030_scb_&years. = T8_moe76;
	Mrenter_inc3050_scb_&years. = T8_moe89;
	Mrenter_inc5080_scb_&years. = T8_moe102;
	Mrenter_inc80100_scb_&years. = T8_moe115;
	Mrenter_inc100pl_scb_&years. = T8_moe128;

	Mrenter_inc030_ncb_&years. = T8_moe79;
	Mrenter_inc3050_ncb_&years. = T8_moe92;
	Mrenter_inc5080_ncb_&years. = T8_moe105; 
	Mrenter_inc80100_ncb_&years. = T8_moe118;
	Mrenter_inc100pl_ncb_&years. = T8_moe131;

	Mrenter_030_eldfam_&years. = T16_moe89 ;
	Mrenter_030_smfam_&years. = T16_moe93 ;
	Mrenter_030_lgfam_&years. = T16_moe97 ;
	Mrenter_030_eldnf_&years. = T16_moe101 ;
	Mrenter_030_othhh_&years. = T16_moe105 ;

	Mrenter_030_eldfam_cb_&years. = %moe_sum(var= T7_moe137 T7_moe138 );
	Mrenter_030_smfam_cb_&years. = %moe_sum(var= T7_moe142 T7_moe143 );
	Mrenter_030_lgfam_cb_&years. = %moe_sum(var= T7_moe147 T7_moe148 );
	Mrenter_030_eldnf_cb_&years. = %moe_sum(var= T7_moe152 T7_moe153 );
	Mrenter_030_othhh_cb_&years. = %moe_sum(var= T7_moe157 T7_moe158);

	Mrenter_030_eldfam_scb_&years. = T7_moe138;
	Mrenter_030_smfam_scb_&years. = T7_moe143 ;
	Mrenter_030_lgfam_scb_&years. = T7_moe148 ;
	Mrenter_030_eldnf_scb_&years. = T7_moe153 ;
	Mrenter_030_othhh_scb_&years. = T7_moe158 ;

	Mrenter_030_eldfam_nop_&years. = T16_moe91 ;
	Mrenter_030_smfam_nop_&years. = T16_moe95 ;
	Mrenter_030_lgfam_nop_&years. = T16_moe99;
	Mrenter_030_eldnf_nop_&years. = T16_moe103 ;
	Mrenter_030_othhh_nop_&years. = T16_moe107 ;

	Mrenter_030_noplumb_&years. = %moe_sum(var= T8_moe71 T8_moe74 T8_moe77 T8_moe80 );
	Mrenter_030_hasplumb_&years. = %moe_sum(var= T8_moe72 T8_moe75 T8_moe78 T8_moe81 );

	Mrenter_030_noplumb_cb_&years. = %moe_sum(var= T8_moe74 T8_moe77 );
	Mrenter_030_hasplumb_cb_&years. = %moe_sum(var= T8_moe75 T8_moe78 );

	Mrenter_030_noplumb_scb_&years. = T8_moe77 ;
	Mrenter_030_hasplumb_scb_&years. = T8_moe78 ;

	Mrenter_030_onlycb_&years. = %moe_sum(var= T3_moe65 T3_moe71);


	label
	renter_cb_&years. = "Renter occupied units, cost burdened, &years_dash."
	renter_scb_&years. = "Renter occupied units, severely cost burdened, &years_dash."
	renter_ncb_&years. = "Renter occupied units, no cost burden computed, &years_dash."
	renter_nop_&years. = "Renter occupied units, no housing problems, &years_dash."
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
	renter_030_eldfam_&years. = "Renter occupied units, household income 0-30%, elderly family (2 people), &years_dash."
	renter_030_smfam_&years. = "Renter occupied units, household income 0-30%, small family (2 non-elderly people or 3-4 person family), &years_dash."
	renter_030_lgfam_&years. = "Renter occupied units, household income 0-30%, large family (5+ people), &years_dash."
	renter_030_eldnf_&years. = "Renter occupied units, household income 0-30%, eldelry nonfamily (1-2 person households), &years_dash."
	renter_030_othhh_&years. = "Renter occupied units, household income 0-30%, other household type, &years_dash."
	renter_030_eldfam_cb_&years. = "Renter occupied units, household income 0-30%, elderly family (2 people), cost burdened, &years_dash."
	renter_030_smfam_cb_&years. = "Renter occupied units, household income 0-30%, small family (2 non-elderly people or 3-4 person family), cost burdened, &years_dash."
	renter_030_lgfam_cb_&years. = "Renter occupied units, household income 0-30%, large family (5+ people), cost burdened, &years_dash."
	renter_030_eldnf_cb_&years. = "Renter occupied units, household income 0-30%, eldelry nonfamily (1-2 person households), cost burdened, &years_dash."
	renter_030_othhh_cb_&years. = "Renter occupied units, household income 0-30%, other household type, cost burdened, &years_dash."
	renter_030_eldfam_scb_&years. = "Renter occupied units, household income 0-30%, elderly family (2 people), severely cost burdened, &years_dash."
	renter_030_smfam_scb_&years. = "Renter occupied units, household income 0-30%, small family (2 non-elderly people or 3-4 person family), severely cost burdened, &years_dash."
	renter_030_lgfam_scb_&years. = "Renter occupied units, household income 0-30%, large family (5+ people), severely cost burdened, &years_dash."
	renter_030_eldnf_scb_&years. = "Renter occupied units, household income 0-30%, eldelry nonfamily (1-2 person households), severely cost burdened, &years_dash."
	renter_030_othhh_scb_&years. = "Renter occupied units, household income 0-30%, other household type, severely cost burdened, &years_dash."
	renter_030_eldfam_nop_&years. = "Renter occupied units, household income 0-30%, elderly family (2 people), no housing problems, &years_dash."
	renter_030_smfam_nop_&years. = "Renter occupied units, household income 0-30%, small family (2 non-elderly people or 3-4 person family), no housing problems, &years_dash."
	renter_030_lgfam_nop_&years. = "Renter occupied units, household income 0-30%, large family (5+ people), no housing problems, &years_dash."
	renter_030_eldnf_nop_&years. = "Renter occupied units, household income 0-30%, eldelry nonfamily (1-2 person households), no housing problems, &years_dash."
	renter_030_othhh_nop_&years. = "Renter occupied units, household income 0-30%, other household type, no housing problems, &years_dash."
	renter_030_noplumb_&years. = "Renter occupied units, household income 0-30%, lacks complete plumbing and kitchen facilities, &years_dash."
	renter_030_hasplumb_&years. = "Renter occupied units, household income 0-30%, has complete plumbing and kitchen facilities, &years_dash."
	renter_030_noplumb_cb_&years. = "Renter occupied units, household income 0-30%, lacks complete plumbing and kitchen facilities, cost burdened, &years_dash."
	renter_030_hasplumb_cb_&years. = "Renter occupied units, household income 0-30%, has complete plumbing and kitchen facilities, cost burdened, &years_dash."
	renter_030_noplumb_scb_&years. = "Renter occupied units, household income 0-30%, lacks complete plumbing and kitchen facilities, severely cost burdened, &years_dash."
	renter_030_hasplumb_scb_&years. = "Renter occupied units, household income 0-30%, has complete plumbing and kitchen facilities, severely cost burdened, &years_dash."
	renter_030_onlycb_&years. = "Renter occupied units, household income 0-30%,only cost burden is a problem, &years_dash."

	Mrenter_cb_&years. = "Renter occupied units, cost burdened, MOE &years_dash. "
	Mrenter_scb_&years. = "Renter occupied units, severely cost burdened, MOE &years_dash."
	Mrenter_ncb_&years. = "Renter occupied units, no cost burden computed, MOE &years_dash."
	Mrenter_nop_&years. = "Renter occupied units, no housing problems, MOE &years_dash."
	Mrenter_inc030_&years. = "Renter occupied units, household income 0-30%, MOE &years_dash."
	Mrenter_inc3050_&years. = "Renter occupied units, household income 30-50%, MOE &years_dash."
	Mrenter_inc5080_&years. = "Renter occupied units, household income 50-80%, MOE &years_dash."
	Mrenter_inc80100_&years. = "Renter occupied units, household income 80-100%, MOE &years_dash."
	Mrenter_inc100pl_&years. = "Renter occupied units, household income 100%+, MOE &years_dash."
	Mrenter_inc030_cb_&years. = "Renter occupied units, household income 0-30%, cost burdened, MOE &years_dash."
	Mrenter_inc3050_cb_&years. = "Renter occupied units, household income 30-50%, cost burdened, MOE &years_dash."
	Mrenter_inc5080_cb_&years. = "Renter occupied units, household income 50-80%, cost burdened, MOE &years_dash."
	Mrenter_inc80100_cb_&years. = "Renter occupied units, household income 80-100%, cost burdened, MOE &years_dash."
	Mrenter_inc100pl_cb_&years. = "Renter occupied units, household income 100%+%, cost burdened, MOE &years_dash."
	Mrenter_inc030_scb_&years. = "Renter occupied units, household income 0-30%, severely cost burdened, MOE &years_dash."
	Mrenter_inc3050_scb_&years. = "Renter occupied units, household income 30-50%, severely cost burdened, MOE &years_dash."
	Mrenter_inc5080_scb_&years. = "Renter occupied units, household income 50-80%, severely cost burdened, MOE &years_dash."
	Mrenter_inc80100_scb_&years. = "Renter occupied units, household income 80-100%, severely cost burdened, MOE &years_dash."
	Mrenter_inc100pl_scb_&years. = "Renter occupied units, household income 100%+, severely cost burdened, MOE &years_dash."
	Mrenter_inc030_ncb_&years. = "Renter occupied units, household income 0-30%, no cost burden computed, MOE &years_dash."
	Mrenter_inc3050_ncb_&years. = "Renter occupied units, household income 30-50%, no cost burden computed, MOE &years_dash."
	Mrenter_inc5080_ncb_&years. = "Renter occupied units, household income 50-80%, no cost burden computed, MOE &years_dash."
	Mrenter_inc80100_ncb_&years. = "Renter occupied units, household income 80-100%, no cost burden computed, MOE &years_dash."
	Mrenter_inc100pl_ncb_&years. = "Renter occupied units, household income 100%+, no cost burden computed, MOE &years_dash."
	Mrenter_030_eldfam_&years. = "Renter occupied units, household income 0-30%, elderly family (2 people), MOE &years_dash."
	Mrenter_030_smfam_&years. = "Renter occupied units, household income 0-30%, small family (2 non-elderly people or 3-4 person family), MOE &years_dash."
	Mrenter_030_lgfam_&years. = "Renter occupied units, household income 0-30%, large family (5+ people), MOE &years_dash."
	Mrenter_030_eldnf_&years. = "Renter occupied units, household income 0-30%, eldelry nonfamily (1-2 person households), MOE &years_dash."
	Mrenter_030_othhh_&years. = "Renter occupied units, household income 0-30%, other household type, MOE &years_dash."
	Mrenter_030_eldfam_cb_&years. = "Renter occupied units, household income 0-30%, elderly family (2 people), cost burdened, MOE &years_dash."
	Mrenter_030_smfam_cb_&years. = "Renter occupied units, household income 0-30%, small family (2 non-elderly people or 3-4 person family), cost burdened, MOE &years_dash."
	Mrenter_030_lgfam_cb_&years. = "Renter occupied units, household income 0-30%, large family (5+ people), cost burdened, MOE &years_dash."
	Mrenter_030_eldnf_cb_&years. = "Renter occupied units, household income 0-30%, eldelry nonfamily (1-2 person households), cost burdened, MOE &years_dash."
	Mrenter_030_othhh_cb_&years. = "Renter occupied units, household income 0-30%, other household type, cost burdened, MOE &years_dash."
	Mrenter_030_eldfam_scb_&years. = "Renter occupied units, household income 0-30%, elderly family (2 people), severely cost burdened, MOE &years_dash."
	Mrenter_030_smfam_scb_&years. = "Renter occupied units, household income 0-30%, small family (2 non-elderly people or 3-4 person family), severely cost burdened, MOE &years_dash."
	Mrenter_030_lgfam_scb_&years. = "Renter occupied units, household income 0-30%, large family (5+ people), severely cost burdened, MOE &years_dash."
	Mrenter_030_eldnf_scb_&years. = "Renter occupied units, household income 0-30%, eldelry nonfamily (1-2 person households), severely cost burdened, MOE &years_dash."
	Mrenter_030_othhh_scb_&years. = "Renter occupied units, household income 0-30%, other household type, severely cost burdened, MOE &years_dash."
	Mrenter_030_eldfam_nop_&years. = "Renter occupied units, household income 0-30%, elderly family (2 people), no housing problems, MOE &years_dash."
	Mrenter_030_smfam_nop_&years. = "Renter occupied units, household income 0-30%, small family (2 non-elderly people or 3-4 person family), no housing problems, MOE &years_dash."
	Mrenter_030_lgfam_nop_&years. = "Renter occupied units, household income 0-30%, large family (5+ people), no housing problems, MOE &years_dash."
	Mrenter_030_eldnf_nop_&years. = "Renter occupied units, household income 0-30%, eldelry nonfamily (1-2 person households), no housing problems, MOE &years_dash."
	Mrenter_030_othhh_nop_&years. = "Renter occupied units, household income 0-30%, other household type, no housing problems, MOE &years_dash."
	Mrenter_030_noplumb_&years. = "Renter occupied units, household income 0-30%, lacks complete plumbing and kitchen facilities, MOE &years_dash."
	Mrenter_030_hasplumb_&years. = "Renter occupied units, household income 0-30%, has complete plumbing and kitchen facilities, MOE &years_dash."
	Mrenter_030_noplumb_cb_&years. = "Renter occupied units, household income 0-30%, lacks complete plumbing and kitchen facilities, cost burdened, MOE &years_dash."
	Mrenter_030_hasplumb_cb_&years. = "Renter occupied units, household income 0-30%, has complete plumbing and kitchen facilities, cost burdened, MOE &years_dash."
	Mrenter_030_noplumb_scb_&years. = "Renter occupied units, household income 0-30%, lacks complete plumbing and kitchen facilities, severely cost burdened, MOE &years_dash."
	Mrenter_030_hasplumb_scb_&years. = "Renter occupied units, household income 0-30%, has complete plumbing and kitchen facilities, severely cost burdened, MOE &years_dash."
	Mrenter_030_onlycb_&years. = "Renter occupied units, household income 0-30%,only cost burden is a problem, MOE &years_dash."
	;

	%Pct_calc( var=Prenter_inc030, label=% Renter occupied units household income 0-30%, num=renter_inc030, den=renter_unit_tot, years= &years. );
	%Pct_calc( var=Prenter_inc030_cb, label=% Renter occupied units household income 0-30% cost burdened, num=renter_inc030_cb, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_inc030_scb, label=% Renter occupied units household income 0-30% severe cost burdened, num=renter_inc030_scb, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_inc030_ncb, label=% Renter occupied units household income 0-30% no cost burden computed, num=renter_inc030_ncb, den=renter_inc030, years= &years. );

	%Moe_prop_a( var=Orenter_inc030_&years., mult=100, num=renter_inc030_&years., den=renter_unit_tot_&years., 
                       num_moe=Mrenter_inc030_&years., den_moe=Mrenter_unit_tot_&years., label_moe = % Renter occupied units household income 0-30% MOE);
	%Moe_prop_a( var=Orenter_inc030_cb_&years., mult=100, num=renter_inc030_cb_&years., den=renter_inc030_&years., 
                       num_moe=Mrenter_inc030_cb_&years., den_moe=Mrenter_inc030_&years., label_moe = % Renter occupied units household income 0-30% cost burdened MOE);
	%Moe_prop_a( var=Orenter_inc030_scb_&years., mult=100, num=renter_inc030_scb_&years., den=renter_inc030_&years., 
                       num_moe=Mrenter_inc030_scb_&years., den_moe=Mrenter_inc030_&years., label_moe = % Renter occupied units household income 0-30% no cost burden computed MOE);
	%Moe_prop_a( var=Orenter_inc030_ncb_&years., mult=100, num=renter_inc030_ncb_&years., den=renter_inc030_&years., 
                       num_moe=Mrenter_inc030_ncb_&years., den_moe=Mrenter_inc030_&years., label_moe = % Renter occupied units household income 0-30% no cost burden computed MOE);

	%Pct_calc( var=Prenter_inc3050, label=% Renter occupied units household income 30-50%, num=renter_inc3050, den=renter_unit_tot, years= &years. );
	%Pct_calc( var=Prenter_inc3050_cb, label=% Renter occupied units household income 30-50% cost burdened, num=renter_inc3050_cb, den=renter_inc3050, years= &years. );
	%Pct_calc( var=Prenter_inc3050_scb, label=% Renter occupied units household income 30-50% severe cost burdened, num=renter_inc3050_scb, den=renter_inc3050, years= &years. );
	%Pct_calc( var=Prenter_inc3050_ncb, label=% Renter occupied units household income 30-50% no cost burden computed, num=renter_inc3050_ncb, den=renter_inc3050, years= &years. );

	%Moe_prop_a( var=Orenter_inc3050_&years., mult=100, num=renter_inc3050_&years., den=renter_unit_tot_&years., 
                       num_moe=Mrenter_inc3050_&years., den_moe=Mrenter_unit_tot_&years., label_moe = % Renter occupied units household income 30-50% MOE);
	%Moe_prop_a( var=Orenter_inc3050_cb_&years., mult=100, num=renter_inc3050_cb_&years., den=renter_inc3050_&years., 
                       num_moe=Mrenter_inc3050_cb_&years., den_moe=Mrenter_inc3050_&years., label_moe = % Renter occupied units household income 30-50% cost burdened MOE);
	%Moe_prop_a( var=Orenter_inc3050_scb_&years., mult=100, num=renter_inc3050_scb_&years., den=renter_inc3050_&years., 
                       num_moe=Mrenter_inc3050_scb_&years., den_moe=Mrenter_inc3050_&years., label_moe = % Renter occupied units household income 30-50% no cost burden computed MOE);
	%Moe_prop_a( var=Orenter_inc3050_ncb_&years., mult=100, num=renter_inc3050_ncb_&years., den=renter_inc3050_&years., 
                       num_moe=Mrenter_inc3050_ncb_&years., den_moe=Mrenter_inc3050_&years., label_moe = % Renter occupied units household income 30-50% no cost burden computed MOE);

	%Pct_calc( var=Prenter_inc5080, label=% Renter occupied units household income 50-80%, num=renter_inc5080, den=renter_unit_tot, years= &years. );
	%Pct_calc( var=Prenter_inc5080_cb, label=% Renter occupied units household income 50-80% cost burdened, num=renter_inc5080_cb, den=renter_inc5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_scb, label=% Renter occupied units household income 50-80% severe cost burdened, num=renter_inc5080_scb, den=renter_inc5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_ncb, label=% Renter occupied units household income 50-80% no cost burden computed, num=renter_inc5080_ncb, den=renter_inc5080, years= &years. );

	%Moe_prop_a( var=Orenter_inc5080_&years., mult=100, num=renter_inc5080_&years., den=renter_unit_tot_&years., 
                       num_moe=Mrenter_inc5080_&years., den_moe=Mrenter_unit_tot_&years., label_moe = % Renter occupied units household income 50-80% MOE);
	%Moe_prop_a( var=Orenter_inc5080_cb_&years., mult=100, num=renter_inc5080_cb_&years., den=renter_inc5080_&years., 
                       num_moe=Mrenter_inc5080_cb_&years., den_moe=Mrenter_inc5080_&years., label_moe = % Renter occupied units household income 50-80% cost burdened MOE);
	%Moe_prop_a( var=Orenter_inc5080_scb_&years., mult=100, num=renter_inc5080_scb_&years., den=renter_inc5080_&years., 
                       num_moe=Mrenter_inc5080_scb_&years., den_moe=Mrenter_inc5080_&years., label_moe = % Renter occupied units household income 50-80% severe cost burdened MOE);
	%Moe_prop_a( var=Orenter_inc5080_ncb_&years., mult=100, num=renter_inc5080_ncb_&years., den=renter_inc5080_&years., 
                       num_moe=Mrenter_inc5080_ncb_&years., den_moe=Mrenter_inc5080_&years., label_moe = % Renter occupied units household income 50-80% no cost burden computed MOE);

	%Pct_calc( var=Prenter_inc80100, label=% Renter occupied units household income 80-100%, num=renter_inc80100, den=renter_unit_tot, years= &years. );
	%Pct_calc( var=Prenter_inc80100_cb, label=% Renter occupied units household income 80-100% cost burdened, num=renter_inc80100_cb, den=renter_inc80100, years= &years. );
	%Pct_calc( var=Prenter_inc80100_scb, label=% Renter occupied units household income 80-100% severe cost burdened, num=renter_inc80100_scb, den=renter_inc80100, years= &years. );
	%Pct_calc( var=Prenter_inc80100_ncb, label=% Renter occupied units household income 80-100% no cost burden computed, num=renter_inc80100_ncb, den=renter_inc80100, years= &years. );

	%Moe_prop_a( var=Orenter_inc80100_&years., mult=100, num=renter_inc80100_&years., den=renter_unit_tot_&years., 
                       num_moe=Mrenter_inc80100_&years., den_moe=Mrenter_unit_tot_&years., label_moe = % Renter occupied units household income 80-100% MOE);
	%Moe_prop_a( var=Orenter_inc80100_cb_&years., mult=100, num=renter_inc80100_cb_&years., den=renter_inc80100_&years., 
                       num_moe=Mrenter_inc80100_cb_&years., den_moe=Mrenter_inc80100_&years., label_moe = % Renter occupied units household income 80-100% cost burdened MOE);
	%Moe_prop_a( var=Orenter_inc80100_scb_&years., mult=100, num=renter_inc80100_scb_&years., den=renter_inc80100_&years., 
                       num_moe=Mrenter_inc80100_scb_&years., den_moe=Mrenter_inc80100_&years., label_moe = % Renter occupied units household income 80-100% severe cost burdened MOE);
	%Moe_prop_a( var=Orenter_inc80100_ncb_&years., mult=100, num=renter_inc80100_ncb_&years., den=renter_inc80100_&years., 
                       num_moe=Mrenter_inc80100_ncb_&years., den_moe=Mrenter_inc80100_&years., label_moe = % Renter occupied units household income 80-100% no cost burden computed MOE);

	%Pct_calc( var=Prenter_inc100pl, label=% Renter occupied units household income 100%+, num=renter_inc100pl, den=renter_unit_tot, years= &years. );
	%Pct_calc( var=Prenter_inc100pl_cb, label=% Renter occupied units household income 100%+ cost burdened, num=renter_inc100pl_cb, den=renter_inc100pl, years= &years. );
	%Pct_calc( var=Prenter_inc100pl_scb, label=% Renter occupied units household income 100%+ severe cost burdened, num=renter_inc100pl_scb, den=renter_inc100pl, years= &years. );
	%Pct_calc( var=Prenter_inc100pl_ncb, label=% Renter occupied units household income 100%+ no cost burden computed, num=renter_inc100pl_ncb, den=renter_inc100pl, years= &years. );

	%Moe_prop_a( var=_&years., mult=100, num=_&years., den=_&years., 
                       num_moe=_&years., den_moe=_&years., label_moe =  MOE);
	%Moe_prop_a( var=_&years., mult=100, num=_&years., den=_&years., 
                       num_moe=_&years., den_moe=_&years., label_moe =  MOE);
	%Moe_prop_a( var=_&years., mult=100, num=_&years., den=_&years., 
                       num_moe=_&years., den_moe=_&years., label_moe =  MOE);
	%Moe_prop_a( var=_&years., mult=100, num=_&years., den=_&years., 
                       num_moe=_&years., den_moe=_&years., label_moe =  MOE);

	%Pct_calc( var=Prenter_030_eldfam, label=% Renter occupied units household income 0-30% elderly family, num=renter_030_eldfam, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_030_eldfam_cb, label=% Renter occupied units household income 0-30% elderly family cost burdened, num=renter_030_eldfam_cb, den=renter_030_eldfam, years= &years. );
	%Pct_calc( var=Prenter_030_eldfam_scb, label=% Renter occupied units household income 0-30% elderly family cost burdened, num=renter_030_eldfam_scb, den=renter_030_eldfam, years= &years. );
	%Pct_calc( var=Prenter_030_eldfam_nop, label=% Renter occupied units household income 0-30% elderly family no housing problems, num=renter_030_eldfam_nop, den=renter_030_eldfam, years= &years. );

	%Moe_prop_a( var=Orenter_030_eldfam_&years., mult=100, num=renter_030_eldfam_&years., den=renter_inc030_&years., 
                       num_moe=Mrenter_030_eldfam_&years., den_moe=Mrenter_inc030_&years., label_moe = % Renter occupied units household income 0-30% elderly family MOE);
	%Moe_prop_a( var=Orenter_030_eldfam_cb_&years., mult=100, num=renter_030_eldfam_cb_&years., den=renter_030_eldfam_&years., 
                       num_moe=Mrenter_030_eldfam_cb_&years., den_moe=Mrenter_030_eldfam_&years., label_moe = % Renter occupied units household income 0-30% elderly family cost burdened MOE);
	%Moe_prop_a( var=Orenter_030_eldfam_scb_&years., mult=100, num=renter_030_eldfam_scb_&years., den=renter_030_eldfam_&years., 
                       num_moe=Mrenter_030_eldfam_scb_&years., den_moe=Mrenter_030_eldfam_&years., label_moe = % Renter occupied units household income 0-30% elderly family cost burdened MOE);
	%Moe_prop_a( var=Orenter_030_eldfam_nop_&years., mult=100, num=renter_030_eldfam_nop_&years., den=renter_030_eldfam_&years., 
                       num_moe=Mrenter_030_eldfam_nop_&years., den_moe=Mrenter_030_eldfam_&years., label_moe = % Renter occupied units household income 0-30% elderly family no housing problems MOE);

	%Pct_calc( var=Prenter_030_smfam, label=% Renter occupied units household income 0-30% small family, num=renter_030_smfam, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_030_smfam_cb, label=% Renter occupied units household income 0-30% small family cost burdened, num=renter_030_smfam_cb, den=renter_030_smfam, years= &years. );
	%Pct_calc( var=Prenter_030_smfam_scb, label=% Renter occupied units household income 0-30% small family cost burdened, num=renter_030_smfam_scb, den=renter_030_smfam, years= &years. );
	%Pct_calc( var=Prenter_030_smfam_nop, label=% Renter occupied units household income 0-30% small family no housing problems, num=renter_030_smfam_nop, den=renter_030_smfam, years= &years. );

	%Moe_prop_a( var=Orenter_030_smfam_&years., mult=100, num=renter_030_smfam_&years., den=renter_inc030_&years., 
                       num_moe=Mrenter_030_smfam_&years., den_moe=Mrenter_inc030_&years., label_moe = % Renter occupied units household income 0-30% small family MOE);
	%Moe_prop_a( var=Orenter_030_smfam_cb_&years., mult=100, num=renter_030_smfam_cb_&years., den=renter_030_smfam_&years., 
                       num_moe=Mrenter_030_smfam_cb_&years., den_moe=Mrenter_030_smfam_&years., label_moe = % Renter occupied units household income 0-30% small family cost burdened MOE);
	%Moe_prop_a( var=Orenter_030_smfam_scb_&years., mult=100, num=renter_030_smfam_scb_&years., den=renter_030_smfam_&years., 
                       num_moe=Mrenter_030_smfam_scb_&years., den_moe=Mrenter_030_smfam_&years., label_moe = % Renter occupied units household income 0-30% small family cost burdened MOE);
	%Moe_prop_a( var=Orenter_030_smfam_nop_&years., mult=100, num=renter_030_smfam_nop_&years., den=renter_030_smfam_&years., 
                       num_moe=Mrenter_030_smfam_nop_&years., den_moe=Mrenter_030_smfam_&years., label_moe = % Renter occupied units household income 0-30% small family no housing problems MOE);

	%Pct_calc( var=Prenter_030_lgfam, label=% Renter occupied units household income 0-30% large family, num=renter_030_lgfam, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_030_lgfam_cb, label=% Renter occupied units household income 0-30% large family cost burdened, num=renter_030_lgfam_cb, den=renter_030_lgfam, years= &years. );
	%Pct_calc( var=Prenter_030_lgfam_scb, label=% Renter occupied units household income 0-30% large family cost burdened, num=renter_030_lgfam_scb, den=renter_030_lgfam, years= &years. );
	%Pct_calc( var=Prenter_030_lgfam_nop, label=% Renter occupied units household income 0-30% large family no housing problems, num=renter_030_lgfam_nop, den=renter_030_lgfam, years= &years. );

	%Moe_prop_a( var=Orenter_030_lgfam_&years., mult=100, num=renter_030_lgfam_&years., den=renter_inc030_&years., 
                       num_moe=Mrenter_030_lgfam_&years., den_moe=Mrenter_inc030_&years., label_moe = % Renter occupied units household income 0-30% large family MOE);
	%Moe_prop_a( var=Orenter_030_lgfam_cb_&years., mult=100, num=renter_030_lgfam_cb_&years., den=renter_030_lgfam_&years., 
                       num_moe=Mrenter_030_lgfam_cb_&years., den_moe=Mrenter_030_lgfam_&years., label_moe = % Renter occupied units household income 0-30% large family cost burdened MOE);
	%Moe_prop_a( var=Orenter_030_lgfam_scb_&years., mult=100, num=renter_030_lgfam_scb_&years., den=renter_030_lgfam_&years., 
                       num_moe=Mrenter_030_lgfam_scb_&years., den_moe=Mrenter_030_lgfam_&years., label_moe = % Renter occupied units household income 0-30% large family cost burdened MOE);
	%Moe_prop_a( var=_&years., mult=100, num=renter_030_lgfam_nop_&years., den=renter_030_lgfam_&years., 
                       num_moe=Mrenter_030_lgfam_nop_&years., den_moe=Mrenter_030_lgfam_&years., label_moe = % Renter occupied units household income 0-30% large family no housing problems MOE);

	%Pct_calc( var=Prenter_030_eldnf, label=% Renter occupied units household income 0-30% elderly non-family family, num=renter_030_eldnf, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_030_eldnf_cb, label=% Renter occupied units household income 0-30% elderly non-family cost burdened, num=renter_030_eldnf_cb, den=renter_030_eldnf, years= &years. );
	%Pct_calc( var=Prenter_030_eldnf_scb, label=% Renter occupied units household income 0-30% elderly non-family cost burdened, num=renter_030_eldnf_scb, den=renter_030_eldnf, years= &years. );
	%Pct_calc( var=Prenter_030_eldnf_nop, label=% Renter occupied units household income 0-30% elderly non-family no housing problems, num=renter_030_eldnf_nop, den=renter_030_eldnf, years= &years. );

	%Moe_prop_a( var=Orenter_030_eldnf_&years., mult=100, num=renter_030_eldnf_&years., den=renter_inc030_&years., 
                       num_moe=Mrenter_030_eldnf_&years., den_moe=Mrenter_inc030_&years., label_moe = % Renter occupied units household income 0-30% elderly non-family family MOE);
	%Moe_prop_a( var=Orenter_030_eldnf_cb_&years., mult=100, num=renter_030_eldnf_cb_&years., den=renter_030_eldnf_&years., 
                       num_moe=Mrenter_030_eldnf_cb_&years., den_moe=Mrenter_030_eldnf_&years., label_moe = % Renter occupied units household income 0-30% elderly non-family cost burdened MOE);
	%Moe_prop_a( var=Orenter_030_eldnf_scb_&years., mult=100, num=renter_030_eldnf_scb_&years., den=renter_030_eldnf_&years., 
                       num_moe=Mrenter_030_eldnf_scb_&years., den_moe=Mrenter_030_eldnf_&years., label_moe = % Renter occupied units household income 0-30% elderly non-family cost burdened MOE);
	%Moe_prop_a( var=Orenter_030_eldnf_nop_&years., mult=100, num=renter_030_eldnf_scb_&years., den=renter_030_eldnf_&years., 
                       num_moe=Mrenter_030_eldnf_scb_&years., den_moe=Mrenter_030_eldnf_&years., label_moe = % Renter occupied units household income 0-30% elderly non-family no housing problems MOE);

	%Pct_calc( var=Prenter_030_othhh, label=% Renter occupied units household income 0-30% other household, num=renter_030_othhh, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_030_othhh_cb, label=% Renter occupied units household income 0-30% other household cost burdened, num=renter_030_othhh_cb, den=renter_030_othhh, years= &years. );
	%Pct_calc( var=Prenter_030_othhh_scb, label=% Renter occupied units household income 0-30% other household severe cost burdened, num=renter_030_othhh_scb, den=renter_030_othhh, years= &years. );
	%Pct_calc( var=Prenter_030_othhh_nop, label=% Renter occupied units household income 0-30% other household no housing problems, num=renter_030_othhh_nop, den=renter_030_othhh, years= &years. );

	%Moe_prop_a( var=Orenter_030_othhh_&years., mult=100, num=renter_030_othhh_&years., den=renter_inc030_&years., 
                       num_moe=Mrenter_030_othhh_&years., den_moe=Mrenter_inc030_&years., label_moe = % Renter occupied units household income 0-30% other household MOE);
	%Moe_prop_a( var=Orenter_030_othhh_cb_&years., mult=100, num=renter_030_othhh_cb_&years., den=renter_030_othhh_&years., 
                       num_moe=Mrenter_030_othhh_cb_&years., den_moe=Mrenter_030_othhh_&years., label_moe = % Renter occupied units household income 0-30% other household cost burdened MOE);
	%Moe_prop_a( var=Orenter_030_othhh_scb_&years., mult=100, num=renter_030_othhh_scb_&years., den=renter_030_othhh_&years., 
                       num_moe=Mrenter_030_othhh_scb_&years., den_moe=Mrenter_030_othhh_&years., label_moe = % Renter occupied units household income 0-30% other household severe cost burdene MOE);
	%Moe_prop_a( var=Orenter_030_othhh_nop_&years., mult=100, num=renter_030_othhh_nop_&years., den=renter_030_othhh_&years., 
                       num_moe=Mrenter_030_othhh_nop_&years., den_moe=Mrenter_030_othhh_&years., label_moe = % Renter occupied units household income 0-30% other household no housing problems MOE);

	%Pct_calc( var=Prenter_030_noplumb, label=% Renter occupied units household income 0-30% household lacks complete plumbing and kitchen facilities, num=renter_030_noplumb, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_030_noplumb_cb, label=% Renter occupied units household income 0-30% household lacks complete plumbing and kitchen facilities and cost burdened, num=renter_030_noplumb_cb, den=renter_030_noplumb, years= &years. );
	%Pct_calc( var=Prenter_030_noplumb_scb, label=% Renter occupied units household income 0-30% household lacks complete plumbing and kitchen facilities and cost burdened, num=renter_030_noplumb_scb, den=renter_030_noplumb, years= &years. );

	%Moe_prop_a( var=Orenter_030_noplumb_&years., mult=100, num=renter_030_noplumb_&years., den=renter_inc030_&years., 
                       num_moe=Mrenter_030_noplumb_&years., den_moe=Mrenter_inc030_&years., label_moe = % Renter occupied units household income 0-30% household lacks complete plumbing and kitchen facilities MOE);
	%Moe_prop_a( var=Orenter_030_noplumb_cb_&years., mult=100, num=renter_030_noplumb_cb_&years., den=renter_030_noplumb_&years., 
                       num_moe=Mrenter_030_noplumb_cb_&years., den_moe=Mrenter_030_noplumb_&years., label_moe = % Renter occupied units household income 0-30% household lacks complete plumbing and kitchen facilities and cost burdened MOE);
	%Moe_prop_a( var=Orenter_030_noplumb_scb_&years., mult=100, num=renter_030_noplumb_scb_&years., den=renter_030_noplumb_&years., 
                       num_moe=Mrenter_030_noplumb_scb_&years., den_moe=Mrenter_030_noplumb_&years., label_moe = % Renter occupied units household income 0-30% household lacks complete plumbing and kitchen facilities and cost burdened MOE);

	%Pct_calc( var=Prenter_030_hasplumb, label=% Renter occupied units household income 0-30% household has complete plumbing and kitchen facilities, num=renter_030_hasplumb, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prenter_030_hasplumb_cb, label=% Renter occupied units household income 0-30% household has complete plumbing and kitchen facilities and cost and cost burdened, num=renter_030_hasplumb_cb, den=renter_030_hasplumb, years= &years. );
	%Pct_calc( var=Prenter_030_hasplumb_scb, label=% Renter occupied units household income 0-30% household has complete plumbing and kitchen facilities and cost and severe cost burdened, num=renter_030_hasplumb_scb, den=renter_030_hasplumb, years= &years. );

	%Moe_prop_a( var=Orenter_030_hasplumb_&years., mult=100, num=renter_030_hasplumb_&years., den=renter_inc030_&years., 
                       num_moe=Mrenter_030_hasplumb_&years., den_moe=Mrenter_inc030_&years., label_moe = % Renter occupied units household income 0-30% household has complete plumbing and kitchen facilities MOE);
	%Moe_prop_a( var=Orenter_030_hasplumb_cb_&years., mult=100, num=renter_030_hasplumb_cb_&years., den=renter_030_hasplumb_&years., 
                       num_moe=Mrenter_030_hasplumb_cb_&years., den_moe=Mrenter_030_hasplumb_&years., label_moe = % Renter occupied units household income 0-30% household has complete plumbing and kitchen facilities and cost and cost burdened MOE);
	%Moe_prop_a( var=Orenter_030_hasplumb_scb_&years., mult=100, num=renter_030_hasplumb_scb_&years., den=renter_030_hasplumb_&years., 
                       num_moe=Mrenter_030_hasplumb_scb_&years., den_moe=Mrenter_030_hasplumb_&years., label_moe = % Renter occupied units household income 0-30% household has complete plumbing and kitchen facilities and cost and severe cost burdened MOE);

	%Pct_calc( var=Prenter_030_onlycb, label=% Renter occupied units household income 0-30% where only cost burden is a problem, num=renter_030_onlycb, den=renter_inc030, years= &years. );

	%Moe_prop_a( var=Orenter_030_onlycb_&years., mult=100, num=renter_030_onlycb_&years., den=renter_inc030_&years., 
                       num_moe=Mrenter_030_onlycb_&years., den_moe=Mrenter_inc030_&years., label_moe = % Renter occupied units household income 0-30% where only cost burden is a problem MOE);

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

	Mrentr_lte1_&years. = T10_moe67;
	Mrentr_lte15_&years. = T10_moe88;
	Mrentr_gt15_&years. = T10_moe109;

	Mrentr_1fam_&years. = %moe_sum(var= T10_moe69 T10_moe73 T10_moe77 T10_moe81 T10_moe85 T10_moe90 T10_moe94 T10_moe98
								T10_moe102 T10_moe106 T10_moe111 T10_moe115 T10_moe119 T10_moe123 T10_moe127);
	Mrentr_sfam_&years. = %moe_sum(var= T10_moe70 T10_moe74 T10_moe78 T10_moe82 T10_moe86 T10_moe91 T10_moe95 T10_moe99
								T10_moe103 T10_moe107 T10_moe112 T10_moe116 T10_moe120 T10_moe124 T10_moe128);
	Mrentr_nfam_&years. = %moe_sum(var= T10_moe69 T10_moe73 T10_moe77 T10_moe81 T10_moe85 T10_moe90 T10_moe94 T10_moe98
								T10_moe102 T10_moe106 T10_moe111 T10_moe115 T10_moe119 T10_moe123 T10_moe127);

	Mrentr_inc030_lte1_&years. = T10_moe68;
	Mrentr_inc3050_lte1_&years. = T10_moe72;
	Mrentr_inc5080_lte1_&years. = T10_moe76;
	Mrentr_inc80100_lte1_&years. = T10_moe80;
	Mrentr_inc100pl_lte1_&years. = T10_moe84;

	Mrentr_inc030_lte15_&years. = T10_moe89;
	Mrentr_inc3050_lte15_&years. = T10_moe93;
	Mrentr_inc5080_lte15_&years. = T10_moe97;
	Mrentr_inc80100_lte15_&years. = T10_moe101;
	Mrentr_inc100pl_lte15_&years. = T10_moe105;

	Mrentr_inc030_gt15_&years. = T10_moe110;
	Mrentr_inc3050_gt15_&years. = T10_moe114;
	Mrentr_inc5080_gt15_&years. = T10_moe118;
	Mrentr_inc80100_gt15_&years. = T10_moe122;
	Mrentr_inc100pl_gt15_&years. = T10_moe126;

	Mrentr_inc030_1fam_&years. = %moe_sum(var= T10_moe69 T10_moe90 T10_moe111);
	Mrentr_inc030_sfam_&years. = %moe_sum(var= T10_moe70 T10_moe91 T10_moe112);
	Mrentr_inc030_nfam_&years. = %moe_sum(var= T10_moe71 T10_moe92 T10_moe113);

	Mrentr_inc030_lte1_1fam_&years. = T10_moe69;
	Mrentr_inc030_lte1_sfam_&years. = T10_moe70;
	Mrentr_inc030_lte1_nfam_&years. = T10_moe71;

	Mrentr_inc030_lte15_1fam_&years. = T10_moe90;
	Mrentr_inc030_lte15_sfam_&years. = T10_moe91;
	Mrentr_inc030_lte15_nfam_&years. = T10_moe92;

	Mrentr_inc030_gt15_1fam_&years. = T10_moe111;
	Mrentr_inc030_gt15_sfam_&years. = T10_moe112;
	Mrentr_inc030_gt15_nfam_&years. = T10_moe113;

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

	Mrentr_lte1_&years. = "Renter occupied units, persons per room less than or equal 1, MOE &years_dash."
	Mrentr_lte15_&years. = "Renter occupied units, persons per room greater than 1 less than or equal 1.5, MOE &years_dash."
	Mrentr_gt15_&years. = "Renter occupied units, persons per room greater than 1.5, MOE &years_dash."
	Mrentr_1fam_&years. = "Renter occupied units, one family, MOE &years_dash."
	Mrentr_sfam_&years. = "Renter occupied units, one family with subfamily or more than 1 family, MOE &years_dash."
	Mrentr_nfam_&years. = "Renter occupied units, non-family, MOE &years_dash."
	Mrentr_inc030_lte1_&years. = "Renter occupied units, household income 0-30%, persons per room less than or equal 1, MOE &years_dash."
	Mrentr_inc3050_lte1_&years. = "Renter occupied units, household income 30-50%, persons per room less than or equal 1, MOE &years_dash."
	Mrentr_inc5080_lte1_&years. = "Renter occupied units, household income 50-80%, persons per room less than or equal 1, MOE &years_dash."
	Mrentr_inc80100_lte1_&years. = "Renter occupied units, household income 80-100%, persons per room less than or equal 1, MOE &years_dash."
	Mrentr_inc100pl_lte1_&years. = "Renter occupied units, household income 100%+, persons per room less than or equal 1, MOE &years_dash."
	Mrentr_inc030_lte15_&years. = "Renter occupied units, household income 0-30%, persons per room greater than 1 less than or equal 1.5, MOE &years_dash."
	Mrentr_inc3050_lte15_&years. = "Renter occupied units, household income 30-50%, persons per room greater than 1 less than or equal 1.5, MOE &years_dash."
	Mrentr_inc5080_lte15_&years. = "Renter occupied units, household income 50-80%, persons per room greater than 1 less than or equal 1.5, MOE &years_dash."
	Mrentr_inc80100_lte15_&years. = "Renter occupied units, household income 80-100%, persons per room greater than 1 less than or equal 1.5, MOE &years_dash."
	Mrentr_inc100pl_lte15_&years. = "Renter occupied units, household income 100%+, persons per room greater than 1 less than or equal 1.5, MOE &years_dash."
	Mrentr_inc030_gt15_&years. = "Renter occupied units, household income 0-30%, persons per room greater than 1.5, MOE &years_dash."
	Mrentr_inc3050_gt15_&years. = "Renter occupied units, household income 30-50%, persons per room greater than 1.5, MOE &years_dash."
	Mrentr_inc5080_gt15_&years. = "Renter occupied units, household income 50-80%, persons per room greater than 1.5, MOE &years_dash."
	Mrentr_inc80100_gt15_&years. = "Renter occupied units, household income 80-100%, persons per room greater than 1.5, MOE &years_dash."
	Mrentr_inc100pl_gt15_&years. = "Renter occupied units, household income 100%+, persons per room greater than 1.5, MOE &years_dash."
	Mrentr_inc030_1fam_&years. = "Renter occupied units, household income 0-30%, one family, MOE &years_dash."
	Mrentr_inc030_sfam_&years. = "Renter occupied units, household income 0-30%, one family with subfamily or more than 1 family, MOE &years_dash."
	Mrentr_inc030_nfam_&years. = "Renter occupied units, household income 0-30%, non-family, MOE &years_dash."
	Mrentr_inc030_lte1_1fam_&years. = "Renter occupied units, household income 0-30%, one family, persons per room less than or equal 1, MOE &years_dash."
	Mrentr_inc030_lte1_sfam_&years. = "Renter occupied units, household income 0-30%, one family with subfamily or more than 1 family, persons per room less than or equal 1, MOE &years_dash."
	Mrentr_inc030_lte1_nfam_&years. = "Renter occupied units, household income 0-30%, non-family, persons per room less than or equal 1, MOE &years_dash."
	Mrentr_inc030_lte15_1fam_&years. = "Renter occupied units, household income 0-30%, one family, persons per room greater than 1 less than or equal 1.5, MOE &years_dash."
	Mrentr_inc030_lte15_sfam_&years. = "Renter occupied units, household income 0-30%, one family with subfamily or more than 1 family, persons per room greater than 1 less than or equal 1.5, MOE &years_dash."
	Mrentr_inc030_lte15_nfam_&years. = "Renter occupied units, household income 0-30%, non-family, persons per room greater than 1 less than or equal 1.5, MOE &years_dash."
	Mrentr_inc030_gt15_1fam_&years. = "Renter occupied units, household income 0-30%, one family, persons per room greater than 1.5, MOE &years_dash."
	Mrentr_inc030_gt15_sfam_&years. = "Renter occupied units, household income 0-30%, one family with subfamily or more than 1 family, persons per room greater 1.5, MOE &years_dash."
	Mrentr_inc030_gt15_nfam_&years. = "Renter occupied units, household income 0-30%, non-family, persons per room greater than 1.5, MOE &years_dash."
	;

	%Pct_calc( var=Prentr_inc030_lte1, label=% Renter occupied units household income 0-30% persons per room less than or equal 1, num=rentr_inc030_lte1, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prentr_inc030_lte15, label=% Renter occupied units household income 0-30% persons per room greater than 1 less than or equal 1.5, num=rentr_inc030_lte15, den=renter_inc030, years= &years. );
	%Pct_calc( var=Prentr_inc030_gt15, label=% Renter occupied units household income 0-30% persons per room greater than 1.5, num=rentr_inc030_gt15, den=renter_inc030, years= &years. );

	%Moe_prop_a( var=Orentr_inc030_lte1_&years., mult=100, num=rentr_inc030_lte1_&years., den=renter_inc030_&years., 
                       num_moe=Mrentr_inc030_lte1_&years., den_moe=Mrenter_inc030_&years., label_moe = % Renter occupied units household income 0-30% persons per room less than or equal 1 MOE);
	%Moe_prop_a( var=Orentr_inc030_lte15_&years., mult=100, num=rentr_inc030_lte15_&years., den=renter_inc030_&years., 
                       num_moe=Mrentr_inc030_lte15_&years., den_moe=Mrenter_inc030_&years., label_moe = % Renter occupied units household income 0-30% persons per room greater than 1 less than or equal 1.5 MOE);
	%Moe_prop_a( var=Orentr_inc030_gt15_&years., mult=100, num=rentr_inc030_gt15_&years., den=renter_inc030_&years., 
                       num_moe=Mrentr_inc030_gt15_&years., den_moe=Mrenter_inc030_&years., label_moe = % Renter occupied units household income 0-30% persons per room greater than 1.5 MOE);

	%Pct_calc( var=Prentr_inc3050_lte1, label=% Renter occupied units household income 30-50% persons per room less than or equal 1, num=rentr_inc3050_lte1, den=renter_inc3050, years= &years. );
	%Pct_calc( var=Prentr_inc3050_lte15, label=% Renter occupied units household income 30-50% persons per room greater than 1 less than or equal 1.5, num=rentr_inc3050_lte15, den=renter_inc3050, years= &years. );
	%Pct_calc( var=Prentr_inc3050_gt15, label=% Renter occupied units household income 30-50% persons per room greater than 1.5, num=rentr_inc3050_gt15, den=renter_inc3050, years= &years. );

	%Moe_prop_a( var=Orentr_inc3050_lte1_&years., mult=100, num=rentr_inc3050_lte1_&years., den=renter_inc3050_&years., 
                       num_moe=Mrentr_inc3050_lte1_&years., den_moe=Mrenter_inc3050_&years., label_moe =% Renter occupied units household income 30-50% persons per room less than or equal 1  MOE);
	%Moe_prop_a( var=Orentr_inc3050_lte15_&years., mult=100, num=rentr_inc3050_lte15_&years., den=renter_inc3050_&years., 
                       num_moe=Mrentr_inc3050_lte15_&years., den_moe=Mrenter_inc3050_&years., label_moe = % Renter occupied units household income 30-50% persons per room greater than 1 less than or equal 1.5 MOE);
	%Moe_prop_a( var=Orentr_inc3050_gt15_&years., mult=100, num=rentr_inc3050_gt15_&years., den=renter_inc3050_&years., 
                       num_moe=Mrentr_inc3050_gt15_&years., den_moe=Mrenter_inc3050_&years., label_moe = % Renter occupied units household income 30-50% persons per room greater than 1.5 MOE);

	%Pct_calc( var=Prentr_inc5080_lte1, label=% Renter occupied units household income 50-80% persons per room less than or equal 1, num=rentr_inc5080_lte1, den=renter_inc5080, years= &years. );
	%Pct_calc( var=Prentr_inc5080_lte15, label=% Renter occupied units household income 50-80% persons per room greater than 1 less than or equal 1.5, num=rentr_inc5080_lte15, den=renter_inc5080, years= &years. );
	%Pct_calc( var=Prentr_inc5080_gt15, label=% Renter occupied units household income 50-80% persons per room greater than 1.5, num=rentr_inc5080_gt15, den=renter_inc5080, years= &years. );

	%Moe_prop_a( var=Orentr_inc5080_lte1_&years., mult=100, num=rentr_inc5080_lte1_&years., den=renter_inc5080_&years., 
                       num_moe=Mrentr_inc5080_lte1_&years., den_moe=Mrenter_inc5080_&years., label_moe = % Renter occupied units household income 50-80% persons per room less than or equal 1 MOE);
	%Moe_prop_a( var=Orentr_inc5080_lte15_&years., mult=100, num=rentr_inc5080_lte15_&years., den=renter_inc5080_&years., 
                       num_moe=Mrentr_inc5080_lte15_&years., den_moe=Mrenter_inc5080_&years., label_moe = % Renter occupied units household income 50-80% persons per room greater than 1 less than or equal 1.5 MOE);
	%Moe_prop_a( var=Orentr_inc5080_gt15_&years., mult=100, num=rentr_inc5080_gt15_&years., den=renter_inc5080_&years., 
                       num_moe=Mrentr_inc5080_gt15_&years., den_moe=Mrenter_inc5080_&years., label_moe = % Renter occupied units household income 50-80% persons per room greater than 1.5 MOE);

	%Pct_calc( var=Prentr_inc80100_lte1, label=% Renter occupied units household income 80-100% persons per room less than or equal 1, num=rentr_inc80100_lte1, den=renter_inc80100, years= &years. );
	%Pct_calc( var=Prentr_inc80100_lte15, label=% Renter occupied units household income 80-100% persons per room greater than 1 less than or equal 1.5, num=rentr_inc80100_lte15, den=renter_inc80100, years= &years. );
	%Pct_calc( var=Prentr_inc80100_gt15, label=% Renter occupied units household income 80-100% persons per room greater than 1.5, num=rentr_inc80100_gt15, den=renter_inc80100, years= &years. );

	%Moe_prop_a( var=Orentr_inc80100_lte1_&years., mult=100, num=rentr_inc80100_lte1_&years., den=renter_inc80100_&years., 
                       num_moe=Mrentr_inc80100_lte1_&years., den_moe=Mrenter_inc80100_&years., label_moe = % Renter occupied units household income 80-100% persons per room less than or equal 1 MOE);
	%Moe_prop_a( var=Orentr_inc80100_lte15_&years., mult=100, num=rentr_inc80100_lte15_&years., den=renter_inc80100_&years., 
                       num_moe=Mrentr_inc80100_lte15_&years., den_moe=Mrenter_inc80100_&years., label_moe = % Renter occupied units household income 80-100% persons per room greater than 1 less than or equal 1.5 MOE);
	%Moe_prop_a( var=Orentr_inc80100_gt15_&years., mult=100, num=rentr_inc80100_gt15_&years., den=renter_inc80100_&years., 
                       num_moe=Mrentr_inc80100_gt15_&years., den_moe=Mrenter_inc80100_&years., label_moe = % Renter occupied units household income 80-100% persons per room greater than 1.5 MOE);

	%Pct_calc( var=Prentr_inc100pl_lte1, label=% Renter occupied units household income 100%+ persons per room less than or equal 1, num=rentr_inc100pl_lte1, den=renter_inc100pl, years= &years. );
	%Pct_calc( var=Prentr_inc100pl_lte15, label=% Renter occupied units household income 100%+ persons per room greater than 1 less than or equal 1.5, num=rentr_inc100pl_lte15, den=renter_inc100pl, years= &years. );
	%Pct_calc( var=Prentr_inc100pl_gt15, label=% Renter occupied units household income 100%+ persons per room greater than 1.5, num=rentr_inc100pl_gt15, den=renter_inc100pl, years= &years. );

	%Moe_prop_a( var=Orentr_inc100pl_lte1_&years., mult=100, num=rentr_inc100pl_lte1_&years., den=renter_inc100pl_&years., 
                       num_moe=Mrentr_inc100pl_lte1_&years., den_moe=Mrenter_inc100pl_&years., label_moe = % Renter occupied units household income 100%+ persons per room less than or equal 1 MOE);
	%Moe_prop_a( var=Orentr_inc100pl_lte15_&years., mult=100, num=rentr_inc100pl_lte15_&years., den=renter_inc100pl_&years., 
                       num_moe=Mrentr_inc100pl_lte15_&years., den_moe=Mrenter_inc100pl_&years., label_moe = % Renter occupied units household income 100%+ persons per room greater than 1 less than or equal 1.5 MOE);
	%Moe_prop_a( var=Orentr_inc100pl_gt15_&years., mult=100, num=rentr_inc100pl_gt15_&years., den=renter_inc100pl_&years., 
                       num_moe=Mrentr_inc100pl_gt15_&years., den_moe=Mrenter_inc100pl_&years., label_moe = % Renter occupied units household income 100%+ persons per room greater than 1.5 MOE);

	%Pct_calc( var=Prentr_inc030_lte1_1fam, label=% Renter occupied units household income 0-30% one family persons per room less than or equal 1, num=rentr_inc030_lte1_1fam, den=rentr_inc030_1fam, years= &years. );
	%Pct_calc( var=Prentr_inc030_lte15_1fam, label=% Renter occupied units household income 0-30% one family persons per room greater than 1 less than or equal 1.5, num=rentr_inc030_lte15_1fam, den=rentr_inc030_1fam, years= &years. );
	%Pct_calc( var=Prentr_inc030_gt15_1fam, label=% Renter occupied units household income 0-30% one family persons per room greater than 1.5, num=rentr_inc030_gt15_1fam, den=rentr_inc030_1fam, years= &years. );

	%Moe_prop_a( var=Orentr_inc030_lte1_1fam_&years., mult=100, num=rentr_inc030_lte1_1fam_&years., den=rentr_inc030_1fam_&years., 
                       num_moe=Mrentr_inc030_lte1_1fam_&years., den_moe=Mrentr_inc030_1fam_&years., label_moe = % Renter occupied units household income 0-30% one family persons per room less than or equal 1 MOE);
	%Moe_prop_a( var=Orentr_inc030_lte15_1fam_&years., mult=100, num=rentr_inc030_lte15_1fam_&years., den=rentr_inc030_1fam_&years., 
                       num_moe=Mrentr_inc030_lte15_1fam_&years., den_moe=Mrentr_inc030_1fam_&years., label_moe = % Renter occupied units household income 0-30% one family persons per room greater than 1 less than or equal 1.5 MOE);
	%Moe_prop_a( var=Orentr_inc030_gt15_1fam_&years., mult=100, num=rentr_inc030_gt15_1fam_&years., den=rentr_inc030_1fam_&years., 
                       num_moe=Mrentr_inc030_gt15_1fam_&years., den_moe=Mrentr_inc030_1fam_&years., label_moe = % Renter occupied units household income 0-30% one family persons per room greater than 1.5 MOE);

	%Pct_calc( var=Prentr_inc030_lte1_sfam, label=% Renter occupied units household income 0-30% one family with subfamily persons per room less than or equal 1, num=rentr_inc030_lte1_sfam, den=rentr_inc030_sfam, years= &years. );
	%Pct_calc( var=Prentr_inc030_lte15_sfam, label=% Renter occupied units household income 0-30% one family with subfamily persons per room greater than 1 less than or equal 1.5, num=rentr_inc030_lte15_sfam, den=rentr_inc030_sfam, years= &years. );
	%Pct_calc( var=Prentr_inc030_gt15_sfam, label=% Renter occupied units household income 0-30% one family with subfamily persons per room greater than 1.5, num=rentr_inc030_gt15_sfam, den=rentr_inc030_sfam, years= &years. );

	%Moe_prop_a( var=Orentr_inc030_lte1_sfam_&years., mult=100, num=rentr_inc030_lte1_sfam_&years., den=rentr_inc030_sfam_&years., 
                       num_moe=Mrentr_inc030_lte1_sfam_&years., den_moe=Mrentr_inc030_sfam_&years., label_moe = % Renter occupied units household income 0-30% one family with subfamily persons per room less than or equal 1 MOE);
	%Moe_prop_a( var=Orentr_inc030_lte15_sfam_&years., mult=100, num=rentr_inc030_lte15_sfam_&years., den=rentr_inc030_sfam_&years., 
                       num_moe=Mrentr_inc030_lte15_sfam_&years., den_moe=Mrentr_inc030_sfam_&years., label_moe = % Renter occupied units household income 0-30% one family with subfamily persons per room greater than 1 less than or equal 1.5 MOE);
	%Moe_prop_a( var=Orentr_inc030_gt15_sfam_&years., mult=100, num=rentr_inc030_gt15_sfam_&years., den=rentr_inc030_sfam_&years., 
                       num_moe=Mrentr_inc030_gt15_sfam_&years., den_moe=Mrentr_inc030_sfam_&years., label_moe = % Renter occupied units household income 0-30% one family with subfamily persons per room greater than 1.5 MOE);

	%Pct_calc( var=Prentr_inc030_lte1_nfam, label=% Renter occupied units household income 0-30% non-family persons per room less than or equal 1, num=rentr_inc030_lte1_nfam, den=rentr_inc030_nfam, years= &years. );
	%Pct_calc( var=Prentr_inc030_lte15_nfam, label=% Renter occupied units household income 0-30% non-family persons per room greater than 1 less than or equal 1.5, num=rentr_inc030_lte15_nfam, den=rentr_inc030_nfam, years= &years. );
	%Pct_calc( var=Prentr_inc030_gt15_nfam, label=% Renter occupied units household income 0-30% non-family persons per room greater than 1.5, num=rentr_inc030_gt15_nfam, den=rentr_inc030_nfam, years= &years. );

	%Moe_prop_a( var=Orentr_inc030_lte1_nfam_&years., mult=100, num=rentr_inc030_lte1_nfam_&years., den=rentr_inc030_nfam_&years., 
                       num_moe=Mrentr_inc030_lte1_nfam_&years., den_moe=Mrentr_inc030_nfam_&years., label_moe = % Renter occupied units household income 0-30% non-family persons per room less than or equal 1 MOE);
	%Moe_prop_a( var=Orentr_inc030_lte15_nfam_&years., mult=100, num=rentr_inc030_lte15_nfam_&years., den=rentr_inc030_nfam_&years., 
                       num_moe=Mrentr_inc030_lte15_nfam_&years., den_moe=Mrentr_inc030_nfam_&years., label_moe = % Renter occupied units household income 0-30% non-family persons per room greater than 1 less than or equal 1.5 MOE);
	%Moe_prop_a( var=Orentr_inc030_gt15_nfam_&years., mult=100, num=rentr_inc030_gt15_nfam_&years., den=rentr_inc030_nfam_&years., 
                       num_moe=Mrentr_inc030_gt15_nfam_&years., den_moe=Mrentr_inc030_nfam_&years., label_moe = % Renter occupied units household income 0-30% non-family persons per room greater than 1.5 MOE);

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

	Mrenter_bt00_&years. = T12_moe109;
	Mrenter_bt8099_&years. = T12_moe130;
	Mrenter_bt6079_&years. = T12_moe151;
	Mrenter_bt4059_&years. = T12_moe172;
	Mrenter_bt39_&years. = T12_moe193;

	Mrenter_in50_&years. = %moe_sum(var= T12_moe110 T12_moe131 T12_moe152 T12_moe173 T12_moe194);
	Mrenter_in5080_&years. = %moe_sum(var= T12_moe115 T12_moe136 T12_moe157 T12_moe178 T12_moe199);
	Mrenter_in80120_&years. = %moe_sum(var= T12_moe120 T12_moe141 T12_moe162 T12_moe183 T12_moe204);
	Mrenter_in120pl_&years. = %moe_sum(var= T12_moe125 T12_moe146 T12_moe167 T12_moe188 T12_moe209);

	Mrenter_inc050_bt00_&years. = T12_moe110;
	Mrenter_inc050_bt8099_&years. = T12_moe131;
	Mrenter_inc050_bt6079_&years. = T12_moe152;
	Mrenter_inc050_bt4059_&years. = T12_moe173;
	Mrenter_inc050_bt39_&years. = T12_moe194;

	Mrenter_inc5080_bt00_&years. = T12_moe115;
	Mrenter_inc5080_bt8099_&years. = T12_moe136;
	Mrenter_inc5080_bt6079_&years. = T12_moe157;
	Mrenter_inc5080_bt4059_&years. = T12_moe178;
	Mrenter_inc5080_bt39_&years. = T12_moe199;

	Mrenter_inc80120_bt00_&years. = T12_moe120;
	Mrenter_inc80120_bt8099_&years. = T12_moe141;
	Mrenter_inc80120_bt6079_&years. = T12_moe162;
	Mrenter_inc80120_bt4059_&years. = T12_moe183;
	Mrenter_inc80120_bt39_&years. = T12_moe204;

	Mrenter_inc120pl_bt00_&years. = T12_moe125;
	Mrenter_inc120pl_bt8099_&years. = T12_moe146;
	Mrenter_inc120pl_bt6079_&years. = T12_moe167;
	Mrenter_inc120pl_bt4059_&years. = T12_moe188;
	Mrenter_inc120pl_bt39_&years. = T12_moe209;

	Mrenter_ncb_inc050_bt00_&years. = T12_moe111 ;
	Mrenter_ncb_inc050_bt8099_&years. = T12_moe132 ;
	Mrenter_ncb_inc050_bt6079_&years. = T12_moe153;
	Mrenter_ncb_inc050_bt4059_&years. = T12_moe174;
	Mrenter_ncb_inc050_bt39_&years. = T12_moe195 ;

	Mrenter_cb_inc050_bt00_&years. = %moe_sum(var= T12_moe112 T12_moe113);
	Mrenter_cb_inc050_bt8099_&years. = %moe_sum(var= T12_moe133 T12_moe134);
	Mrenter_cb_inc050_bt6079_&years. = %moe_sum(var= T12_moe154 T12_moe155 );
	Mrenter_cb_inc050_bt4059_&years. = %moe_sum(var= T12_moe175 T12_moe176 );
	Mrenter_cb_inc050_bt39_&years. = %moe_sum(var= T12_moe196 T12_moe197 );

	Mrenter_scb_inc050_bt00_&years. = T12_moe113;
	Mrenter_scb_inc050_bt8099_&years. = T12_moe134 ;
	Mrenter_scb_inc050_bt6079_&years. = T12_moe155;
	Mrenter_scb_inc050_bt4059_&years. = T12_moe176 ;
	Mrenter_scb_inc050_bt39_&years. = T12_moe197 ;

	Mrenter_cb_inc050_&years. = %moe_sum(var= T12_moe112 T12_moe113 T12_moe133 T12_moe134 T12_moe154 T12_moe155 T12_moe175 T12_moe176 T12_moe196 T12_moe197);
	Mrenter_scb_inc050_&years. = %moe_sum(var= T12_moe113 T12_moe134 T12_moe155 T12_moe176 T12_moe197);
	Mrenter_ncb_inc050_&years. = %moe_sum(var= T12_moe111 T12_moe132 T12_moe153 T12_moe174 T12_moe195);


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

	Mrenter_bt00_&years. = "Renter occupied units, built 2000 or later, MOE &years_dash."
	Mrenter_bt8099_&years. = "Renter occupied units, built 1980-1999, MOE &years_dash."
	Mrenter_bt6079_&years. = "Renter occupied units, built 1960-1979, MOE &years_dash."
	Mrenter_bt4059_&years. = "Renter occupied units, built 1940-1959, MOE &years_dash."
	Mrenter_bt39_&years. = "Renter occupied units, built 1940-1959, MOE &years_dash."
	Mrenter_in50_&years. = "Renter occupied units, household income 0-50%, MOE &years_dash."
	Mrenter_in5080_&years. = "Renter occupied units, household income 0-50%, MOE &years_dash."
	Mrenter_in80120_&years. = "Renter occupied units, household income 50-80%, MOE &years_dash."
	Mrenter_in120pl_&years. = "Renter occupied units, household income 120%+, MOE &years_dash."
	Mrenter_inc050_bt00_&years. = "Renter occupied units, household income 0-50%, built 2000 or later, MOE &years_dash."
	Mrenter_inc050_bt8099_&years. = "Renter occupied units, household income 0-50%, built 1980-1999, MOE &years_dash."
	Mrenter_inc050_bt6079_&years. = "Renter occupied units, household income 0-50%, built 1960-1979, MOE &years_dash."
	Mrenter_inc050_bt4059_&years. = "Renter occupied units, household income 0-50%, built 1940-1959, MOE &years_dash."
	Mrenter_inc050_bt39_&years. = "Renter occupied units, household income 0-50%, built 1939 or earlier, MOE &years_dash."
	Mrenter_inc5080_bt00_&years. = "Renter occupied units, household income 50-80%, built 2000 or later, MOE &years_dash."
	Mrenter_inc5080_bt8099_&years. = "Renter occupied units, household income 50-80%, built 1980-1999, MOE &years_dash."
	Mrenter_inc5080_bt6079_&years. = "Renter occupied units, household income 50-80%, built 1960-1979, MOE &years_dash."
	Mrenter_inc5080_bt4059_&years. = "Renter occupied units, household income 50-80%, built 1940-1959, MOE &years_dash."
	Mrenter_inc5080_bt39_&years. = "Renter occupied units, household income 50-80%, built 1939 or earlier, MOE &years_dash."
	Mrenter_inc80120_bt00_&years. = "Renter occupied units, household income 80-120%, built 2000 or later, MOE &years_dash."
	Mrenter_inc80120_bt8099_&years. = "Renter occupied units, household income 80-120%, built 1980-1999, MOE &years_dash."
	Mrenter_inc80120_bt6079_&years. = "Renter occupied units, household income 80-120%, built 1960-1979, MOE &years_dash."
	Mrenter_inc80120_bt4059_&years. = "Renter occupied units, household income 80-120%, built 1940-1959, MOE &years_dash."
	Mrenter_inc80120_bt39_&years. = "Renter occupied units, household income 80-120%, built 1939 or earlier, MOE &years_dash."
	Mrenter_inc120pl_bt00_&years. = "Renter occupied units, household income 120%+, built 2000 or later, MOE &years_dash."
	Mrenter_inc120pl_bt8099_&years. = "Renter occupied units, household income 120%+, built 1980-1999, MOE &years_dash."
	Mrenter_inc120pl_bt6079_&years. = "Renter occupied units, household income 120%+, built 1960-1979, MOE &years_dash."
	Mrenter_inc120pl_bt4059_&years. = "Renter occupied units, household income 120%+, built 1940-1959, MOE &years_dash."
	Mrenter_inc120pl_bt39_&years. = "Renter occupied units, household income 120%+, built 1939 or earlier, MOE &years_dash."
	Mrenter_ncb_inc050_bt00_&years. = "Renter occupied units, not cost burdened, household income 50-80%, built 1980-1999, MOE &years_dash."
	Mrenter_ncb_inc050_bt8099_&years. = "Renter occupied units, not cost burdened, household income 50-80%, built 1980-1999, MOE &years_dash."
	Mrenter_ncb_inc050_bt6079_&years. = "Renter occupied units, not cost burdened, household income 50-80%, built 1960-1979, MOE &years_dash."
	Mrenter_ncb_inc050_bt4059_&years. = "Renter occupied units, not cost burdened, household income 50-80%, built 1940-1959, MOE &years_dash."
	Mrenter_ncb_inc050_bt39_&years. = "Renter occupied units, not cost burdened, household income 50-80%, built 1939 or earlier, MOE &years_dash."
	Mrenter_cb_inc050_bt00_&years. = "Renter occupied units, cost burdened, household income 50-80%, built 1980-1999, MOE &years_dash."
	Mrenter_cb_inc050_bt8099_&years. = "Renter occupied units, cost burdened, household income 50-80%, built 1980-1999, MOE &years_dash."
	Mrenter_cb_inc050_bt6079_&years. = "Renter occupied units, cost burdened, household income 50-80%, built 1960-1979, MOE &years_dash."
	Mrenter_cb_inc050_bt4059_&years. = "Renter occupied units, cost burdened, household income 50-80%, built 1940-1959, MOE &years_dash."
	Mrenter_cb_inc050_bt39_&years. = "Renter occupied units, cost burdened, household income 50-80%, built 1939 or earlier, MOE &years_dash."
	Mrenter_scb_inc050_bt00_&years. = "Renter occupied units, severely cost burdened, household income 50-80%, built 1980-1999, MOE &years_dash."
	Mrenter_scb_inc050_bt8099_&years. = "Renter occupied units, severely cost burdened, household income 50-80%, built 1980-1999, MOE &years_dash."
	Mrenter_scb_inc050_bt6079_&years. = "Renter occupied units, severely cost burdened, household income 50-80%, built 1960-1979, MOE &years_dash."
	Mrenter_scb_inc050_bt4059_&years. = "Renter occupied units, severely cost burdened, household income 50-80%, built 1940-1959, MOE &years_dash."
	Mrenter_scb_inc050_bt39_&years. = "Renter occupied units, severely cost burdened, household income 50-80%, built 1939 or earlier, MOE &years_dash."
	Mrenter_cb_inc050_&years. = "Renter occupied units, household income 50-80%, cost burndened, MOE &years_dash."
	Mrenter_scb_inc050_&years. = "Renter occupied units, household income 50-80%, severely cost burndened, MOE &years_dash."
	Mrenter_ncb_inc050_&years. = "Renter occupied units, household income 50-80%, not cost burndened, MOE &years_dash."
	;

	%Pct_calc( var=Prenter_inc050_bt00, label=% Renter occupied units household income 0-50% built 2000 or later, num=renter_inc050_bt00, den=renter_in50, years= &years. );
	%Pct_calc( var=Prenter_inc050_bt8099, label=% Renter occupied units household income 0-50% built 1980-1999, num=renter_inc050_bt8099, den=renter_in50, years= &years. );
	%Pct_calc( var=Prenter_inc050_bt6079, label=% Renter occupied units household income 0-50% built 1960-1979, num=renter_inc050_bt6079, den=renter_in50, years= &years. );
	%Pct_calc( var=Prenter_inc050_bt4059, label=% Renter occupied units household income 0-50% built 1940-1959, num=renter_inc050_bt4059, den=renter_in50, years= &years. );
	%Pct_calc( var=Prenter_inc050_bt39, label=% Renter occupied units household income 0-50% built 1939 or earlier, num=renter_inc050_bt39, den=renter_in50, years= &years. );

	%Moe_prop_a( var=Orenter_inc050_bt00_&years., mult=100, num=renter_inc050_bt00_&years., den=renter_in50_&years., 
                       num_moe=Mrenter_inc050_bt00_&years., den_moe=Mrenter_in50_&years., label_moe = % Renter occupied units household income 0-50% built 2000 or later MOE);
	%Moe_prop_a( var=Orenter_inc050_bt8099_&years., mult=100, num=renter_inc050_bt8099_&years., den=renter_in50_&years., 
                       num_moe=Mrenter_inc050_bt8099_&years., den_moe=Mrenter_in50_&years., label_moe = % Renter occupied units household income 0-50% built 1980-1999 MOE);
	%Moe_prop_a( var=Orenter_inc050_bt6079_&years., mult=100, num=renter_inc050_bt6079_&years., den=renter_in50_&years., 
                       num_moe=Mrenter_inc050_bt6079_&years., den_moe=Mrenter_in50_&years., label_moe = % Renter occupied units household income 0-50% built 1960-1979 MOE);
	%Moe_prop_a( var=Orenter_inc050_bt4059_&years., mult=100, num=renter_inc050_bt4059_&years., den=renter_in50_&years., 
                       num_moe=Mrenter_inc050_bt4059_&years., den_moe=Mrenter_in50_&years., label_moe = % Renter occupied units household income 0-50% built 1940-1959 MOE);
	%Moe_prop_a( var=Orenter_inc050_bt39_&years., mult=100, num=renter_inc050_bt39_&years., den=renter_in50_&years., 
                       num_moe=Mrenter_inc050_bt39_&years., den_moe=Mrenter_in50_&years., label_moe = % Renter occupied units household income 0-50% built 1939 or earlier MOE);

	%Pct_calc( var=Prenter_inc5080_bt00, label=% Renter occupied units household income 50-80% built 2000 or later, num=renter_inc5080_bt00, den=renter_in5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_bt8099, label=% Renter occupied units household income 50-80% built 1980-1999, num=renter_inc5080_bt8099, den=renter_in5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_bt6079, label=% Renter occupied units household income 50-80% built 1960-1979, num=renter_inc5080_bt6079, den=renter_in5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_bt4059, label=% Renter occupied units household income 50-80% built 1940-1959, num=renter_inc5080_bt4059, den=renter_in5080, years= &years. );
	%Pct_calc( var=Prenter_inc5080_bt39, label=% Renter occupied units household income 50-80% built 1939 or earlier, num=renter_inc5080_bt39, den=renter_in5080, years= &years. );

	%Moe_prop_a( var=Orenter_inc5080_bt00_&years., mult=100, num=renter_inc5080_bt00_&years., den=renter_in5080_&years., 
                       num_moe=Mrenter_inc5080_bt00_&years., den_moe=Mrenter_in5080_&years., label_moe = % Renter occupied units household income 50-80% built 2000 or later MOE);
	%Moe_prop_a( var=Orenter_inc5080_bt8099_&years., mult=100, num=renter_inc5080_bt8099_&years., den=renter_in5080_&years., 
                       num_moe=Mrenter_inc5080_bt8099_&years., den_moe=Mrenter_in5080_&years., label_moe = % Renter occupied units household income 50-80% built 1980-1999 MOE);
	%Moe_prop_a( var=Orenter_inc5080_bt6079_&years., mult=100, num=renter_inc5080_bt6079_&years., den=renter_in5080_&years., 
                       num_moe=Mrenter_inc5080_bt6079_&years., den_moe=Mrenter_in5080_&years., label_moe = % Renter occupied units household income 50-80% built 1960-1979 MOE);
	%Moe_prop_a( var=Orenter_inc5080_bt4059_&years., mult=100, num=renter_inc5080_bt4059_&years., den=renter_in5080_&years., 
                       num_moe=Mrenter_inc5080_bt4059_&years., den_moe=Mrenter_in5080_&years., label_moe = % Renter occupied units household income 50-80% built 1940-1959 MOE);
	%Moe_prop_a( var=Orenter_inc5080_bt39_&years., mult=100, num=renter_inc5080_bt39_&years., den=renter_in5080_&years., 
                       num_moe=Mrenter_inc5080_bt39_&years., den_moe=Mrenter_in5080_&years., label_moe =  MOE);

	%Pct_calc( var=Prenter_inc80120_bt00, label=% Renter occupied units household income 80-120% built 2000 or later, num=renter_inc80120_bt00, den=renter_in80120, years= &years. );
	%Pct_calc( var=Prenter_inc80120_bt8099, label=% Renter occupied units household income 80-120% built 1980-1999, num=renter_inc80120_bt8099, den=renter_in80120, years= &years. );
	%Pct_calc( var=Prenter_inc80120_bt6079, label=% Renter occupied units household income 80-120% built 1960-1979, num=renter_inc80120_bt6079, den=renter_in80120, years= &years. );
	%Pct_calc( var=Prenter_inc80120_bt4059, label=% Renter occupied units household income 80-120% built 1940-1959, num=renter_inc80120_bt4059, den=renter_in80120, years= &years. );
	%Pct_calc( var=Prenter_inc80120_bt39, label=% Renter occupied units household income 80-120% built 1939 or earlier, num=renter_inc80120_bt39, den=renter_in80120, years= &years. );

	%Moe_prop_a( var=Orenter_inc80120_bt00_&years., mult=100, num=renter_inc80120_bt00_&years., den=renter_in80120_&years., 
                       num_moe=Mrenter_inc80120_bt00_&years., den_moe=Mrenter_in80120_&years., label_moe = % Renter occupied units household income 80-120% built 2000 or later MOE);
	%Moe_prop_a( var=Orenter_inc80120_bt8099_&years., mult=100, num=renter_inc80120_bt8099_&years., den=renter_in80120_&years., 
                       num_moe=Mrenter_inc80120_bt8099_&years., den_moe=Mrenter_in80120_&years., label_moe = % Renter occupied units household income 80-120% built 1980-1999 MOE);
	%Moe_prop_a( var=Orenter_inc80120_bt6079_&years., mult=100, num=renter_inc80120_bt6079_&years., den=renter_in80120_&years., 
                       num_moe=Mrenter_inc80120_bt6079_&years., den_moe=Mrenter_in80120_&years., label_moe = % Renter occupied units household income 80-120% built 1960-1979 MOE);
	%Moe_prop_a( var=Orenter_inc80120_bt4059_&years., mult=100, num=renter_inc80120_bt4059_&years., den=renter_in80120_&years., 
                       num_moe=Mrenter_inc80120_bt4059_&years., den_moe=Mrenter_in80120_&years., label_moe = % Renter occupied units household income 80-120% built 1940-1959 MOE);
	%Moe_prop_a( var=Orenter_inc80120_bt39_&years., mult=100, num=renter_inc80120_bt39_&years., den=renter_in80120_&years., 
                       num_moe=Mrenter_inc80120_bt39_&years., den_moe=Mrenter_in80120_&years., label_moe = % Renter occupied units household income 80-120% built 1939 or earlier MOE);

	%Pct_calc( var=Prenter_inc120pl_bt00, label=% Renter occupied units household income 120%+ built 2000 or later, num=renter_inc120pl_bt00, den=renter_in120pl, years= &years. );
	%Pct_calc( var=Prenter_inc120pl_bt8099, label=% Renter occupied units household income 120%+ built 1980-1999, num=renter_inc120pl_bt8099, den=renter_in120pl, years= &years. );
	%Pct_calc( var=Prenter_inc120pl_bt6079, label=% Renter occupied units household income 120%+ built 1960-1979, num=renter_inc120pl_bt6079, den=renter_in120pl, years= &years. );
	%Pct_calc( var=Prenter_inc120pl_bt4059, label=% Renter occupied units household income 120%+ built 1940-1959, num=renter_inc120pl_bt4059, den=renter_in120pl, years= &years. );
	%Pct_calc( var=Prenter_inc120pl_bt39, label=% Renter occupied units household income 120%+ built 1939 or earlier, num=renter_inc120pl_bt39, den=renter_in120pl, years= &years. );

	%Moe_prop_a( var=Orenter_inc120pl_bt00_&years., mult=100, num=renter_inc120pl_bt00_&years., den=renter_in120pl_&years., 
                       num_moe=Mrenter_inc120pl_bt00_&years., den_moe=Mrenter_in120pl_&years., label_moe = % Renter occupied units household income 120%+ built 2000 or later MOE);
	%Moe_prop_a( var=Orenter_inc120pl_bt8099_&years., mult=100, num=renter_inc120pl_bt8099_&years., den=renter_in120pl_&years., 
                       num_moe=Mrenter_inc120pl_bt8099_&years., den_moe=Mrenter_in120pl_&years., label_moe = % Renter occupied units household income 120%+ built 1980-1999 MOE);
	%Moe_prop_a( var=Orenter_inc120pl_bt6079_&years., mult=100, num=renter_inc120pl_bt6079_&years., den=renter_in120pl_&years., 
                       num_moe=Mrenter_inc120pl_bt6079_&years., den_moe=Mrenter_in120pl_&years., label_moe = % Renter occupied units household income 120%+ built 1960-1979 MOE);
	%Moe_prop_a( var=Orenter_inc120pl_bt4059_&years., mult=100, num=renter_inc120pl_bt4059_&years., den=renter_in120pl_&years., 
                       num_moe=Mrenter_inc120pl_bt4059_&years., den_moe=Mrenter_in120pl_&years., label_moe = % Renter occupied units household income 120%+ built 1940-1959 MOE);
	%Moe_prop_a( var=Orenter_inc120pl_bt39_&years., mult=100, num=renter_inc120pl_bt39_&years., den=renter_in120pl_&years., 
                       num_moe=Mrenter_inc120pl_bt39_&years., den_moe=Mrenter_in120pl_&years., label_moe = % Renter occupied units household income 120%+ built 1939 or earlier MOE);

	%Pct_calc( var=Prenter_ncb_in050_bt00, label=% Renter occupied units NOT cost burdened built 2000 or later, num=renter_ncb_inc050_bt00, den=renter_ncb_inc050, years= &years. );
	%Pct_calc( var=Prenter_ncb_in050_bt8099, label=% Renter occupied units NOT cost burdened built 1980-1999, num=renter_ncb_inc050_bt8099, den=renter_ncb_inc050, years= &years. );
	%Pct_calc( var=Prenter_ncb_in050_bt6079, label=% Renter occupied units NOT cost burdened built 1960-1979, num=renter_ncb_inc050_bt6079, den=renter_ncb_inc050, years= &years. );
	%Pct_calc( var=Prenter_ncb_in050_bt4059, label=% Renter occupied units NOT cost burdened built 1940-1959, num=renter_ncb_inc050_bt4059, den=renter_ncb_inc050, years= &years. );
	%Pct_calc( var=Prenter_ncb_in050_bt39, label=% Renter occupied units NOT cost burdened built 1939 or earlier, num=renter_ncb_inc050_bt39, den=renter_ncb_inc050, years= &years. );

	%Moe_prop_a( var=Orenter_ncb_in050_bt00_&years., mult=100, num=renter_ncb_inc050_bt00_&years., den=renter_ncb_inc050_&years., 
                       num_moe=Mrenter_ncb_inc050_bt00_&years., den_moe=Mrenter_ncb_inc050_&years., label_moe = % Renter occupied units NOT cost burdened built 2000 or later MOE);
	%Moe_prop_a( var=Orenter_ncb_in050_bt8099_&years., mult=100, num=renter_ncb_inc050_bt8099_&years., den=renter_ncb_inc050_&years., 
                       num_moe=Mrenter_ncb_inc050_bt8099_&years., den_moe=Mrenter_ncb_inc050_&years., label_moe = % Renter occupied units NOT cost burdened built 1980-1999 MOE);
	%Moe_prop_a( var=Orenter_ncb_in050_bt6079_&years., mult=100, num=renter_ncb_inc050_bt6079_&years., den=renter_ncb_inc050_&years., 
                       num_moe=Mrenter_ncb_inc050_bt6079_&years., den_moe=Mrenter_ncb_inc050_&years., label_moe = % Renter occupied units NOT cost burdened built 1960-1979 MOE);
	%Moe_prop_a( var=Orenter_ncb_in050_bt4059_&years., mult=100, num=renter_ncb_inc050_bt4059_&years., den=renter_ncb_inc050_&years., 
                       num_moe=Mrenter_ncb_inc050_bt4059_&years., den_moe=Mrenter_ncb_inc050_&years., label_moe = % Renter occupied units NOT cost burdened built 1940-1959 MOE);
	%Moe_prop_a( var=Orenter_ncb_in050_bt39_&years., mult=100, num=renter_ncb_inc050_bt39_&years., den=renter_ncb_inc050_&years., 
                       num_moe=Mrenter_ncb_inc050_bt39_&years., den_moe=Mrenter_ncb_inc050_&years., label_moe = % Renter occupied units NOT cost burdened built 1939 or earlier MOE);

	%Pct_calc( var=Prenter_cb_in050_bt00, label=% Renter occupied units cost burdened built 2000 or later, num=renter_cb_inc050_bt00, den=renter_cb_inc050, years= &years. );
	%Pct_calc( var=Prenter_cb_in050_bt8099, label=% Renter occupied units cost burdened built 1980-1999, num=renter_cb_inc050_bt8099, den=renter_cb_inc050, years= &years. );
	%Pct_calc( var=Prenter_cb_in050_bt6079, label=% Renter occupied units cost burdened built 1960-1979, num=renter_cb_inc050_bt6079, den=renter_cb_inc050, years= &years. );
	%Pct_calc( var=Prenter_cb_in050_bt4059, label=% Renter occupied units cost burdened built 1940-1959, num=renter_cb_inc050_bt4059, den=renter_cb_inc050, years= &years. );
	%Pct_calc( var=Prenter_cb_in050_bt39, label=% Renter occupied units cost burdened built 1939 or earlier, num=renter_cb_inc050_bt39, den=renter_cb_inc050, years= &years. );

	%Moe_prop_a( var=Orenter_cb_in050_bt00_&years., mult=100, num=renter_cb_inc050_bt00_&years., den=renter_cb_inc050_&years., 
                       num_moe=Mrenter_cb_inc050_bt00_&years., den_moe=Mrenter_cb_inc050_&years., label_moe = % Renter occupied units cost burdened built 2000 or later MOE);
	%Moe_prop_a( var=Orenter_cb_in050_bt8099_&years., mult=100, num=renter_cb_inc050_bt8099_&years., den=renter_cb_inc050_&years., 
                       num_moe=Mrenter_cb_inc050_bt8099_&years., den_moe=Mrenter_cb_inc050_&years., label_moe = % Renter occupied units cost burdened built 1980-1999 MOE);
	%Moe_prop_a( var=Orenter_cb_in050_bt6079_&years., mult=100, num=renter_cb_inc050_bt6079_&years., den=renter_cb_inc050_&years., 
                       num_moe=Mrenter_cb_inc050_bt6079_&years., den_moe=Mrenter_cb_inc050_&years., label_moe = % Renter occupied units cost burdened built 1960-1979 MOE);
	%Moe_prop_a( var=Orenter_cb_in050_bt4059_&years., mult=100, num=renter_cb_inc050_bt4059_&years., den=renter_cb_inc050_&years., 
                       num_moe=Mrenter_cb_inc050_bt4059_&years., den_moe=Mrenter_cb_inc050_&years., label_moe = % Renter occupied units cost burdened built 1940-1959 MOE);
	%Moe_prop_a( var=Orenter_cb_in050_bt39_&years., mult=100, num=renter_cb_inc050_bt39_&years., den=renter_cb_inc050_&years., 
                       num_moe=Mrenter_cb_inc050_bt39_&years., den_moe=Mrenter_cb_inc050_&years., label_moe = % Renter occupied units cost burdened built 1939 or earlier MOE);

	%Pct_calc( var=Prenter_scb_in050_bt00, label=% Renter occupied units severely cost burdened built 2000 or later, num=renter_scb_inc050_bt00, den=renter_scb_inc050, years= &years. );
	%Pct_calc( var=Prenter_scb_in050_bt8099, label=% Renter occupied units severely cost burdened built 1980-1999 or later, num=renter_scb_inc050_bt8099, den=renter_scb_inc050, years= &years. );
	%Pct_calc( var=Prenter_scb_in050_bt6079, label=% Renter occupied units severely cost burdened built 1960-1979, num=renter_scb_inc050_bt6079, den=renter_scb_inc050, years= &years. );
	%Pct_calc( var=Prenter_scb_in050_bt4059, label=% Renter occupied units severely cost burdened built 1940-1959, num=renter_scb_inc050_bt4059, den=renter_scb_inc050, years= &years. );
	%Pct_calc( var=Prenter_scb_in050_bt39, label=% Renter occupied units severely cost burdened built 1939 or earlier, num=renter_scb_inc050_bt39, den=renter_scb_inc050, years= &years. );

	%Moe_prop_a( var=Orenter_scb_in050_bt00_&years., mult=100, num=renter_scb_inc050_bt00_&years., den=renter_scb_inc050_&years., 
                       num_moe=Mrenter_scb_inc050_bt00_&years., den_moe=Mrenter_scb_inc050_&years., label_moe = % Renter occupied units severely cost burdened built 2000 or later MOE);
	%Moe_prop_a( var=Orenter_scb_in050_bt8099_&years., mult=100, num=renter_scb_inc050_bt8099_&years., den=renter_scb_inc050_&years., 
                       num_moe=Mrenter_scb_inc050_bt8099_&years., den_moe=Mrenter_scb_inc050_&years., label_moe = % Renter occupied units severely cost burdened built 1980-1999 or later MOE);
	%Moe_prop_a( var=Orenter_scb_in050_bt6079_&years., mult=100, num=renter_scb_inc050_bt6079_&years., den=renter_scb_inc050_&years., 
                       num_moe=Mrenter_scb_inc050_bt6079_&years., den_moe=Mrenter_scb_inc050_&years., label_moe = % Renter occupied units severely cost burdened built 1960-1979 MOE);
	%Moe_prop_a( var=Orenter_scb_in050_bt4059_&years., mult=100, num=renter_scb_inc050_bt4059_&years., den=renter_scb_inc050_&years., 
                       num_moe=Mrenter_scb_inc050_bt4059_&years., den_moe=Mrenter_scb_inc050_&years., label_moe = % Renter occupied units severely cost burdened built 1940-1959 MOE);
	%Moe_prop_a( var=Orenter_scb_in050_bt39_&years., mult=100, num=renter_scb_inc050_bt39_&years., den=renter_scb_inc050_&years., 
                       num_moe=Mrenter_scb_inc050_bt39_&years., den_moe=Mrenter_scb_inc050_&years., label_moe = % Renter occupied units severely cost burdened built 1939 or earlier MOE);

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


	%if %upcase( &years. ) = 2012_16 %then %do;

	/* Disability */
	renter_030_eyeear_&years. = T6_est89;
	renter_030_eyeear_1prob_&years. = T6_est90;
	renter_030_eyeear_0prob_&years. = T6_est91;
	renter_030_eyeear_nc_&years. = T6_est92;

	renter_030_amb_&years. = T6_est106;
	renter_030_amb_1prob_&years. = T6_est107;
	renter_030_amb_0prob_&years. = T6_est108;
	renter_030_amb_nc_&years. = T6_est109;

	renter_030_cog_&years. = T6_est123;
	renter_030_cog_1prob_&years. = T6_est124;
	renter_030_cog_0prob_&years. = T6_est125;
	renter_030_cog_nc_&years. = T6_est126;

	renter_030_self_&years. = T6_est140;
	renter_030_self_1prob_&years. = T6_est141;
	renter_030_self_0prob_&years. = T6_est142;
	renter_030_self_nc_&years. = T6_est143;

	renter_030_nodis_&years. = T6_est157;
	renter_030_nodis_1prob_&years. = T6_est158;
	renter_030_nodis_0prob_&years. = T6_est159;
	renter_030_nodis_nc_&years. = T6_est160;

	label
	renter_030_eyeear_&years. = "Renter occupied units, household income 0-30%, HH member has a hearing or vision impairment, &years_dash."
	renter_030_eyeear_1prob_&years. = "Renter occupied units, household income 0-30%, HH member has a hearing or vision impairment, 1 or more of the 4 housing unit problems, &years_dash."
	renter_030_eyeear_0prob_&years. = "Renter occupied units, household income 0-30%, HH member has a hearing or vision impairment, none of the 4 housing unit problems, &years_dash."
	renter_030_eyeear_nc_&years. = "Renter occupied units, household income 0-30%, HH member has a hearing or vision impairment, cost burden not computed, &years_dash."
	renter_030_amb_&years. = "Renter occupied units, household income 0-30%, HH member has an ambulatory limitation, &years_dash."
	renter_030_amb_1prob_&years. = "Renter occupied units, household income 0-30%, HH member has an ambulatory limitation, 1 or more of the 4 housing unit problems, &years_dash."
	renter_030_amb_0prob_&years. = "Renter occupied units, household income 0-30%, HH member has an ambulatory limitation, none of the 4 housing unit problems, &years_dash."
	renter_030_amb_nc_&years. = "Renter occupied units, household income 0-30%, HH member has an ambulatory limitation, cost burden not computed, &years_dash."
	renter_030_cog_&years. = "Renter occupied units, household income 0-30%, HH member has a cognitive limitation, &years_dash."
	renter_030_cog_1prob_&years. = "Renter occupied units, household income 0-30%, HH member a cognitive limitation, 1 or more of the 4 housing unit problems, &years_dash."
	renter_030_cog_0prob_&years. = "Renter occupied units, household income 0-30%, HH member a cognitive limitation, none of the 4 housing unit problems, &years_dash."
	renter_030_cog_nc_&years. = "Renter occupied units, household income 0-30%, HH member a cognitive limitation, cost burden not computed, &years_dash."
	renter_030_self_&years. = "Renter occupied units, household income 0-30%, HH member has self-care or independent living limitation, &years_dash."
	renter_030_self_1prob_&years. = "Renter occupied units, household income 0-30%, HH member has self-care or independent living limitation, 1 or more of the 4 housing unit problems, &years_dash."
	renter_030_self_0prob_&years. = "Renter occupied units, household income 0-30%, HH member has self-care or independent living limitation, none of the 4 housing unit problems, &years_dash."
	renter_030_self_nc_&years. = "Renter occupied units, household income 0-30%, HH member has self-care or independent living limitation, cost burden not computed, &years_dash."
	renter_030_nodis_&years. = "Renter occupied units, household income 0-30%, HH member has none of the limitations, &years_dash."
	renter_030_nodis_1prob_&years. = "Renter occupied units, household income 0-30%, HH member has none of the limitations, 1 or more of the 4 housing unit problems, &years_dash."
	renter_030_nodis_0prob_&years. = "Renter occupied units, household income 0-30%, HH member has none of the limitations, none of the 4 housing unit problems, &years_dash."
	renter_030_nodis_nc_&years. = "Renter occupied units, household income 0-30%, HH member an has none of the limitations, cost burden not computed, &years_dash."
	;

	%Pct_calc( var=Prenter_030_eyeear_1prob, label=% Renter occupied units household income 0-30% HH member has a hearing or vision impairment 1 or more of the 4 housing unit problems, num=renter_030_eyeear_1prob, den=renter_030_eyeear, years= &years. );
	%Pct_calc( var=Prenter_030_eyeear_0prob, label=% Renter occupied units household income 0-30% HH member has a hearing or vision impairment none of the 4 housing unit problems, num=renter_030_eyeear_0prob, den=renter_030_eyeear, years= &years. );
	%Pct_calc( var=Prenter_030_eyeear_nc, label=% Renter occupied units household income 0-30% HH member has a hearing or vision impairment cost burden not computed, num=renter_030_eyeear_nc, den=renter_030_eyeear, years= &years. );

	%Pct_calc( var=Prenter_030_amb_1prob, label=% Renter occupied units household income 0-30% HH member has an ambulatory limitation 1 or more of the 4 housing unit problems, num=renter_030_amb_1prob, den=renter_030_amb, years= &years. );
	%Pct_calc( var=Prenter_030_amb_0prob, label=% Renter occupied units household income 0-30% HH member has an ambulatory limitation none of the 4 housing unit problems, num=renter_030_amb_0prob, den=renter_030_amb, years= &years. );
	%Pct_calc( var=Prenter_030_amb_nc, label=% Renter occupied units household income 0-30% HH member has an ambulatory limitation cost burden not computed, num=renter_030_amb_nc, den=renter_030_amb, years= &years. );

	%Pct_calc( var=Prenter_030_cog_1prob, label=% Renter occupied units household income 0-30% HH member has a cognitive limitation 1 or more of the 4 housing unit problems, num=renter_030_cog_1prob, den=renter_030_cog, years= &years. );
	%Pct_calc( var=Prenter_030_cog_0prob, label=% Renter occupied units household income 0-30% HH member has a cognitive limitation none of the 4 housing unit problems, num=renter_030_cog_0prob, den=renter_030_cog, years= &years. );
	%Pct_calc( var=Prenter_030_cog_nc, label=% Renter occupied units household income 0-30% HH member has a cognitive limitation cost burden not computed, num=renter_030_cog_nc, den=renter_030_cog, years= &years. );

	%Pct_calc( var=Prenter_030_self_1prob, label=% Renter occupied units household income 0-30% HH member has a self-care or independent living limitation 1 or more of the 4 housing unit problems, num=renter_030_self_1prob, den=renter_030_self, years= &years. );
	%Pct_calc( var=Prenter_030_self_0prob, label=% Renter occupied units household income 0-30% HH member has a self-care or independent living limitation none of the 4 housing unit problems, num=renter_030_self_0prob, den=renter_030_self, years= &years. );
	%Pct_calc( var=Prenter_030_self_nc, label=% Renter occupied units household income 0-30% HH member has a self-care or independent living limitation cost burden not computed, num=renter_030_self_nc, den=renter_030_self, years= &years. );

	%Pct_calc( var=Prenter_030_nodis_1prob, label=% Renter occupied units household income 0-30% HH member has none of the limitations 1 or more of the 4 housing unit problems, num=renter_030_nodis_1prob, den=renter_030_nodis, years= &years. );
	%Pct_calc( var=Prenter_030_nodis_0prob, label=% Renter occupied units household income 0-30% HH member has none of the limitations none of the 4 housing unit problems, num=renter_030_nodis_0prob, den=renter_030_nodis, years= &years. );
	%Pct_calc( var=Prenter_030_nodis_nc, label=% Renter occupied units household income 0-30% HH member has none of the limitations cost burden not computed, num=renter_030_nodis_nc, den=renter_030_nodis, years= &years. );

	%end;

run;

%mend chas_summary_vars;


/* End of Macro */
