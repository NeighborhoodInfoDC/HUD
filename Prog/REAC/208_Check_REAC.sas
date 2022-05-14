/**************************************************************************
 Program:  208_Check_REAC.sas
 Library:  HUD
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  05/13/22
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  208
 
 Description: Review REAC scores for selected projects. 

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

%global _files;

** Define libraries **;
%DCData_lib( HUD )

proc sql noprint;
  select memname into :_files separated by ' ' from dictionary.tables
  where upcase( libname ) = "HUD" and 
    upcase( substr( memname, 1, 5 ) ) = "REAC_" and upcase( substr( memname, length( memname ) - 1, 2 ) ) = "DC"
  order by memname;
quit;

%put _files=&_files;

run;

/** Macro process_files - Start Definition **/

%macro process_files(  );

  %local i v;

  data A;
  
    set
    
    %let i = 1;
    %let v = %scan( &_files, &i, %str( ) );

    %do %until ( &v = );

      hud.&v (in=in_&v)

      %let i = %eval( &i + 1 );
      %let v = %scan( &_files, &i, %str( ) );

    %end;

    ;
    by rems_property_id;
    
    select;
    
      %let i = 1;
      %let v = %scan( &_files, &i, %str( ) );

      %do %until ( &v = );
    
        when ( in_&v ) file = "&v";
      
        %let i = %eval( &i + 1 );
        %let v = %scan( &_files, &i, %str( ) );

      %end;
    
    end;
    
    length inspec_id 8 inspec_score $ 5 release_date $ 10;
    
    inspec_id = inspec_id_1;
    inspec_score = inspec_score_1;
    release_date = release_date_1;
    n_score = input( compress( inspec_score, 'abcdefghijklmnopqrstuvwxyz*' ), 8. );
    date = input( release_date, anydtdte10. );
    
    output;
    
    inspec_id = inspec_id_2;
    inspec_score = inspec_score_2;
    release_date = release_date_2;
    n_score = input( compress( inspec_score, 'abcdefghijklmnopqrstuvwxyz*' ), 8. );
    date = input( release_date, anydtdte10. );
    
    output;
    
    inspec_id = inspec_id_3;
    inspec_score = inspec_score_3;
    release_date = release_date_3;
    n_score = input( compress( inspec_score, 'abcdefghijklmnopqrstuvwxyz*' ), 8. );
    date = input( release_date, anydtdte10. );
    
    output;
    
    format date mmddyys10. inspec_id z6.0;
    
    keep rems_property_id file inspec_id inspec_score release_date date n_score;

  run;


%mend process_files;

/** End Macro Definition **/


%process_files()


** Summary table **;

proc tabulate data=A format=9.0 noseps missing;
  where rems_property_id in ( '800000023', '800003759', '800003675', '800003758' );
  class rems_property_id file date;
  var n_score inspec_id;
  table 
    /** Pages **/
    rems_property_id * ( n_score='SCORES' inspec_id='INSPECTION ID' ),
    /** Rows **/
    file=' ',
    /** Columns **/
    max=' ' * date=' '
    /rts=18
  ;
  format date mmddyyd8.;
run;

