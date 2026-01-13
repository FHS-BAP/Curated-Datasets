******************************************************************************************************************************************
Introduction to Gen1 curated dataset source code
******************************************************************************************************************************************

Created by Sophia Lu 
Revised by Alvin Ang
Last updated: Feb 2024


The purpose of this SAS code is to allow users to create similar data structure and naming convention to that of the FHS-BAP Gen1
curated dataset, as shown in the coding manual. The order of the variable may vary from the manual.

TAKE NOTE: The participant ID system used in this program code is IDTYPE, ID and FRAMID. Your data may use a different ID system (e.g., SHAREid), 
adjust accordingly with the following steps: 
 
		Look for the following portions of code and delete them if necessary:

		/*Creating universal identifer variables - framid;*/
		  framid=id; */

		/*Creating universal identifer variables - framid;*/
		  if idtype=0 then framid=id; */
		  else if idtype=1 then framid=id+80000; */
          else if idtype=2 then framid=id+20000; */
          else if idtype=3 then framid=id+30000; */
          else if idtype=7 then framid=id+700000; */
          else framid=id+720000;*/

		Copy and paste this SAS code onto a Word document and replace all "framid" with the ID system your data has using the "find and replace" function


Please ensure you have these listed datasets to run this SAS code optimally. It is highly recommended to have them in the same location.


Generic names are used for these datasets within this SAS code. 
Tip: You can copy and paste this SAS code onto a Word document and use the "find and replace" function to customize to your dataset names 

1)  vr_wkthru_ex32_0_0997 (Gen1 Workthru)
	vr_raceall_2008_a_0712 (FHS race/ethnicity information) 
	vr_educ_2018_a_1307 (Harmonized education dataset for all cohorts)

2)  np_summary_through2022_18053 (NP Summary Score)

3)  demrev_through2022_4308 (Dementia Review)

4)  Commonly used outcomes (CHD, Stroke, AF, Diabetes and Cancer): 
	vr_soe_2022_a_1424 (Verified Sequence of Events (SOE) Cardiovascular Endpoints)
	vr_afcum_2022_a_1412 (verified Atrial Fibrillation/Flutter dataset)
	vr_diab_ex28_0_0601 (Verified Diabetes dataset)
	vr_cancer_2019_a_1162_v1 (Verified Cancer dataset)
	vr_survdth_2021_a_1452 (Verified Survival Status dataset) 

5) 	Individual FHS exam questionnaires: 
	e_exam_ex07_0_0076_v1 (Gen 1 Exam 1-7)
	e_exam_ex22_0_0070 (Gen 1 Exam 22)
	e_exam_ex23_0_0071 (Gen 1 Exam 23)
	e_exam_ex25_0_0073 (Gen 1 Exam 25)
	e_exam_ex26_0_0074 (Gen 1 Exam 26)
	e_exam_ex27_0_0075 (Gen 1 Exam 27)
	e_exam_ex28_0_0256 (Gen 1 Exam 28)
	e_exam_ex29_0_0210_v2 (Gen 1 Exam 29)
	e_exam_ex30_0_0274 (Gen 1 Exam 30)
	e_exam_ex31_0_0738 (Gen 1 Exam 31)
	e_exam_ex32_0_0939 (Gen 1 Exam 32)
	vr_mmse_ex32_0_0945 (Verified Gen 1 MMSE dataset)

6)  Neuropathology Data 
	neuropath_through2022_245 (FHS Brain Donor Neuropathology Data) 

*Provide the location of these datasets to import from before you run the SAS code. ;
libname in1 'C:\Users\angtf\Desktop\Test_SAS\Input_data';
*Provide the location of the derived datasets to export to before you run the SAS code. ;
libname out1 'C:\Users\angtf\Desktop\Test_SAS\Output_data';


******************************************************************************************************************************************
Renaming variables within FHS Gen 1 workthru dataset
******************************************************************************************************************************************

*Read in the Gen 1 workthru dataset by using a data step;

data wt_0;
set in1.vr_wkthru_ex32_0_0997;
*Creating universal identifer variables - framid;
framid=id;
drop att1-att32;
run;

/*rename the other variables*/
data wt_0_1;
set wt_0;
*Create smoking history variable;
array currsmk{*} currsmk2-currsmk5 currsmk7-currsmk15 currsmk17-currsmk32; 
array smksum{*} currsmk1 smksum2-smksum5 smksum7-smksum15 smksum17-smksum32; 
array smoking_ever{*} smoking_ever_core2-smoking_ever_core5 smoking_ever_core7-smoking_ever_core15 smoking_ever_core17-smoking_ever_core32; 
do k = 1 to dim(currsmk);
smksum{k+1} = sum(smksum{k},currsmk{k});
end;
do i = 1 to dim(currsmk); 
if currsmk(i) = . then smoking_ever(i) =.; 
else if  currsmk(i) = 1 then smoking_ever(i) =1; 
else if smksum(i+1) > 0 then smoking_ever(i) = 2; 
else smoking_ever(i) = 0; 
end; 
drop i k smksum:;
*Standardize variable naming; 
rename 
	age1-age32=Age_core1-Age_core32
	bg1-bg4=BG_core1-BG_core4  
	bg6=BG_core6  
	bg8-bg10=BG_core8-BG_core10  
	bg13-bg23=BG_core13-BG_core23  
	bg26-bg28=BG_core26-BG_core28
	bmi1=BMI_core1  
	bmi4=BMI_core4  
	bmi5=BMI_core5  
	bmi10-bmi32=BMI_core10-BMI_core32 
	calc_LDL24-calc_LDL28=Calc_LDL_core24-Calc_LDL_core28
	creat14=Creatinine_core14
	creat15=Creatinine_core15
	creat20=Creatinine_core20
	creat24=Creatinine_core24
	creat25=Creatinine_core25
	creat26=Creatinine_core26
	creat27=Creatinine_core27
	creat28=Creatinine_core28
	cpd1-cpd5=CPD_core1-CPD_core5 
	cpd7-cpd15=CPD_core7-CPD_core15  
	cpd17-cpd32=CPD_core17-CPD_core32
	currsmk1-currsmk5=Smoking_core1-Smoking_core5
	currsmk7-currsmk15=Smoking_core7-Smoking_core15
	currsmk17-currsmk32=Smoking_core17-Smoking_core32
	date1-date32=Date_core1-Date_core32
   	dbp1-dbp32=DBP_core1-DBP_core32
	DLVH1-DLVH32=DLVH_core1-DLVH_core32
	dmrx1-dmrx32=DMRX_core1-DMRX_core32
	hdl15=HDL_core15
	hdl20=HDL_core20
	hdl22-hdl28=HDL_core22-HDL_core28
	hgt1=Height_core1 
	hgt4=Height_core4  
	hgt5=Height_core5  
	hgt10-hgt32=Height_core10-Height_core32
	hip19-hip23=Hip_core19-Hip_core23
	hrx4-hrx32=HRX_core4-HRX_core32
	liprx6-liprx32=LIPRX_core6-LIPRX_core32
   	sbp1-sbp32=SBP_core1-SBP_core32
	tc1-tc8=TC_core1-TC_core8
	tc13=TC_core13
	tc14=TC_core14
	tc15=TC_core15
	tc20=TC_core20
	tc22-tc28=TC_core22-TC_core28
	trig7=Triglycerides_core7  
	trig8=Triglycerides_core8  
	trig24-trig28=Triglycerides_core24-Triglycerides_core28
	vent_rt1=Vent_rt_core1  
	vent_rt4-vent_rt32=Vent_rt_core4-Vent_rt_core32
 	waist4=Waist_core4
    waist5=Waist_core5
	waist19-waist23=Waist_core19-Waist_core23
	wgt1-wgt32=Weight_core1-Weight_core32
;
run;


*Read in FHS race/ethnicity information by using a data step;
data race_0 race_17 race_2372; 
retain framid; 
set in1.vr_raceall_2008_a_0712; 
*Creating universal identifer variables - framid;
if idtype=0 then framid=id;
else if idtype=1 then framid=id+80000;
else if idtype=2 then framid=id+20000;
else if idtype=3 then framid=id+30000;
else if idtype=7 then framid=id+700000;
else framid=id+720000;
*Assume Gen 1, 2 and 3 participants with missing race_code information as Non-Hispanic White;
if idtype in (0,1,3) and race_code=" " then race_code="EW"; 
*Creating derived variable - Race;
if race_code in ("B", "BB", "BBN", "BEB", "BEBN", "BEWB", "BEWBN", "BHB", "BN", "BO", "BWB", "EB", "EBN") then race = 2;
else if race_code in ("A", "AO", "EA", "N", "X", "XA", "XEA") then race = 3;
else if race_code in ("E", "EW", "W", "WO", "") then race = 1;
else if race_code in ("H", "HEW", "HH", "HHB", "HHR", "HHW", "HHWBA", "HO", "HW", "WH") then race = 4;
else race = 5;
*Output into three separate datasets based on cohorts;
if idtype = 0 then output race_0;
else if idtype in (1,7) then output race_17;
else output race_2372;
keep framid race_code race;
run; 

*Read in verified Gen 1 diabetes dataset by using a data step;
data diabetes_0; 
retain framid; 
set in1.vr_diab_ex28_0_0601; 
*Creating universal identifer variables - framid;
framid=id;
keep framid Curr_diab: Hx_diab:; 
rename
CURR_DIAB1-CURR_DIAB28=Curr_dm_core1-Curr_dm_core28
HX_DIAB1-HX_DIAB28=Hx_dm_core1-Hx_dm_core28
;
run; 

*Macro to sort datasets by ID variable;
*****datain- data read in, and ID=ID variable******;
%macro sort (datain, ID);
proc sort data=&datain;
by &ID;
run;
%mend sort;

*Sort all three datasets by using the macro-sort;
%sort(wt_0_1, framid);
%sort(race_0, framid);
%sort(diabetes_0, framid);



*Combined workthru, race and diabetes datasets;
data wt_0_2; 
merge wt_0_1 race_0 diabetes_0;
by framid; 
run; 

/*Reordering variables*/
data backbone_0;
retain idtype id framid sex race_code race; 
if 0 then set wt_0_2 (keep=Date_core:) wt_0_2 (keep=Age_core:) wt_0_2 (keep=Height_core:) wt_0_2 (keep=Weight_core:) wt_0_2 (keep=BMI_core:) wt_0_2 (keep=Hip_core:) wt_0_2 (keep=Waist_core:) wt_0_2 (keep=Smoking_core:) wt_0_2 (keep=Smoking_ever_core:) wt_0_2 (keep=CPD_core:) wt_0_2 (keep=SBP_core:) wt_0_2 (keep=DBP_core:) wt_0_2 (keep=Vent_RT_core:) wt_0_2 (keep=DLVH_core:) wt_0_2 (keep=HRX_core:) wt_0_2 (keep=BG_core:) wt_0_2 (keep=DMRX_core:) wt_0_2 (keep=curr_dm_core:) wt_0_2 (keep=hx_dm_core:) wt_0_2 (keep=TC_core:) wt_0_2 (keep=HDL_core:) wt_0_2 (keep=Triglycerides_core:) wt_0_2 (keep=Calc_LDL_core:) wt_0_2 (keep=LIPRX_core:) wt_0_2 (keep=Creatinine_core:);
set wt_0_2;
run;





******************************************************************************************************************************************
Variables renaming and transposition of NP Summary Score dataset
******************************************************************************************************************************************

*Read in the NP Summary Score dataset by using a data step;
data NP_all_cohort_1;
set in1.np_summary_through2022_18053;
*Creating universal identifer variables - framid;
if idtype=0 then framid=id;
else if idtype=1 then framid=id+80000;
else if idtype=2 then framid=id+20000;
else if idtype=3 then framid=id+30000;
else if idtype=7 then framid=id+700000;
else framid=id+720000;
run;

proc sort data=NP_all_cohort_1;
by framid examdate;
run;

*Create a pivot variable so we can transpose the NP dataset;
data NP_all_cohort_2;
set NP_all_cohort_1;
by framid;
if first.framid then NP_exam=1;
else NP_exam+1;
run;

*Convert pivot variable to a suffix character variable for transposition;
data NP_all_cohort_3 (drop=old_NP_exam);
retain idtype id framid NP_exam examdate age sex battery marital handedness employment education_b1 education_b2 educg occup_b1 occup_b2 lmi lmd lmr lmi_joe lmd_joe lmr_joe LM_story vri vrd vrr pasi pasi_e pasi_h pasd pasd_e pasd_h pasr dsf dsb trailsA trailsB sim hvot bnt10 bnt10_semantic bnt10_phonemic bnt30 bnt30_semantic bnt30_phonemic bnt36 bnt36_semantic bnt36_phonemic FingTapR FingTapL wrat fas fas_animal bd wais coding_correct coding_incorrect Incidental_paired Incidental_free Math_correct Math_incorrect_add Math_incorrect_sub Math_incorrect_mul right_open left_open right_close left_close mri352 test_language;
  length NP_exam $10;
  set NP_all_cohort_2 (rename=(NP_exam=old_NP_exam));
  NP_exam=cats("_NP", put(old_NP_exam,best.));
run;

*Splitting the dataset into three smaller datasets based on study cohorts: 1)Gen 1, 2)Gen2 and Omni1 and 3)Gen3, Omni2 and NOS;
data NP_cohort0_1 NP_cohort17_1 NP_cohort2372_1;
set NP_all_cohort_3;
if idtype = 0 then output NP_cohort0_1;
else if idtype in (1,7) then output NP_cohort17_1;
else output NP_cohort2372_1;
drop idtype id sex;  
run;

/*************************************************************************************************************************************************************

%MultiTranspose arguments list

Argument    			 Value    															 

out    				 the name of the output data set;     

data    				 the name of the input data set;     

vars    				 lists which variables are to be transposed;     

by    					 the name of the variable(s) that identifies(y) a subject;     

pivot    				 variable name from input data set for which each row value should lead to a new series of variables
   					 (one series per variable listed in vars, above) in output data set;     
   				 
   					 There should be only one variable named in pivot argument.
   					 Also, the column used as a pivot cannot have any duplicate values for a given series of values found in by variables.
   					 %MultiTranspose will check that these conditions are met.


copy    				 a list of variables that occur repeatedly with each observation for a subject and will be copied to the resulting data set;     

   					 %MultiTranspose will run a check that copy variables have the same values within each series of by values.
   					 Can be left empty.


dropMissingPivot    	 whether or not observations corresponding to a missing value in pivot should be dropped from the input data before transposing;     

   					 Default: 1 (yes).
   					 Call with dropMissingPivot=0 if you'd rather not drop observations where variable defined as pivot has a missing value.


UseNumericExtension     whether the observed character string value for variable used as pivot (when it is indeed a string variable)
   					 should be replaced by numbers as suffixes in transposed variable names or not;     

   					 Default: 0 (no: character string values observed in pivot variable will be used as suffixes in new variable names).
   					 Call with UseNumericExtension=1 to use numbers as suffixes in transposed variable names rather than characters.
   					 Relevant only when pivot variable is literal.


library    			 the name of the library where value labels are defined
   					 (if any variables of interest in the input data set were categorical/attached value labels);     

   					 Default: library.
   					 Feel free to change the default library to work, for example.

***********************************************************************************************************************************************************/

/*Transposition Macro*/

%macro MultiTranspose(out=, data=, vars=, by=, pivot=, copy=, dropMissingPivot=1, UseNumericExt=0, library=library);
	%local dsCandidateVarnames dsContents dsCopiedVars dsLocalOut dsNewVars dsNewVarsFreq dsPivotLabels dsPivotLabelsHigh dsPivotLabelsLow dsPivotLabelsOther dsPivotObsValues dsRowvarsFreq dsTmp dsTmpOut dsTransposedVars dsXtraVars;

	%local anyfmtHigh anyfmtLow anyfmtOther anymissinglabel anymissingPivotlabel anyrepeatedvarname byfmt bylbl byvar datefmt;
	%local formatl formattedPivot i llabel lmax lPivotlabel lPivotmylabel;
	%local nbyvars ncandidatevars ncopy newlbl newvar newvars nNewvars npivot npivotvalues nvars;
	%local pivotfmt pivotIsDate pivotIsNumeric pivotvalue s tmp tmpvar;
	%local v var vars xnewvars xtravar ynewvars;

	/*
    	PIVOT names the column in the input file whose row values provide the column names in the output file.
    	There should only be one variable in the PIVOT statement. Also, the column used for the PIVOT statement cannot have
    	any duplicate values (for a given set of values taken by variables listed in BY)
	*/;

	* Check that mandatory arguments were filled;

	%if %length(%superq(out)) eq 0 %then %do;
    	%put ERROR: [MultiTranspose] output file must be specified (through out= argument);
    	%goto Farewell;
	%end;

	%if %length(%superq(data)) eq 0 %then %do;
    	%put ERROR: [MultiTranspose] input data set must be specified (through data= argument);
    	%goto Farewell;
	%end;

	%if %length(%superq(vars)) eq 0 %then %do;
    	%put ERROR: [MultiTranspose] list of variables to be transposed must be specified (through vars= argument);
    	%goto Farewell;
	%end;

	%if %length(%superq(by)) eq 0 %then %do;
    	%put ERROR: [MultiTranspose] *by* variables must be specified (through by= argument);
    	%goto Farewell;
	%end;

	%if %length(%superq(pivot)) eq 0 %then %do;
    	%put ERROR: [MultiTranspose] pivot variable must be specified (through pivot= argument);
    	%goto Farewell;
	%end;


	%let nbyvars	= %MultiTransposeNTokens(&by);
	%let npivot	= %MultiTransposeNTokens(&pivot);

	* ~~~ First make sure that no duplicate (in variables by * pivot) is found in source data set ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~;

	%if &npivot ne 1 %then %do;
    	%put ERROR: [MultiTranspose] one and only one variable name must be given in *pivot* argument;
    	%goto Farewell;
	%end;

	%let dsCandidateVarnames = %MultiTransposeNewDatasetName(candidatevarnames);
	%let ncandidatevars = %sysevalf(&nbyvars+2);

	data &dsCandidateVarnames;
    	retain found 0;
    	length vname $ 32;
    	do i = 1 to &ncandidatevars;
        	vname = cats("_", i);
        	if vname not in (%MultiTransposeDQList(&by &pivot)) then do;
            	if not found then output;
            	found = 1;
        	end;
    	end;
	run;

	proc sql noprint;
    	select strip(vname) into :tmpvar
    	from &dsCandidateVarnames;
	quit;

	%let dsRowvarsFreq = %MultiTransposeNewDatasetName(rowvarsfreq);

	proc sql;
    	create table &dsRowvarsFreq as
    	select %MultiTransposeCommasep(&by &pivot), sum(1) as &tmpvar
    	from &data
    	%if &dropMissingPivot eq 1 %then %do;
        	where not missing(&pivot)
    	%end;
    	group %MultiTransposeCommasep(&by &pivot)
    	;
	quit;

	proc sql noprint;
    	select max(&tmpvar) into :tmp
    	from &dsRowvarsFreq;
	quit;
	proc datasets nolist; delete &dsCandidateVarnames &dsRowvarsFreq; quit;

	%if &tmp gt 1 %then %do;
    	%put ERROR: [MultiTranspose] duplicates were found in data &data in variables (&by) * &pivot;
    	%goto Farewell;
	%end;

	* ~~~ Now make sure that no duplicate (in by * copy) is found in source data set ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~;

	%let ncopy = %MultiTransposeNTokens(&copy);

	%if &ncopy %then %do;
    	%let dsCopiedVars = %MultiTransposeNewDatasetName(copiedvars);

    	proc sql;
        	create table &dsCopiedVars as
        	select distinct %MultiTransposeCommasep(&by &copy)
        	from &data;
    	quit;

    	proc sql;
        	create table &dsRowvarsFreq as
        	select %MultiTransposeCommasep(&by), sum(1) as &tmpvar
        	from &dsCopiedVars
        	group %MultiTransposeCommasep(&by);
    	quit;

    	proc sql noprint;
        	select max(&tmpvar) into :tmp
        	from &dsRowvarsFreq;
    	quit;
    	proc datasets nolist; delete &dsRowvarsFreq; quit;

    	%if &tmp gt 1 %then %do;
        	proc datasets nolist; delete &dsCopiedVars; quit;
        	%put ERROR: [MultiTranspose] some copy variables (&copy) are not uniquely defined for some output data rows (defined by &by);
        	%goto Farewell;
    	%end;
	%end;

	* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~;

	* Create &out, just to make sure it exists and its name is not recycled;
	data &out; stop; run;

	%let dsContents = %MultiTransposeNewDatasetName(contents);
	proc contents data=&data noprint out=&dsContents (keep=name label type format formatl); run;

	%let dsTmp = %MultiTransposeNewDatasetName(tmp);

	proc sql noprint;
    	select compress(ifc(substr(format,1,1) eq "$", substr(format,2), format)), type eq 1, formatl,
        	format in ("DATE", "DDMMYY", "DDMMYYB", "DDMMYYC", "DDMMYYD", "DDMMYYN", "DDMMYYP", "DDMMYYS", "EURDFDE", "EURDFMY", "EURDFDMY", "EURDFWKX",
                        	"JULIAN", "MINGUO", "MMDDYY", "MMDDYYB", "MMDDYYC", "MMDDYYD", "MMDDYYN", "MMDDYYP", "MMDDYYS", "MMYY", "MMYYC", "MMYYD", "MMYYN", "MMYYP", "MMYYS",
                        	"MONYY", "NENGO", "PDJULG", "PDJULI", "WEEKDATE", "WORDDATE", "WORDDATX",
                        	"YYMM", "YYMMC", "YYMMDD", "YYMMP", "YYMMS", "YYMMN", "YYMMDD", "YYMON", "YYQ", "YYQC", "YYQD", "YYQP", "YYQSYYQN", "YYQR", "YYQRC", "YYQRD", "YYQRP", "YYQRS")
        	into :pivotfmt, :pivotIsNumeric, :formatl, :pivotIsDate
    	from &dsContents
    	where upcase(name) eq upcase("&pivot");
	quit;

	%if &pivotIsDate %then %do;
    	%if &formatl eq 0 %then %let datefmt=&pivotfmt;
    	%else %let datefmt=%sysfunc(compress(&pivotfmt.&formatl));
	%end;

	/* Pivot values */;

	%let dsPivotObsValues = %MultiTransposeNewDatasetName(obspivots);
	proc sql;
    	create table &dsPivotObsValues as
    	select distinct(&pivot) as PivotValue
    	from &data
    	%if &dropMissingPivot %then %do;
        	where not missing(&pivot)
    	%end;
    	order &pivot;
	quit;

	data &dsPivotObsValues;
    	set &dsPivotObsValues;
    	PivotIndex = _N_;
	run;

	proc sql noprint;
    	select N(PivotIndex) into :npivotvalues
    	from &dsPivotObsValues;
	quit;

	/* Vars to transpose */;

	%let nvars = %MultiTransposeNTokens(&vars);

	%let dsTransposedVars = %MultiTransposeNewDatasetName(transposedvars);
	data &dsTransposedVars;
    	length name $32;
    	%do v = 1 %to &nvars;
        	%let var = %scan(&vars, &v);
        	name = "&var";
        	output;
    	%end;
	run;

	%let dsNewVars = %MultiTransposeNewDatasetName(newvars);

	%if &pivotIsNumeric %then %do;
    	proc sql;
        	create table &dsNewVars as
        	select v.name, upcase(v.name) as ucname, s.PivotValue, s.PivotIndex,
            	case
                	when s.PivotValue eq . then	cats(v.name, "00")
                	%if &pivotIsDate %then %do;
                    	else cats(v.name, compress(put(s.PivotValue, &datefmt..)))
                	%end;
                	%else %do;
                    	else cats(v.name, s.PivotValue)
                	%end;
            	end as NewVar length=200
        	from &dsTransposedVars as v, &dsPivotObsValues as s;
    	quit;
	%end;
	%else %do;
    	%if &UseNumericExt %then %do;
        	proc sql;
            	create table &dsNewVars as
            	select v.name, upcase(v.name) as ucname, s.PivotValue, s.PivotIndex, cats(v.name, s.PivotIndex) as NewVar length=200
            	from &dsTransposedVars as v, &dsPivotObsValues as s;
        	quit;
    	%end;
    	%else %do;
        	proc sql;
            	create table &dsNewVars as
            	select v.name, upcase(v.name) as ucname, s.PivotValue, s.PivotIndex, tranwrd(compbl(cats(v.name, s.PivotValue)), " ", "_") as NewVar length=200
            	from &dsTransposedVars as v, &dsPivotObsValues as s;
        	quit;
    	%end;
	%end;    

	data &dsNewVars (drop=j);
    	set &dsNewVars;

    	j = notalnum(NewVar);
    	do while(j gt 0 and j le length(NewVar));
        	if    	j gt 1    	then NewVar = substr(NewVar, 1, j-1) || "_" || substr(NewVar, j+1);
        	else	if j eq 1	then NewVar = "_" || substr(NewVar, 2);
        	j = notalnum(NewVar, j+1);
    	end;

    	ucnewvar = upcase(NewVar);
	run;


	%let dsXtraVars = %MultiTransposeNewDatasetName(xtravars);
	data &dsXtraVars;
    	length ucnewvar $ 200;
    	%do i = 1 %to &nbyvars;
        	%let xtravar = %scan(&by, &i);
        	ucnewvar = strip(upcase("&xtravar"));
        	output;
    	%end;
    	%do i = 1 %to &ncopy;
        	%let xtravar = %scan(&copy, &i);
        	ucnewvar = strip(upcase("&xtravar"));
        	output;
    	%end;
	run;

	%let dsNewVarsFreq = %MultiTransposeNewDatasetName(newvarsfreq);
	proc sql;
    	create table &dsNewVarsFreq as
    	select a.ucnewvar, N(a.ucnewvar) as f
    	from
        	(
            	select ucnewvar from &dsNewVars
            	outer union corresponding
            	select ucnewvar from &dsXtraVars
        	) as a
    	group a.ucnewvar;
	quit;
	proc datasets nolist; delete &dsXtraVars; quit;

	proc sql noprint;
    	select ucnewvar, N(ucnewvar) gt 0 into :multipdefnvars separated by ", ", :anyrepeatedvarname
    	from &dsNewVarsFreq
    	where f gt 1;
	quit;

	%if &anyrepeatedvarname %then %do;
    	%put ERROR: [MultiTranspose] given the variables to transpose and the values taken by variable &pivot,
        	some variables created in transposed output data set (&multipdefnvars) would have ambiguous meanings:
        	please rename some of the variables to transpose prior to calling MultiTranspose again in order to avoid these ambiguities.;
    	proc datasets nolist; delete &out; quit;
    	%goto ByeBye;
	%end;

	/* Pivot fmt values */;

	%let dsPivotLabels = %MultiTransposeNewDatasetName(pivotlabels);
	%let formattedPivot = 0;

	%if %length(&pivotfmt) %then %do;
    	%if &pivotIsDate %then %do;
        	%let formattedPivot = 1;
        	%let anyfmtHigh = 0;
        	%let anyfmtLow = 0;
        	%let anyfmtOther = 0;

        	proc sql;
            	create table &dsPivotLabels as
            	select PivotValue as start, PivotValue as end, compress(put(PivotValue, &datefmt..)) as Label
            	from &dsPivotObsValues;
        	quit;
    	%end;
    	%else %if %upcase("&library") eq "WORK" or %sysfunc(exist(&library..formats)) %then %do;
        	%let formattedPivot = 1;
        	proc format library=&library cntlout=&dsTmp; run;

        	data &dsTmp;
            	set &dsTmp;

            	if upcase(fmtname) ne upcase("&pivotfmt") then delete;

            	High = 0;
            	Low = 0;
            	Other = 0;

            	if        	upcase(HLO) eq "L"	then do;
                	start	= "";
                	Low = 1;
            	end;
            	else if	upcase(HLO) eq "H"	then do;
                	end	= "";
                	High = 1;
            	end;
            	else if	upcase(HLO) eq "O"	then do;
                	start = "";
                	end	= "";
                	Other = 1;
            	end;
        	run;

        	%if &pivotIsNumeric %then %do;
            	proc sql;
                	create table &dsPivotLabels as
                	select input(start, best32.) as start, input(end, best32.) as end, Label, High, Low, Other
                	from &dsTmp;
            	quit;
        	%end;
        	%else %do;
            	proc sql;
                	create table &dsPivotLabels as
                	select start, end, Label, High, Low, Other
                	from &dsTmp;
            	quit;
        	%end;

        	proc sql noprint;
            	select max(High), max(Low), max(Other) into :anyfmtHigh, :anyfmtLow, :anyfmtOther
            	from &dsPivotLabels;
        	quit;

        	%if &anyfmtHigh %then %do;
            	%let dsPivotLabelsHigh = %MultiTransposeNewDatasetName(pivotlabelshigh);
            	proc sql;
                	create table &dsPivotLabelsHigh as
                	select start, Label
                	from &dsPivotLabels
                	where High eq 1;
                	delete from &dsPivotLabels where High eq 1;
            	quit;
        	%end;

        	%if &anyfmtLow %then %do;
            	%let dsPivotLabelsLow = %MultiTransposeNewDatasetName(pivotlabelslow);
            	proc sql;
                	create table &dsPivotLabelsLow as
                	select end, Label
                	from &dsPivotLabels
                	where Low eq 1;
                	delete from &dsPivotLabels where Low eq 1;
            	quit;
        	%end;

        	%if &anyfmtOther %then %do;
            	%let dsPivotLabelsOther = %MultiTransposeNewDatasetName(pivotlabelsother);
            	proc sql;
                	create table &dsPivotLabelsOther as
                	select Label
                	from &dsPivotLabels
                	where Other eq 1;
                	delete from &dsPivotLabels where Other eq 1;
            	quit;
        	%end;

        	proc datasets nolist; delete &dsTmp; quit;
    	%end;
	%end;
	%else %do;
    	proc sql;
        	create table &dsPivotLabels as
        	select PivotValue as start, PivotValue as end, "" as Label
        	from &dsPivotObsValues;
    	quit;
	%end;

	/* Transpose data, one pivot-value at a time */;

	%let dsLocalOut	= %MultiTransposeNewDatasetName(localout);
	%let dsTmpOut	= %MultiTransposeNewDatasetName(tmpout);

	%do s = 1 %to &npivotvalues;
    	proc sql noprint;
        	select name, NewVar, NewVar into :vars separated by ' ', :newvars separated by ' ', :ynewvars separated by ", y."
        	from &dsNewVars
        	where PivotIndex eq &s;
    	quit;
   	 
    	proc sql;
        	create table &dsTmp as
        	select %MultiTransposeCommasep4sql(d, &by)
        	%do v = 1 %to &nvars;
            	%let var = %scan(&vars, &v);
            	%let newvar = %scan(&newvars, &v);
            	, d.&var as &newvar
        	%end;
        	from &data as d, &dsPivotObsValues as s
        	where d.&pivot eq s.PivotValue and s.PivotIndex eq &s;
    	quit;

    	%if &s eq 1 %then %do;
        	proc datasets nolist; change &dsTmp=&dsLocalOut; quit;
        	%let xnewvars=&newvars;
    	%end;
    	%else %do;
        	proc sql;
            	create table &dsTmpOut as
            	select
                	%do i = 1 %to &nbyvars;
                    	%let byvar = %scan(&by, &i);
                    	coalesce(x.&byvar, y.&byvar) as &byvar,
                	%end;
                	%MultiTransposeCommasep4sql(x, &xnewvars), y.&ynewvars
            	from &dsLocalOut as x
            	full join &dsTmp as y
            	on
                	%do i = 1 %to &nbyvars;
                    	%let byvar = %scan(&by, &i);
                    	%if &i gt 1 %then %do;
                        	and
                    	%end;
                    	x.&byvar eq y.&byvar
                	%end;
                	;
        	quit;
        	proc datasets nolist; delete &dsLocalOut; change &dsTmpOut=&dsLocalOut; quit;
        	%let xnewvars=&xnewvars &newvars;
    	%end;
	%end;


	%if &ncopy eq 0 %then %do;
    	proc datasets nolist; delete &out; change &dsLocalOut=&out; quit;
	%end;
	%else %do;
    	proc sql;
        	create table &out as
        	select t.*, %MultiTransposeCommasep4sql(c, &copy)
        	from &dsLocalOut as t, &dsCopiedVars as c
        	where
        	%do i = 1 %to &nbyvars;
            	%let byvar = %scan(&by, &i);
            	%if &i gt 1 %then %do;
                	and
            	%end;
            	t.&byvar eq c.&byvar
        	%end;
        	;
    	quit;
    	proc datasets nolist; delete &dsCopiedVars &dsLocalOut; quit;
	%end;
    

	/* Get variable labels */;

	proc sql;
    	create table &dsTmp as
    	select t.*, c.label
    	from &dsTransposedVars as t, &dsContents as c
    	where upcase(t.name) eq upcase(c.name);
	quit;

	proc sql noprint;
    	select max(length(strip(label))), max(length(strip(name))), max(missing(label)) into :llabel, :lmax, :anymissinglabel
    	from &dsTmp;
	quit;

	%if &anymissinglabel and &lmax gt &llabel %then %let llabel = &lmax;

	proc sql;
    	create table &dsTransposedVars as
    	select *, coalesce(strip(label), strip(name)) as newvarLabel
    	from &dsTmp;
	quit;
	proc datasets nolist; delete &dsTmp; quit;


	* If pivot is a formatted variable, get the formats for each of its values, else define a label as "pivot = Value";

	%if &formattedPivot %then %do;
    	proc sql;
        	create table &dsTmp as
        	select s.PivotValue, s.PivotIndex, l.Label as PivotLabel
        	from &dsPivotObsValues as s
        	left join &dsPivotLabels as l
        	on (missing(s.PivotValue) and s.PivotValue eq l.start)
            	or (not missing(s.PivotValue) and s.PivotValue ge l.start and s.PivotValue le l.end);
    	quit;

    	%if &anyfmtHigh %then %do;
        	proc datasets nolist; delete &dsPivotObsValues; change &dsTmp=&dsPivotObsValues; quit;
        	proc sql;
            	create table &dsTmp as
            	select s.PivotValue, s.PivotIndex, coalesce(s.Label, x.Label) as PivotLabel
            	from &dsPivotObsValues as s
            	left join &dsPivotLabelsHigh as x
            	on s.PivotValue ge x.start;
        	quit;
        	proc datasets nolist; delete &dsPivotLabelsHigh; quit;
    	%end;

    	%if &anyfmtLow %then %do;
        	proc datasets nolist; delete &dsPivotObsValues; change &dsTmp=&dsPivotObsValues; quit;
        	proc sql;
            	create table &dsTmp as
            	select s.PivotValue, s.PivotIndex, coalesce(s.Label, x.Label) as PivotLabel
            	from &dsPivotObsValues as s
            	left join &dsPivotLabelsLow as x
            	on s.PivotValue le x.end;
        	quit;
        	proc datasets nolist; delete &dsPivotLabelsLow; quit;
    	%end;

    	%if &anyfmtOther %then %do;
        	proc datasets nolist; delete &dsPivotObsValues; change &dsTmp=&dsPivotObsValues; quit;
        	proc sql;
            	create table &dsTmp as
            	select s.PivotValue, s.PivotIndex, coalesce(s.Label, x.Label) as PivotLabel
            	from &dsPivotObsValues as s, &dsPivotLabelsOther as x;
        	quit;
        	proc datasets nolist; delete &dsPivotLabelsOther; quit;
    	%end;
	%end;
	%else %do;
    	proc sql;
        	create table &dsTmp as
        	select PivotValue, PivotIndex, "" as PivotLabel
        	from &dsPivotObsValues;
    	quit;
	%end;
	proc datasets nolist; delete &dsPivotObsValues; change &dsTmp=&dsPivotObsValues; quit;

	proc sql noprint;
    	select N(PivotIndex) gt 0 into :anymissingpivotlabel
    	from &dsPivotObsValues
    	where missing(PivotLabel);
	quit;

	%if &anymissingpivotlabel %then %do;
    	proc sql noprint;
        	select max(length(PivotLabel)) into :lpivotlabel
        	from &dsPivotObsValues;
    	quit;

    	%if &pivotIsNumeric %then %do;
        	proc sql noprint;
            	select max(length(strip(put(PivotValue, best32.)))) into :lpivotmylabel
            	from &dsPivotObsValues;
        	quit;
    	%end;
    	%else %do;
        	proc sql noprint;
            	select max(length(PivotValue)) into :lpivotmylabel
            	from &dsPivotObsValues;
        	quit;
    	%end;

    	%let lpivotmylabel = %sysevalf(3+&lpivotmylabel+%length(&pivot));
    	%if &lpivotmylabel gt &lpivotlabel %then %let lpivotlabel = &lpivotmylabel;

    	%if &pivotIsNumeric %then %do;
        	proc sql;
            	create table &dsTmp as
            	select PivotValue, PivotIndex, coalesce(PivotLabel, catx(" = ", strip("&pivot"), strip(put(PivotValue, best32.)))) as PivotLabel length=&lpivotlabel
            	from &dsPivotObsValues;
        	quit;
    	%end;
    	%else %do;
        	proc sql;
            	create table &dsTmp as
            	select PivotValue, PivotIndex, coalesce(PivotLabel, catx(" = ", strip("&pivot"), strip(PivotValue))) as PivotLabel length=&lpivotlabel
            	from &dsPivotObsValues;
        	quit;
    	%end;
    	proc datasets nolist; delete &dsPivotObsValues; change &dsTmp=&dsPivotObsValues; quit;
	%end;

	* Give new labels to new (transposed) variables;

	proc sql;
    	create table &dsTmp as
    	select n.newvar, t.newvarlabel, s.PivotLabel
    	from &dsNewVars as n, &dsTransposedVars as t, &dsPivotObsValues as s
    	where n.name eq t.name and n.PivotIndex eq s.PivotIndex;
	quit;
	proc datasets nolist; delete &dsNewVars; change &dsTmp=&dsNewVars; quit;

	proc sql noprint;
    	select NewVar, N(NewVar) into :newvars separated by ' ', :nNewvars
    	from &dsNewVars;
	quit;

	%do i = 1 %to &nNewvars;
    	%let newvar = %scan(&newvars, &i);

    	proc sql noprint;
        	select catx(":: ", tranwrd(newvarLabel, '"', '""'), tranwrd(PivotLabel, '"', '""')) into :newlbl
        	from &dsNewVars
        	where NewVar eq "&newvar";
    	quit;

    	proc datasets nolist;
        	modify &out;
        	label &newvar = "&newlbl";
    	quit;
	%end;

	* Put back format on by variables;

	%do i = 1 %to &nbyvars;
    	%let byvar = %scan(&by, &i);
    	%let byfmt=;
    	%let bylbl=;
    	proc sql noprint;
        	select
            	ifc(anyalnum(format) or formatl gt 0, cats(format, ifc(formatl gt 0, strip(put(formatl, 4.)), ""), "."), ""),
            	tranwrd(label, '"', '""')
            	into :byfmt, :bylbl
        	from &dsContents
        	where lowcase(name) eq lowcase("&byvar");
    	quit;

    	%if %length(&byfmt) or %length(&bylbl) %then %do;
        	proc datasets nolist;
            	modify &out;
            	%if %length(&bylbl) %then %do;
                	label &byvar = "&bylbl";
            	%end;
            	%if %length(&byfmt) %then %do;
                	format &byvar &byfmt;
            	%end;
        	quit;
    	%end;
	%end;

	proc datasets nolist; delete &dsPivotLabels; quit;

	%ByeBye:
	proc datasets nolist; delete &dsContents &dsNewVars &dsNewVarsFreq &dsPivotObsValues &dsTransposedVars; quit;
	%Farewell:
%mend;


%macro MultiTransposeCommasep(lov);
	%sysfunc(tranwrd(%Qsysfunc(compbl(%sysfunc(strip(&lov)))), %str( ), %str(, )))
%mend;


%macro MultiTransposeCommasep4sql(datasetindex, lov);
	&datasetindex..%sysfunc(tranwrd(%Qsysfunc(compbl(%sysfunc(strip(&lov)))), %str( ), %str(, &datasetindex..)))
%mend;


%macro MultiTransposeDQList(list);
	"%sysfunc(tranwrd(%sysfunc(compbl(&list)),%quote( ),%quote(", ")))"
%mend;


%macro MultiTransposeNewDatasetName(proposalname);
	%*Finds the first unused dataset named *datasetname*, adding a leading underscore and a numeric suffix as large as necessary to make it unique!;
	%local i newdatasetname;
	%let proposalname=%sysfunc(compress(&proposalname));
	%let newdatasetname=_&proposalname;

	%do %while(%sysfunc(exist(&newdatasetname)));
    	%let i = %eval(&i+1);
    	%let newdatasetname=_&proposalname&i;
	%end;

	&newdatasetname
%mend;


%macro MultiTransposeNTokens(list);
	%if %length(&list) %then %do;
    	%eval(1 + %length(%sysfunc(compbl(&list))) - %length(%sysfunc(compress(&list))))
	%end;
	%else %do;
    	0
	%end;
%mend;

/*Transpose NP Summary Score for Gen 2 and Omni 1 participants*/
%MultiTranspose
(out=NP_cohort0_2,
data=NP_cohort0_1,
vars= examdate age battery marital handedness employment education_b1 education_b2 educg occup_b1 occup_b2 lmi lmd lmr lmi_joe lmd_joe lmr_joe LM_story vri vrd vrr pasi pasi_e pasi_h pasd pasd_e pasd_h pasr dsf dsb trailsA trailsB sim hvot bnt10 bnt10_semantic bnt10_phonemic bnt30 bnt30_semantic bnt30_phonemic bnt36 bnt36_semantic bnt36_phonemic FingTapR FingTapL wrat fas fas_animal bd wais coding_correct coding_incorrect Incidental_paired Incidental_free Math_correct Math_incorrect_add Math_incorrect_sub Math_incorrect_mul right_open left_open right_close left_close mri352 test_language,
by=framid,
pivot=NP_exam,
dropMissingPivot=0,
library=work);





******************************************************************************************************************************************
Date-matching between NP dates and core exam dates
******************************************************************************************************************************************

*Read in workthru and NP Summary Score dataset by using a data step;

data date_matching; 
merge wt_0_2 NP_cohort0_2; 
by framid; 
keep framid date_core: examdate_np:;
run; 


data date_matching_1 (drop = i); 
set date_matching; 
array examdate_np[*] examdate_np1-examdate_np13; 
array date_core[*] date_core:; 
array np_closest_exam_date[13] ; 
array np_days_apart[13] ; 
array np_exam_cycle[13] ; 
do i = 1 to dim(examdate_np); 
if examdate_np(i) ne . then np_closest_exam_date(i) = date_core1; 
else  np_closest_exam_date(i) = .; 
if examdate_np(i) ne . then np_days_apart(i) = date_core1-examdate_np(i); 
else np_days_apart(i) = .; 
if examdate_np(i) ne . then np_exam_cycle(i)= 1; 
else np_exam_cycle(i) = .; 
end; 
format np_closest_exam_date: MMDDYY10. ;
run;

data date_matching_2 (drop = i j); 
set date_matching_1; 
array examdate_np[*] examdate_np1-examdate_np13; 
array date_core[*] date_core:; 
array np_closest_exam_date[13] np_closest_exam_date:; 
array np_days_apart[13] np_days_apart:; 
array np_exam_cycle[13] np_exam_cycle:;
do i = 1 to dim(examdate_np); 
if examdate_np[i] ne . then do j = 2 to dim(date_core); 
if . < abs(date_core[j] - examdate_np[i]) < abs(np_days_apart[i]) then do; 
np_closest_exam_date[i] = date_core[j]; 
np_days_apart[i] = date_core[j] - examdate_np[i];
np_exam_cycle[i] = j; 
end; 
end; 
end; 
drop Date_core: examdate_NP:;
run; 






******************************************************************************************************************************************
Dementia outcome variables from Dementia review dataset
******************************************************************************************************************************************

*Read in the Dementia Review dataset by using a data step;
data demrv_all_cohort_1;
retain idtype framid review_date normal_date impairment_date mild_date moderate_date severe_date eddd demrv046 demrv103;
set in1.demrev_through2022_4308;
*Creating universal identifer variables - framid;
if idtype=0 then framid=id;
else if idtype=1 then framid=id+80000;
else if idtype=2 then framid=id+20000;
else if idtype=3 then framid=id+30000;
else if idtype=7 then framid=id+700000;
else framid=id+720000;
if eddd = . then eddd = min(mild_date, moderate_date, severe_date);
keep idtype framid review_date normal_date impairment_date mild_date moderate_date severe_date eddd demrv046 demrv103;
format review_date normal_date impairment_date mild_date moderate_date severe_date eddd MMDDYY10. ; 
run;

proc sort data=demrv_all_cohort_1;
by framid review_date;
run;


*Splitting the dataset into three smaller datasets based on study cohorts: 1)Gen 1, 2)Gen2 and Omni1 and 3)Gen3, Omni2 and NOS;
data demrv_cohort0_1 demrv_cohort17_1 demrv_cohort2372_1;
set demrv_all_cohort_1;
*Last dementia review observation per FHS participant;  
by framid; 
if last.framid; 
if idtype = 0 then output demrv_cohort0_1;
else if idtype in (1,7) then output demrv_cohort17_1;
else output demrv_cohort2372_1;
drop idtype review_date;  
run;





******************************************************************************************************************************************
CHD and Stroke outcome variables from verified SoE dataset
******************************************************************************************************************************************

*Read in the verified SoE dataset by using a data step;
data chd_all_cohort_1 stroke_all_cohort_1 strokerisk_all_cohort_1;
set in1.vr_soe_2022_a_1424;
*Creating universal identifer variables - framid;
if idtype=0 then framid=id;
else if idtype=1 then framid=id+80000;
else if idtype=2 then framid=id+20000;
else if idtype=3 then framid=id+30000;
else if idtype=7 then framid=id+700000;
else framid=id+720000;
if event in (1, 2, 3, 4, 5, 6, 7, 8, 21, 22, 23, 24) then output chd_all_cohort_1;
if event in (10, 11, 13, 14, 15, 16, 17, 19) then output stroke_all_cohort_1;  
if event in (1, 2, 3, 4, 5, 6, 7, 8, 9, 21, 22, 23, 24, 26, 30, 39, 40, 41, 49) then output strokerisk_all_cohort_1; /*This dataset will be used to calculate FSRP, it will not be included in the curated dataset*/
run;

proc sort data=chd_all_cohort_1;
by framid date;
run;

*Splitting the dataset into three smaller datasets based on study cohorts: 1)Gen 1, 2)Gen2 and Omni1 and 3)Gen3, Omni2 and NOS;
data chd_cohort0_1 chd_cohort17_1 chd_cohort2372_1;
set chd_all_cohort_1;
*First CHD observation per FHS participant;  
by framid; 
if first.framid; 
first_chd_date = date; 
if idtype = 0 then output chd_cohort0_1;
else if idtype in (1,7) then output chd_cohort17_1;
else output chd_cohort2372_1;
keep framid first_chd_date;
format first_chd_date MMDDYY10.;
run;

proc sort data=stroke_all_cohort_1;
by framid date;
run;

*Splitting the dataset into three smaller datasets based on study cohorts: 1)Gen 1, 2)Gen2 and Omni1 and 3)Gen3, Omni2 and NOS;
data stroke_cohort0_1 stroke_cohort17_1 stroke_cohort2372_1;
set stroke_all_cohort_1;
*First stroke observation per FHS participant;  
by framid; 
if first.framid; 
first_stroke_date = date; 
if idtype = 0 then output stroke_cohort0_1;
else if idtype in (1,7) then output stroke_cohort17_1;
else output stroke_cohort2372_1;
keep framid first_stroke_date;
format first_stroke_date MMDDYY10.; 
run;

proc sort data=strokerisk_all_cohort_1;
by framid date;
run;

*Splitting the dataset into three smaller datasets based on study cohorts: 1)Gen 1, 2)Gen2 and Omni1 and 3)Gen3, Omni2 and NOS;
data strokerisk_cohort0_1 strokerisk_cohort17_1 strokerisk_cohort2372_1;
set strokerisk_all_cohort_1;
*First CHD observation per FHS participant;  
by framid; 
if first.framid; 
first_strokerisk_date = date; 
if idtype = 0 then output strokerisk_cohort0_1;
else if idtype in (1,7) then output strokerisk_cohort17_1;
else output strokerisk_cohort2372_1;
keep framid first_strokerisk_date;
format first_strokerisk_date MMDDYY10.; 
run;








******************************************************************************************************************************************
AF outcome variables from verified AF dataset
******************************************************************************************************************************************

*Read in the verified AF dataset by using a data step;
data af_all_cohort_1;
set in1.vr_afcum_2022_a_1412;
*Creating universal identifer variables - framid;
if idtype=0 then framid=id;
else if idtype=1 then framid=id+80000;
else if idtype=2 then framid=id+20000;
else if idtype=3 then framid=id+30000;
else if idtype=7 then framid=id+700000;
else framid=id+720000;
if rhythm in (1, 2, 3) then output;
run;

proc sort data=af_all_cohort_1;
by framid ecgdate;
run;

*Splitting the dataset into three smaller datasets based on study cohorts: 1)Gen 1, 2)Gen2 and Omni1 and 3)Gen3, Omni2 and NOS;
data af_cohort0_1 af_cohort17_1 af_cohort2372_1;
set af_all_cohort_1;
*First AF observation per FHS participant;  
by framid; 
if first.framid; 
first_af_date = ecgdate; 
if idtype = 0 then output af_cohort0_1;
else if idtype in (1,7) then output af_cohort17_1;
else output af_cohort2372_1;
keep framid first_af_date;
format first_af_date MMDDYY10.;
run;




******************************************************************************************************************************************
Cancer outcome variables from verified cancer dataset
******************************************************************************************************************************************

*Read in the verified cancer dataset by using a data step;
data cancer_all_cohort_1;
set in1.vr_cancer_2019_a_1162_v1;
*Creating universal identifer variables - framid;
if idtype=0 then framid=id;
else if idtype=1 then framid=id+80000;
else if idtype=2 then framid=id+20000;
else if idtype=3 then framid=id+30000;
else if idtype=7 then framid=id+700000;
else framid=id+720000;
run;

proc sort data=cancer_all_cohort_1;
by framid d_date;
run;

*Splitting the dataset into three smaller datasets based on study cohorts: 1)Gen 1, 2)Gen2 and Omni1 and 3)Gen3, Omni2 and NOS;
data cancer_cohort0_1 cancer_cohort17_1 cancer_cohort2372_1;
retain framid first_cancer_date topo_cancer location_cancer hist_cancer;
set cancer_all_cohort_1;
*First cancer observation per FHS participant;  
by framid; 
if first.framid; 
first_cancer_date = d_date; 
topo_cancer = TOPO; 
location_cancer = LOCATION;
hist_cancer = HIST;
if idtype = 0 then output cancer_cohort0_1;
else if idtype in (1,7) then output cancer_cohort17_1;
else output cancer_cohort2372_1;
keep framid first_cancer_date topo_cancer location_cancer hist_cancer;
format first_cancer_date MMDDYY10.; 
run;





******************************************************************************************************************************************
Survival/Last contact variables 
******************************************************************************************************************************************

*Read in the verified survival status dataset by using a data step;
data surv_cohort0_1 surv_cohort17_1 surv_cohort2372_1;
set in1.vr_survdth_2021_a_1452;
*Creating universal identifer variables - framid;
if idtype=0 then framid=id;
else if idtype=1 then framid=id+80000;
else if idtype=2 then framid=id+20000;
else if idtype=3 then framid=id+30000;
else if idtype=7 then framid=id+700000;
else framid=id+720000;
last_contact_date = LASTCON;
death_date = DATEDTH;
if idtype = 0 then output surv_cohort0_1;
else if idtype in (1,7) then output surv_cohort17_1;
else output surv_cohort2372_1;
keep framid last_contact_date death_date;
format last_contact_date death_date MMDDYY10.; 
run;








******************************************************************************************************************************************
Prevalent variables for Gen 1 
******************************************************************************************************************************************

*Sort datasets by framid; 
%sort(backbone_0, framid);
%sort(NP_cohort0_2, framid);
%sort(demrv_cohort0_1, framid);
%sort(chd_cohort0_1, framid);
%sort(stroke_cohort0_1, framid);
%sort(AF_cohort0_1, framid);
%sort(cancer_cohort0_1, framid);
%sort(strokerisk_cohort0_1, framid);

data prevalence_derivation0; 
merge backbone_0 NP_cohort0_2 demrv_cohort0_1 chd_cohort0_1 stroke_cohort0_1 AF_cohort0_1 cancer_cohort0_1 strokerisk_cohort0_1;
by framid; 
run; 

data prevalence_cohort0; 
set prevalence_derivation0; 
array date_core[*] date_core:; 
array examdate_np[*] examdate_np1-examdate_np13; 

*Derived prevalent variables for each FHS core exam;
array prevalent_chd_core[32] ; 
array prevalent_stroke_core[32] ; 
array prevalent_af_core[32] ;
array prevalent_dementia_core[32] ; 
array prevalent_cancer_core[32] ;
array prevalent_strokerisk_core[32] ;

do i = 1 to dim(date_core); 
if date_core(i) ne . then do; 
if first_CHD_date = . then prevalent_chd_core(i) = 0;  
else if date_core(i) < first_chd_date then prevalent_chd_core(i) = 0; 
else if date_core(i) >= first_chd_date then prevalent_chd_core(i) = 1;
end; 
else if date_core(i) = . then prevalent_chd_core(i) = .;
end;

do i = 1 to dim(date_core); 
if date_core(i) ne . then do; 
if first_stroke_date = . then prevalent_stroke_core(i) = 0;  
else if date_core(i) < first_stroke_date then prevalent_stroke_core(i) = 0; 
else if date_core(i) >= first_stroke_date then prevalent_stroke_core(i) = 1;
end; 
else if date_core(i) = . then prevalent_stroke_core(i) = .;
end;

do i = 1 to dim(date_core); 
if date_core(i) ne . then do; 
if first_af_date = . then prevalent_af_core(i) = 0;  
else if date_core(i) < first_af_date then prevalent_af_core(i) = 0; 
else if date_core(i) >= first_af_date then prevalent_af_core(i) = 1;
end; 
else if date_core(i) = . then prevalent_af_core(i) = .;
end;

do i = 1 to dim(date_core); 
if date_core(i) ne . then do; 
if eddd = . then prevalent_dementia_core(i) = 0;  
else if date_core(i) < eddd then prevalent_dementia_core(i) = 0; 
else if date_core(i) >= eddd then prevalent_dementia_core(i) = 1;
end; 
else if date_core(i) = . then prevalent_dementia_core(i) = .;
end;

do i = 1 to dim(date_core); 
if date_core(i) ne . then do; 
if first_cancer_date = . then prevalent_cancer_core(i) = 0;  
else if date_core(i) < first_cancer_date then prevalent_cancer_core(i) = 0; 
else if date_core(i) >= first_cancer_date then prevalent_cancer_core(i) = 1;
end; 
else if date_core(i) = . then prevalent_cancer_core(i) = .;
end;

do i = 1 to dim(date_core); 
if date_core(i) ne . then do; 
if first_strokerisk_date = . then prevalent_strokerisk_core(i) = 0;  
else if date_core(i) < first_strokerisk_date then prevalent_strokerisk_core(i) = 0; 
else if date_core(i) >= first_strokerisk_date then prevalent_strokerisk_core(i) = 1;
end; 
else if date_core(i) = . then prevalent_strokerisk_core(i) = .;
end;

*Derived prevalent variables for each NP test;
array prevalent_chd_NP[13] ; 
array prevalent_stroke_NP[13] ; 
array prevalent_af_NP[13] ;
array prevalent_dementia_NP[13] ; 
array prevalent_cancer_NP[13] ;
array prevalent_strokerisk_NP[13] ;

do j = 1 to dim(examdate_np); 
if examdate_np(j) ne . then do; 
if first_CHD_date = . then prevalent_chd_np(j) = 0;  
else if examdate_np(j) < first_chd_date then prevalent_chd_np(j) = 0; 
else if examdate_np(j) >= first_chd_date then prevalent_chd_np(j) = 1;
end; 
else if examdate_np(j) = . then prevalent_chd_np(j) = .;
end;

do j = 1 to dim(examdate_np); 
if examdate_np(j) ne . then do; 
if first_stroke_date = . then prevalent_stroke_np(j) = 0;  
else if examdate_np(j) < first_stroke_date then prevalent_stroke_np(j) = 0; 
else if examdate_np(j) >= first_stroke_date then prevalent_stroke_np(j) = 1;
end; 
else if examdate_np(j) = . then prevalent_stroke_np(j) = .;
end;

do j = 1 to dim(examdate_np); 
if examdate_np(j) ne . then do; 
if first_af_date = . then prevalent_af_np(j) = 0;  
else if examdate_np(j) < first_af_date then prevalent_af_np(j) = 0; 
else if examdate_np(j) >= first_af_date then prevalent_af_np(j) = 1;
end; 
else if examdate_np(j) = . then prevalent_af_np(j) = .;
end;

do j = 1 to dim(examdate_np); 
if examdate_np(j) ne . then do; 
if eddd = . then prevalent_dementia_np(j) = 0;  
else if examdate_np(j) < eddd then prevalent_dementia_np(j) = 0; 
else if examdate_np(j) >= eddd then prevalent_dementia_np(j) = 1;
end; 
else if examdate_np(j) = . then prevalent_dementia_np(j) = .;
end;

do j = 1 to dim(examdate_np); 
if examdate_np(j) ne . then do; 
if first_cancer_date = . then prevalent_cancer_np(j) = 0;  
else if examdate_np(j) < first_cancer_date then prevalent_cancer_np(j) = 0; 
else if examdate_np(j) >= first_cancer_date then prevalent_cancer_np(j) = 1;
end; 
else if examdate_np(j) = . then prevalent_cancer_np(j) = .;
end;

do j = 1 to dim(examdate_np); 
if examdate_np(j) ne . then do; 
if first_strokerisk_date = . then prevalent_strokerisk_np(j) = 0;  
else if examdate_np(j) < first_strokerisk_date then prevalent_strokerisk_np(j) = 0; 
else if examdate_np(j) >= first_strokerisk_date then prevalent_strokerisk_np(j) = 1;
end; 
else if examdate_np(j) = . then prevalent_strokerisk_np(j) = .;
end;
run; 

data prevalence_cohort0_1; 
set prevalence_cohort0; 
keep framid prevalent_chd_core: prevalent_stroke_core: prevalent_af_core: prevalent_dementia_core: prevalent_cancer_core: prevalent_chd_np: prevalent_stroke_np: prevalent_af_np: prevalent_dementia_np: prevalent_cancer_np: ;    
run;







******************************************************************************************************************************************
MMSE variables from verified MMSE dataset
******************************************************************************************************************************************
*read in verified MMSE dataset with a data step;
data mmse_0;
set in1.vr_mmse_ex32_0_0945;
*Creating universal identifer variables - framid;
framid=id;
keep framid exam cogscr maxcog; 
run; 

proc transpose data=mmse_0 out=widecogscr prefix=cogscr_core;
   by framid;
   id exam;
   var cogscr;
run;

proc transpose data=mmse_0 out=widemaxcog prefix=maxcog_core;
   by framid;
   id exam;
   var maxcog;
run;

data mmse_0_1;
retain framid; 
merge  widecogscr(drop=_name_) widemaxcog(drop=_name_);
    by framid;
drop _LABEL_;
run;






******************************************************************************************************************************************
CES-D variables from individual FHS exam questionnaires
******************************************************************************************************************************************
*read in exam 22 with a data step;
data exam22_0;
set in1.e_exam_ex22_0_0070;
*Creating universal identifer variables - framid;
framid=id;
*create a variable for the sum of positively worded CESD variables in exam 25;
positive_score_22=12-sum(of FO050, FO054, FO058, FO062);
*total score for CES-D Variable;
if nmiss(of FO047-FO066)=0 then total_sum=sum(of FO047-FO066)-( FO050+FO054+FO058+FO062)+positive_score_22;
else total_sum=.;
*extract framid, CES-D variables, and CESD_total_core22 with the keep function;
keep FRAMID FO047-FO066 total_sum;
*rename the CES-D variables with CESD_Q#_core#;
rename FO047=CESD_1_core22
	   FO048=CESD_2_core22
	   FO049=CESD_3_core22
	   FO050=CESD_4_core22
	   FO051=CESD_5_core22
	   FO052=CESD_6_core22
	   FO053=CESD_7_core22
	   FO054=CESD_8_core22
	   FO055=CESD_9_core22
	   FO056=CESD_10_core22
	   FO057=CESD_11_core22
	   FO058=CESD_12_core22
	   FO059=CESD_13_core22
	   FO060=CESD_14_core22
	   FO061=CESD_15_core22
	   FO062=CESD_16_core22
	   FO063=CESD_17_core22
	   FO064=CESD_18_core22
	   FO065=CESD_19_core22
	   FO066=CESD_20_core22
	   total_sum=CESD_TOTAL_core22;
run;
/*label CESD variables in another data step with a label function*/
data exam22_0_1;
set exam22_0;
label CESD_1_core22='I was bothered by things that usually dont bother me (at exam 22)'
	  CESD_2_core22='I did not feel like eating my appetite was poor (at exam 22)'
	  CESD_3_core22='I felt that I could not shake off the blues, even with the help of family and friends (at exam 22)'
	  CESD_4_core22='I felt that I was just as good as other people (at exam 22)'
	  CESD_5_core22='I had trouble keeping my mind on what I was doing (at exam 22)'
	  CESD_6_core22='I felt depressed (at exam 22)'
	  CESD_7_core22='I felt that everything I did was an effort (at exam 22)'
	  CESD_8_core22='I felt hopeful about the future (at exam 22)'
	  CESD_9_core22='I thought my life had been a failure (at exam 22)'
	  CESD_10_core22='I felt fearful (at exam 22)'
	  CESD_11_core22='My sleep was restless (at exam 22)'
	  CESD_12_core22='I was happy (at exam 22)'
	  CESD_13_core22='I talked less than usual (at exam 22)'
	  CESD_14_core22='I felt lonely (at exam 22)'
	  CESD_15_core22='People were unfriendly (at exam 22)'
	  CESD_16_core22='I enjoyed life (at exam 22)'
	  CESD_17_core22='I had crying spells (at exam 22)'
	  CESD_18_core22='I felt sad (at exam 22)'
	  CESD_19_core22='I felt that people disliked me (at exam 22)'
	  CESD_20_core22='I could not "get going" (at exam 22)'
	  CESD_total_core22='CESD total score ate core exam 22';
run;

*read in Exam 23 with data step;
data exam23_0;
set in1.e_exam_ex23_0_0071;
*Creating universal identifer variables - framid;
framid=id;
/*create a variable for the total of postively worded questions in exam 23*/
positive_score_23=12-sum(of FP502, FP506, FP510, FP514);
/*find the total score of CESD variables*/
if nmiss(of FP499-FP518)=0 then CESD_TOTAL_core23= sum(of FP499-FP518)-( FP502+FP506+FP510+ FP514)+Positive_score_23;
else CESD_TOTAL_core23=.;
*extract framid, CES-D variables, and CESD_total_core23 with the keep function;
keep framid FP499-FP518 CESD_TOTAL_core23;
*rename the CES-D variables with CESD_Q#_core#;
rename FP499=CESD_1_core23
	   FP500=CESD_2_core23
	   FP501=CESD_3_core23
	   FP502=CESD_4_core23
	   FP503=CESD_5_core23
	   FP504=CESD_6_core23
	   FP505=CESD_7_core23
	   FP506=CESD_8_core23
	   FP507=CESD_9_core23
	   FP508=CESD_10_core23
	   FP509=CESD_11_core23
	   FP510=CESD_12_core23
	   FP511=CESD_13_core23
	   FP512=CESD_14_core23
	   FP513=CESD_15_core23
	   FP514=CESD_16_core23
	   FP515=CESD_17_core23
	   FP516=CESD_18_core23
	   FP517=CESD_19_core23
	   FP518=CESD_20_core23;
run;
/*label the CESD variables for core exam 23 in another data step*/
data exam23_0_1;
set exam23_0;
label CESD_1_core23='I was bothered by things that usually dont bother me (at exam 23)'
	  CESD_2_core23='I did not feel like eating my appetite was poor (at exam 23)'
	  CESD_3_core23='I felt that I could not shake off the blues, even with the help of family and friends (at exam 23)'
	  CESD_4_core23='I felt that I was just as good as other people (at exam 23)'
	  CESD_5_core23='I had trouble keeping my mind on what I was doing (at exam 23)'
	  CESD_6_core23='I felt depressed (at exam 23)'
	  CESD_7_core23='I felt that everything I did was an effort (at exam 23)'
	  CESD_8_core23='I felt hopeful about the future (at exam 23)'
	  CESD_9_core23='I thought my life had been a failure (at exam 23)'
	  CESD_10_core23='I felt fearful (at exam 23)'
	  CESD_11_core23='My sleep was restless (at exam 23)'
	  CESD_12_core23='I was happy (at exam 23)'
	  CESD_13_core23='I talked less than usual (at exam 23)'
	  CESD_14_core23='I felt lonely (at exam 23)'
	  CESD_15_core23='People were unfriendly (at exam 23)'
	  CESD_16_core23='I enjoyed life (at exam 23)'
	  CESD_17_core23='I had crying spells (at exam 23)'
	  CESD_18_core23='I felt sad (at exam 23)'
	  CESD_19_core23='I felt that people disliked me (at exam 23)'
	  CESD_20_core23='I could not "get going" (at exam 23)'
	  CESD_total_core23='CESD total score ate core exam 23';
run;


*Read in Exam 25 with a data step;
data exam25_0;
set in1.e_exam_ex25_0_0073;
*Creating universal identifer variables - framid;
framid=id;
*create a variable for the sum of the Positive Variables;
positive_score_25=12-sum(of FR143, FR147, FR151, FR155);
*create a variable for total score for people who answered 25 questions;
if nmiss(of FR140-FR159)=0 then CESD_TOTAL_core25=sum(of FR140-FR159)-(FR143+FR147+FR151+ FR155)+positive_score_25;
else CESD_TOTAL_core25=.;
*extract framid, CES-D variables, and CESD_total_core25 with the keep function;
keep framid FR140-FR159 CESD_TOTAL_core25;
*rename the CES-D variables with CESD_Q#_core#;
rename FR140=CESD_1_core25
	   FR141=CESD_2_core25
	   FR142=CESD_3_core25
	   FR143=CESD_4_core25
	   FR144=CESD_5_core25
	   FR145=CESD_6_core25
	   FR146=CESD_7_core25
	   FR147=CESD_8_core25
	   FR148=CESD_9_core25
	   FR149=CESD_10_core25
	   FR150=CESD_11_core25
	   FR151=CESD_12_core25
	   FR152=CESD_13_core25
	   FR153=CESD_14_core25
	   FR154=CESD_15_core25
	   FR155=CESD_16_core25
	   FR156=CESD_17_core25
	   FR157=CESD_18_core25
	   FR158=CESD_19_core25
	   FR159=CESD_20_core25;
run;
/*label the Exam 25 CESD variables in new data step*/
data exam25_0_1;
set exam25_0;
label CESD_1_core25='I was bothered by things that usually dont bother me (at exam 25)'
	  CESD_2_core25='I did not feel like eating my appetite was poor (at exam 25)'
	  CESD_3_core25='I felt that I could not shake off the blues, even with the help of family and friends (at exam 25)'
	  CESD_4_core25='I felt that I was just as good as other people (at exam 25)'
	  CESD_5_core25='I had trouble keeping my mind on what I was doing (at exam 25)'
	  CESD_6_core25='I felt depressed (at exam 25)'
	  CESD_7_core25='I felt that everything I did was an effort (at exam 25)'
	  CESD_8_core25='I felt hopeful about the future (at exam 25)'
	  CESD_9_core25='I thought my life had been a failure (at exam 25)'
	  CESD_10_core25='I felt fearful (at exam 25)'
	  CESD_11_core25='My sleep was restless (at exam 25)'
	  CESD_12_core25='I was happy (at exam 25)'
	  CESD_13_core25='I talked less than usual (at exam 25)'
	  CESD_14_core25='I felt lonely (at exam 25)'
	  CESD_15_core25='People were unfriendly (at exam 25)'
	  CESD_16_core25='I enjoyed life (at exam 25)'
	  CESD_17_core25='I had crying spells (at exam 25)'
	  CESD_18_core25='I felt sad (at exam 25)'
	  CESD_19_core25='I felt that people disliked me (at exam 25)'
	  CESD_20_core25='I could not "get going" (at exam 25)'
	  CESD_total_core25='CESD total score ate core exam 25';
run;

*read in Exam 26 in a data step;
data exam26_0;
set in1.e_exam_ex26_0_0074;
*Creating universal identifer variables - framid;
framid=id;
/*create a variable for the total of points for positvely worded questions in exam 26*/
positive_score_26=12-sum(of FS160, FS164, FS168, FS172);
/*create variable for total score for people who answered all 20 questions*/
if nmiss(of FS157-FS176)=0 then CESD_TOTAL_core26=sum(of FS157-FS176)-(FS160+FS164+FS168+FS172)+positive_score_26;
else CESD_TOTAL_core26=.;
*extract framid, CES-D variables, and CESD_total_core26 with the keep function;
keep framid FS157-FS176 CESD_TOTAL_core26;
*rename the CES-D variables with CESD_Q#_core#;
rename FS157=CESD_1_core26
	   FS158=CESD_2_core26
	   FS159=CESD_3_core26
	   FS160=CESD_4_core26
	   FS161=CESD_5_core26
	   FS162=CESD_6_core26
	   FS163=CESD_7_core26
	   FS164=CESD_8_core26
	   FS165=CESD_9_core26
	   FS166=CESD_10_core26
	   FS167=CESD_11_core26
	   FS168=CESD_12_core26
	   FS169=CESD_13_core26
	   FS170=CESD_14_core26
	   FS171=CESD_15_core26
	   FS172=CESD_16_core26
	   FS173=CESD_17_core26
	   FS174=CESD_18_core26
	   FS175=CESD_19_core26
	   FS176=CESD_20_core26;
run;
/*label Exam 26 CES-D variables in another data step*/
data exam26_0_1;
set exam26_0;
label CESD_1_core26='I was bothered by things that usually dont bother me (at exam 26)'
	  CESD_2_core26='I did not feel like eating my appetite was poor (at exam 26)'
	  CESD_3_core26='I felt that I could not shake off the blues, even with the help of family and friends (at exam 26)'
	  CESD_4_core26='I felt that I was just as good as other people (at exam 26)'
	  CESD_5_core26='I had trouble keeping my mind on what I was doing (at exam 26)'
	  CESD_6_core26='I felt depressed (at exam 26)'
	  CESD_7_core26='I felt that everything I did was an effort (at exam 26)'
	  CESD_8_core26='I felt hopeful about the future (at exam 26)'
	  CESD_9_core26='I thought my life had been a failure (at exam 26)'
	  CESD_10_core26='I felt fearful (at exam 26)'
	  CESD_11_core26='My sleep was restless (at exam 26)'
	  CESD_12_core26='I was happy (at exam 26)'
	  CESD_13_core26='I talked less than usual (at exam 26)'
	  CESD_14_core26='I felt lonely (at exam 26)'
	  CESD_15_core26='People were unfriendly (at exam 26)'
	  CESD_16_core26='I enjoyed life (at exam 26)'
	  CESD_17_core26='I had crying spells (at exam 26)'
	  CESD_18_core26='I felt sad (at exam 26)'
	  CESD_19_core26='I felt that people disliked me (at exam 26)'
	  CESD_20_core26='I could not "get going" (at exam 26)'
	  CESD_total_core26='CESD total score ate core exam 26';
run;

*read in Exam 27;
data exam27_0;
set in1.e_exam_ex27_0_0075;
*Creating universal identifer variables - framid;
framid=id;
*create a variable for the total number of points for questions that were positively phrased in exam 27;
positive_score_27=12-sum(of FT029, FT033, FT037, FT041);
*create a variable of the sum of scores for people who answered all 20 questions;
if nmiss(of FT026-FT045)=0 then CESD_TOTAL_core27=sum(of FT026-FT045)-(FT029+FT033+FT037+FT041)+positive_score_27;
else CESD_total_core27=.;
*extract framid, CES-D variables, and CESD_total_core27 with the keep function;
keep framid FT026-FT045 CESD_TOTAL_core27;
*rename the CES-D variables with CESD_Q#_core#;
rename FT026=CESD_1_core27
	   FT027=CESD_2_core27
	   FT028=CESD_3_core27
	   FT029=CESD_4_core27
	   FT030=CESD_5_core27
	   FT031=CESD_6_core27
	   FT032=CESD_7_core27
	   FT033=CESD_8_core27
	   FT034=CESD_9_core27
	   FT035=CESD_10_core27
	   FT036=CESD_11_core27
	   FT037=CESD_12_core27
	   FT038=CESD_13_core27
	   FT039=CESD_14_core27
	   FT040=CESD_15_core27
	   FT041=CESD_16_core27
	   FT042=CESD_17_core27
	   FT043=CESD_18_core27
	   FT044=CESD_19_core27
	   FT045=CESD_20_core27
;
run;
/*label the exam 27 CESD variables in another data step*/
data exam27_0_1;
set exam27_0;
label CESD_1_core27='I was bothered by things that usually dont bother me (at exam 27)'
	  CESD_2_core27='I did not feel like eating my appetite was poor (at exam 27)'
	  CESD_3_core27='I felt that I could not shake off the blues, even with the help of family and friends (at exam 27)'
	  CESD_4_core27='I felt that I was just as good as other people (at exam 27)'
	  CESD_5_core27='I had trouble keeping my mind on what I was doing (at exam 27)'
	  CESD_6_core27='I felt depressed (at exam 27)'
	  CESD_7_core27='I felt that everything I did was an effort (at exam 27)'
	  CESD_8_core27='I felt hopeful about the future (at exam 27)'
	  CESD_9_core27='I thought my life had been a failure (at exam 27)'
	  CESD_10_core27='I felt fearful (at exam 27)'
	  CESD_11_core27='My sleep was restless (at exam 27)'
	  CESD_12_core27='I was happy (at exam 27)'
	  CESD_13_core27='I talked less than usual (at exam 27)'
	  CESD_14_core27='I felt lonely (at exam 27)'
	  CESD_15_core27='People were unfriendly (at exam 27)'
	  CESD_16_core27='I enjoyed life (at exam 27)'
	  CESD_17_core27='I had crying spells (at exam 27)'
	  CESD_18_core27='I felt sad (at exam 27)'
	  CESD_19_core27='I felt that people disliked me (at exam 27)'
	  CESD_20_core27='I could not "get going" (at exam 27)'
	  CESD_total_core27='CESD total score ate core exam 27';
run;

*Read in the dataset for exam 28;
data exam28_0;
set in1.e_exam_ex28_0_0256;
*Creating universal identifer variables - framid;
framid=id;
*create a variable for the total number of points for questions that were positively phrased in exam 28;
positive_score_28=12-sum(of FU364, FU368, FU372, FU376);
*create a new variable for total score for CES-D variables for exam 28;
if nmiss(of FU361-FU380)=0 then CESD_TOTAL_core28=sum(of FU361-FU380)-(FU364+FU368+FU372+FU376)+positive_Score_28;
else CESD_total_core28=.;
*extract framid, CES-D variables, and CESD_total_core28 with the keep function;
keep framid FU361-FU380 CESD_total_core28;
*rename the CES-D variables with CESD_Q#_core#;
rename FU361=CESD_1_core28
	   FU362=CESD_2_core28
	   FU363=CESD_3_core28
	   FU364=CESD_4_core28
	   FU365=CESD_5_core28
	   FU366=CESD_6_core28
	   FU367=CESD_7_core28
	   FU368=CESD_8_core28
	   FU369=CESD_9_core28
	   FU370=CESD_10_core28
	   FU371=CESD_11_core28
	   FU372=CESD_12_core28
	   FU373=CESD_13_core28
	   FU374=CESD_14_core28
	   FU375=CESD_15_core28
	   FU376=CESD_16_core28
	   FU377=CESD_17_core28
	   FU378=CESD_18_core28
	   FU379=CESD_19_core28
	   FU380=CESD_20_core28;
run;
/*label the exam 28 CESD variables in another data step*/
data exam28_0_1;
set exam28_0;
label CESD_1_core28='I was bothered by things that usually dont bother me (at exam 28)'
	  CESD_2_core28='I did not feel like eating my appetite was poor (at exam 28)'
	  CESD_3_core28='I felt that I could not shake off the blues, even with the help of family and friends (at exam 28)'
	  CESD_4_core28='I felt that I was just as good as other people (at exam 28)'
	  CESD_5_core28='I had trouble keeping my mind on what I was doing (at exam 28)'
	  CESD_6_core28='I felt depressed (at exam 28)'
	  CESD_7_core28='I felt that everything I did was an effort (at exam 28)'
	  CESD_8_core28='I felt hopeful about the future (at exam 28)'
	  CESD_9_core28='I thought my life had been a failure (at exam 28)'
	  CESD_10_core28='I felt fearful (at exam 28)'
	  CESD_11_core28='My sleep was restless (at exam 28)'
	  CESD_12_core28='I was happy (at exam 28)'
	  CESD_13_core28='I talked less than usual (at exam 28)'
	  CESD_14_core28='I felt lonely (at exam 28)'
	  CESD_15_core28='People were unfriendly (at exam 28)'
	  CESD_16_core28='I enjoyed life (at exam 28)'
	  CESD_17_core28='I had crying spells (at exam 28)'
	  CESD_18_core28='I felt sad (at exam 28)'
	  CESD_19_core28='I felt that people disliked me (at exam 28)'
	  CESD_20_core28='I could not "get going" (at exam 28)'
	  CESD_total_core28='CESD total score ate core exam 28';
run;

*read in the dataset for exam 29;
data exam29_0;
set in1.e_exam_ex29_0_0210_v2;
*Creating universal identifer variables - framid;
framid=id;
*create a variable for the total score of positively worded questions for exam 29;
positive_score_29=12-sum(of FV523, FV527, FV531, FV535);
*create a new variable for total score for CES-D variables in exam 29;
if nmiss(of FV520-FV539)=0 then CESD_TOTAL_core29=sum(of FV520-FV539)-(FV523+FV527+FV531+FV535)+positive_score_29;
*extract framid, CES-D variables, and CESD_total_core29 with the keep function;
keep framid FV520-FV539 CESD_total_core29;
*rename the CES-D variables with CESD_Q#_core#;
rename FV520=CESD_1_core29
       FV521=CESD_2_core29
	   FV522=CESD_3_core29
	   FV523=CESD_4_core29
	   FV524=CESD_5_core29
	   FV525=CESD_6_core29
	   FV526=CESD_7_core29
	   FV527=CESD_8_core29
	   FV528=CESD_9_core29
	   FV529=CESD_10_core29
	   FV530=CESD_11_core29
	   FV531=CESD_12_core29
	   FV532=CESD_13_core29
	   FV533=CESD_14_core29
	   FV534=CESD_15_core29
	   FV535=CESD_16_core29
	   FV536=CESD_17_core29
	   FV537=CESD_18_core29
	   FV538=CESD_19_core29
	   FV539=CESD_20_core29
;
run;
/*label Exam 29 CESD variables in a new data step*/
data exam29_0_1;
set exam29_0;
label CESD_1_core29='I was bothered by things that usually dont bother me (at exam 29)'
	  CESD_2_core29='I did not feel like eating my appetite was poor (at exam 29)'
	  CESD_3_core29='I felt that I could not shake off the blues, even with the help of family and friends (at exam 29)'
	  CESD_4_core29='I felt that I was just as good as other people (at exam 29)'
	  CESD_5_core29='I had trouble keeping my mind on what I was doing (at exam 29)'
	  CESD_6_core29='I felt depressed (at exam 29)'
	  CESD_7_core29='I felt that everything I did was an effort (at exam 29)'
	  CESD_8_core29='I felt hopeful about the future (at exam 29)'
	  CESD_9_core29='I thought my life had been a failure (at exam 29)'
	  CESD_10_core29='I felt fearful (at exam 29)'
	  CESD_11_core29='My sleep was restless (at exam 29)'
	  CESD_12_core29='I was happy (at exam 29)'
	  CESD_13_core29='I talked less than usual (at exam 29)'
	  CESD_14_core29='I felt lonely (at exam 29)'
	  CESD_15_core29='People were unfriendly (at exam 29)'
	  CESD_16_core29='I enjoyed life (at exam 29)'
	  CESD_17_core29='I had crying spells (at exam 29)'
	  CESD_18_core29='I felt sad (at exam 29)'
	  CESD_19_core29='I felt that people disliked me (at exam 29)'
	  CESD_20_core29='I could not "get going" (at exam 29)'
	  CESD_total_core29='CESD total score ate core exam 29';
run;

*read the dataset in for exam 30;
data exam30_0;
set in1.e_exam_ex30_0_0274;
*Creating universal identifer variables - framid;
framid=id;
*create a variable for the sum of positively worded questions in Exam 30;
positive_score_30=12-sum(of FW525, FW529, FW533, FW537);
*add all questions to create CESD_TOTAL_core30 for people who answered all 20 questions;
if nmiss(of FW522-FW541)=0 then CESD_TOTAL_core30=sum(of FW522-FW541)-(FW525+FW529+FW533+FW537)+positive_score_30;
*extract framid, CES-D variables, and CESD_total_core30 with the keep function;
keep framid FW522-FW541 CESD_TOTAL_core30;
*rename the CES-D variables with CESD_Q#_core#;
rename FW522=CESD_1_core30
       FW523=CESD_2_core30
	   FW524=CESD_3_core30
	   FW525=CESD_4_core30
	   FW526=CESD_5_core30
	   FW527=CESD_6_core30
	   FW528=CESD_7_core30
	   FW529=CESD_8_core30
	   FW530=CESD_9_core30
	   FW531=CESD_10_core30
	   FW532=CESD_11_core30
	   FW533=CESD_12_core30
	   FW534=CESD_13_core30
	   FW535=CESD_14_core30
	   FW536=CESD_15_core30
	   FW537=CESD_16_core30
	   FW538=CESD_17_core30
	   FW539=CESD_18_core30
	   FW540=CESD_19_core30
	   FW541=CESD_20_core30
;
run;
/*label Exam 30 CESD variables in a new data step*/
data exam30_0_1;
set exam30_0;
label CESD_1_core30='I was bothered by things that usually dont bother me (at exam 30)'
	  CESD_2_core30='I did not feel like eating my appetite was poor (at exam 30)'
	  CESD_3_core30='I felt that I could not shake off the blues, even with the help of family and friends (at exam 30)'
	  CESD_4_core30='I felt that I was just as good as other people (at exam 30)'
	  CESD_5_core30='I had trouble keeping my mind on what I was doing (at exam 30)'
	  CESD_6_core30='I felt depressed (at exam 30)'
	  CESD_7_core30='I felt that everything I did was an effort (at exam 30)'
	  CESD_8_core30='I felt hopeful about the future (at exam 30)'
	  CESD_9_core30='I thought my life had been a failure (at exam 30)'
	  CESD_10_core30='I felt fearful (at exam 30)'
	  CESD_11_core30='My sleep was restless (at exam 30)'
	  CESD_12_core30='I was happy (at exam 30)'
	  CESD_13_core30='I talked less than usual (at exam 30)'
	  CESD_14_core30='I felt lonely (at exam 30)'
	  CESD_15_core30='People were unfriendly (at exam 30)'
	  CESD_16_core30='I enjoyed life (at exam 30)'
	  CESD_17_core30='I had crying spells (at exam 30)'
	  CESD_18_core30='I felt sad (at exam 30)'
	  CESD_19_core30='I felt that people disliked me (at exam 30)'
	  CESD_20_core30='I could not "get going" (at exam 30)'
	  CESD_total_core30='CESD total score ate core exam 30';
run;

*read in dataset for exam 31;
data exam31_0;
set in1.e_exam_ex31_0_0738;
*Creating universal identifer variables - framid;
framid=id;
*create a variable for positive variables in the CES-D questionaire;
positive_score_31=12-sum(of FX525, FX529, FX533, FX537);
*create a variable for the total sum for people who answered all 20 questions;
if nmiss(of FX522-FX541)=0 then CESD_TOTAL_core31=sum(of FX522-FX541)-(FX525+FX529+FX533+FX537)+positive_score_31;
*extract framid, CES-D variables, and CESD_total_core31 with the keep function;
keep framid FX522-FX541 CESD_TOTAL_core31;
*rename the CES-D variables with CESD_Q#_core#;
rename FX522=CESD_1_core31
	   FX523=CESD_2_core31
	   FX524=CESD_3_core31
	   FX525=CESD_4_core31
	   FX526=CESD_5_core31
	   FX527=CESD_6_core31
	   FX528=CESD_7_core31
	   FX529=CESD_8_core31
	   FX530=CESD_9_core31
	   FX531=CESD_10_core31
	   FX532=CESD_11_core31
	   FX533=CESD_12_core31
	   FX534=CESD_13_core31
	   FX535=CESD_14_core31
	   FX536=CESD_15_core31
	   FX537=CESD_16_core31
	   FX538=CESD_17_core31
	   FX539=CESD_18_core31
	   FX540=CESD_19_core31
	   FX541=CESD_20_core31
;
run;
/*label exam 31 CES-D variables in a new data step*/
data exam31_0_1;
set exam31_0;
label CESD_1_core31='I was bothered by things that usually dont bother me (at exam 31)'
	  CESD_2_core31='I did not feel like eating my appetite was poor (at exam 31)'
	  CESD_3_core31='I felt that I could not shake off the blues, even with the help of family and friends (at exam 31)'
	  CESD_4_core31='I felt that I was just as good as other people (at exam 31)'
	  CESD_5_core31='I had trouble keeping my mind on what I was doing (at exam 31)'
	  CESD_6_core31='I felt depressed (at exam 31)'
	  CESD_7_core31='I felt that everything I did was an effort (at exam 31)'
	  CESD_8_core31='I felt hopeful about the future (at exam 31)'
	  CESD_9_core31='I thought my life had been a failure (at exam 31)'
	  CESD_10_core31='I felt fearful (at exam 31)'
	  CESD_11_core31='My sleep was restless (at exam 31)'
	  CESD_12_core31='I was happy (at exam 31)'
	  CESD_13_core31='I talked less than usual (at exam 31)'
	  CESD_14_core31='I felt lonely (at exam 31)'
	  CESD_15_core31='People were unfriendly (at exam 31)'
	  CESD_16_core31='I enjoyed life (at exam 31)'
	  CESD_17_core31='I had crying spells (at exam 31)'
	  CESD_18_core31='I felt sad (at exam 31)'
	  CESD_19_core31='I felt that people disliked me (at exam 31)'
	  CESD_20_core31='I could not "get going" (at exam 31)'
	  CESD_total_core31='CESD total score ate core exam 31';
run;

*read in dataset for core exam 32;
data exam32_0;
set in1.e_exam_ex32_0_0939;
*Creating universal identifer variables - framid;
framid=id;
/*extract CES-D variables*/
keep framid FY522 FY526 FY527 FY528 FY529 FY531 FY532 FY533 FY535 FY541;
/*rename the CES-D variables in exam 32*/
rename FY522=CESD_1_core32
	   FY526=CESD_2_core32
	   FY527=CESD_3_core32
	   FY528=CESD_4_core32
	   FY529=CESD_5_core32
	   FY531=CESD_6_core32
	   FY532=CESD_7_core32
	   FY533=CESD_8_core32
	   FY535=CESD_9_core32
	   FY541=CESD_10_core32
;
run;
/*label variables in exam 32 in another data step*/
data exam32_0_1;
set exam32_0;
label CESD_1_core32='I was bothered by things that usually dont bother me (at exam 32)'
	  CESD_2_core32='I did not feel like eating my appetite was poor (at exam 32)'
	  CESD_3_core32='I felt that I could not shake off the blues, even with the help of family and friends (at exam 32)'
	  CESD_4_core32='I felt that I was just as good as other people (at exam 32)'
	  CESD_5_core32='I had trouble keeping my mind on what I was doing (at exam 32)'
	  CESD_6_core32='I felt depressed (at exam 32)'
	  CESD_7_core32='I felt that everything I did was an effort (at exam 32)'
	  CESD_8_core32='I felt hopeful about the future (at exam 32)'
	  CESD_9_core32='I thought my life had been a failure (at exam 32)'
	  CESD_10_core32='I felt fearful (at exam 32)'
;
run;

/*Sort all the datasets by FRAMID*/
%sort(exam22_0_1, FRAMID);
%sort(exam23_0_1, FRAMID);
%sort(exam25_0_1, FRAMID);
%sort(exam26_0_1, FRAMID);
%sort(exam27_0_1, FRAMID);
%sort(exam28_0_1, FRAMID);
%sort(exam29_0_1, FRAMID);
%sort(exam30_0_1, FRAMID);
%sort(exam31_0_1, FRAMID);
%sort(exam32_0_1, FRAMID);

/*merge the datasets by FRAMID*/
data CESD_0;
retain framid; 
merge exam22_0_1 exam23_0_1 exam25_0_1 exam26_0_1 exam27_0_1 exam28_0_1 exam29_0_1 exam30_0_1 exam31_0_1 exam32_0_1;
by framid;
run;







******************************************************************************************************************************************
Education information 
******************************************************************************************************************************************

*Education information from Gen 1 Exam 1-7 FHS questionnaire; 
data edu_core7_0; 
retain framid; 
set in1.e_exam_ex07_0_0076_v1;
*Creating universal identifer variables - framid;
framid = id;
keep framid MF5; 
rename 
MF5=edu_core1; 
run; 

*Education information from harmonized education dataset for all cohorts; 

data edu_all_0 edu_all_17 edu_all_2372;
set in1.vr_educ_2018_a_1307; 
*Creating universal identifer variables - framid;
if idtype = 0 then framid = id; 
else if idtype = 1 then framid = 80000 + id;
else if idtype = 2 then framid = 20000 + id;
else if idtype = 3 then framid = 30000 + id;
else if idtype = 7 then framid = 700000 + id;
else if idtype = 72 then framid = 720000 + id;
*Recode to numeric values;
if education = "a:noHSdeg" then edu_all = 0; 
else if education = "b:HSdeg" then edu_all = 1; 
else if education = "c:somecoll" then edu_all = 2; 
else if education = "d:collgrad" then edu_all = 3; 
else edu_all =.; 
*Output into three separate datasets based on cohorts;
if idtype = 0 then output edu_all_0; 
else if idtype in (1,7) then output edu_all_17; 
else output edu_all_2372;
keep framid edu_all; 
run; 

*Sort two datasets by using the macro-sort;
%sort(edu_core7_0, framid);
%sort(edu_all_0, framid);


*Append two FHS education datasets together;
data edu_0; 
merge edu_core7_0 edu_all_0; 
by framid; 
run; 








******************************************************************************************************************************************
Neuropathology data availability
******************************************************************************************************************************************

*Read in the verified cancer dataset by using a data step;
data neuropath_cohort0_1 neuropath_cohort17_1 neuropath_cohort2372_1;
retain framid npbraak_neuropath nia_reagan_neuropath neuropath_avail;
set in1.neuropath_through2022_245;
*Creating universal identifer variables - framid;
neuropath_avail = 1; 
if idtype=0 then framid=id;
else if idtype=1 then framid=id+80000;
else if idtype=2 then framid=id+20000;
else if idtype=3 then framid=id+30000;
else if idtype=7 then framid=id+700000;
else framid=id+720000;
if idtype = 0 then output neuropath_cohort0_1;
else if idtype in (1,7) then output neuropath_cohort17_1;
else output neuropath_cohort2372_1;
npbraak_neuropath = npbraak;
nia_reagan_neuropath = NPNIT; 
keep framid npbraak_neuropath nia_reagan_neuropath neuropath_avail;
run;







******************************************************************************************************************************************
Creation of FHS CVD risk scores
******************************************************************************************************************************************

/*Calculating FHS CVD Risk Score - Please refer to the original publication*/
/*DAgostino Sr, R. B., Vasan, R. S., Pencina, M. J., Wolf, P. A., Cobain, M., Massaro, J. M., & Kannel, W. B. (2008). General cardiovascular risk profile for use in primary care: the Framingham Heart Study. Circulation, 117(6), 743-753.*/;

data fhscvd_0;
set backbone_0; 
array date_core[*] date_core15 date_core20 date_core22-date_core28; 
array age_core[*] age_core15 age_core20 age_core22-age_core28; 
array age_fhscvd_core[*] age_fhscvd_core15 age_fhscvd_core20 age_fhscvd_core22-age_fhscvd_core28; 

array hdl_core[*] hdl_core15 hdl_core20 hdl_core22-hdl_core28; 
array hdl_fhscvd_core[*] hdl_fhscvd_core15 hdl_fhscvd_core20 hdl_fhscvd_core22-hdl_fhscvd_core28; 

array TC_core[*] TC_core15 TC_core20 TC_core22-TC_core28; 
array tc_fhscvd_core[*] tc_fhscvd_core15 tc_fhscvd_core20 tc_fhscvd_core22-tc_fhscvd_core28; 

array smoking_core[*] Smoking_core15 Smoking_core20 Smoking_core22-Smoking_core28; 
array smoking_fhscvd_core[*] smoking_fhscvd_core15 smoking_fhscvd_core20 smoking_fhscvd_core22-smoking_fhscvd_core28; 

array Hx_dm_core[*] Hx_dm_core15 Hx_dm_core20 Hx_dm_core22-Hx_dm_core28; 
array dm_fhscvd_core[*] dm_fhscvd_core15 dm_fhscvd_core20 dm_fhscvd_core22-dm_fhscvd_core28; 


array hrx_core[*] hrx_core15 hrx_core20 hrx_core22-hrx_core28; 
array sbp_core[*] sbp_core15 sbp_core20 sbp_core22-sbp_core28; 
array sbp_fhscvd_core[*] sbp_fhscvd_core15 sbp_fhscvd_core20 sbp_fhscvd_core22-sbp_fhscvd_core28; 

array fhscvd_core[*] fhscvd_core15 fhscvd_core20 fhscvd_core22-fhscvd_core28; 

do i = 1 to dim(date_core); 
if date_core(i) = . then fhscvd_core(i) = .; /*No FHSCVD risk score is calculated if participant did not attend the exam*/
	else do; 
		if sex = 1 then do; /*Men FHS CVD risk score*/
			if age_core(i) = . then age_fhscvd_core(i) = .; /*Missing age will be treated as missing due to out of bounds based on original publication*/ 
			else if (30 <= age_core(i) =< 34) then age_fhscvd_core(i) = 0; 
			else if (35 <= age_core(i) =< 39) then age_fhscvd_core(i) = 2;
			else if (40 <= age_core(i) =< 44) then age_fhscvd_core(i) = 5;
			else if (45 <= age_core(i) =< 49) then age_fhscvd_core(i) = 6;
			else if (50 <= age_core(i) =< 54) then age_fhscvd_core(i) = 8;
			else if (55 <= age_core(i) =< 59) then age_fhscvd_core(i) = 10;
			else if (60 <= age_core(i) =< 64) then age_fhscvd_core(i) = 11;
			else if (65 <= age_core(i) =< 69) then age_fhscvd_core(i) = 12;
			else if (70 <= age_core(i) =< 74) then age_fhscvd_core(i) = 14;
			else if age_core(i) >= 75  then age_fhscvd_core(i) = 15;
			else age_fhscvd_core(i) = .; /*Age below 30 will be treated as missing due to out of bounds based on original publication*/ 

			if hdl_core(i) = . then hdl_fhscvd_core(i) = .; /*Missing HDL will be treated as missing due to out of bounds based on original publication*/ 
			else if hdl_core(i) >= 60 then hdl_fhscvd_core(i) = -2; 
			else if (50 <= hdl_core(i) =< 59) then hdl_fhscvd_core(i) = -1; 
			else if (45 <= hdl_core(i) =< 49) then hdl_fhscvd_core(i) = 0; 
			else if (35 <= hdl_core(i) =< 44) then hdl_fhscvd_core(i) = 1; 
			else if hdl_core(i) < 35 then hdl_fhscvd_core(i) = 2;

			if TC_core(i) = . then tc_fhscvd_core(i) = .; /*Missing TC will be treated as missing due to out of bounds based on original publication*/
			else if TC_core(i) < 160 then tc_fhscvd_core(i) = 0; 
			else if (160 <= TC_core(i) =< 199) then tc_fhscvd_core(i) = 1; 
			else if (200 <= TC_core(i) =< 239) then tc_fhscvd_core(i) = 2; 
			else if (240 <= TC_core(i) =< 279) then tc_fhscvd_core(i) = 3; 
			else if TC_core(i) >= 280 then tc_fhscvd_core(i) = 4;

			if smoking_core(i) = . then smoking_fhscvd_core(i) = .; /*Missing smoking information will be treated as missing due to out of bounds based on original publication*/
			else if smoking_core(i) = 0 then smoking_fhscvd_core(i) = 0; 
			else if smoking_core(i) = 1 then smoking_fhscvd_core(i) = 4; 

			if hx_dm_core(i) = . then dm_fhscvd_core(i) = .; /*Missing history of diabetes information will be treated as missing due to out of bounds based on original publication*/
			else if hx_dm_core(i) = 0 then dm_fhscvd_core(i) = 0; 
			else if hx_dm_core(i) = 1 then dm_fhscvd_core(i) = 3; 

			if hrx_core(i) = . then sbp_fhscvd_core(i) = .; /*Missing treatment for hypertension will not have SBP component calculated ue to out of bounds based on original publication*/
				else do; 
					if hrx_core(i) = 0 then do; /*Considered as not treated for hypertension category in original publication*/
						if sbp_core(i) = . then sbp_fhscvd_core(i) = .; /*Missing SBP information will be treated as missing due to out of bounds based on original publication*/
						else if sbp_core(i) < 120 then sbp_fhscvd_core(i) = -2; 
						else if (120 <= sbp_core(i) =< 129) then sbp_fhscvd_core(i) = 0;
						else if (130 <= sbp_core(i) =< 139) then sbp_fhscvd_core(i) = 1;
						else if (140 <= sbp_core(i) =< 159) then sbp_fhscvd_core(i) = 2;
						else if sbp_core(i) >= 160 then sbp_fhscvd_core(i) = 3;
						end; 
					else if hrx_core(i) = 1 then do; /*Considered as treated for hypertension category in original publication*/
						if sbp_core(i) = . then sbp_fhscvd_core(i) = .; /*Missing SBP information will be treated as missing due to out of bounds based on original publication*/
						else if sbp_core(i) < 120 then sbp_fhscvd_core(i) = 0; 
						else if (120 <= sbp_core(i) =< 129) then sbp_fhscvd_core(i) = 2;
						else if (130 <= sbp_core(i) =< 139) then sbp_fhscvd_core(i) = 3;
						else if (140 <= sbp_core(i) =< 159) then sbp_fhscvd_core(i) = 4;
						else if sbp_core(i) >= 160 then sbp_fhscvd_core(i) = 5;
						end;
				end; 
		end;

		if sex = 2 then do; /*Men FHS CVD risk score*/
			if age_core(i) = . then age_fhscvd_core(i) = .; /*Missing age will be treated as missing due to out of bounds based on original publication*/ 
			else if (30 <= age_core(i) =< 34) then age_fhscvd_core(i) = 0; 
			else if (35 <= age_core(i) =< 39) then age_fhscvd_core(i) = 2;
			else if (40 <= age_core(i) =< 44) then age_fhscvd_core(i) = 4;
			else if (45 <= age_core(i) =< 49) then age_fhscvd_core(i) = 5;
			else if (50 <= age_core(i) =< 54) then age_fhscvd_core(i) = 7;
			else if (55 <= age_core(i) =< 59) then age_fhscvd_core(i) = 8;
			else if (60 <= age_core(i) =< 64) then age_fhscvd_core(i) = 9;
			else if (65 <= age_core(i) =< 69) then age_fhscvd_core(i) = 10;
			else if (70 <= age_core(i) =< 74) then age_fhscvd_core(i) = 11;
			else if age_core(i) >= 75  then age_fhscvd_core(i) = 12;
			else age_fhscvd_core(i) = .; /*Age below 30 will be treated as missing due to out of bounds based on original publication*/ 


			if hdl_core(i) = . then hdl_fhscvd_core(i) = .; /*Missing HDL will be treated as missing due to out of bounds based on original publication*/ 
			else if hdl_core(i) >= 60 then hdl_fhscvd_core(i) = -2; 
			else if (50 <= hdl_core(i) =< 59) then hdl_fhscvd_core(i) = -1; 
			else if (45 <= hdl_core(i) =< 49) then hdl_fhscvd_core(i) = 0; 
			else if (35 <= hdl_core(i) =< 44) then hdl_fhscvd_core(i) = 1; 
			else if hdl_core(i) < 35 then hdl_fhscvd_core(i) = 2;

			if TC_core(i) = . then tc_fhscvd_core(i) = .; /*Missing TC will be treated as missing due to out of bounds based on original publication*/
			else if TC_core(i) < 160 then tc_fhscvd_core(i) = 0; 
			else if (160 <= TC_core(i) =< 199) then tc_fhscvd_core(i) = 1; 
			else if (200 <= TC_core(i) =< 239) then tc_fhscvd_core(i) = 3; 
			else if (240 <= TC_core(i) =< 279) then tc_fhscvd_core(i) = 4; 
			else if TC_core(i) >= 280 then tc_fhscvd_core(i) = 5;

			if smoking_core(i) = . then smoking_fhscvd_core(i) = .; /*Missing smoking information will be treated as missing due to out of bounds based on original publication*/
			else if smoking_core(i) = 0 then smoking_fhscvd_core(i) = 0; 
			else if smoking_core(i) = 1 then smoking_fhscvd_core(i) = 3; 

			if hx_dm_core(i) = . then dm_fhscvd_core(i) = .; /*Missing history of diabetes information will be treated as missing due to out of bounds based on original publication*/
			else if hx_dm_core(i) = 0 then dm_fhscvd_core(i) = 0; 
			else if hx_dm_core(i) = 1 then dm_fhscvd_core(i) = 4; 

			if hrx_core(i) = . then sbp_fhscvd_core(i) = .; /*Missing treatment for hypertension will not have SBP component calculated ue to out of bounds based on original publication*/
				else do; 
					if hrx_core(i) = 0 then do; /*Considered as not treated for hypertension category in original publication*/
						if sbp_core(i) = . then sbp_fhscvd_core(i) = .; /*Missing SBP information will be treated as missing due to out of bounds based on original publication*/
						else if sbp_core(i) < 120 then sbp_fhscvd_core(i) = -3; 
						else if (120 <= sbp_core(i) =< 129) then sbp_fhscvd_core(i) = 0;
						else if (130 <= sbp_core(i) =< 139) then sbp_fhscvd_core(i) = 1;
						else if (140 <= sbp_core(i) =< 149) then sbp_fhscvd_core(i) = 2;
						else if (150 <= sbp_core(i) =< 159) then sbp_fhscvd_core(i) = 4;
						else if sbp_core(i) >= 160 then sbp_fhscvd_core(i) = 5;
						end; 
					else if hrx_core(i) = 1 then do; /*Considered as treated for hypertension category in original publication*/
						if sbp_core(i) = . then sbp_fhscvd_core(i) = .; /*Missing SBP information will be treated as missing due to out of bounds based on original publication*/
						else if sbp_core(i) < 120 then sbp_fhscvd_core(i) = -1; 
						else if (120 <= sbp_core(i) =< 129) then sbp_fhscvd_core(i) = 2;
						else if (130 <= sbp_core(i) =< 139) then sbp_fhscvd_core(i) = 3;
						else if (140 <= sbp_core(i) =< 149) then sbp_fhscvd_core(i) = 5;
						else if (150 <= sbp_core(i) =< 159) then sbp_fhscvd_core(i) = 6;
						else if sbp_core(i) >= 160 then sbp_fhscvd_core(i) = 7;
						end;
				end; 
 		end;
	end;
FHSCVD_core(i) = age_fhscvd_core(i) + hdl_fhscvd_core(i) + tc_fhscvd_core(i) + smoking_fhscvd_core(i) + dm_fhscvd_core(i) + sbp_fhscvd_core(i) ; /*If any component(s) have missing values, the FHSCVD risk score will not be calculated*/
end;
keep framid age_fhscvd_core: hdl_fhscvd_core: tc_fhscvd_core: smoking_fhscvd_core: dm_fhscvd_core: sbp_fhscvd_core: FHSCVD_core: ; 
run; 








******************************************************************************************************************************************
Creation of FHS Stroke Risk Profile 
******************************************************************************************************************************************

/*Calculating FHS Stroke Risk Profile - Please refer to the original publication*/
/*Wolf, P. A., D'Agostino, R. B., Belanger, A. J., & Kannel, W. B. (1991). Probability of stroke: a risk profile from the Framingham Study. Stroke, 22(3), 312-318.*/;


data fsrp_0;
set prevalence_cohort0; 
array date_core[*] date_core4 date_core5 date_core7-date_core15 date_core17-date_core28; 
array age_core[*] age_core4 age_core5 age_core7-age_core15 age_core17-age_core28; 
array age_fsrp_core[*] age_fsrp_core4 age_fsrp_core5 age_fsrp_core7-age_fsrp_core15 age_fsrp_core17-age_fsrp_core28; 

array sbp_core[*] sbp_core4 sbp_core5 sbp_core7-sbp_core15 sbp_core17-sbp_core28; 
array sbp_fsrp_core[*] sbp_fsrp_core4 sbp_fsrp_core5 sbp_fsrp_core7-sbp_fsrp_core15 sbp_fsrp_core17-sbp_fsrp_core28; 

array hrx_core[*] hrx_core4 hrx_core5 hrx_core7-hrx_core15 hrx_core17-hrx_core28; 
array hrx_fsrp_core[*] hrx_fsrp_core4 hrx_fsrp_core5 hrx_fsrp_core7-hrx_fsrp_core15 hrx_fsrp_core17-hrx_fsrp_core28; 

array Hx_dm_core[*] hx_dm_core4 hx_dm_core5 hx_dm_core7-hx_dm_core15 hx_dm_core17-hx_dm_core28; 
array dm_fsrp_core[*] dm_fsrp_core4 dm_fsrp_core5 dm_fsrp_core7-dm_fsrp_core15 dm_fsrp_core17-dm_fsrp_core28; 

array smoking_core[*] smoking_core4 smoking_core5 smoking_core7-smoking_core15 smoking_core17-smoking_core28; 
array smoking_fsrp_core[*] smoking_fsrp_core4 smoking_fsrp_core5 smoking_fsrp_core7-smoking_fsrp_core15 smoking_fsrp_core17-smoking_fsrp_core28; 

array precvd_core[*] prevalent_strokerisk_core4 prevalent_strokerisk_core5 prevalent_strokerisk_core7-prevalent_strokerisk_core15 prevalent_strokerisk_core17-prevalent_strokerisk_core28; 
array precvd_fsrp_core[*] precvd_fsrp_core4 precvd_fsrp_core5 precvd_fsrp_core7-precvd_fsrp_core15 precvd_fsrp_core17-precvd_fsrp_core28; 

array preaf_core[*] prevalent_af_core4 prevalent_af_core5 prevalent_af_core7-prevalent_af_core15 prevalent_af_core17-prevalent_af_core28; 
array preaf_fsrp_core[*] preaf_fsrp_core4 preaf_fsrp_core5 preaf_fsrp_core7-preaf_fsrp_core15 preaf_fsrp_core17-preaf_fsrp_core28; 

array DLVH_core[*] dlvh_core4 dlvh_core5 dlvh_core7-dlvh_core15 dlvh_core17-dlvh_core28; 
array dlvh_fsrp_core[*] dlvh_fsrp_core4 dlvh_fsrp_core5 dlvh_fsrp_core7-dlvh_fsrp_core15 dlvh_fsrp_core17-dlvh_fsrp_core28; 

array fsrp_core[*] fsrp_core4 fsrp_core5 fsrp_core7-fsrp_core15 fsrp_core17-fsrp_core28; 
array revised_fsrp_core[*] revised_fsrp_core4 revised_fsrp_core5 revised_fsrp_core7-revised_fsrp_core15 revised_fsrp_core17-revised_fsrp_core28; 

do i = 1 to dim(date_core); 
if date_core(i) = . then fsrp_core(i) = .; /*No FSRP risk score is calculated if participant did not attend the exam*/
	else do; 
		if sex = 1 then do; /*Men FRSP*/
			if age_core(i) = . then age_fsrp_core(i) = .; /*Missing age will be treated as missing due to out of bounds based on original publication*/ 
			else if (54 <= age_core(i) =< 56) then age_fsrp_core(i) = 0; 
			else if (57 <= age_core(i) =< 59) then age_fsrp_core(i) = 1;
			else if (60 <= age_core(i) =< 62) then age_fsrp_core(i) = 2;
			else if (63 <= age_core(i) =< 65) then age_fsrp_core(i) = 3;
			else if (66 <= age_core(i) =< 68) then age_fsrp_core(i) = 4;
			else if (69 <= age_core(i) =< 71) then age_fsrp_core(i) = 5;
			else if (72 <= age_core(i) =< 74) then age_fsrp_core(i) = 6;
			else if (75 <= age_core(i) =< 77) then age_fsrp_core(i) = 7;
			else if (78 <= age_core(i) =< 80) then age_fsrp_core(i) = 8;
			else if (81 <= age_core(i) =< 83) then age_fsrp_core(i) = 9;
			else if (84 <= age_core(i) =< 86) then age_fsrp_core(i) = 10;
			else age_fsrp_core(i) = .; /*Age below 54 or above 86 will be treated as missing due to out of bounds based on original publication*/

			if sbp_core(i) = . then sbp_fsrp_core(i) = .; /*Missing SBP information will be treated as missing due to out of bounds based on original publication*/
			else if (95 <= sbp_core(i) =< 105) then sbp_fsrp_core(i) = 0;
			else if (106 <= sbp_core(i) =< 116) then sbp_fsrp_core(i) = 1;
			else if (117 <= sbp_core(i) =< 126) then sbp_fsrp_core(i) = 2;
			else if (127 <= sbp_core(i) =< 137) then sbp_fsrp_core(i) = 3;
			else if (138 <= sbp_core(i) =< 148) then sbp_fsrp_core(i) = 4;
			else if (149 <= sbp_core(i) =< 159) then sbp_fsrp_core(i) = 5;
			else if (160 <= sbp_core(i) =< 170) then sbp_fsrp_core(i) = 6;
			else if (171 <= sbp_core(i) =< 181) then sbp_fsrp_core(i) = 7;
			else if (182 <= sbp_core(i) =< 191) then sbp_fsrp_core(i) = 8;
			else if (192 <= sbp_core(i) =< 202) then sbp_fsrp_core(i) = 9;
			else if (203 <= sbp_core(i) =< 213) then sbp_fsrp_core(i) = 10;
			else sbp_fsrp_core(i) = .; /*SBP below 95 or above 213 will be treated as missing due to out of bounds based on original publication*/
					
			if hrx_core(i) = . then hrx_fsrp_core(i) = .; /*Missing treatment of hypertension information will be treated as missing due to out of bounds based on original publication*/
			else if hrx_core(i) = 0 then hrx_fsrp_core(i) = 0; 
			else if hrx_core(i) = 1 then hrx_fsrp_core(i) = 2;

			if hx_dm_core(i) = . then dm_fsrp_core(i) = .; /*Missing history of diabetes information will be treated as missing due to out of bounds based on original publication*/
			else if hx_dm_core(i) = 0 then dm_fsrp_core(i) = 0; 
			else if hx_dm_core(i) = 1 then dm_fsrp_core(i) = 2;

			if smoking_core(i) = . then smoking_fsrp_core(i) = .; /*Missing smoking information will be treated as missing due to out of bounds based on original publication*/
			else if smoking_core(i) = 0 then smoking_fsrp_core(i) = 0; 
			else if smoking_core(i) = 1 then smoking_fsrp_core(i) = 3;

			if precvd_core(i) = . then precvd_fsrp_core(i) = .; /*Missing prevalence CVD information will be treated as missing due to out of bounds based on original publication*/
			else if precvd_core(i) = 0 then precvd_fsrp_core(i) = 0; 
			else if precvd_core(i) = 1 then precvd_fsrp_core(i) = 3; 

			if preaf_core(i) = . then preaf_fsrp_core(i) = .; /*Missing prevalence AF information will be treated as missing due to out of bounds based on original publication*/
			else if preaf_core(i) = 0 then preaf_fsrp_core(i) = 0; 
			else if preaf_core(i) = 1 then preaf_fsrp_core(i) = 4;

			if dlvh_core(i) = . then dlvh_fsrp_core(i) = .; /*Missing prevalence LVH information will be treated as missing due to out of bounds based on original publication*/
			else if dlvh_core(i) = 0 then dlvh_fsrp_core(i) = 0; 
			else if dlvh_core(i) = 1 then dlvh_fsrp_core(i) = 6;
		end; 

		if sex = 2 then do; /*Women FSRP*/
			if age_core(i) = . then age_fsrp_core(i) = .; /*Missing age will be treated as missing due to out of bounds based on original publication*/ 
			else if (54 <= age_core(i) =< 56) then age_fsrp_core(i) = 0; 
			else if (57 <= age_core(i) =< 59) then age_fsrp_core(i) = 1;
			else if (60 <= age_core(i) =< 62) then age_fsrp_core(i) = 2;
			else if (63 <= age_core(i) =< 65) then age_fsrp_core(i) = 3;
			else if (66 <= age_core(i) =< 68) then age_fsrp_core(i) = 4;
			else if (69 <= age_core(i) =< 71) then age_fsrp_core(i) = 5;
			else if (72 <= age_core(i) =< 74) then age_fsrp_core(i) = 6;
			else if (75 <= age_core(i) =< 77) then age_fsrp_core(i) = 7;
			else if (78 <= age_core(i) =< 80) then age_fsrp_core(i) = 8;
			else if (81 <= age_core(i) =< 83) then age_fsrp_core(i) = 9;
			else if (84 <= age_core(i) =< 86) then age_fsrp_core(i) = 10;
			else age_fsrp_core(i) = .; /*Age below 54 or above 86 will be treated as missing due to out of bounds based on original publication*/

			if sbp_core(i) = . then sbp_fsrp_core(i) = .; /*Missing SBP information will be treated as missing due to out of bounds based on original publication*/
			else if (95 <= sbp_core(i) =< 104) then sbp_fsrp_core(i) = 0;
			else if (105 <= sbp_core(i) =< 114) then sbp_fsrp_core(i) = 1;
			else if (115 <= sbp_core(i) =< 124) then sbp_fsrp_core(i) = 2;
			else if (125 <= sbp_core(i) =< 134) then sbp_fsrp_core(i) = 3;
			else if (135 <= sbp_core(i) =< 144) then sbp_fsrp_core(i) = 4;
			else if (145 <= sbp_core(i) =< 154) then sbp_fsrp_core(i) = 5;
			else if (155 <= sbp_core(i) =< 164) then sbp_fsrp_core(i) = 6;
			else if (165 <= sbp_core(i) =< 174) then sbp_fsrp_core(i) = 7;
			else if (175 <= sbp_core(i) =< 184) then sbp_fsrp_core(i) = 8;
			else if (185 <= sbp_core(i) =< 194) then sbp_fsrp_core(i) = 9;
			else if (195 <= sbp_core(i) =< 204) then sbp_fsrp_core(i) = 10;
			else sbp_fsrp_core(i) = .; /*SBP below 95 or above 204 will be treated as missing due to out of bounds based on original publication*/
		
			if hrx_core(i) = . then hrx_fsrp_core(i) = .; /*Missing treatment of hypertension information will be treated as missing due to out of bounds based on original publication*/
			else if hrx_core(i) = 0 then hrx_fsrp_core(i) = 0; 
			else if hrx_core(i) = 1 then do;
				if sbp_core(i) = . then hrx_fsrp_core(i) = .; /*Missing SBP information will be treated as missing due to out of bounds based on original publication*/
				else if (95 <= sbp_core(i) =< 104) then hrx_fsrp_core(i) = 6;
				else if (105 <= sbp_core(i) =< 114) then hrx_fsrp_core(i) = 5;
				else if (115 <= sbp_core(i) =< 124) then hrx_fsrp_core(i) = 5;
				else if (125 <= sbp_core(i) =< 134) then hrx_fsrp_core(i) = 4;
				else if (135 <= sbp_core(i) =< 144) then hrx_fsrp_core(i) = 3;
				else if (145 <= sbp_core(i) =< 154) then hrx_fsrp_core(i) = 3;
				else if (155 <= sbp_core(i) =< 164) then hrx_fsrp_core(i) = 2;
				else if (165 <= sbp_core(i) =< 174) then hrx_fsrp_core(i) = 1;
				else if (175 <= sbp_core(i) =< 184) then hrx_fsrp_core(i) = 1;
				else if (185 <= sbp_core(i) =< 194) then hrx_fsrp_core(i) = 0;
				else if (195 <= sbp_core(i) =< 204) then hrx_fsrp_core(i) = 0;
				else hrx_fsrp_core(i) = .; /*SBP below 95 or above 204 will be treated as missing due to out of bounds based on original publication*/
				end; 

			if hx_dm_core(i) = . then dm_fsrp_core(i) = .; /*Missing history of diabetes information will be treated as missing due to out of bounds based on original publication*/
			else if hx_dm_core(i) = 0 then dm_fsrp_core(i) = 0; 
			else if hx_dm_core(i) = 1 then dm_fsrp_core(i) = 3;

			if smoking_core(i) = . then smoking_fsrp_core(i) = .; /*Missing smoking information will be treated as missing due to out of bounds based on original publication*/
			else if smoking_core(i) = 0 then smoking_fsrp_core(i) = 0; 
			else if smoking_core(i) = 1 then smoking_fsrp_core(i) = 3;

			if precvd_core(i) = . then precvd_fsrp_core(i) = .; /*Missing prevalence CVD information will be treated as missing due to out of bounds based on original publication*/
			else if precvd_core(i) = 0 then precvd_fsrp_core(i) = 0; 
			else if precvd_core(i) = 1 then precvd_fsrp_core(i) = 2; 

			if preaf_core(i) = . then preaf_fsrp_core(i) = .; /*Missing prevalence AF information will be treated as missing due to out of bounds based on original publication*/
			else if preaf_core(i) = 0 then preaf_fsrp_core(i) = 0; 
			else if preaf_core(i) = 1 then preaf_fsrp_core(i) = 6;

			if dlvh_core(i) = . then dlvh_fsrp_core(i) = .; /*Missing prevalence LVH information will be treated as missing due to out of bounds based on original publication*/
			else if dlvh_core(i) = 0 then dlvh_fsrp_core(i) = 0; 
			else if dlvh_core(i) = 1 then dlvh_fsrp_core(i) = 4;
		end;
	end;
fsrp_core(i) = age_fsrp_core(i) + sbp_fsrp_core(i) + hrx_fsrp_core(i) + dm_fsrp_core(i) + smoking_fsrp_core(i) + precvd_fsrp_core(i) + preaf_fsrp_core(i) + dlvh_fsrp_core(i); /*If any component(s) have missing values, the FSRP risk score will not be calculated*/
revised_fsrp_core(i) = age_fsrp_core(i) + sbp_fsrp_core(i) + hrx_fsrp_core(i) + dm_fsrp_core(i) + smoking_fsrp_core(i) + precvd_fsrp_core(i) + preaf_fsrp_core(i); /*If any component(s) have missing values, the revised FSRP risk score will not be calculated*/
end;
keep framid age_fsrp_core: sbp_fsrp_core: hrx_fsrp_core: dm_fsrp_core: smoking_fsrp_core: precvd_fsrp_core: preaf_fsrp_core: dlvh_fsrp_core: fsrp_core: revised_fsrp_core:; 
run; 






******************************************************************************************************************************************
Creation of FHS Gen 1 curated dataset
******************************************************************************************************************************************

*Sort all datasets by using the macro-sort;
%sort(backbone_0, framid);
%sort(NP_cohort0_2, framid);
%sort(date_matching_2, framid);
%sort(demrv_cohort0_1, framid);
%sort(chd_cohort0_1, framid);
%sort(stroke_cohort0_1, framid);
%sort(AF_cohort0_1, framid);
%sort(cancer_cohort0_1, framid);
%sort(surv_cohort0_1, framid);
%sort(prevalence_cohort0_1, framid);
%sort(fhscvd_0, framid);
%sort(fsrp_0, framid);
%sort(mmse_0_1, framid);
%sort(CESD_0, framid);
%sort(edu_0, framid);
%sort(neuropath_cohort0_1, framid);

*Read in all derived datasets to create curated dataset for FHS Gen 1 cohorts; 
data out1.curated_bap_0_02012024;
retain idtype id framid sex race_code race date_core1-date_core32 age_core1-age_core32 edu_core1 edu_all;
merge  
backbone_0
NP_cohort0_2
date_matching_2
demrv_cohort0_1
chd_cohort0_1
stroke_cohort0_1
AF_cohort0_1
cancer_cohort0_1
surv_cohort0_1
prevalence_cohort0_1
fhscvd_0
fsrp_0
mmse_0_1
CESD_0
edu_0
neuropath_cohort0_1; 

by framid; 
if neuropath_avail = . then neuropath_avail = 0;  
run; 


*Check format and accuracy; 
proc print data=out1.curated_bap_0_02012024;
*Should have 1 observations with 13 NP assessments; 
where examdate_np13 ne .;
run; 

*Remove label for csv file; 
data csv_curated_0; 
set out1.curated_bap_0_02012024;
run; 
proc datasets lib=work memtype=data;
   modify csv_curated_0;
     attrib _all_ label=' ';
run;
quit;
filename csv "C:\Users\angtf\Desktop\Test_SAS\Output_data\curated_bap_0_02012024_nolabel.csv" lrecl=10000000;
proc export data=csv_curated_0
outfile=csv
dbms=csv replace;run; 

