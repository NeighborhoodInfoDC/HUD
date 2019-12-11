/**************************************************************************
 Program:  Shorten CHAS Labels.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   Rob Pitingolo
 Created:  12/03/2019
 Version:  SAS 9.4
 Environment:  Windows
 Description: Use CHAS data dictionary to pull labels and then uses a macro
			  to shorten them so they fit in the SAS character limit. 
 Modifications: 

**************************************************************************/


/* Take the data diciontary from HUD and combine all the description variables in to a single column */
%macro makebiglist ();
	%do n = 1 %to 4;

data d&n.;
	set chasraw.Datadictionary;
	d = Description_&n.;
	keep d;
run;

%end;

%mend makebiglist; 
%makebiglist ();

data biglist;
	set d1 d2 d3 d4;
run;


/* Run a freq to get all of the unique values of the labels */
proc freq data = biglist ;
	tables d / out= dvars;
run;


/* Using the unique values, shorten the labels via macro and add back to the data dictionary */
data Datadictionary_short;
	set chasraw.Datadictionary;
	%macro makelabels (before,after);
	if Description_1 = &before. then Description_1 = &after.;
	if Description_2 = &before. then Description_2 = &after.;
	if Description_3 = &before. then Description_3 = &after.;
	if Description_4 = &before. then Description_4 = &after.;
	if Description_5 = &before. then Description_5 = &after.;
	%mend makelabels;



%makelabels (" AND Cost burden cannot be computed, none of the 3 other housing problems"," AND Cost burden cannot be computed, no other problems");
%makelabels (" AND Household income greater than 100% of HAMFI"," AND HH income GT 100% HAMFI");
%makelabels (" AND Household income greater than 30% of HAMFI but less than or equal to 50% of HAMFI"," AND HH income 30%-50% HAMFI");
%makelabels (" AND Household income greater than 50% of HAMFI but less than or equal to 80% of HAMFI"," AND HH income 50%-80% HAMFI");
%makelabels (" AND Household income greater than 80% of HAMFI but less than or equal to 100% of HAMFI"," AND HH income 80%-100% HAMFI");
%makelabels (" AND Household income is greater than 30% but less than or equal to 50% of HAMFI"," AND HH income is 30%-50% HAMFI");
%makelabels (" AND Household income is greater than 50% but less than or equal to 80% of HAMFI"," AND HH income is 50%-80% HAMFI");
%makelabels (" AND Household income is greater than 80% of HAMFI"," AND HH income is GT 80% HAMFI"); 
%makelabels (" AND Household income is less than or equal to 30% of HAMFI"," AND HH income is LTE 30% HAMFI");
%makelabels (" AND Household income less than or equal to 30% of HAMFI"," AND HH income is LTE 30% HAMFI");
%makelabels (" AND Rent greater than RHUD30 and less than or equal to RHUD50"," AND Rent RHUD30-RHUD50");
%makelabels (" AND Rent greater than RHUD50 and less than or equal to RHUD80"," AND Rent RHUD50-RHUD80"); 
%makelabels (" AND Rent greater than RHUD80"," AND Rent GT RHUD80");
%makelabels (" AND Rent less than or equal to RHUD30"," AND Rent LTE to RHUD30");
%makelabels (" AND Structure built between 1940 and 1959"," AND Structure built 1940-1959");
%makelabels (" AND Structure built between 1940 and 1979"," AND Structure built 1940-1979");
%makelabels (" AND Structure built between 1960 and 1979"," AND Structure built 1960-1979");
%makelabels (" AND Structure built between 1980 and 1999"," AND Structure built 1980-1999");
%makelabels (" AND Structure built in 1939 or earlier"," AND Structure built 1939 or earlier");
%makelabels (" AND Structure built in 1980 or later"," AND Structure built 1980 or later");
%makelabels (" AND Structure built in 2000 or later"," AND Structure built 2000 or later");
%makelabels (" AND Value greater than VHUD100"," AND Value GT VHUD100");
%makelabels (" AND Value greater than VHUD50 and less than or equal to VHUD80"," AND Value VHUD50-VHUD80");
%makelabels (" AND Value greater than VHUD80 and less than or equal to VHUD100"," AND Value VHUD80-VHUD100");
%makelabels (" AND Value less than or equal to VHUD50"," AND Value LTE to VHUD50");
%makelabels (" AND cost burden not computed, household has none of the other housing problems"," AND cost burden not computed, HH has other problems");
%makelabels (" AND cost burden not computed, household has none of the other housing problems (lacks kitchen or plumbing, or has more than 1 person per room)"," AND cost burden not computed, HH has other problems");
%makelabels (" AND cost burden not computed, household has none of the other severe housing problems"," AND cost burden not computed, HH has other severe problems");
%makelabels (" AND cost burden not computed, none of the other 3 housing unit problems"," AND cost burden not computed, HH has other problems");
%makelabels (" AND has 1 or more of the 4 housing unit problems"," AND has 1 or more of the 4 HU problems");
%makelabels (" AND has 1 or more of the 4 housing unit problems (lacks kitchen or plumbing, more than 1 person per room, or cost burden greater than 30%)"," AND has 1 or more of the 4 HU problems");
%makelabels (" AND has 1 or more of the 4 housing unit problems (lacks kitchen or plumbing, more than 1 person per room, or cost burden greater than 50%)"," AND has 1 or more of the 4 HU problems");
%makelabels (" AND has 1 or more of the 4 severe housing unit problems"," AND has 1 or more of the 4 severe HU problems");
%makelabels (" AND has complete kitchen and plumbing facilities"," AND has complete kitchen and plumbing");
%makelabels (" AND has none of the 4 housing unit problems"," AND has none of the 4 HU problems");
%makelabels (" AND has none of the 4 housing unit problems (lacks kitchen or plumbing, more than 1 person per room, or cost burden greater than 30%)"," AND has none of the 4 HU problems");
%makelabels (" AND has none of the 4 housing unit problems (lacks kitchen or plumbing, more than 1 person per room, or cost burden greater than 50%)"," AND has none of the 4 HU problems");
%makelabels (" AND has none of the 4 severe housing unit problems"," AND has none of the 4 severe HU problems");
%makelabels (" AND household contains 1 or more children age 6 or younger"," AND HH contains 1 or more children age 6 or younger");
%makelabels (" AND household contains at least 1 person age 62-74 but no one age 75+"," AND HH contains at least 1 person age 62-74 but none age 75+");
%makelabels (" AND household contains at least 1 person age 75+"," AND HH contains at least 1 person age 75+");
%makelabels (" AND household contains no children age 6 or younger"," AND HH contains no children age 6 or younger");
%makelabels (" AND household contains no one age 62+"," AND HH contains no one age 62+");
%makelabels (" AND household income is greater than 100% but less than or equal to 115% of HAMFI"," AND HH income 100%-115% HAMFI");
%makelabels (" AND household income is greater than 100% of HAMFI"," AND household income GT 100% of HAMFI");
%makelabels (" AND household income is greater than 115% but less than or equal to 120% of HAMFI"," AND HH income 115%-120% HAMFI");
%makelabels (" AND household income is greater than 120% but less than or equal to 140% of HAMFI"," AND HH income 120%-140% of HAMFI");
%makelabels (" AND household income is greater than 120% of HAMFI"," AND HH income GT than 120% of HAMFI");
%makelabels (" AND household income is greater than 140% of HAMFI"," AND HH income GT 140% of HAMFI");
%makelabels (" AND household income is greater than 20% but less than or equal to 30% of HAMFI"," AND HH income 20%-30% HAMFI");
%makelabels (" AND household income is greater than 30% but less than or equal to 40% of HAMFI"," AND HH income 30%-40% HAMFI");
%makelabels (" AND household income is greater than 30% but less than or equal to 50% of HAMFI"," AND HH income 30%-50% HAMFI");
%makelabels (" AND household income is greater than 30% of HAMFI but less than or equal to 50% of HAMFI"," AND HH income 30%-50% HAMFI");
%makelabels (" AND household income is greater than 40% but less than or equal to 50% of HAMFI"," AND HH income 40%-50% HAMFI");
%makelabels (" AND household income is greater than 50% but less than 80% of HAMFI"," AND HH income 50%-80% HAMFI");
%makelabels (" AND household income is greater than 50% but less than or equal to 60% of HAMFI"," AND HH income 50%-60% HAMFI");
%makelabels (" AND household income is greater than 50% but less than or equal to 80% of HAMFI"," AND HH income 50%-80% HAMFI");
%makelabels (" AND household income is greater than 50% of HAMFI but less than or equal to 80% of HAMFI"," AND HH income 50%-80% HAMFI");
%makelabels (" AND household income is greater than 60% but less than or equal to 65% of HAMFI"," AND HH income 60%-65% HAMFI");
%makelabels (" AND household income is greater than 65% but less than or equal to 80% of HAMFI"," AND HH income 65%-80% HAMFI");
%makelabels (" AND household income is greater than 80% but less than 120% of HAMFI"," AND HH income 80%-120% HAMFI");
%makelabels (" AND household income is greater than 80% but less than or equal to 100% of HAMFI"," AND HH income 80%-100% HAMFI");
%makelabels (" AND household income is greater than 80% but less than or equal to 95% of HAMFI"," AND HH income 80%-95% HAMFI");
%makelabels (" AND household income is greater than 80% of HAMFI"," AND HH income GT 80% of HAMFI");
%makelabels (" AND household income is greater than 95% but less than or equal to 100% of HAMFI"," AND HH income 95%-100% HAMFI");
%makelabels (" AND household income is less than or equal to 20% of HAMFI"," AND HH income LTE 20% HAMFI");
%makelabels (" AND household income is less than or equal to 30% of HAMFI"," AND HH income LTE 30% HAMFI");
%makelabels (" AND household income is less than or equal to 50% of HAMFI"," AND HH income LTE 50% HAMFI");
%makelabels (" AND household size is 5 or more"," AND GG size 5+");
%makelabels (" AND household size is less than 5"," AND HH size under 5");
%makelabels (" AND household type is elderly family (2 persons, with either or both age 62 or over)"," AND HH type is elderly family");
%makelabels (" AND household type is elderly non-family"," AND HH type is elderly non-family");
%makelabels (" AND household type is elderly non-family (1 or 2 person non-family households with either person 62 years or over)"," AND HH type is elderly non-family");
%makelabels (" AND household type is family, no spouse*"," AND HH type is family, no spouse*");
%makelabels (" AND household type is large family (5 or more persons)"," AND GHH type is large family (5+)");
%makelabels (" AND household type is married couple family"," AND HH type is married couple family");
%makelabels (" AND household type is non-family"," AND HH type is non-family");
%makelabels (" AND household type is non-family non-elderly"," AND HH type is non-family non-elderly");
%makelabels (" AND household type is one family with at least one subfamily or more than one family"," AND household type is one family with at least one subfamily or more than one family");
%makelabels (" AND household type is one family with no subfamilies"," AND HH type is one family no subfamilies");
%makelabels (" AND household type is small family (2 persons, neither person 62 years or over, or 3 or 4 persons)"," AND HH type is small family");
%makelabels (" AND housing cost burden is greater than 30% but less than or equal to 50%"," AND  cost burden 30%-50%");
%makelabels (" AND housing cost burden is greater than 50%"," AND cost burden is GT 50%");
%makelabels (" AND housing cost burden is less than or equal to 30%"," AND cost burden LTE 30%");
%makelabels (" AND housing cost burden not computed (household has no/negative income)"," AND cost burden not computed");
%makelabels (" AND housing cost burden not computed (no/negative income)"," AND cost burden not computed");
%makelabels (" AND housing cost burden not computed, none of the needs above"," AND cost burden not computed, none of the needs above");
%makelabels (" AND housing unit has complete kitchen and plumbing facilities"," AND HU has complete kitchen and plumbing");
%makelabels (" AND housing unit has complete plumbing and kitchen facilities"," AND HU has complete plumbing and kitchen");
%makelabels (" AND housing unit lacks complete kitchen or plumbing facilities"," AND HU lacks complete kitchen or plumbing");
%makelabels (" AND housing unit lacks complete plumbing or kitchen facilities"," AND HU lacks complete plumbing or kitchen");
%makelabels (" AND lacking complete plumbing or kitchen facilities"," AND lacking complete plumbing or kitchen");
%makelabels (" AND lacks complete kitchen or plumbing facilities"," AND lacks complete kitchen or plumbing");
%makelabels (" AND number of bedrooms is 0 or 1"," AND bedrooms is 0 or 1");
%makelabels (" AND number of bedrooms is 2"," AND bedrooms is 2");
%makelabels (" AND number of bedrooms is 3 or more"," AND bedrooms is 3 or more");
%makelabels (" AND other household type (non-elderly non-family)"," AND other HH type (non-elderly non-family)");
%makelabels (" AND persons per room is greater than 1 but less than or equal to 1.5"," AND persons per room 1-1.5");
%makelabels (" AND persons per room is greater than 1.5"," AND persons per room GT 1.5");
%makelabels (" AND persons per room is less than or equal to 1"," AND persons per room is LTE 1");
%makelabels (" AND race/ethnicity is American Indian or Alaska Native alone, non-Hispanic"," AND race/ethnicity is AIAN alone, non-Hisp");
%makelabels (" AND race/ethnicity is Asian alone, non-Hispanic"," AND race/ethnicity is Asian alone, non-Hisp");
%makelabels (" AND race/ethnicity is Black or African-American alone, non-Hispanic"," AND race/ethnicity is Black alone, non-Hisp");
%makelabels (" AND race/ethnicity is Hispanic, any race"," AND race/ethnicity is Hispanic");
%makelabels (" AND race/ethnicity is Pacific Islander alone, non-Hispanic"," AND race/ethnicity is PI alone, non-Hisp");
%makelabels (" AND race/ethnicity is White alone, non-Hispanic"," AND race/ethnicity is White alone, non-Hisp");
%makelabels (" AND race/ethnicity is other (including multiple races, non-Hispanic)"," AND race/ethnicity is other, non-Hisp)");
%makelabels (" AND rent is greater than RHUD30 but less than or equal to RHUD50"," AND rent RHUD30-RHUD50");
%makelabels (" AND rent is greater than RHUD50 but less than or equal to RHUD80"," AND rent RHUD50-RHUD80");
%makelabels (" AND rent is greater than RHUD80"," AND rent GT RHUD80");
%makelabels (" AND rent is less than or equal to RHUD30"," AND rent LTE RHUD30");
%makelabels (" AND value is greater than VHUD100"," AND value GT VHUD100");
%makelabels (" AND value is greater than VHUD50 but less than or equal to VHUD80"," AND value VHUD50-VHUD80");
%makelabels (" AND value is greater than VHUD80 but less than or equal to VHUD100"," AND value VHUD80-VHUD100");
%makelabels (" AND value is less than or equal to VHUD50"," AND value is LTE VHUD50");
%makelabels (" AND with housing cost burden greater than 30% but less than or equal to 50%, none of the needs above"," AND with cost burden 30%-50%, none of the needs above");
%makelabels (" AND with housing cost burden greater than 50%, none of the needs above"," AND with cost burden GT 50%, none of the needs above");
%makelabels (" AND with more than 1 but less than or equal to 1.5 persons per room, none of the needs above"," AND with 1-1.5 persons per room, none of the needs above");
%makelabels (" AND with more than 1.5 persons per room, none of the needs above"," AND with 1.5+ persons per room, none of the needs above");
%makelabels ("2 to 4 units in structure","2-4 units in structure");
%makelabels ("5 or more units in structure","5+ units in structure");
%makelabels ("Census tract FIPS code. 6 digits. Included only in files at summary level 140.","Tract FIPS. 6 digits. Only at sum level 140.");
%makelabels ("Consolidated City FIPS code. 5 digits. Included only in files at summary level 170.","City FIPS. 5 digits. Only at sum level 170.");
%makelabels ("County FIPS code. 3 digits. Included only in files at summary level 050, 060, 140, and 155.","County FIPS. 3 digits. Only at sum level 050, 060, 140, and 155.");
%makelabels ("Geographic summary level code.","Geographic summary level code.");
%makelabels ("Household member has a cognitive limitation","HH member has a cognitive limitation");
%makelabels ("Household member has a hearing or vision impairment","HH member has a hearing or vision impairment");
%makelabels ("Household member has a self-care or independent living limitation","HH member has a self-care or independent living limitation");
%makelabels ("Household member has an ambulatory limitation","HH member has an ambulatory limitation");
%makelabels ("Household member has none of the above limitations","HH member has no limitations");
%makelabels ("Identifies the data as being produced from the 2009-2013 American Community Survey.","IDs data as produced from 2009-2013 ACS.");
%makelabels ("Minor Civil Division FIPS code. 5 digits. Included only in files at summary level 060.","Minor Civil Division FIPS. 5 digits. Included only at sum level 060.");
%makelabels ("Place FIPS code. 5 digits. Included only in files at summary level 155 and 160.","Place FIPS. 5 digits. Included only at sum level 155 and 160.");
%makelabels ("State FIPS code. 2 digits.","State FIPS. 2 digits.");
%makelabels ("The name of the jurisdiction.","Jurisdiction name.");
%makelabels ("Unique geographic id. Digits 1-3 indicate the summary level. Digits 4-5 indicate the component. Digits 6-7 always say US. The remainder varies by summary level. For instance, at summary level 050 (counties), there are 5 digits to indicate the state and county.","Unique geographic id.");


run;


/* Combine now short labels into a label statement */
data Datadictionary_labels;
	set Datadictionary_short;

	fulllabel = left(trim(Description_1))||""||left(trim(Description_2))||left(trim(Description_3))||left(trim(Description_4))||left(trim(Description_5));
	labelstatement = left(trim(Column_Name))||"="||""""||left(trim(fulllabel))||"""";
run;


/* Export as CSV to paste into Label_CHAS macro */
proc export data = Datadictionary_labels (keep = labelstatement)
	dbms = csv
	outfile = "&_dcdata_default_path.\HUD\Macros\CHAS_labelstatement.csv"
	replace;
run;


/* End of program */
