/**************************************************************************
 Program:  208_Delete_REAC.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  05/13/22
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  208
 
 Description:  Delete 2022_02 and 2022_04 data sets. These data sets
 were created using an out-of-date version of the HUD REAC data. 

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( HUD )

%global _files;

** Compile list of data sets in _files macro variable **;

proc sql noprint;
  select memname into :_files separated by ' ' from dictionary.tables
  where upcase( libname ) = "HUD" and 
    upcase( substr( memname, 1, 12 ) ) in ( "REAC_2022_02", "REAC_2022_04" )
  order by memname;
quit;

%put _files=&_files;


** Delete data sets **;

proc datasets library=HUD memtype=(data);
  delete &_files;
quit;


** Remove metadata **;

/** Macro Cleanup_metadata - Start Definition **/

%macro Cleanup_metadata(  );

  %local i v;

  %let i = 1;
  %let v = %scan( &_files, &i, %str( ) );

  %do %until ( &v = );

    %Delete_metadata_file( 
      ds_lib=HUD,
      ds_name=&v,
      meta_lib=_metadat,
      meta_pre=meta
    )

    run;

    %let i = %eval( &i + 1 );
    %let v = %scan( &_files, &i, %str( ) );

  %end;

%mend Cleanup_metadata;

/** End Macro Definition **/


%Cleanup_metadata()

