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

/*%include "L:\SAS\Inc\StdLocal.sas";*/
%include "C:\DCData\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD, local=n )

proc format library=HUD;

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

run;

proc catalog catalog=HUD.Formats;
  modify mfis_soa (desc="MFIS section of act code") / entrytype=formatc;
  contents;
quit;

