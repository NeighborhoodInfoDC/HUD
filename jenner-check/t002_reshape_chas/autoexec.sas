/* cap input rows for the captured run */
options obs=100;

/* Reshape_CHAS.sas reads the global &chas_in as its input data set,
   exactly as Export_CHAS_csv.sas sets it before calling the macro. */
%let chas_in = chas_dc;
