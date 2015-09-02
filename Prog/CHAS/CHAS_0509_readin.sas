** PROGRAM NAME: CHAS_0509_readin.sas
**
** PROJECT:  Native American Housing 
**
** DESCRIPTION :  reads in comma delimited Consolidated Planning/Comprehensive Housing Affordability Strategy (CHAS) files 
**				  for Tables 1 (housing problems), 2 (severe housing problems), and 9 (housing cost burden) for counties
**				  and states. These tables are special tabulations of the 2005-09 ACS 5 Year Estimates. This program 
**				  then merges all the data into a single dataset.  
**
** ASSISTING PROGRAMS:
** PREVIOUS PROGRAM:
** FOLLOWING PROGRAM:
**
** AUTHOR      :  Jennifer Biess
**
** CREATED     : 09/24/2012 
** MODIFICATIONS: 3-6-13 (J.Biess) cleaned up documentation and uploaded output dataset to alpha.
**
*************************************************************************************************************************;
options mprint spool; 
libname nahsg 'd:\nahsg\data';
libname chas 'd:\nahsg\data\chas';

filename t1_cty 'D:\nahsg\data\CHAS\Table1_county.csv';
filename t2_cty 'D:\nahsg\data\CHAS\Table2_county.csv';
filename t9_cty 'D:\nahsg\data\CHAS\Table9_county.csv';
filename t1_st 'D:\nahsg\data\CHAS\Table1_state.csv';
filename t2_st 'D:\nahsg\data\CHAS\Table2_state.csv';
filename t9_st 'D:\nahsg\data\CHAS\Table9_state.csv';

%include "K:\Metro\KPettit\NatData\template\stdhead9.sas";

*reads in CSV file for CHAS 05-09 tables 1 (housing problems), 2 (severe housing problems), and 9 (housing cost burden)
for counties and states. County and state data are contained in separate csv files, but with identical structures. 
The chas_readin macro creates a data step to read in each table and later merge the data from tables 1, 2, and 9 together.
This is run first for counties (ultimately creating one dataset for all county observations with all variables)
and then for states (ultimately creating one dataset for all state observations with all variables);

%macro chas_readin(level= ); 
data t1_&level. (label = "CHAS 20005-09 Table 1");
infile t1_&level. missover dsd dlm="," lrecl=22000 firstobs=2; 
input
source: $13.
sumlevel: $3.
geoid: $12.
NAME: $70.
ST: $2.
CTY: $3.
T1_est1: 8.
T1_est2: 8.
T1_est3: 8.
T1_est4: 8.
T1_est5: 8.
T1_est6: 8.
T1_est7: 8.
T1_est8: 8.
T1_est9: 8.
T1_est10: 8.
T1_est11: 8.
T1_est12: 8.
T1_est13: 8.
T1_est14: 8.
T1_est15: 8.
T1_est16: 8.
T1_est17: 8.
T1_est18: 8.
T1_est19: 8.
T1_est20: 8.
T1_est21: 8.
T1_est22: 8.
T1_est23: 8.
T1_est24: 8.
T1_est25: 8.
T1_est26: 8.
T1_est27: 8.
T1_est28: 8.
T1_est29: 8.
T1_est30: 8.
T1_est31: 8.
T1_est32: 8.
T1_est33: 8.
T1_est34: 8.
T1_est35: 8.
T1_est36: 8.
T1_est37: 8.
T1_est38: 8.
T1_est39: 8.
T1_est40: 8.
T1_est41: 8.
T1_est42: 8.
T1_est43: 8.
T1_est44: 8.
T1_est45: 8.
T1_est46: 8.
T1_est47: 8.
T1_est48: 8.
T1_est49: 8.
T1_est50: 8.
T1_est51: 8.
T1_est52: 8.
T1_est53: 8.
T1_est54: 8.
T1_est55: 8.
T1_est56: 8.
T1_est57: 8.
T1_est58: 8.
T1_est59: 8.
T1_est60: 8.
T1_est61: 8.
T1_est62: 8.
T1_est63: 8.
T1_est64: 8.
T1_est65: 8.
T1_est66: 8.
T1_est67: 8.
T1_est68: 8.
T1_est69: 8.
T1_est70: 8.
T1_est71: 8.
T1_est72: 8.
T1_est73: 8.
T1_est74: 8.
T1_est75: 8.
T1_est76: 8.
T1_est77: 8.
T1_est78: 8.
T1_est79: 8.
T1_est80: 8.
T1_est81: 8.
T1_est82: 8.
T1_est83: 8.
T1_est84: 8.
T1_est85: 8.
T1_est86: 8.
T1_est87: 8.
T1_est88: 8.
T1_est89: 8.
T1_est90: 8.
T1_est91: 8.
T1_est92: 8.
T1_est93: 8.
T1_est94: 8.
T1_est95: 8.
T1_est96: 8.
T1_est97: 8.
T1_est98: 8.
T1_est99: 8.
T1_est100: 8.
T1_est101: 8.
T1_est102: 8.
T1_est103: 8.
T1_est104: 8.
T1_est105: 8.
T1_est106: 8.
T1_est107: 8.
T1_est108: 8.
T1_est109: 8.
T1_est110: 8.
T1_est111: 8.
T1_est112: 8.
T1_est113: 8.
T1_est114: 8.
T1_est115: 8.
T1_est116: 8.
T1_est117: 8.
T1_est118: 8.
T1_est119: 8.
T1_est120: 8.
T1_est121: 8.
T1_est122: 8.
T1_est123: 8.
T1_est124: 8.
T1_est125: 8.
T1_est126: 8.
T1_est127: 8.
T1_est128: 8.
T1_est129: 8.
T1_est130: 8.
T1_est131: 8.
T1_est132: 8.
T1_est133: 8.
T1_est134: 8.
T1_est135: 8.
T1_est136: 8.
T1_est137: 8.
T1_est138: 8.
T1_est139: 8.
T1_est140: 8.
T1_est141: 8.
T1_est142: 8.
T1_est143: 8.
T1_est144: 8.
T1_est145: 8.
T1_est146: 8.
T1_est147: 8.
T1_est148: 8.
T1_est149: 8.
T1_est150: 8.
T1_est151: 8.
T1_est152: 8.
T1_est153: 8.
T1_est154: 8.
T1_est155: 8.
T1_est156: 8.
T1_est157: 8.
T1_est158: 8.
T1_est159: 8.
T1_est160: 8.
T1_est161: 8.
T1_est162: 8.
T1_est163: 8.
T1_est164: 8.
T1_est165: 8.
T1_est166: 8.
T1_est167: 8.
T1_est168: 8.
T1_est169: 8.
T1_est170: 8.
T1_est171: 8.
T1_est172: 8.
T1_est173: 8.
T1_est174: 8.
T1_est175: 8.
T1_est176: 8.
T1_est177: 8.
T1_est178: 8.
T1_est179: 8.
T1_est180: 8.
T1_est181: 8.
T1_est182: 8.
T1_est183: 8.
T1_est184: 8.
T1_est185: 8.
T1_est186: 8.
T1_est187: 8.
T1_est188: 8.
T1_est189: 8.
T1_est190: 8.
T1_est191: 8.
T1_est192: 8.
T1_est193: 8.
T1_est194: 8.
T1_est195: 8.
T1_est196: 8.
T1_est197: 8.
T1_est198: 8.
T1_est199: 8.
T1_est200: 8.
T1_est201: 8.
T1_est202: 8.
T1_est203: 8.
T1_est204: 8.
T1_est205: 8.
T1_est206: 8.
T1_est207: 8.
T1_est208: 8.
T1_est209: 8.
T1_est210: 8.
T1_est211: 8.
T1_est212: 8.
T1_est213: 8.
T1_est214: 8.
T1_est215: 8.
T1_est216: 8.
T1_est217: 8.
T1_est218: 8.
T1_est219: 8.
T1_est220: 8.
T1_est221: 8.
T1_est222: 8.
T1_est223: 8.
T1_est224: 8.
T1_est225: 8.
T1_est226: 8.
T1_est227: 8.
T1_est228: 8.
T1_est229: 8.
T1_est230: 8.
T1_est231: 8.
T1_est232: 8.
T1_est233: 8.
T1_est234: 8.
T1_est235: 8.
T1_est236: 8.
T1_est237: 8.
T1_est238: 8.
T1_est239: 8.
T1_est240: 8.
T1_est241: 8.
T1_est242: 8.
T1_est243: 8.
T1_est244: 8.
T1_est245: 8.
T1_est246: 8.
T1_est247: 8.
T1_est248: 8.
T1_est249: 8.
;

label 
T1_est1 = 'Total: Occupied housing units'
T1_est2 = 'Owner occupied'
T1_est3 = 'Owner occupied has 1+ housing problems (CB>30%)'
T1_est4 = 'Owner occupied has 1+ housing problems (CB>30%) le 30% HAMFI'
T1_est5 = 'Owner occupied has 1+ housing problems (CB>30%) le 30% HAMFI White alone, non-Hispanic'
T1_est6 = 'Owner occupied has 1+ housing problems (CB>30%) le 30% HAMFI Black or African-American alone, non-Hispanic'
T1_est7 = 'Owner occupied has 1+ housing problems (CB>30%) le 30% HAMFI Asian alone, non-Hispanic'
T1_est8 = 'Owner occupied has 1+ housing problems (CB>30%) le 30% HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est9 = 'Owner occupied has 1+ housing problems (CB>30%) le 30% HAMFI Pacific Islander alone, non-Hispanic'
T1_est10 = 'Owner occupied has 1+ housing problems (CB>30%) le 30% HAMFI Hispanic, any race'
T1_est11 = 'Owner occupied has 1+ housing problems (CB>30%) le 30% HAMFI other (including multiple races, non-Hispanic)'
T1_est12 = 'Owner occupied has 1+ housing problems (CB>30%) gt 30% but le 50% HAMFI'
T1_est13 = 'Owner occupied has 1+ housing problems (CB>30%) gt 30% but le 50% HAMFI White alone, non-Hispanic'
T1_est14 = 'Owner occupied has 1+ housing problems (CB>30%) gt 30% but le 50% HAMFI Black or African-American alone, non-Hispanic'
T1_est15 = 'Owner occupied has 1+ housing problems (CB>30%) gt 30% but le 50% HAMFI Asian alone, non-Hispanic'
T1_est16 = 'Owner occupied has 1+ housing problems (CB>30%) gt 30% but le 50% HAMFI AIAN alone, non-Hispanic'
T1_est17 = 'Owner occupied has 1+ housing problems (CB>30%) gt 30% but le 50% HAMFI Pacific Islander alone, non-Hispanic'
T1_est18 = 'Owner occupied has 1+ housing problems (CB>30%) gt 30% but le 50% HAMFI Hispanic, any race'
T1_est19 = 'Owner occupied has 1+ housing problems (CB>30%) gt 30% but le 50% HAMFI other (including multiple races, non-Hispanic)'
T1_est20 = 'Owner occupied has 1+ housing problems (CB>30%) gt 50% but le 80% HAMFI'
T1_est21 = 'Owner occupied has 1+ housing problems (CB>30%) gt 50% but le 80% HAMFI White alone, non-Hispanic'
T1_est22 = 'Owner occupied has 1+ housing problems (CB>30%) gt 50% but le 80% HAMFI Black or African-American alone, non-Hispanic'
T1_est23 = 'Owner occupied has 1+ housing problems (CB>30%) gt 50% but le 80% HAMFI Asian alone, non-Hispanic'
T1_est24 = 'Owner occupied has 1+ housing problems (CB>30%) gt 50% but le 80% HAMFI AIAN alone, non-Hispanic'
T1_est25 = 'Owner occupied has 1+ housing problems (CB>30%) gt 50% but le 80% HAMFI Pacific Islander alone, non-Hispanic'
T1_est26 = 'Owner occupied has 1+ housing problems (CB>30%) gt 50% but le 80% HAMFI Hispanic, any race'
T1_est27 = 'Owner occupied has 1+ housing problems (CB>30%) gt 50% but le 80% HAMFI other (including multiple races, non-Hispanic)'
T1_est28 = 'Owner occupied has 1+ housing problems (CB>30%) gt 80% but le 100% HAMFI'
T1_est29 = 'Owner occupied has 1+ housing problems (CB>30%) gt 80% but le 100% HAMFI White alone, non-Hispanic'
T1_est30 = 'Owner occupied has 1+ housing problems (CB>30%) gt 80% but le 100% HAMFI Black or African-American alone, non-Hispanic'
T1_est31 = 'Owner occupied has 1+ housing problems (CB>30%) gt 80% but le 100% HAMFI Asian alone, non-Hispanic'
T1_est32 = 'Owner occupied has 1+ housing problems (CB>30%) gt 80% but le 100% HAMFI AIAN alone, non-Hispanic'
T1_est33 = 'Owner occupied has 1+ housing problems (CB>30%) gt 80% but le 100% HAMFI Pacific Islander alone, non-Hispanic'
T1_est34 = 'Owner occupied has 1+ housing problems (CB>30%) gt 80% but le 100% HAMFI Hispanic, any race'
T1_est35 = 'Owner occupied has 1+ housing problems (CB>30%) gt 80% but le 100% HAMFI other (including multiple races, non-Hispanic)'
T1_est36 = 'Owner occupied has 1+ housing problems (CB>30%) gt 100% HAMFI'
T1_est37 = 'Owner occupied has 1+ housing problems (CB>30%) gt 100% HAMFI White alone, non-Hispanic'
T1_est38 = 'Owner occupied has 1+ housing problems (CB>30%) gt 100% HAMFI Black or African-American alone, non-Hispanic'
T1_est39 = 'Owner occupied has 1+ housing problems (CB>30%) gt 100% HAMFI Asian alone, non-Hispanic'
T1_est40 = 'Owner occupied has 1+ housing problems (CB>30%) gt 100% HAMFI AIAN alone, non-Hispanic'
T1_est41 = 'Owner occupied has 1+ housing problems (CB>30%) gt 100% HAMFI Pacific Islander alone, non-Hispanic'
T1_est42 = 'Owner occupied has 1+ housing problems (CB>30%) gt 100% HAMFI Hispanic, any race'
T1_est43 = 'Owner occupied has 1+ housing problems (CB>30%) gt 100% HAMFI other (including multiple races, non-Hispanic)'
T1_est44 = 'Owner occupied has no housing problems'
T1_est45 = 'Owner occupied has no housing problems less than or equal to 30% of HAMFI'
T1_est46 = 'Owner occupied has no housing problems less than or equal to 30% of HAMFI White alone, non-Hispanic'
T1_est47 = 'Owner occupied has no housing problems less than or equal to 30% of HAMFI Black or African-American alone, non-Hispanic'
T1_est48 = 'Owner occupied has no housing problems less than or equal to 30% of HAMFI Asian alone, non-Hispanic'
T1_est49 = 'Owner occupied has no housing problems less than or equal to 30% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est50 = 'Owner occupied has no housing problems less than or equal to 30% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est51 = 'Owner occupied has no housing problems less than or equal to 30% of HAMFI Hispanic, any race'
T1_est52 = 'Owner occupied has no housing problems less than or equal to 30% of HAMFI other (including multiple races, non-Hispanic)'
T1_est53 = 'Owner occupied has no housing problems greater than 30% but less than or equal to 50% of HAMFI'
T1_est54 = 'Owner occupied has no housing problems greater than 30% but less than or equal to 50% of HAMFI White alone, non-Hispanic'
T1_est55 = 'Owner occupied has no housing problems greater than 30% but less than or equal to 50% of HAMFI Black or African-American alone, non-Hispanic'
T1_est56 = 'Owner occupied has no housing problems greater than 30% but less than or equal to 50% of HAMFI Asian alone, non-Hispanic'
T1_est57 = 'Owner occupied has no housing problems greater than 30% but less than or equal to 50% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est58 = 'Owner occupied has no housing problems greater than 30% but less than or equal to 50% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est59 = 'Owner occupied has no housing problems greater than 30% but less than or equal to 50% of HAMFI Hispanic, any race'
T1_est60 = 'Owner occupied has no housing problems greater than 30% but less than or equal to 50% of HAMFI other (including multiple races, non-Hispanic)'
T1_est61 = 'Owner occupied has no housing problems greater than 50% but less than or equal to 80% of HAMFI'
T1_est62 = 'Owner occupied has no housing problems greater than 50% but less than or equal to 80% of HAMFI White alone, non-Hispanic'
T1_est63 = 'Owner occupied has no housing problems greater than 50% but less than or equal to 80% of HAMFI Black or African-American alone, non-Hispanic'
T1_est64 = 'Owner occupied has no housing problems greater than 50% but less than or equal to 80% of HAMFI Asian alone, non-Hispanic'
T1_est65 = 'Owner occupied has no housing problems greater than 50% but less than or equal to 80% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est66 = 'Owner occupied has no housing problems greater than 50% but less than or equal to 80% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est67 = 'Owner occupied has no housing problems greater than 50% but less than or equal to 80% of HAMFI Hispanic, any race'
T1_est68 = 'Owner occupied has no housing problems greater than 50% but less than or equal to 80% of HAMFI other (including multiple races, non-Hispanic)'
T1_est69 = 'Owner occupied has no housing problems greater than 80% but less than or equal to 100% of HAMFI'
T1_est70 = 'Owner occupied has no housing problems greater than 80% but less than or equal to 100% of HAMFI White alone, non-Hispanic'
T1_est71 = 'Owner occupied has no housing problems greater than 80% but less than or equal to 100% of HAMFI Black or African-American alone, non-Hispanic'
T1_est72 = 'Owner occupied has no housing problems greater than 80% but less than or equal to 100% of HAMFI Asian alone, non-Hispanic'
T1_est73 = 'Owner occupied has no housing problems greater than 80% but less than or equal to 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est74 = 'Owner occupied has no housing problems greater than 80% but less than or equal to 100% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est75 = 'Owner occupied has no housing problems greater than 80% but less than or equal to 100% of HAMFI Hispanic, any race'
T1_est76 = 'Owner occupied has no housing problems greater than 80% but less than or equal to 100% of HAMFI other (including multiple races, non-Hispanic)'
T1_est77 = 'Owner occupied has no housing problems greater than 100% of HAMFI'
T1_est78 = 'Owner occupied has no housing problems greater than 100% of HAMFI White alone, non-Hispanic'
T1_est79 = 'Owner occupied has no housing problems greater than 100% of HAMFI Black or African-American alone, non-Hispanic'
T1_est80 = 'Owner occupied has no housing problems greater than 100% of HAMFI Asian alone, non-Hispanic'
T1_est81 = 'Owner occupied has no housing problems greater than 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est82 = 'Owner occupied has no housing problems greater than 100% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est83 = 'Owner occupied has no housing problems greater than 100% of HAMFI Hispanic, any race'
T1_est84 = 'Owner occupied has no housing problems greater than 100% of HAMFI other (including multiple races, non-Hispanic)'
T1_est85 = 'Owner occupied cost burden not computed, none of the other 3 housing problems'
T1_est86 = 'Owner occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI'
T1_est87 = 'Owner occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI White alone, non-Hispanic'
T1_est88 = 'Owner occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI Black or African-American alone, non-Hispanic'
T1_est89 = 'Owner occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI Asian alone, non-Hispanic'
T1_est90 = 'Owner occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est91 = 'Owner occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est92 = 'Owner occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI Hispanic, any race'
T1_est93 = 'Owner occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI other (including multiple races, non-Hispanic)'
T1_est94 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI'
T1_est95 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI White alone, non-Hispanic'
T1_est96 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI Black or African-American alone, non-Hispanic'
T1_est97 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI Asian alone, non-Hispanic'
T1_est98 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est99 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est100 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI Hispanic, any race'
T1_est101 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI other (including multiple races, non-Hispanic)'
T1_est102 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI'
T1_est103 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI White alone, non-Hispanic'
T1_est104 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI Black or African-American alone, non-Hispanic'
T1_est105 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI Asian alone, non-Hispanic'
T1_est106 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est107 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est108 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI Hispanic, any race'
T1_est109 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI other (including multiple races, non-Hispanic)'
T1_est110 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI'
T1_est111 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI White alone, non-Hispanic'
T1_est112 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI Black or African-American alone, non-Hispanic'
T1_est113 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI Asian alone, non-Hispanic'
T1_est114 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est115 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est116 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI Hispanic, any race'
T1_est117 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI other (including multiple races, non-Hispanic)'
T1_est118 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI'
T1_est119 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI White alone, non-Hispanic'
T1_est120 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI Black or African-American alone, non-Hispanic'
T1_est121 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI Asian alone, non-Hispanic'
T1_est122 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est123 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est124 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI Hispanic, any race'
T1_est125 = 'Owner occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI other (including multiple races, non-Hispanic)'
T1_est126 = 'Renter occupied'
T1_est127 = 'Renter occupied has 1+ housing problems (CB>30%)'
T1_est128 = 'Renter occupied has 1+ housing problems (CB>30%) less than or equal to 30% of HAMFI'
T1_est129 = 'Renter occupied has 1+ housing problems (CB>30%) less than or equal to 30% of HAMFI White alone, non-Hispanic'
T1_est130 = 'Renter occupied has 1+ housing problems (CB>30%) less than or equal to 30% of HAMFI Black or African-American alone, non-Hispanic'
T1_est131 = 'Renter occupied has 1+ housing problems (CB>30%) less than or equal to 30% of HAMFI Asian alone, non-Hispanic'
T1_est132 = 'Renter occupied has 1+ housing problems (CB>30%) less than or equal to 30% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est133 = 'Renter occupied has 1+ housing problems (CB>30%) less than or equal to 30% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est134 = 'Renter occupied has 1+ housing problems (CB>30%) less than or equal to 30% of HAMFI Hispanic, any race'
T1_est135 = 'Renter occupied has 1+ housing problems (CB>30%) less than or equal to 30% of HAMFI other (including multiple races, non-Hispanic)'
T1_est136 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 30% but less than or equal to 50% of HAMFI'
T1_est137 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 30% but less than or equal to 50% of HAMFI White alone, non-Hispanic'
T1_est138 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 30% but less than or equal to 50% of HAMFI Black or African-American alone, non-Hispanic'
T1_est139 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 30% but less than or equal to 50% of HAMFI Asian alone, non-Hispanic'
T1_est140 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 30% but less than or equal to 50% of HAMFI AIAN alone, non-Hispanic'
T1_est141 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 30% but less than or equal to 50% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est142 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 30% but less than or equal to 50% of HAMFI Hispanic, any race'
T1_est143 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 30% but less than or equal to 50% of HAMFI other (including multiple races, non-Hispanic)'
T1_est144 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 50% but less than or equal to 80% of HAMFI'
T1_est145 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 50% but less than or equal to 80% of HAMFI White alone, non-Hispanic'
T1_est146 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 50% but less than or equal to 80% of HAMFI Black or African-American alone, non-Hispanic'
T1_est147 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 50% but less than or equal to 80% of HAMFI Asian alone, non-Hispanic'
T1_est148 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 50% but less than or equal to 80% of HAMFI AIAN alone, non-Hispanic'
T1_est149 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 50% but less than or equal to 80% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est150 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 50% but less than or equal to 80% of HAMFI Hispanic, any race'
T1_est151 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 50% but less than or equal to 80% of HAMFI other (including multiple races, non-Hispanic)'
T1_est152 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 80% but less than or equal to 100% of HAMFI'
T1_est153 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 80% but less than or equal to 100% of HAMFI White alone, non-Hispanic'
T1_est154 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 80% but less than or equal to 100% of HAMFI Black or African-American alone, non-Hispanic'
T1_est155 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 80% but less than or equal to 100% of HAMFI Asian alone, non-Hispanic'
T1_est156 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 80% but less than or equal to 100% of HAMFI AIAN alone, non-Hispanic'
T1_est157 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 80% but less than or equal to 100% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est158 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 80% but less than or equal to 100% of HAMFI Hispanic, any race'
T1_est159 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 80% but less than or equal to 100% of HAMFI other (including multiple races, non-Hispanic)'
T1_est160 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 100% of HAMFI'
T1_est161 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 100% of HAMFI White alone, non-Hispanic'
T1_est162 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 100% of HAMFI Black or African-American alone, non-Hispanic'
T1_est163 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 100% of HAMFI Asian alone, non-Hispanic'
T1_est164 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est165 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 100% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est166 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 100% of HAMFI Hispanic, any race'
T1_est167 = 'Renter occupied has 1+ housing problems (CB>30%) greater than 100% of HAMFI other (including multiple races, non-Hispanic)'
T1_est168 = 'Renter occupied has none of the 4 housing problems'
T1_est169 = 'Renter occupied has none of the 4 housing problems less than or equal to 30% of HAMFI'
T1_est170 = 'Renter occupied has none of the 4 housing problems less than or equal to 30% of HAMFI White alone, non-Hispanic'
T1_est171 = 'Renter occupied has none of the 4 housing problems less than or equal to 30% of HAMFI Black or African-American alone, non-Hispanic'
T1_est172 = 'Renter occupied has none of the 4 housing problems less than or equal to 30% of HAMFI Asian alone, non-Hispanic'
T1_est173 = 'Renter occupied has none of the 4 housing problems less than or equal to 30% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est174 = 'Renter occupied has none of the 4 housing problems less than or equal to 30% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est175 = 'Renter occupied has none of the 4 housing problems less than or equal to 30% of HAMFI Hispanic, any race'
T1_est176 = 'Renter occupied has none of the 4 housing problems less than or equal to 30% of HAMFI other (including multiple races, non-Hispanic)'
T1_est177 = 'Renter occupied has none of the 4 housing problems greater than 30% but less than or equal to 50% of HAMFI'
T1_est178 = 'Renter occupied has none of the 4 housing problems greater than 30% but less than or equal to 50% of HAMFI White alone, non-Hispanic'
T1_est179 = 'Renter occupied has none of the 4 housing problems greater than 30% but less than or equal to 50% of HAMFI Black or African-American alone, non-Hispanic'
T1_est180 = 'Renter occupied has none of the 4 housing problems greater than 30% but less than or equal to 50% of HAMFI Asian alone, non-Hispanic'
T1_est181 = 'Renter occupied has none of the 4 housing problems greater than 30% but less than or equal to 50% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est182 = 'Renter occupied has none of the 4 housing problems greater than 30% but less than or equal to 50% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est183 = 'Renter occupied has none of the 4 housing problems greater than 30% but less than or equal to 50% of HAMFI Hispanic, any race'
T1_est184 = 'Renter occupied has none of the 4 housing problems greater than 30% but less than or equal to 50% of HAMFI other (including multiple races, non-Hispanic)'
T1_est185 = 'Renter occupied has none of the 4 housing problems greater than 50% but less than or equal to 80% of HAMFI'
T1_est186 = 'Renter occupied has none of the 4 housing problems greater than 50% but less than or equal to 80% of HAMFI White alone, non-Hispanic'
T1_est187 = 'Renter occupied has none of the 4 housing problems greater than 50% but less than or equal to 80% of HAMFI Black or African-American alone, non-Hispanic'
T1_est188 = 'Renter occupied has none of the 4 housing problems greater than 50% but less than or equal to 80% of HAMFI Asian alone, non-Hispanic'
T1_est189 = 'Renter occupied has none of the 4 housing problems greater than 50% but less than or equal to 80% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est190 = 'Renter occupied has none of the 4 housing problems greater than 50% but less than or equal to 80% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est191 = 'Renter occupied has none of the 4 housing problems greater than 50% but less than or equal to 80% of HAMFI Hispanic, any race'
T1_est192 = 'Renter occupied has none of the 4 housing problems greater than 50% but less than or equal to 80% of HAMFI other (including multiple races, non-Hispanic)'
T1_est193 = 'Renter occupied has none of the 4 housing problems greater than 80% but less than or equal to 100% of HAMFI'
T1_est194 = 'Renter occupied has none of the 4 housing problems greater than 80% but less than or equal to 100% of HAMFI White alone, non-Hispanic'
T1_est195 = 'Renter occupied has none of the 4 housing problems greater than 80% but less than or equal to 100% of HAMFI Black or African-American alone, non-Hispanic'
T1_est196 = 'Renter occupied has none of the 4 housing problems greater than 80% but less than or equal to 100% of HAMFI Asian alone, non-Hispanic'
T1_est197 = 'Renter occupied has none of the 4 housing problems greater than 80% but less than or equal to 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est198 = 'Renter occupied has none of the 4 housing problems greater than 80% but less than or equal to 100% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est199 = 'Renter occupied has none of the 4 housing problems greater than 80% but less than or equal to 100% of HAMFI Hispanic, any race'
T1_est200 = 'Renter occupied has none of the 4 housing problems greater than 80% but less than or equal to 100% of HAMFI other (including multiple races, non-Hispanic)'
T1_est201 = 'Renter occupied has none of the 4 housing problems greater than 100% of HAMFI'
T1_est202 = 'Renter occupied has none of the 4 housing problems greater than 100% of HAMFI White alone, non-Hispanic'
T1_est203 = 'Renter occupied has none of the 4 housing problems greater than 100% of HAMFI Black or African-American alone, non-Hispanic'
T1_est204 = 'Renter occupied has none of the 4 housing problems greater than 100% of HAMFI Asian alone, non-Hispanic'
T1_est205 = 'Renter occupied has none of the 4 housing problems greater than 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est206 = 'Renter occupied has none of the 4 housing problems greater than 100% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est207 = 'Renter occupied has none of the 4 housing problems greater than 100% of HAMFI Hispanic, any race'
T1_est208 = 'Renter occupied has none of the 4 housing problems greater than 100% of HAMFI other (including multiple races, non-Hispanic)'
T1_est209 = 'Renter occupied cost burden not computed, none of the other 3 housing problems'
T1_est210 = 'Renter occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI'
T1_est211 = 'Renter occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI White alone, non-Hispanic'
T1_est212 = 'Renter occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI Black or African-American alone, non-Hispanic'
T1_est213 = 'Renter occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI Asian alone, non-Hispanic'
T1_est214 = 'Renter occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est215 = 'Renter occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est216 = 'Renter occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI Hispanic, any race'
T1_est217 = 'Renter occupied cost burden not computed, none of the other 3 housing problems less than or equal to 30% of HAMFI other (including multiple races, non-Hispanic)'
T1_est218 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI'
T1_est219 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI White alone, non-Hispanic'
T1_est220 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI Black or African-American alone, non-Hispanic'
T1_est221 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI Asian alone, non-Hispanic'
T1_est222 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est223 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est224 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI Hispanic, any race'
T1_est225 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 30% but less than or equal to 50% of HAMFI other (including multiple races, non-Hispanic)'
T1_est226 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI'
T1_est227 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI White alone, non-Hispanic'
T1_est228 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI Black or African-American alone, non-Hispanic'
T1_est229 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI Asian alone, non-Hispanic'
T1_est230 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est231 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est232 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI Hispanic, any race'
T1_est233 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 50% but less than or equal to 80% of HAMFI other (including multiple races, non-Hispanic)'
T1_est234 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI'
T1_est235 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI White alone, non-Hispanic'
T1_est236 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI Black or African-American alone, non-Hispanic'
T1_est237 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI Asian alone, non-Hispanic'
T1_est238 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est239 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est240 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI Hispanic, any race'
T1_est241 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 80% but less than or equal to 100% of HAMFI other (including multiple races, non-Hispanic)'
T1_est242 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI'
T1_est243 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI White alone, non-Hispanic'
T1_est244 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI Black or African-American alone, non-Hispanic'
T1_est245 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI Asian alone, non-Hispanic'
T1_est246 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T1_est247 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI Pacific Islander alone, non-Hispanic'
T1_est248 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI Hispanic, any race'
T1_est249 = 'Renter occupied cost burden not computed, none of the other 3 housing problems greater than 100% of HAMFI other (including multiple races, non-Hispanic)'
; 

run; 

data t2_&level. (label = "CHAS 20005-09 Table 2" drop = source sumlevel name st cty);
infile t2_&level. missover dsd dlm="," lrecl=22000 firstobs=2; 
input
source: $13.
sumlevel: $3.
geoid: $12.
NAME: $70.
ST: $2.
CTY: $3.
T2_est1: 8.
T2_est2: 8.
T2_est3: 8.
T2_est4: 8.
T2_est5: 8.
T2_est6: 8.
T2_est7: 8.
T2_est8: 8.
T2_est9: 8.
T2_est10: 8.
T2_est11: 8.
T2_est12: 8.
T2_est13: 8.
T2_est14: 8.
T2_est15: 8.
T2_est16: 8.
T2_est17: 8.
T2_est18: 8.
T2_est19: 8.
T2_est20: 8.
T2_est21: 8.
T2_est22: 8.
T2_est23: 8.
T2_est24: 8.
T2_est25: 8.
T2_est26: 8.
T2_est27: 8.
T2_est28: 8.
T2_est29: 8.
T2_est30: 8.
T2_est31: 8.
T2_est32: 8.
T2_est33: 8.
T2_est34: 8.
T2_est35: 8.
T2_est36: 8.
T2_est37: 8.
T2_est38: 8.
T2_est39: 8.
T2_est40: 8.
T2_est41: 8.
T2_est42: 8.
T2_est43: 8.
T2_est44: 8.
T2_est45: 8.
T2_est46: 8.
T2_est47: 8.
T2_est48: 8.
T2_est49: 8.
T2_est50: 8.
T2_est51: 8.
T2_est52: 8.
T2_est53: 8.
T2_est54: 8.
T2_est55: 8.
T2_est56: 8.
T2_est57: 8.
T2_est58: 8.
T2_est59: 8.
T2_est60: 8.
T2_est61: 8.
T2_est62: 8.
T2_est63: 8.
T2_est64: 8.
T2_est65: 8.
T2_est66: 8.
T2_est67: 8.
T2_est68: 8.
T2_est69: 8.
T2_est70: 8.
T2_est71: 8.
T2_est72: 8.
T2_est73: 8.
T2_est74: 8.
T2_est75: 8.
T2_est76: 8.
T2_est77: 8.
T2_est78: 8.
T2_est79: 8.
T2_est80: 8.
T2_est81: 8.
T2_est82: 8.
T2_est83: 8.
T2_est84: 8.
T2_est85: 8.
T2_est86: 8.
T2_est87: 8.
T2_est88: 8.
T2_est89: 8.
T2_est90: 8.
T2_est91: 8.
T2_est92: 8.
T2_est93: 8.
T2_est94: 8.
T2_est95: 8.
T2_est96: 8.
T2_est97: 8.
T2_est98: 8.
T2_est99: 8.
T2_est100: 8.
T2_est101: 8.
T2_est102: 8.
T2_est103: 8.
T2_est104: 8.
T2_est105: 8.
T2_est106: 8.
T2_est107: 8.
T2_est108: 8.
T2_est109: 8.
T2_est110: 8.
T2_est111: 8.
T2_est112: 8.
T2_est113: 8.
T2_est114: 8.
T2_est115: 8.
T2_est116: 8.
T2_est117: 8.
T2_est118: 8.
T2_est119: 8.
T2_est120: 8.
T2_est121: 8.
T2_est122: 8.
T2_est123: 8.
T2_est124: 8.
T2_est125: 8.
T2_est126: 8.
T2_est127: 8.
T2_est128: 8.
T2_est129: 8.
T2_est130: 8.
T2_est131: 8.
T2_est132: 8.
T2_est133: 8.
T2_est134: 8.
T2_est135: 8.
T2_est136: 8.
T2_est137: 8.
T2_est138: 8.
T2_est139: 8.
T2_est140: 8.
T2_est141: 8.
T2_est142: 8.
T2_est143: 8.
T2_est144: 8.
T2_est145: 8.
T2_est146: 8.
T2_est147: 8.
T2_est148: 8.
T2_est149: 8.
T2_est150: 8.
T2_est151: 8.
T2_est152: 8.
T2_est153: 8.
T2_est154: 8.
T2_est155: 8.
T2_est156: 8.
T2_est157: 8.
T2_est158: 8.
T2_est159: 8.
T2_est160: 8.
T2_est161: 8.
T2_est162: 8.
T2_est163: 8.
T2_est164: 8.
T2_est165: 8.
T2_est166: 8.
T2_est167: 8.
T2_est168: 8.
T2_est169: 8.
T2_est170: 8.
T2_est171: 8.
T2_est172: 8.
T2_est173: 8.
T2_est174: 8.
T2_est175: 8.
T2_est176: 8.
T2_est177: 8.
T2_est178: 8.
T2_est179: 8.
T2_est180: 8.
T2_est181: 8.
T2_est182: 8.
T2_est183: 8.
T2_est184: 8.
T2_est185: 8.
T2_est186: 8.
T2_est187: 8.
T2_est188: 8.
T2_est189: 8.
T2_est190: 8.
T2_est191: 8.
T2_est192: 8.
T2_est193: 8.
T2_est194: 8.
T2_est195: 8.
T2_est196: 8.
T2_est197: 8.
T2_est198: 8.
T2_est199: 8.
T2_est200: 8.
T2_est201: 8.
T2_est202: 8.
T2_est203: 8.
T2_est204: 8.
T2_est205: 8.
T2_est206: 8.
T2_est207: 8.
T2_est208: 8.
T2_est209: 8.
T2_est210: 8.
T2_est211: 8.
T2_est212: 8.
T2_est213: 8.
T2_est214: 8.
T2_est215: 8.
T2_est216: 8.
T2_est217: 8.
T2_est218: 8.
T2_est219: 8.
T2_est220: 8.
T2_est221: 8.
T2_est222: 8.
T2_est223: 8.
T2_est224: 8.
T2_est225: 8.
T2_est226: 8.
T2_est227: 8.
T2_est228: 8.
T2_est229: 8.
T2_est230: 8.
T2_est231: 8.
T2_est232: 8.
T2_est233: 8.
T2_est234: 8.
T2_est235: 8.
T2_est236: 8.
T2_est237: 8.
T2_est238: 8.
T2_est239: 8.
T2_est240: 8.
T2_est241: 8.
T2_est242: 8.
T2_est243: 8.
T2_est244: 8.
T2_est245: 8.
T2_est246: 8.
T2_est247: 8.
T2_est248: 8.
T2_est249: 8.
; 

label 
T2_est1 = 'Total: Occupied housing units'
T2_est2 = 'Owner occupied'
T2_est3 = 'Owner occupied has 1+ severe housing problems (CB>50%)'
T2_est4 = 'Owner occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI'
T2_est5 = 'Owner occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI White alone, non-Hispanic'
T2_est6 = 'Owner occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI Black or African-American alone, non-Hispanic'
T2_est7 = 'Owner occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI Asian alone, non-Hispanic'
T2_est8 = 'Owner occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est9 = 'Owner occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est10 = 'Owner occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI Hispanic, any race'
T2_est11 = 'Owner occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI other (including multiple races, non-Hispanic)'
T2_est12 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI'
T2_est13 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI White alone, non-Hispanic'
T2_est14 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI Black or African-American alone, non-Hispanic'
T2_est15 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI Asian alone, non-Hispanic'
T2_est16 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI AIAN alone, non-Hispanic'
T2_est17 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est18 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI Hispanic, any race'
T2_est19 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI other (including multiple races, non-Hispanic)'
T2_est20 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI'
T2_est21 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI White alone, non-Hispanic'
T2_est22 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI Black or African-American alone, non-Hispanic'
T2_est23 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI Asian alone, non-Hispanic'
T2_est24 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI AIAN alone, non-Hispanic'
T2_est25 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est26 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI Hispanic, any race'
T2_est27 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI other (including multiple races, non-Hispanic)'
T2_est28 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI'
T2_est29 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI White alone, non-Hispanic'
T2_est30 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI Black or African-American alone, non-Hispanic'
T2_est31 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI Asian alone, non-Hispanic'
T2_est32 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI AIAN alone, non-Hispanic'
T2_est33 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est34 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI Hispanic, any race'
T2_est35 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI other (including multiple races, non-Hispanic)'
T2_est36 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI'
T2_est37 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI White alone, non-Hispanic'
T2_est38 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI Black or African-American alone, non-Hispanic'
T2_est39 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI Asian alone, non-Hispanic'
T2_est40 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est41 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est42 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI Hispanic, any race'
T2_est43 = 'Owner occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI other (including multiple races, non-Hispanic)'
T2_est44 = 'Owner occupied has none of the 4 severe housing problems'
T2_est45 = 'Owner occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI'
T2_est46 = 'Owner occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI White alone, non-Hispanic'
T2_est47 = 'Owner occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI Black or African-American alone, non-Hispanic'
T2_est48 = 'Owner occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI Asian alone, non-Hispanic'
T2_est49 = 'Owner occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est50 = 'Owner occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est51 = 'Owner occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI Hispanic, any race'
T2_est52 = 'Owner occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI other (including multiple races, non-Hispanic)'
T2_est53 = 'Owner occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI'
T2_est54 = 'Owner occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI White alone, non-Hispanic'
T2_est55 = 'Owner occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Black or African-American alone, non-Hispanic'
T2_est56 = 'Owner occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Asian alone, non-Hispanic'
T2_est57 = 'Owner occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est58 = 'Owner occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est59 = 'Owner occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Hispanic, any race'
T2_est60 = 'Owner occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI other (including multiple races, non-Hispanic)'
T2_est61 = 'Owner occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI'
T2_est62 = 'Owner occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI White alone, non-Hispanic'
T2_est63 = 'Owner occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Black or African-American alone, non-Hispanic'
T2_est64 = 'Owner occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Asian alone, non-Hispanic'
T2_est65 = 'Owner occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est66 = 'Owner occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est67 = 'Owner occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Hispanic, any race'
T2_est68 = 'Owner occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI other (including multiple races, non-Hispanic)'
T2_est69 = 'Owner occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI'
T2_est70 = 'Owner occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI White alone, non-Hispanic'
T2_est71 = 'Owner occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Black or African-American alone, non-Hispanic'
T2_est72 = 'Owner occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Asian alone, non-Hispanic'
T2_est73 = 'Owner occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est74 = 'Owner occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est75 = 'Owner occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Hispanic, any race'
T2_est76 = 'Owner occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI other (including multiple races, non-Hispanic)'
T2_est77 = 'Owner occupied has none of the 4 severe housing problems greater than 100% of HAMFI'
T2_est78 = 'Owner occupied has none of the 4 severe housing problems greater than 100% of HAMFI White alone, non-Hispanic'
T2_est79 = 'Owner occupied has none of the 4 severe housing problems greater than 100% of HAMFI Black or African-American alone, non-Hispanic'
T2_est80 = 'Owner occupied has none of the 4 severe housing problems greater than 100% of HAMFI Asian alone, non-Hispanic'
T2_est81 = 'Owner occupied has none of the 4 severe housing problems greater than 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est82 = 'Owner occupied has none of the 4 severe housing problems greater than 100% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est83 = 'Owner occupied has none of the 4 severe housing problems greater than 100% of HAMFI Hispanic, any race'
T2_est84 = 'Owner occupied has none of the 4 severe housing problems greater than 100% of HAMFI other (including multiple races, non-Hispanic)'
T2_est85 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems'
T2_est86 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI'
T2_est87 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI White alone, non-Hispanic'
T2_est88 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI Black or African-American alone, non-Hispanic'
T2_est89 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI Asian alone, non-Hispanic'
T2_est90 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est91 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est92 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI Hispanic, any race'
T2_est93 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI other (including multiple races, non-Hispanic)'
T2_est94 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI'
T2_est95 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI White alone, non-Hispanic'
T2_est96 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Black or African-American alone, non-Hispanic'
T2_est97 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Asian alone, non-Hispanic'
T2_est98 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est99 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est100 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Hispanic, any race'
T2_est101 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI other (including multiple races, non-Hispanic)'
T2_est102 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI'
T2_est103 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI White alone, non-Hispanic'
T2_est104 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Black or African-American alone, non-Hispanic'
T2_est105 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Asian alone, non-Hispanic'
T2_est106 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est107 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est108 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Hispanic, any race'
T2_est109 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI other (including multiple races, non-Hispanic)'
T2_est110 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI'
T2_est111 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI White alone, non-Hispanic'
T2_est112 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Black or African-American alone, non-Hispanic'
T2_est113 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Asian alone, non-Hispanic'
T2_est114 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est115 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est116 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Hispanic, any race'
T2_est117 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI other (including multiple races, non-Hispanic)'
T2_est118 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI'
T2_est119 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI White alone, non-Hispanic'
T2_est120 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI Black or African-American alone, non-Hispanic'
T2_est121 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI Asian alone, non-Hispanic'
T2_est122 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est123 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est124 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI Hispanic, any race'
T2_est125 = 'Owner occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI other (including multiple races, non-Hispanic)'
T2_est126 = 'Renter occupied'
T2_est127 = 'Renter occupied has 1+ severe housing problems (CB>50%)'
T2_est128 = 'Renter occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI'
T2_est129 = 'Renter occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI White alone, non-Hispanic'
T2_est130 = 'Renter occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI Black or African-American alone, non-Hispanic'
T2_est131 = 'Renter occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI Asian alone, non-Hispanic'
T2_est132 = 'Renter occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est133 = 'Renter occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est134 = 'Renter occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI Hispanic, any race'
T2_est135 = 'Renter occupied has 1+ severe housing problems (CB>50%) less than or equal to 30% of HAMFI other (including multiple races, non-Hispanic)'
T2_est136 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI'
T2_est137 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI White alone, non-Hispanic'
T2_est138 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI Black or African-American alone, non-Hispanic'
T2_est139 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI Asian alone, non-Hispanic'
T2_est140 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI AIAN alone, non-Hispanic'
T2_est141 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est142 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI Hispanic, any race'
T2_est143 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 30% but less than or equal to 50% of HAMFI other (including multiple races, non-Hispanic)'
T2_est144 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI'
T2_est145 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI White alone, non-Hispanic'
T2_est146 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI Black or African-American alone, non-Hispanic'
T2_est147 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI Asian alone, non-Hispanic'
T2_est148 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI AIAN alone, non-Hispanic'
T2_est149 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est150 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI Hispanic, any race'
T2_est151 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 50% but less than or equal to 80% of HAMFI other (including multiple races, non-Hispanic)'
T2_est152 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI'
T2_est153 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI White alone, non-Hispanic'
T2_est154 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI Black or African-American alone, non-Hispanic'
T2_est155 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI Asian alone, non-Hispanic'
T2_est156 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI AIAN alone, non-Hispanic'
T2_est157 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est158 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI Hispanic, any race'
T2_est159 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 80% but less than or equal to 100% of HAMFI other (including multiple races, non-Hispanic)'
T2_est160 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI'
T2_est161 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI White alone, non-Hispanic'
T2_est162 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI Black or African-American alone, non-Hispanic'
T2_est163 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI Asian alone, non-Hispanic'
T2_est164 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est165 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est166 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI Hispanic, any race'
T2_est167 = 'Renter occupied has 1+ severe housing problems (CB>50%) greater than 100% of HAMFI other (including multiple races, non-Hispanic)'
T2_est168 = 'Renter occupied has none of the 4 severe housing problems'
T2_est169 = 'Renter occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI'
T2_est170 = 'Renter occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI White alone, non-Hispanic'
T2_est171 = 'Renter occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI Black or African-American alone, non-Hispanic'
T2_est172 = 'Renter occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI Asian alone, non-Hispanic'
T2_est173 = 'Renter occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est174 = 'Renter occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est175 = 'Renter occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI Hispanic, any race'
T2_est176 = 'Renter occupied has none of the 4 severe housing problems less than or equal to 30% of HAMFI other (including multiple races, non-Hispanic)'
T2_est177 = 'Renter occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI'
T2_est178 = 'Renter occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI White alone, non-Hispanic'
T2_est179 = 'Renter occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Black or African-American alone, non-Hispanic'
T2_est180 = 'Renter occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Asian alone, non-Hispanic'
T2_est181 = 'Renter occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est182 = 'Renter occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est183 = 'Renter occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Hispanic, any race'
T2_est184 = 'Renter occupied has none of the 4 severe housing problems greater than 30% but less than or equal to 50% of HAMFI other (including multiple races, non-Hispanic)'
T2_est185 = 'Renter occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI'
T2_est186 = 'Renter occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI White alone, non-Hispanic'
T2_est187 = 'Renter occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Black or African-American alone, non-Hispanic'
T2_est188 = 'Renter occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Asian alone, non-Hispanic'
T2_est189 = 'Renter occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est190 = 'Renter occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est191 = 'Renter occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Hispanic, any race'
T2_est192 = 'Renter occupied has none of the 4 severe housing problems greater than 50% but less than or equal to 80% of HAMFI other (including multiple races, non-Hispanic)'
T2_est193 = 'Renter occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI'
T2_est194 = 'Renter occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI White alone, non-Hispanic'
T2_est195 = 'Renter occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Black or African-American alone, non-Hispanic'
T2_est196 = 'Renter occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Asian alone, non-Hispanic'
T2_est197 = 'Renter occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est198 = 'Renter occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est199 = 'Renter occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Hispanic, any race'
T2_est200 = 'Renter occupied has none of the 4 severe housing problems greater than 80% but less than or equal to 100% of HAMFI other (including multiple races, non-Hispanic)'
T2_est201 = 'Renter occupied has none of the 4 severe housing problems greater than 100% of HAMFI'
T2_est202 = 'Renter occupied has none of the 4 severe housing problems greater than 100% of HAMFI White alone, non-Hispanic'
T2_est203 = 'Renter occupied has none of the 4 severe housing problems greater than 100% of HAMFI Black or African-American alone, non-Hispanic'
T2_est204 = 'Renter occupied has none of the 4 severe housing problems greater than 100% of HAMFI Asian alone, non-Hispanic'
T2_est205 = 'Renter occupied has none of the 4 severe housing problems greater than 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est206 = 'Renter occupied has none of the 4 severe housing problems greater than 100% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est207 = 'Renter occupied has none of the 4 severe housing problems greater than 100% of HAMFI Hispanic, any race'
T2_est208 = 'Renter occupied has none of the 4 severe housing problems greater than 100% of HAMFI other (including multiple races, non-Hispanic)'
T2_est209 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems'
T2_est210 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI'
T2_est211 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI White alone, non-Hispanic'
T2_est212 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI Black or African-American alone, non-Hispanic'
T2_est213 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI Asian alone, non-Hispanic'
T2_est214 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est215 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est216 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI Hispanic, any race'
T2_est217 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems less than or equal to 30% of HAMFI other (including multiple races, non-Hispanic)'
T2_est218 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI'
T2_est219 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI White alone, non-Hispanic'
T2_est220 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Black or African-American alone, non-Hispanic'
T2_est221 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Asian alone, non-Hispanic'
T2_est222 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est223 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est224 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI Hispanic, any race'
T2_est225 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 30% but less than or equal to 50% of HAMFI other (including multiple races, non-Hispanic)'
T2_est226 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI'
T2_est227 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI White alone, non-Hispanic'
T2_est228 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Black or African-American alone, non-Hispanic'
T2_est229 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Asian alone, non-Hispanic'
T2_est230 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est231 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est232 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI Hispanic, any race'
T2_est233 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 50% but less than or equal to 80% of HAMFI other (including multiple races, non-Hispanic)'
T2_est234 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI'
T2_est235 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI White alone, non-Hispanic'
T2_est236 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Black or African-American alone, non-Hispanic'
T2_est237 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Asian alone, non-Hispanic'
T2_est238 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est239 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est240 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI Hispanic, any race'
T2_est241 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 80% but less than or equal to 100% of HAMFI other (including multiple races, non-Hispanic)'
T2_est242 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI'
T2_est243 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI White alone, non-Hispanic'
T2_est244 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI Black or African-American alone, non-Hispanic'
T2_est245 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI Asian alone, non-Hispanic'
T2_est246 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI American Indian or Alaska Native alone, non-Hispanic'
T2_est247 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI Pacific Islander alone, non-Hispanic'
T2_est248 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI Hispanic, any race'
T2_est249 = 'Renter occupied cost burden not computed, none of the other 3 severe housing problems greater than 100% of HAMFI other (including multiple races, non-Hispanic)'
; 

run;

data t9_&level. (label = "CHAS 20005-09 Table 9" drop = source sumlevel name st cty);
infile t9_&level. missover dsd dlm="," lrecl=22000 firstobs=2; 
input
source: $13.
sumlevel: $3.
geoid: $12.
NAME: $70.
ST: $2.
CTY: $3.
T9_est1: 8.
T9_est2: 8.
T9_est3: 8.
T9_est4: 8.
T9_est5: 8.
T9_est6: 8.
T9_est7: 8.
T9_est8: 8.
T9_est9: 8.
T9_est10: 8.
T9_est11: 8.
T9_est12: 8.
T9_est13: 8.
T9_est14: 8.
T9_est15: 8.
T9_est16: 8.
T9_est17: 8.
T9_est18: 8.
T9_est19: 8.
T9_est20: 8.
T9_est21: 8.
T9_est22: 8.
T9_est23: 8.
T9_est24: 8.
T9_est25: 8.
T9_est26: 8.
T9_est27: 8.
T9_est28: 8.
T9_est29: 8.
T9_est30: 8.
T9_est31: 8.
T9_est32: 8.
T9_est33: 8.
T9_est34: 8.
T9_est35: 8.
T9_est36: 8.
T9_est37: 8.
T9_est38: 8.
T9_est39: 8.
T9_est40: 8.
T9_est41: 8.
T9_est42: 8.
T9_est43: 8.
T9_est44: 8.
T9_est45: 8.
T9_est46: 8.
T9_est47: 8.
T9_est48: 8.
T9_est49: 8.
T9_est50: 8.
T9_est51: 8.
T9_est52: 8.
T9_est53: 8.
T9_est54: 8.
T9_est55: 8.
T9_est56: 8.
T9_est57: 8.
T9_est58: 8.
T9_est59: 8.
T9_est60: 8.
T9_est61: 8.
T9_est62: 8.
T9_est63: 8.
T9_est64: 8.
T9_est65: 8.
T9_est66: 8.
T9_est67: 8.
T9_est68: 8.
T9_est69: 8.
T9_est70: 8.
T9_est71: 8.
T9_est72: 8.
T9_est73: 8.
; 

label 
T9_est1 = 'Total: Occupied housing units'
T9_est2 = 'Owner occupied'
T9_est3 = 'Owner occupied White alone, non-Hispanic'
T9_est4 = 'Owner occupied White alone, non-Hispanic less than or equal to 30%'
T9_est5 = 'Owner occupied White alone, non-Hispanic greater than 30% but less than or equal to 50%'
T9_est6 = 'Owner occupied White alone, non-Hispanic greater than 50%'
T9_est7 = 'Owner occupied White alone, non-Hispanic not computed (no/negative income)'
T9_est8 = 'Owner occupied Black or African-American alone, non-Hispanic'
T9_est9 = 'Owner occupied Black or African-American alone, non-Hispanic less than or equal to 30%'
T9_est10 = 'Owner occupied Black or African-American alone, non-Hispanic greater than 30% but less than or equal to 50%'
T9_est11 = 'Owner occupied Black or African-American alone, non-Hispanic greater than 50%'
T9_est12 = 'Owner occupied Black or African-American alone, non-Hispanic not computed (no/negative income)'
T9_est13 = 'Owner occupied Asian alone, non-Hispanic'
T9_est14 = 'Owner occupied Asian alone, non-Hispanic less than or equal to 30%'
T9_est15 = 'Owner occupied Asian alone, non-Hispanic greater than 30% but less than or equal to 50%'
T9_est16 = 'Owner occupied Asian alone, non-Hispanic greater than 50%'
T9_est17 = 'Owner occupied Asian alone, non-Hispanic not computed (no/negative income)'
T9_est18 = 'Owner occupied American Indian or Alaska Native alone, non-Hispanic'
T9_est19 = 'Owner occupied American Indian or Alaska Native alone, non-Hispanic less than or equal to 30%'
T9_est20 = 'Owner occupied American Indian or Alaska Native alone, non-Hispanic greater than 30% but less than or equal to 50%'
T9_est21 = 'Owner occupied American Indian or Alaska Native alone, non-Hispanic greater than 50%'
T9_est22 = 'Owner occupied American Indian or Alaska Native alone, non-Hispanic not computed (no/negative income)'
T9_est23 = 'Owner occupied Pacific Islander alone, non-Hispanic'
T9_est24 = 'Owner occupied Pacific Islander alone, non-Hispanic less than or equal to 30%'
T9_est25 = 'Owner occupied Pacific Islander alone, non-Hispanic greater than 30% but less than or equal to 50%'
T9_est26 = 'Owner occupied Pacific Islander alone, non-Hispanic greater than 50%'
T9_est27 = 'Owner occupied Pacific Islander alone, non-Hispanic not computed (no/negative income)'
T9_est28 = 'Owner occupied Hispanic, any race'
T9_est29 = 'Owner occupied Hispanic, any race less than or equal to 30%'
T9_est30 = 'Owner occupied Hispanic, any race greater than 30% but less than or equal to 50%'
T9_est31 = 'Owner occupied Hispanic, any race greater than 50%'
T9_est32 = 'Owner occupied Hispanic, any race not computed (no/negative income)'
T9_est33 = 'Owner occupied other (including multiple races, non-Hispanic)'
T9_est34 = 'Owner occupied other (including multiple races, non-Hispanic) less than or equal to 30%'
T9_est35 = 'Owner occupied other (including multiple races, non-Hispanic) greater than 30% but less than or equal to 50%'
T9_est36 = 'Owner occupied other (including multiple races, non-Hispanic) greater than 50%'
T9_est37 = 'Owner occupied other (including multiple races, non-Hispanic) not computed (no/negative income)'
T9_est38 = 'Renter occupied'
T9_est39 = 'Renter occupied White alone, non-Hispanic'
T9_est40 = 'Renter occupied White alone, non-Hispanic less than or equal to 30%'
T9_est41 = 'Renter occupied White alone, non-Hispanic greater than 30% but less than or equal to 50%'
T9_est42 = 'Renter occupied White alone, non-Hispanic greater than 50%'
T9_est43 = 'Renter occupied White alone, non-Hispanic not computed (no/negative income)'
T9_est44 = 'Renter occupied Black or African-American alone, non-Hispanic'
T9_est45 = 'Renter occupied Black or African-American alone, non-Hispanic less than or equal to 30%'
T9_est46 = 'Renter occupied Black or African-American alone, non-Hispanic greater than 30% but less than or equal to 50%'
T9_est47 = 'Renter occupied Black or African-American alone, non-Hispanic greater than 50%'
T9_est48 = 'Renter occupied Black or African-American alone, non-Hispanic not computed (no/negative income)'
T9_est49 = 'Renter occupied Asian alone, non-Hispanic'
T9_est50 = 'Renter occupied Asian alone, non-Hispanic less than or equal to 30%'
T9_est51 = 'Renter occupied Asian alone, non-Hispanic greater than 30% but less than or equal to 50%'
T9_est52 = 'Renter occupied Asian alone, non-Hispanic greater than 50%'
T9_est53 = 'Renter occupied Asian alone, non-Hispanic not computed (no/negative income)'
T9_est54 = 'Renter occupied American Indian or Alaska Native alone, non-Hispanic'
T9_est55 = 'Renter occupied American Indian or Alaska Native alone, non-Hispanic less than or equal to 30%'
T9_est56 = 'Renter occupied American Indian or Alaska Native alone, non-Hispanic greater than 30% but less than or equal to 50%'
T9_est57 = 'Renter occupied American Indian or Alaska Native alone, non-Hispanic greater than 50%'
T9_est58 = 'Renter occupied American Indian or Alaska Native alone, non-Hispanic not computed (no/negative income)'
T9_est59 = 'Renter occupied Pacific Islander alone, non-Hispanic'
T9_est60 = 'Renter occupied Pacific Islander alone, non-Hispanic less than or equal to 30%'
T9_est61 = 'Renter occupied Pacific Islander alone, non-Hispanic greater than 30% but less than or equal to 50%'
T9_est62 = 'Renter occupied Pacific Islander alone, non-Hispanic greater than 50%'
T9_est63 = 'Renter occupied Pacific Islander alone, non-Hispanic not computed (no/negative income)'
T9_est64 = 'Renter occupied Hispanic, any race'
T9_est65 = 'Renter occupied Hispanic, any race less than or equal to 30%'
T9_est66 = 'Renter occupied Hispanic, any race greater than 30% but less than or equal to 50%'
T9_est67 = 'Renter occupied Hispanic, any race greater than 50%'
T9_est68 = 'Renter occupied Hispanic, any race not computed (no/negative income)'
T9_est69 = 'Renter occupied other (including multiple races, non-Hispanic)'
T9_est70 = 'Renter occupied other (including multiple races, non-Hispanic) less than or equal to 30%'
T9_est71 = 'Renter occupied other (including multiple races, non-Hispanic) greater than 30% but less than or equal to 50%'
T9_est72 = 'Renter occupied other (including multiple races, non-Hispanic) greater than 50%'
T9_est73 = 'Renter occupied other (including multiple races, non-Hispanic) not computed (no/negative income)'
; 

run; 

proc sort data = t1_&level.; by geoid; run; 
proc sort data = t2_&level.; by geoid; run; 
proc sort data = t9_&level.; by geoid; run; 

data &level.; 
merge t1_&level. t2_&level. t9_&level.; 
by geoid; 
run;

%mend chas_readin; 

%chas_readin(level=cty)
%chas_readin(level=st)

*Append state and county datasets together for one complete dataset and assign ucounty; 
data CHAS_05_09 (where = (st ne '72') rename = (cty=county sumlevel=sumlev)); 
length ucounty $5; 
set cty ST; 
ucounty = st||cty;
run; 

data chas_05_09_V2 (rename = (st=state)); 
set chas_05_09; 

label
st = 'State code' 
county = 'County code' 
ucounty = 'Unique County Identifier'
sumlev = 'Summary Level'
geoid = 'Census ID' 
name = 'Name of Geographic Area'
source = 'Source dataset'
;

run;

data chas.chas_05_09 (label = 'CHAS 05-09 Housing Problems, Servere Housing Problems, and Cost Burden for States and Counties'); 
set chas_05_09_v2; 
run;

/*upload file to the Alpha;

signon;
rsubmit;

libname nahsg 'DISK$USER02:[nahsg.cenacs]';
options compress=yes;

proc upload data=chas.chas_05_09 out=nahsg.chas_05_09;
run;

endrsubmit;
