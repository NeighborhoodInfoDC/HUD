/**************************************************************************
 Program:  Make_formats.sas
 Library:  HUD
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  09/12/15
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Create HUD library formats.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )

proc format library=HUD;

  value $mfis_status
    "A" = "Active"
    "T" = "Terminated";
    
  value $mfis_claim_type
    "C" = "Claim"
    "N" = "Nonclaim";
    
  value $mfis_term_type
    "11" = "Prepayment"
    "12" = "Supersession"
    "13" = "Non-conveyed"
    "14" = "Cancelled"
    "15" = "Conveyance"
    "17" = "Correction/cancellation"
    "18" = "Maturity"
    "19" = "Assignment"
    "20" = "Acquired"
    "21" = "Voluntary"
    "22" = "Transfer with reinsurance"
    "23" = "Partial releases"
    "24" = "Coinsurance claim"
    "26" = "Nonpayment of MIP"
    "32" = "Coinsurance conv to full insurance"
    "42" = "Partial payment of claim"
    "50" = "Demo re engineering w/o partial claim"
    "51" = "Demo re engineering w/partial claim"
    "52" = "OMHAR re engineering w/o partial claim"
    "53" = "OMHAR re engineering w/partial claim"
    "54" = "OMHAR re engineering w/partial claim & supplemental"
    "60" = "Missing termination type-old case"
    "69" = "Risk share claim"
    "99" = "Change to correct SOA and project number";
  
  value $mfis_desc2term_type
    "PREPAYMENT" = "11"
    "SUPERSESSION" = "12"
    "NON-CONVEYED" = "13"
    "CANCELLED" = "14"
    "CONVEYANCE" = "15"
    "CORRECTION/CANCELLATION" = "17"
    "MATURITY" = "18"
    "ASSIGNMENT" = "19"
    "ACQUIRED" = "20"
    "VOLUNTARY" = "21"
    "TRANSFER WITH REINSURANCE" = "22"
    "PARTIAL RELEASES" = "23"
    "COINSURANCE CLAIM" = "24"
    "NONPAYMENT OF MIP" = "26"
    "COINSURANCE CONV TO FULL INSURANCE" = "32"
    "PARTIAL PAYMENT OF CLAIM" = "42"
    "DEMO RE ENGINEERING W/O PARTIAL CLAIM" = "50"
    "DEMO RE ENGINEERING W/PARTIAL CLAIM" = "51"
    "OMHAR RE ENGINEERING W/O PARTIAL CLAIM" = "52"
    "OMHAR RE ENGINEERING W/PARTIAL CLAIM" = "53"
    "OMHAR RE ENGINEERING W/PARTIAL CLAIM & SUPPLEMENTAL" = "54"
    "MISSING TERMINATION TYPE-OLD CASE" = "60"
    "RISK SHARE CLAIM" = "69"
    "CHANGE TO CORRECT SOA AND PROJECT NUMBER" = "99"
    other = " ";
  
  value $mfis_soa (notsorted)
    "ZPE" = "202 Capital Advance for Elderly"
    "ZPD" = "811 Capital Advance for Disabled"
    "YHE" = "542(c) HFA Risk Sharing -- Existing"
    "YHN" = "542(c) HFA Risk Sharing -- NC/SR"
    "YPL" = "542(b) QPE Green Risk Shg: >15 yr term"
    "YPR" = "542(b) QPE Green Risk Shg: < 15 yr term w/Amortz Reserve"
    "YPX" = "542(b) QPE Green Risk Shg: < 15 yr term, no Amortz Reserve"
    "YQE" = "542(b) QPE Risk Sharing -- Existing"
    "YQR" = "542(b) QPE Risk Sharing -- Recently Compt'd"
    "OMR" = "221d4 NC/SR -- SRO"
    "OMI" = "221d4 NC/SR "
    "MMR" = "221d3 NC/SR Market Rate -- SRO"
    "MMI" = "221d3 NC/SR Market Rate"
    "LUR" = "220 NC/SR in Urban Renewal Area"
    "QER" = "231 NC/SR Elderly Hsg "
    "KCP" = "213 NC/SR Sales and Investor Coop "
    "KCS" = "213 NC/SR Management Coop"
    "KCT" = "213(i) NC/SR Consumer Coop"
    "HRI" = "223(f) Refi/Purchase Apts"
    "REE" = "223(a)(7) Refi of Now/Fmr Coins'd 207 in Military Impact Area"
    "RFE" = "223(a)(7) Refi of Now/Formerly Coinsured 207"
    "RFO" = "223(a)(7) Refi of 207 PMM Sale"
    "REB" = "223(a)(7) Refi of 207 Apts"
    "RED" = "223(a)(7) Refi of 213 Coop"
    "REC" = "223(a)(7) Refi of 236"
    "REF" = "223(a)(7) Refi of 220 in Urban Renewal Area"
    "RFG" = "223(a)(7) Refi of Now/Formerly Coinsured 221d3"
    "RFS" = "223(a)(7) Refi of 221d4 or 221d3 Prior Asset Sale"
    "RFM" = "223(a)(7) Refi of a 221d3 BMIR"
    "REH" = "223(a)(7) Refi of 221d3 Market Rate"
    "REV" = "223(a)(7) Refi of Now/Formerly Coinsured 221d4"
    "REJ" = "223(a)(7) Refi of 221d4 NC/SR"
    "REI" = "223(a)(7) Refi of Now/Formerly Coinsured 223(f) Apts"
    "REK" = "223(a)(7) Refi of 223(f) Apts"
    "REN" = "223(a)(7) Refi of 231 Elderly"
    "REP" = "223(a)(7) Refi of 241a on 236 "
    "RER" = "223(a)(7) Refi of 241a on BMIR "
    "RES" = "223(a)(7) Refi of 241a on Apts (not BMIR/236)"
    "REY" = "223(a)(7) Refi of 241f equity loan on 236 "
    "REX" = "223(a)(7) Refi of 241f equity loan on BMIR "
    "REW" = "223(a)(7) Refi of 241f equity loan on 221d3/d4 Market Rate "
    "RFC" = "223(a)(7) Refi of Operating Loss on 213 coop"
    "RFD" = "223(a)(7) Refi of Operating Loss on BMIR/236"
    "RFA" = "223(a)(7) Refi of Operating Loss on Apts (not BMIR/236)"
    "ZSB" = "241a Improvement/Addition on 207 Apts"
    "ZSD" = "241a Improvement/Addition on 213 Coop"
    "ZSF" = "241a Improvement/Addition on 220 Urban Renewal"
    "ZSL" = "241a Improvement/Addition on 221d3 BMIR"
    "ZSJ" = "241a Improvement/Addition on 221d3/d4 Market Rate"
    "ZSM" = "241a Improvement/Addition on 223(f) Apts"
    "ZSN" = "241a Improvement/Addition on 231 Elderly Hsg"
    "ZSR" = "241a Improvement/Addition on 236"
    "TCH" = "234(d) NC/SR Condo"
    "HRC" = "207 Mobile Home Park "
    "XTX" = "223d 10yr Operating Loss"
    "XTD" = "223d 2yr Operating Loss on 207 Mobile Home Park"
    "XTB" = "223d 2yr Operating Loss on 207 Apts"
    "XTF" = "223d 2yr Operating Loss on 213 Coop"
    "XTJ" = "223d 2yr Operating Loss on 221 d3/d4 Market Rate"
    "XTN" = "223d 2yr Operating Loss on 231 Elderly Hsg"
    "RNF" = "232 NC/SR Nursing/ICF"
    "RNQ" = "223(f) Refi/Purchase of 232 Nursing/ICF"
    "REQ" = "223(a)(7) Refi of 232 NC/SR Nursing/ICF"
    "RFP" = "223(a)(7) Refi of 223f Nursing/ICF"
    "XTQ" = "223d 2yr Operating Loss for 232 Nursing/ICF "
    "ZSQ" = "241a Improvement/Addition on 232 Nursing/ICF "
    "RNL" = "232 NC/SR Asst'd Living "
    "RNA" = "223(f) Refi/Purchase of 232 Asst'd Living "
    "REL" = "223(a)(7) Refi of 232 NC/SR Asst'd Living "
    "RFQ" = "223(a)(7) Refi of 223f ALF"
    "XTA" = "223d 2yr Operating Loss on 232 Asst'd Living "
    "ZSA" = "241a Improvement/Addition on 232 Asst'd Living "
    "RNT" = "232 NC/SR Board & Care "
    "RNB" = "223(f) Refi/Purchase of 232 Board & Care "
    "REM" = "223(a)(7) Refi of 232 NC/SR Board & Care "
    "RFR" = "223(a)(7) Refi of 223f B & C"
    "XTC" = "223d 2yr Operating Loss on 232 Board & Care"
    "ZSC" = "241a Improvement/Addition on 232 Board & Care "
    "REO" = "223(a)(7) Refi of Now/Formerly Coinsured on 232 Health Care Facility"
    "REU" = "223(a)(7) Refi of 241a loan on 232 Health Care Facility"
    "RFB" = "223(a)(7) Refi of Operating Loss on 232 Health Care Facility"
    "RNS" = "232(i) Fire safety Equipment on 232 Health Care Facility"
    "ZHL" = "242 NC/SR Hospitals"
    "ZHF" = "223(f) Refi/Purchase of 242 Hospital"
    "RFT" = "223(a)(7) Refi of 241a loan on Hospital"
    "RET" = "223(a)(7) Refi of NC/SR Hospital"
    "ZST" = "241a Improvement/Addition on a 242 Hospital "
    "XTU" = "223d 2yr Operating Loss on 242 Hospital"
    "ZGF" = "Group Practice Title XI";

  value $mfis_soacat
    "207APTS" = "207 Apartments"
    "207EXCPT" = "207 Exception (Sale of PMM)"
    "207MBHC" = "207 Mobile Home Courts"
    "207RENT" = "207 Rental Projects"
    "207223FC0I" = "207/223(f)/244 Co-Insurance"
    "207223FCIC" = "207/223(f) Co-Insurance Converted to Full Insurance"
    "207223FPRH" = "207/223(f) Pur/Refin Hsg."
    "207223FEDA" = "207/223(f)/223(e) Declining Area"
    "207223FDEL" = "207/223(f) - Delegated"
    "213MGTCP" = "213 Management Cooperative"
    "213ICNSCP" = "213(i) Consumer Cooperative"
    "213SICP" = "213 Sales and Inv. Cooperative"
    "220URBRH" = "220 Urban Renewal Hsg."
    "220223EDA" = "220/223(e) Declin. Area"
    "221D3BMIRUC" = "221(d)(3) BMIR Urban Renewal/Coop Hsg"
    "221D3MRMI" = "221(d)(3) Mkt. Rate Moderate Inc/Disp Fams"
    "221D4CIC" = "221(d)(4) Co-Insurance Converted to Full Insurance"
    "221D4MSRO" = "221(d)(4) Mkt. Rate - Single Room Occupancy"
    "221D4MRMI" = "221(d)(4) Mkt. Rate Mod Inc/Disp Fams"
    "221D4MRDA" = "221(d)(4) Mkt. Rate/223(e)Declin. Area"
    "221D4MRCI" = "221(d)(4)/244 Mkt. Rate/Co-Insurance"
    "221D4MRD" = "221(d)(4) Mkt. Rate - Delegated"
    "221HRSP" = "221(h) Rehab. Sales Project"
    "221HRSDA" = "221(h) Rehab Sales/223(e) Declin. Area"
    "223A7R221D3" = "223(a)(7) Refi of 221d3 Market Rate in a 223(e) Declining Area"
    "223A7R221D4" = "223(a)(7) Refi of 221d4 in a 223(e) Declining Area"
    "223A7207CIC" = "223(a)(7)/207 Co-Insurance Converted to Full Ins."
    "223A7REFI" = "223(a)(7)/207 Refinanced Insurance"
    "223A7223FCIC" = "223(a)(7)/207/223(f) Co-Insurance Converted to Full Ins."
    "223A7223FREFI" = "223(a)(7)/207/223(f) Refinanced Insurance"
    "223A7RPRCI" = "223(a)(7)/207/223(f)/244 Refi/Pur/Refin Co-In"
    "223A7207REXC" = "223(a)(7)/207/Refi/Exception(Sale of PMM)"
    "223A7213RCP" = "223(a)(7)/213 Refi/Coops"
    "223A7220RUR" = "223(a)(7)/220 Refi/Urban Renewal"
    "223A7220RDA" = "223(a)(7)/220/223(e) Refi/Declining Areas"
    "223A7221DCIC" = "223(a)(7)/221(d)(3) Co-Insurance Converted to Full Ins."
    "223A7221D3MRMI" = "223(a)(7)/221(d)(3) MKT Refi/Moderate Income"
    "223A7221D3BMIR" = "223(a)(7)/221(d)(3)BMIR/Urban Renewal/Coop Hsg"
    "223A7221D4MRMI" = "223(a)(7)/221(d)(4) MKT Refi/Moderate Income"
    "223A7221D4MMIC" = "223(a)(7)/221(d)(4) MKT/244 Refi/Mod Income Co-In"
    "223A7223DAS" = "223(a)(7)/223(d)/221 Asset Sales"
    "223A7223DHC" = "223(a)(7)/223(d)/232 Refi/2 yr Op Loss Loan - Health Care"
    "223A7231REH" = "223(a)(7)/231 Refi/Elderly Housing"
    "223A7232RAL" = "223(a)(7)/232 Refi/Assisted Living"
    "223A7232RBC" = "223(a)(7)/232 Refi/Board and Care"
    "223A7232RNH" = "223(a)(7)/232 Refi/Nursing Home"
    "223A7PRAL" = "223(a)(7)/232/223(f)/Pur/Refi/Assisted Living"
    "223A7PRBC" = "223(a)(7)/232/223(f)/Pur/Refi/Board & Care"
    "223A7PRNH" = "223(a)(7)/232/223(f)/Pur/Refi/Nursing Home"
    "223A7RLIF" = "223(a)(7)/236(j)(1) Refi/Lower Inc Families"
    "223A7232RIA" = "223(a)(7)/241(a)/232 Refi/Improvements & Additions"
    "223A7236RIA" = "223(a)(7)/241(a)/236 Refi/Improvements & Additions"
    "223A7242RIA" = "223(a)(7)/241(a)/242 Refi/Improvements & Additions"
    "223ARIAA" = "223(a)(7)/241(a)/Refi/Impro & Adds - Apts(not 236/BMIR)"
    "223A7BMIRREL" = "223(a)(7)/241(f)/221 - BMIR Refi/Equity Loan"
    "223A7MRREL" = "223(a)(7)/241(f)/221 - MR Refi/Equity Loan"
    "223A7236REL" = "223(a)(7)/241(f)/236 Refi/Equity Loan"
    "223A7221BMIRRIA" = "223(a)(7)/241/(a)/221-BMIR Refi/Improvements & Add"
    "223A7242RH" = "223(a)(7)/242 Refi/Hospital"
    "223CBMIRAS" = "223(c)/221(d)(3) BMIR Asset Sales"
    "223CMRAS" = "223(c)/221(d)(3) MR Asset Sales"
    "223D2YOL" = "223(d)/207 Two Yr. Opr. Loss"
    "223DBMIR2YOL" = "223(d)/221-BMIR Two Yr. Opr. Loss"                      
    "223D2YOLAL" = "223(d)/232 2yr Op Loss/Assted Lvng"
    "223D2YOLBC" = "223(d)/232 2yr Op Loss/Brd & Care"
    "223D2YOLNH" = "223(d)/232 Two Yr. Opr. Loss/Nursing Hm"
    "223D2YOLLIF" = "223(d)/236 Two Yr. Opr. Loss/Lower Income Families"
    "231ELDERLY" = "231 Elderly Housing"
    "232ASSTLVN" = "232 Assisted Living"
    "232BRDCARE" = "232 Board and Care"
    "232NRSNGHM" = "232 Nursing Homes"
    "232NRSNGHMD" = "232 Nursing Homes - Delegated"
    "232IFS" = "232(i) Fire Safety"
    "232PRAL" = "232/223(f)/Pur/Refin/Assisted Living"
    "232PRBC" = "232/223(f)/Pur/Refin/Board & Care"
    "232PRNH" = "232/223(f)/Pur/Refin/Nursing Hms"
    "234DCND" = "234(d) Condominium"
    "235JRS" = "235(j) Rehab. Sales"
    "236J1EH" = "236(j)(1)/202 Elderly Hsg."
    "236J1LIF" = "236(j)(1)/Lower Income Families"
    "236J1LIFDA" = "236(j)(1)/223(e)/Lower Income Families/Declin. Area"
    "241AIMPADD" = "241(a)/207 Improvements & Additions"
    "241AIAC" = "241(a)/213 Improvements & Additions /Coops"
    "241AIAUR" = "241(a)/220 Improvements & Additions /Urban Renewal"
    "241ABMIRIA" = "241(a)/221-BMIR Improvements & Additions"
    "241AMIRIA" = "241(a)/221-MIR(d)(3)&(d)(4) Improvements & Additions"
    "241AIAPR" = "241(a)/223(f) Improvements & Additions/Pur/Refin"
    "241AIABC" = "241(a)/232 /Improvements & Additions /Board & Care"
    "241AIANH" = "241(a)/232 /Improvements & Additions /Nursing Homes"
    "241AIAAL" = "241(a)/232/Improvements & Additions /Assisted Liv"
    "241AIALIF" = "241(a)/236 /Improvements & Additions/Lower Inc Families"
    "241AIAH" = "241(a)/242 /Improvements & Additions /Hospitals"
    "241FBMIREL" = "241(f)/221-BMIR Equity Loan"
    "241FEL" = "241(f)/236 Equity Loan"
    "242HSPTLS" = "242 Hospitals"
    "242HSPDA" = "242/223(e)/Hospitals/Declin. Area"
    "242RP242H" = "242/223(f)/Refi/Purchase of a 242 Hospital"
    "542BQPERSP15" = "542(b) QPE Risk Sharing Plus < 15 yr term, no Amtz Balloon"
    "542BQPERSRC" = "542(b) QPE Risk Sharing-Recent Comp"
    "542BQPERSE" = "542(b) QPE Risk Sharing-Existing"
    "542CHFARSE" = "542(c) HFA Risk Sharing-Existing"
    "542CHFARSRC" = "542(c) HFA Risk Sharing-Recent Comp"
    "542CHFARSFFB" = "542(c) HFA Risk Sharing-FFB Existing/Coop/Apts/MHP/ALF"
    "542BQPERSFFBE" = "542(b) QPE Risk Sharing-FFB Existing"
    "608VETHSG" = "608 Veteran Housing"
    "608PBHSDS" = "608-610 Pub. Hsg. Disposition"
    "608WH" = "608 War Housing"
    "803ARSH" = "803 Armed Services Housing"
    "803MILH" = "803 Military Housing"
    "810ARSH" = "810 Armed Services Housing"
    "908NTDH" = "908 National Defense Housing"
    "TX1002LD" = "Title X 1002 Land Development"
    "TXIGRPPR" = "Title XI Group Practice"
    ;
  
  value $mfis_soacat2cod
    "207APARTMENTS" = "207APTS"
    "207EXCEPTIONSALEOFPMM" = "207EXCPT"
    "207MOBILEHOMECOURTS" = "207MBHC"
    "207RENTALPROJECTS" = "207RENT"
    "207/223F/244COINSURANCE" = "207223FC0I"
    "207/223FCOINSURANCECONVERTEDTOFULLINSURANCE" = "207223FCIC"
    "207/223FPUR/REFINHSG" = "207223FPRH"
    "207/223F/223EDECLININGAREA" = "207223FEDA"
    "207/223FDELEGATED" = "207223FDEL"
    "213MANAGEMENTCOOPERATIVE" = "213MGTCP"
    "213ICONSUMERCOOPERATIVE" = "213ICNSCP"
    "213SALESANDINVCOOPERATIVE" = "213SICP"
    "220URBANRENEWALHSG" = "220URBRH"
    "220/223EDECLINAREA" = "220223EDA"
    "221D3BMIRURBANRENEWAL/COOPHSG" = "221D3BMIRUC"
    "221D3MKTRATEMODERATEINC/DISPFAMS" = "221D3MRMI"
    "221D4COINSURANCECONVERTEDTOFULLINSURANCE" = "221D4CIC"
    "221D4MKTRATESINGLEROOMOCCUPANCY" = "221D4MSRO"
    "221D4MKTRATEMODINC/DISPFAMS" = "221D4MRMI"
    "221D4MKTRATE/223EDECLINAREA" = "221D4MRDA"
    "221D4/244MKTRATE/COINSURANCE" = "221D4MRCI"
    "221D4MKTRATEDELEGATED" = "221D4MRD"
    "221HREHABSALESPROJECT" = "221HRSP"
    "221HREHABSALES/223EDECLINAREA" = "221HRSDA"
    "223A7REFIOF221D3MARKETRATEINA223EDECLININGAREA" = "223A7R221D3"
    "223A7REFIOF221D4INA223EDECLININGAREA" = "223A7R221D4"
    "223A7/207COINSURANCECONVERTEDTOFULLINS" = "223A7207CIC"
    "223A7/207REFINANCEDINSURANCE" = "223A7REFI"
    "223A7/207/223FCOINSURANCECONVERTEDTOFULLINS" = "223A7223FCIC"
    "223A7/207/223FREFINANCEDINSURANCE" = "223A7223FREFI"
    "223A7/207/223F/244REFI/PUR/REFINCOIN" = "223A7RPRCI"
    "223A7/207/REFI/EXCEPTIONSALEOFPMM" = "223A7207REXC"
    "223A7/213REFI/COOPS" = "223A7213RCP"
    "223A7/220REFI/URBANRENEWAL" = "223A7220RUR"
    "223A7/220/223EREFI/DECLININGAREAS" = "223A7220RDA"
    "223A7/221D3COINSURANCECONVERTEDTOFULLINS" = "223A7221DCIC"
    "223A7/221D3MKTREFI/MODERATEINCOME" = "223A7221D3MRMI"
    "223A7/221D3BMIR/URBANRENEWAL/COOPHSG" = "223A7221D3BMIR"
    "223A7/221D4MKTREFI/MODERATEINCOME" = "223A7221D4MRMI"
    "223A7/221D4MKT/244REFI/MODINCOMECOIN" = "223A7221D4MMIC"
    "223A7/223D/221ASSETSALES" = "223A7223DAS"
    "223A7/223D/232REFI/2YROPLOSSLOANHEALTHCARE" = "223A7223DHC"
    "223A7/231REFI/ELDERLYHOUSING" = "223A7231REH"
    "223A7/232REFI/ASSISTEDLIVING" = "223A7232RAL"
    "223A7/232REFI/BOARDANDCARE" = "223A7232RBC"
    "223A7/232REFI/NURSINGHOME" = "223A7232RNH"
    "223A7/232/223F/PUR/REFI/ASSISTEDLIVING" = "223A7PRAL"
    "223A7/232/223F/PUR/REFI/BOARDCARE" = "223A7PRBC"
    "223A7/232/223F/PUR/REFI/NURSINGHOME" = "223A7PRNH"
    "223A7/236J1REFI/LOWERINCFAMILIES" = "223A7RLIF"
    "223A7/241A/232REFI/IMPROVEMENTSADDITIONS" = "223A7232RIA"
    "223A7/241A/236REFI/IMPROVEMENTSADDITIONS" = "223A7236RIA"
    "223A7/241A/242REFI/IMPROVEMENTSADDITIONS" = "223A7242RIA"
    "223A7/241A/REFI/IMPROADDSAPTSNOT236/BMIR" = "223ARIAA"
    "223A7/241F/221BMIRREFI/EQUITYLOAN" = "223A7BMIRREL"
    "223A7/241F/221MRREFI/EQUITYLOAN" = "223A7MRREL"
    "223A7/241F/236REFI/EQUITYLOAN" = "223A7236REL"
    "223A7/241/A/221BMIRREFI/IMPROVEMENTSADD" = "223A7221BMIRRIA"
    "223A7/242REFI/HOSPITAL" = "223A7242RH"
    "223C/221D3BMIRASSETSALES" = "223CBMIRAS"
    "223C/221D3MRASSETSALES"= "223CMRAS"
    "223D/207TWOYROPRLOSS" = "223D2YOL"
    "223D/221BMIRTWOYROPRLOSS", "223D/221MIRTWOYROPRLOSS" = "223DBMIR2YOL"
    "223D/2322YROPLOSS/ASSTEDLVNG" = "223D2YOLAL"
    "223D/2322YROPLOSS/BRDCARE" = "223D2YOLBC"
    "223D/232TWOYROPRLOSS/NURSINGHM" = "223D2YOLNH"
    "223D/236TWOYROPRLOSS/LOWERINCOMEFAMILIES" = "223D2YOLLIF"
    "231ELDERLYHOUSING" = "231ELDERLY"
    "232ASSISTEDLIVING" = "232ASSTLVN"
    "232BOARDANDCARE" = "232BRDCARE"
    "232NURSINGHOMES" = "232NRSNGHM"
    "232NURSINGHOMESDELEGATED" = "232NRSNGHMD"
    "232IFIRESAFETY" = "232IFS"
    "232/223F/PUR/REFIN/ASSISTEDLIVING" = "232PRAL"
    "232/223F/PUR/REFIN/BOARDCARE" = "232PRBC"
    "232/223F/PUR/REFIN/NURSINGHMS" = "232PRNH"
    "234DCONDOMINIUM" = "234DCND"
    "235JREHABSALES"= "235JRS"
    "236J1/202ELDERLYHSG" = "236J1EH"
    "236J1/LOWERINCOMEFAMILIES" = "236J1LIF"
    "236J1/223E/LOWERINCOMEFAMILIES/DECLINAREA"= "236J1LIFDA"
    "241A/207IMPROVEMENTSADDITIONS" = "241AIMPADD"
    "241A/213IMPROVEMENTSADDITIONS/COOPS" = "241AIAC"
    "241A/220IMPROVEMENTSADDITIONS/URBANRENEWAL" = "241AIAUR"
    "241A/221BMIRIMPROVEMENTSADDITIONS" = "241ABMIRIA"
    "241A/221MIRD3D4IMPROVEMENTSADDITIONS" = "241AMIRIA"
    "241A/223FIMPROVEMENTSADDITIONS/PUR/REFIN" = "241AIAPR"
    "241A/232/IMPROVEMENTSADDITIONS/BOARDCARE" = "241AIABC"
    "241A/232/IMPROVEMENTSADDITIONS/NURSINGHOMES" = "241AIANH"
    "241A/232/IMPROVEMENTSADDITIONS/ASSISTEDLIV" = "241AIAAL"
    "241A/236/IMPROVEMENTSADDITIONS/LOWERINCFAMILIES" = "241AIALIF"
    "241A/242/IMPROVEMENTSADDITIONS/HOSPITALS" = "241AIAH"
    "241F/221BMIREQUITYLOAN" = "241FBMIREL"
    "241F/236EQUITYLOAN" = "241FEL"
    "242HOSPITALS" = "242HSPTLS"
    "242/223E/HOSPITALS/DECLINAREA" = "242HSPDA"
    "242/223F/REFI/PURCHASEOFA242HOSPITAL" = "242RP242H"
    "542BQPERISKSHARINGPLUS<15YRTERM,NOAMTZBALLOON" = "542BQPERSP15"
    "542BQPERISKSHARINGRECENTCOMP" = "542BQPERSRC"
    "542BQPERISKSHARINGEXISTING" = "542BQPERSE"
    "542CHFARISKSHARINGEXISTING" = "542CHFARSE"
    "542CHFARISKSHARINGRECENTCOMP" = "542CHFARSRC"
    "542CHFARISKSHARINGFFBEXISTING/COOP/APTS/MHP/ALF" = "542CHFARSFFB"
    "QPERISKSHARINGFFBEXISTING" = "542BQPERSFFBE"
    "608VETERANHOUSING" = "608VETHSG"
    "608610PUBHSGDISPOSITION"= "608PBHSDS"
    "608WARHOUSING"= "608WH"
    "803ARMEDSERVICESHOUSING" = "803ARSH"
    "803MILITARYHOUSING" = "803MILH"
    "810ARMEDSERVICESHOUSING"= "810ARSH"
    "908NATIONALDEFENSEHOUSING" = "908NTDH"
    "TITLEX1002LANDDEVELOPMENT"= "TX1002LD"
    "TITLEXIGROUPPRACTICE"= "TXIGRPPR"
    other = " ";
    
    /** APSH formats **/
    
    $apsh_sumlevel
      '01' = "U.S. total"
      '03' = "State total, including D.C. and outlying areas"
      '04' = "Public housing agency (PHA)"
      '05' = "Core Based Statistical Areas (CBSA)"
      '06' = "Projects (multifamily assisted or public housing)"
      '07' = "Census tract"
      '08' = "City, or census-designated place-CDP"
      '09' = "County"
      '10' = "Zipcode"
      '11' = "Congressional District";
      
    $apsh_program
      '1' = "Summary of all HUD programs"
      '2' = "Public housing"
      '3' = "Housing choice vouchers"
      '4' = "Moderate rehabilitation"
      '5' = "Project based section 8"
      '6' = "RentSup/RAP"
      '7' = "S236/BMIR"
      '8' = "202/PRAC"
      '9' = "811/PRAC";

    $apsh_sub_program
      'LMSA' = "Loan management set-aside"
      '202/8' = "Section 202/8"
      'PD' = "Property disposition"
      'NC/SR' = "New construction and substantial rehabilitation"
      'SUP' = "Rent supplement"
      'RAP' = "Rental assistance program"
      'S236' = "Section 236"
      'BMIR' = "Below market interest rate"
      '202/PRAC' = "Section 202 capital advance/project rental assistance contract"
      '811/PRAC' = "Section 811 capital advance/project rental assistance contract"
      'NA' = "Not applicable";

    $apsh_ha_size
      '1' = "Agencies with 1-99 units"
      '2' = "100-299 units"
      '3' = "300-499 units"
      '4' = "500-999 units"
      '5' = "1,000-2,999 units"
      '6' = "3,000-4,999 units"
      '7' = "5,000-9,999 units"
      '8' = "10,000-29,999 units"
      '9' = "30,000+ units";

run;

proc catalog catalog=HUD.Formats;
  modify mfis_status (desc="MFIS mortgage status") / entrytype=formatc;
  modify mfis_claim_type (desc="MFIS termination claim type") / entrytype=formatc;
  modify mfis_term_type (desc="MFIS termination type code") / entrytype=formatc;
  modify mfis_desc2term_type (desc="MFIS convert desc to term type code") / entrytype=formatc;
  modify mfis_soa (desc="MFIS section of act code") / entrytype=formatc;
  modify mfis_soacat (desc="MFIS section of act category code") / entrytype=formatc;
  modify mfis_soacat2cod (desc="MFIS convert SOA cat text to code") / entrytype=formatc;
  modify apsh_sumlevel (desc="APSH summary level") / entrytype=formatc;
  modify apsh_program (desc="APSH assisted housing program") / entrytype=formatc;
  modify apsh_program (desc="APSH subprogram type") / entrytype=formatc;
  modify apsh_ha_size (desc="APSH housing agency size") / entrytype=formatc;
  contents;
quit;

