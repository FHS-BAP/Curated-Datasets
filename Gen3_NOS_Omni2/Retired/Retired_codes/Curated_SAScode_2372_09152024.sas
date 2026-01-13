******************************************************************************************************************************************
Introduction to Gen3/Omni2/NOS curated dataset source code
******************************************************************************************************************************************

Created by Sophia Lu 
Revised by Alvin Ang	
Last updated: Sept 2024


The purpose of this SAS code is to allow users to create similar data structure and naming convention to that of the FHS-BAP Gen3/Omni2/NOS
curated dataset, as shown in the coding manual. The order of the variable may vary from the manual.

Please ensure you have these listed datasets to run this SAS code optimally. It is highly recommended to have them in the same location.


Generic names are used for these datasets within this SAS code. 
Tip: You can copy and paste this SAS code onto a Word document and use the "find and replace" function to customize to your dataset names 

1)  vr_wkthru_ex03_3b_1191 (Gen 3/Omni 2/NOS workthru) 
	vr_raceall_2008_a_0712 (FHS race/ethnicity information) 
	vr_educ_2018_a_1307 (Harmonized education dataset for all cohorts)

2)  np_summary_through2023_18834 (NP Summary Score)

3)  vr_demrv_through2023_4425_v1 (Dementia Review)

4)  Commonly used outcomes (CHD, Stroke, AF, Diabetes and Cancer): 
	vr_soe_2022_a_1424 (Verified Sequence of Events (SOE) Cardiovascular Endpoints)
	vr_afcum_2022_a_1412 (verified Atrial Fibrillation/Flutter dataset)
	vr_diab_ex03_3b_1312 (Verified Diabetes dataset)
	vr_cancer_2019_a_1162_v1 (Verified Cancer dataset)
	vr_survdth_2021_a_1452 (Verified Survival Status dataset)  

5) 	Individual FHS exam questionnaires: 
	e_exam_ex01_3_0086_v2 (Gen 3 exam 1)
	e_exam_ex01_72_0652 (Omni 2 exam 1)
	e_exam_ex01_2_0813 (NOS exam 1)
	e_exam_2011_m_0017_v1 (Gen 3/Omni 2/NOS exam 2)
	e_exam_ex03_3b_1069 (Gen 3/Omni 2/NOS exam 3)

6)  Neuropathology Data 
	neuropath_through2023_260 (FHS Brain Donor Neuropathology Data) 

*Provide the location of these datasets to import from before you run the SAS code. ;
libname in1 'C:\Users\angtf\SAS_files\Input_files';
*Provide the location of the derived datasets to export to before you run the SAS code. ;
libname out1 'C:\Users\angtf\SAS_files\Output_files';



******************************************************************************************************************************************
Renaming/Ordering variables within FHS Gen 3/Omni 2/NOS workthru dataset
******************************************************************************************************************************************

*Read in the Gen 3/Omni 2/NOS workthru dataset by using a data step;
data wt_2372_1;
*Replace Gen 3/Omni 2/NOS workthru dataset name;
retain idtype id framid; 
set in1.vr_wkthru_ex03_3b_1191;  
*Creating universal identifer variables - framid;
if idtype=2 then framid=id+20000;
else if idtype=3 then framid=id+30000;
else framid=id+720000;
*drop ATT1-ATT3 (attended exams 1-3) from dataset;
drop ATT1-ATT3;
run;
*rename the variables in the dataset (variable_core1-variable_core3) using the rename option in another data step;
data wt_2372_2;
set wt_2372_1;
*Create smoking history variable; 
array currsmk{*} currsmk2-currsmk3; 
array smksum{*} currsmk1 smksum2-smksum3; 
array smoking_ever{*} smoking_ever_core2-smoking_ever_core3; 
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
rename 
	DATE1=Date_core1
   	DATE2=Date_core2
   	DATE3=Date_core3
	AGE1=Age_core1
   	AGE2=Age_core2
   	AGE3=Age_core3
   	BG1= BG_core1
   	BG2=BG_core2
   	BG3=BG_core3
   	BMI1=BMI_core1
   	BMI2=BMI_core2
   	BMI3=BMI_core3
   	CALC_LDL1=Calc_LDL_core1
   	CALC_LDL2=Calc_LDL_core2
   	CALC_LDL3=Calc_LDL_core3
   	CPD1=CPD_core1
   	CPD2=CPD_core2
   	CPD3=CPD_core3
   	CREAT1=Creatinine_core1
   	CREAT2=Creatinine_core2
   	CREAT3=Creatinine_core3
   	CURRSMK1=Smoking_core1
   	CURRSMK2=Smoking_core2
   	CURRSMK3=Smoking_core3
   	DBP1=DBP_core1
   	DBP2=DBP_core2
   	DBP3=DBP_core3
   	DLVH1=DLVH_core1
   	DLVH2=DLVH_core2
   	DLVH3=DLVH_core3
   	DMRX1=DMRX_core1
   	DMRX2=DMRX_core2
   	DMRX3=DMRX_core3
   	FASTING_BG1=Fasting_BG_core1
   	FASTING_BG2=Fasting_BG_core2
   	FASTING_BG3=Fasting_BG_core3
   	HDL1=HDL_core1
   	HDL2=HDL_core2
   	HDL3=HDL_core3
   	HGT1=Height_core1
   	HGT2=Height_core2
   	HGT3=Height_core3
   	HIP2=Hip_core2
   	HIP3=Hip_core3
   	HRX1=HRX_core1
   	HRX2=HRX_core2
   	HRX3=HRX_core3
   	LIPRX1=LIPRX_core1
   	LIPRX2=LIPRX_core2
   	LIPRX3=LIPRX_core3
   	SBP1=SBP_core1
   	SBP2=SBP_core2
   	SBP3=SBP_core3
   	SEX=Sex
   	TC1=TC_core1
   	TC2=TC_core2
   	TC3=TC_core3
   	TRIG1=Triglycerides_core1
   	TRIG2=Triglycerides_core2
   	TRIG3=Triglycerides_core3
   	VENT_RT1=Vent_RT_core1
   	VENT_RT2=Vent_RT_core2
   	VENT_RT3=Vent_RT_core3
   	WAIST1=Waist_core1
   	WAIST2=Waist_core2
   	WAIST3=Waist_core3
   	WGT1=Weight_core1
   	WGT2=Weight_core2
   	WGT3=Weight_core3
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

*Read in verified Gen 3/Omni 2/NOS diabetes dataset by using a data step;
data diabetes_2372; 
retain framid; 
set in1.vr_diab_ex03_3b_1312; 
*Creating universal identifer variables - framid;
if idtype=2 then framid=id+20000;
else if idtype=3 then framid=id+30000;
else framid=id+720000;
drop idtype id; 
rename
CURR_DIAB1-CURR_DIAB3=Curr_dm_core1-Curr_dm_core3
HX_DIAB1-HX_DIAB3=Hx_dm_core1-Hx_dm_core3
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
%sort(wt_2372_2, framid);
%sort(race_2372, framid);
%sort(diabetes_2372, framid);


*Combined workthru, race and diabetes datasets;
data wt_2372_3; 
merge wt_2372_2 race_2372 diabetes_2372;
by framid; 
run; 

/*Reordering variables*/
data backbone_2372;
retain idtype id framid sex race_code race; 
if 0 then set wt_2372_3 (keep=Date_core:) wt_2372_3 (keep=Age_core:) wt_2372_3 (keep=Height_core:) wt_2372_3 (keep=Weight_core:) wt_2372_3 (keep=BMI_core:) wt_2372_3 (keep=Hip_core:) wt_2372_3 (keep=Waist_core:) wt_2372_3 (keep=Smoking_core:) wt_2372_3 (keep=Smoking_ever_core:) wt_2372_3 (keep=CPD_core:) wt_2372_3 (keep=SBP_core:) wt_2372_3 (keep=DBP_core:) wt_2372_3 (keep=Vent_RT_core:) wt_2372_3 (keep=DLVH_core:) wt_2372_3 (keep=HRX_core:) wt_2372_3 (keep=BG_core:) wt_2372_3 (keep=Fasting_BG_core:) wt_2372_3 (keep=DMRX_core:) wt_2372_3 (keep=curr_dm_core:) wt_2372_3 (keep=hx_dm_core:) wt_2372_3 (keep=TC_core:) wt_2372_3 (keep=HDL_core:) wt_2372_3 (keep=Triglycerides_core:) wt_2372_3 (keep=Calc_LDL_core:) wt_2372_3 (keep=LIPRX_core:) wt_2372_3 (keep=Creatinine_core:);
set wt_2372_3;
run;





******************************************************************************************************************************************
Variables renaming and transposition of NP Summary Score dataset
******************************************************************************************************************************************

*Read in the NP Summary Score dataset by using a data step;
data NP_all_cohort_1;
set in1.np_summary_through2023_18834;
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

/*Transpose NP Summary Score for Gen 3, Omni 2 and NOS participants*/
%MultiTranspose
(out=NP_cohort2372_2,
data=NP_cohort2372_1,
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
merge wt_2372_2 NP_cohort2372_2; 
by framid; 
keep framid date_core: examdate_np:;
run; 


data date_matching_1 (drop = i); 
set date_matching; 
array examdate_np[*] examdate_np:; 
array date_core[*] date_core:; 
array np_closest_exam_date[5] ; 
array np_days_apart[5] ; 
array np_exam_cycle[5] ; 
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
array examdate_np[*] examdate_np:; 
array date_core[*] date_core:; 
array np_closest_exam_date[5] np_closest_exam_date:; 
array np_days_apart[5] np_days_apart:; 
array np_exam_cycle[5] np_exam_cycle:;
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
set in1.vr_demrv_through2023_4425_v1;
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
Prevalent variables for Gen 3/NOS/Omni 2
******************************************************************************************************************************************

*Sort datasets by framid; 
%sort(backbone_2372, framid);
%sort(NP_cohort2372_2, framid);
%sort(demrv_cohort2372_1, framid);
%sort(chd_cohort2372_1, framid);
%sort(stroke_cohort2372_1, framid);
%sort(AF_cohort2372_1, framid);
%sort(cancer_cohort2372_1, framid);
%sort(strokerisk_cohort2372_1, framid);

data prevalence_derivation2372; 
merge backbone_2372 NP_cohort2372_2 demrv_cohort2372_1 chd_cohort2372_1 stroke_cohort2372_1 AF_cohort2372_1 cancer_cohort2372_1 strokerisk_cohort2372_1;
by framid; 
run; 

data prevalence_cohort2372; 
set prevalence_derivation2372; 
array date_core[*] date_core:; 
array examdate_np[*] examdate_np1-examdate_np5; 

*Derived prevalent variables for each FHS core exam;
array prevalent_chd_core[3] ; 
array prevalent_stroke_core[3] ; 
array prevalent_af_core[3] ;
array prevalent_dementia_core[3] ; 
array prevalent_cancer_core[3] ;
array prevalent_strokerisk_core[3] ;

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
array prevalent_chd_NP[5] ; 
array prevalent_stroke_NP[5] ; 
array prevalent_af_NP[5] ;
array prevalent_dementia_NP[5] ; 
array prevalent_cancer_NP[5] ;
array prevalent_strokerisk_NP[5] ;


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

data prevalence_cohort2372_1; 
set prevalence_cohort2372; 
keep framid prevalent_chd_core: prevalent_stroke_core: prevalent_af_core: prevalent_dementia_core: prevalent_cancer_core: prevalent_chd_np: prevalent_stroke_np: prevalent_af_np: prevalent_dementia_np: prevalent_cancer_np: ;    
run;








******************************************************************************************************************************************
CES-D variables from individual FHS exam questionnaires
******************************************************************************************************************************************

*Read in Gen3/NOS/Omni2 Exam 1 dataset by using a data step;

data gen3_exam1;
*Replace Gen3 Exam 1 dataset name;
set in1.e_exam_ex01_3_0086_v2;
*Creating universal identifer variables - framid;
framid=id+30000;
run;
data omni2_exam1;
*Replace Omni2 Exam 1 dataset name;
set in1.e_exam_ex01_72_0652;
*Creating universal identifer variables - framid;
framid=id+720000;
run;
data nos_exam1;
*Replace NOS Exam 1 dataset name;
set in1.e_exam_ex01_2_0813;
*Creating universal identifer variables - framid;
framid=id+20000;
run;
*Macro to extract the CES-D variables during exam 1 and rename them from Gen3/Omni2/NOS Exam 1;

****datain= data read into the macro
ID- ID variable in the dataset
var1-var20-- the variables we want in the new dataset
dataout= new dataset that is created;
%macro sso(datain, ID, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15, var16, var17, var18, var19, var20,
dataout);
data mone;
set &datain;
run;
data mtwo;
set mone;
keep &ID &var1-&var20;
run;
data mthree;
set mtwo;
rename &var1=CESD_1_core1
   	&var2=CESD_2_core1
   	&var3=CESD_3_core1
   	&var4=CESD_4_core1
   	&var5=CESD_5_core1
   	&var6=CESD_6_core1
   	&var7=CESD_7_core1
   	&var8=CESD_8_core1
   	&var9=CESD_9_core1
   	&var10=CESD_10_core1
   	&var11=CESD_11_core1
   	&var12=CESD_12_core1
   	&var13=CESD_13_core1
   	&var14=CESD_14_core1
   	&var15=CESD_15_core1
   	&var16=CESD_16_core1
   	&var17=CESD_17_core1
   	&var18=CESD_18_core1
   	&var19=CESD_19_core1
   	&var20=CESD_20_core1;
run;
data &dataout;
set mthree;
run;
%mend sso;
*Extract and rename the CES-D variables for all three datasets by using the macro. We'd have to
call the macro by using %macroname (sso in this case) and including all the necessary components
to the macro;
%sso(omni2_exam1, framid, G3A518, G3A519, G3A520, G3A521, G3A522, G3A523, G3A524, G3A525,
G3A526, G3A527, G3A528, G3A529, G3A530, G3A531, G3A532, G3A533, G3A534, G3A535, G3A536,G3A537,
omni2_exam1_a);
%sso(gen3_exam1, framid, G3A518, G3A519, G3A520, G3A521, G3A522, G3A523, G3A524, G3A525,
G3A526, G3A527, G3A528, G3A529, G3A530, G3A531, G3A532, G3A533, G3A534, G3A535, G3A536,G3A537,
gen3_exam1_a);
%sso(nos_exam1, framid, G3A518, G3A519, G3A520, G3A521, G3A522, G3A523, G3A524, G3A525,
G3A526, G3A527, G3A528, G3A529, G3A530, G3A531, G3A532, G3A533, G3A534, G3A535, G3A536,G3A537,
nos_exam1_a);

*Append the three Exam 1 datasets together;
data exam1_2372;
set nos_exam1_a gen3_exam1_a omni2_exam1_a;
*Reverse score for positive-worded questions;
Positive_core1 = 12 - sum(CESD_4_core1 + CESD_8_core1 + CESD_12_core1 + CESD_16_core1);
*Total CES-D scores for all 20 answered questions;
if nmiss(of CESD:) = 0 then CESD_TOTAL_core1 = sum(of CESD:) - (CESD_4_core1 + CESD_8_core1 + CESD_12_core1 + CESD_16_core1) + Positive_core1;
else CESD_TOTAL_core1 = .;
drop Positive_core1; 
run;

*Extracting and renaming the variables for Gen3/Omni2/NOS exam 2;
data exam2_2372;
*Replace Gen3/NOS/Omni2 Exam 2 dataset name;
set in1.e_exam_2011_m_0017_v1;
*Creating universal identifer variables - framid;
if idtype=2 then framid=id+20000;
else if idtype=3 then framid=id+30000;
else framid=id+720000;
*Reverse score for positive-worded questions;
Positive_core2 = 12 - sum(G3B0672 + G3B0676 + G3B0680 + G3B0684);
*Total CES-D scores for all 20 answered questions;
if nmiss(of G3B0669-G3B0688) = 0 then CESD_TOTAL_core2 = sum(of G3B0669-G3B0688) - (G3B0672 + G3B0676 + G3B0680 + G3B0684) + Positive_core2;
else CESD_TOTAL_core2 = .;
keep framid G3B0669-G3B0688 CESD_TOTAL_core2;
rename G3B0669=CESD_1_core2
   	G3B0670=CESD_2_core2
   	G3B0671=CESD_3_core2
   	G3B0672=CESD_4_core2
   	G3B0673=CESD_5_core2
   	G3B0674=CESD_6_core2
   	G3B0675=CESD_7_core2
   	G3B0676=CESD_8_core2
   	G3B0677=CESD_9_core2
   	G3B0678=CESD_10_core2
   	G3B0679=CESD_11_core2
   	G3B0680=CESD_12_core2
   	G3B0681=CESD_13_core2
   	G3B0682=CESD_14_core2
   	G3B0683=CESD_15_core2
   	G3B0684=CESD_16_core2
   	G3B0685=CESD_17_core2
   	G3B0686=CESD_18_core2
   	G3B0687=CESD_19_core2
   	G3B0688=CESD_20_core2;
run;

*Extracting and renaming the variables for Gen3/Omni2/NOS exam 3;
data exam3_2372;
*Replace Gen3/NOS/Omni2 Exam 3 dataset name;
set in1.e_exam_ex03_3b_1069;
*Creating universal identifer variables - framid;
if idtype=2 then framid=id+20000;
else if idtype=3 then framid=id+30000;
else framid=id+720000;
*Reverse score for positive-worded questions;
Positive_core3 = 12 - sum(G3C0720 + G3C0724 + G3C0728 + G3C0732);
*Total CES-D scores for all 20 answered questions;
if nmiss(of G3C0717-G3C0736) = 0 then CESD_TOTAL_core3 = sum(of G3C0717-G3C0736) - (G3C0720 + G3C0724 + G3C0728 + G3C0732) + Positive_core3;
else CESD_TOTAL_core3 = .;
keep framid G3C0717-G3C0736 CESD_TOTAL_core3 ;
rename G3C0717=CESD_1_core3
   	G3C0718=CESD_2_core3
   	G3C0719=CESD_3_core3
   	G3C0720=CESD_4_core3
   	G3C0721=CESD_5_core3
   	G3C0722=CESD_6_core3
   	G3C0723=CESD_7_core3
   	G3C0724=CESD_8_core3
   	G3C0725=CESD_9_core3
   	G3C0726=CESD_10_core3
   	G3C0727=CESD_11_core3
   	G3C0728=CESD_12_core3
   	G3C0729=CESD_13_core3
   	G3C0730=CESD_14_core3
   	G3C0731=CESD_15_core3
   	G3C0732=CESD_16_core3
   	G3C0733=CESD_17_core3
   	G3C0734=CESD_18_core3
   	G3C0735=CESD_19_core3
   	G3C0736=CESD_20_core3
;
run;

*Relabel all the variables in each dataset;
data exam1_2372_1;
set exam1_2372;
label cesd_1_core1='I was bothered by things that usually don_t bother me (at exam 1)'
      cesd_2_core1='I did not feel like eating; my appetite was poor (at exam 1)'
      cesd_3_core1='I felt that I could not shake off the blues, even with the help of family and friends (at exam 1)'
	  cesd_4_core1='I felt that I was just as good as other people (at exam 1)'
      cesd_5_core1='I had trouble keeping my mind on what I was doing (at exam 1)'
      cesd_6_core1='I felt depressed (at exam 1)'
      cesd_7_core1='I felt that everything I did was an effort (at exam 1)'
      cesd_8_core1='I felt hopeful about the future (at exam 1)'
      cesd_9_core1='I thought my life had been a failure (at exam 1)'
      cesd_10_core1='I felt fearful (at exam 1)'
      cesd_11_core1='My sleep was restless (at exam 1)'
      cesd_12_core1='I was happy (at exam 1)'
      cesd_13_core1='I talked less than usual (at exam 1)'
      cesd_14_core1='I felt lonely (at exam 1)'
      cesd_15_core1='People were unfriendly (at exam 1)'
      cesd_16_core1='I enjoyed life (at exam 1)'
      cesd_17_core1='I had crying spells (at exam 1)'
      cesd_18_core1='I felt sad (at exam 1)'
      cesd_19_core1='I felt that people disliked me (at exam 1)'
      cesd_20_core1='I could not "get going" (at exam 1)';
run;
data exam2_2372_1;
set exam2_2372;
label cesd_1_core2='I was bothered by things that usually don_t bother me (at exam 2)'
      cesd_2_core2='I did not feel like eating; my appetite was poor (at exam 2)'
      cesd_3_core2='I felt that I could not shake off the blues, even with the help of family and friends (at exam 2)'
	  cesd_4_core2='I felt that I was just as good as other people (at exam 2)'
      cesd_5_core2='I had trouble keeping my mind on what I was doing (at exam 2)'
      cesd_6_core2='I felt depressed (at exam 2)'
      cesd_7_core2='I felt that everything I did was an effort (at exam 2)'
      cesd_8_core2='I felt hopeful about the future (at exam 2)'
      cesd_9_core2='I thought my life had been a failure (at exam 2)'
      cesd_10_core2='I felt fearful (at exam 2)'
      cesd_11_core2='My sleep was restless (at exam 2)'
      cesd_12_core2='I was happy (at exam 2)'
      cesd_13_core2='I talked less than usual (at exam 2)'
      cesd_14_core2='I felt lonely (at exam 2)'
      cesd_15_core2='People were unfriendly (at exam 2)'
      cesd_16_core2='I enjoyed life (at exam 2)'
      cesd_17_core2='I had crying spells (at exam 2)'
      cesd_18_core2='I felt sad (at exam 2)'
      cesd_19_core2='I felt that people disliked me (at exam 2)'
      cesd_20_core2='I could not "get going" (at exam 2)';
run;
data exam3_2372_1;
set exam3_2372;
label cesd_1_core3='I was bothered by things that usually don_t bother me (at exam 3)'
      cesd_2_core3='I did not feel like eating; my appetite was poor (at exam 3)'
      cesd_3_core3='I felt that I could not shake off the blues, even with the help of family and friends (at exam 3)'
	  cesd_4_core3='I felt that I was just as good as other people (at exam 3)'
      cesd_5_core3='I had trouble keeping my mind on what I was doing (at exam 3)'
      cesd_6_core3='I felt depressed (at exam 3)'
      cesd_7_core3='I felt that everything I did was an effort (at exam 3)'
      cesd_8_core3='I felt hopeful about the future (at exam 3)'
      cesd_9_core3='I thought my life had been a failure (at exam 3)'
      cesd_10_core3='I felt fearful (at exam 3)'
      cesd_11_core3='My sleep was restless (at exam 3)'
      cesd_12_core3='I was happy (at exam 3)'
      cesd_13_core3='I talked less than usual (at exam 3)'
      cesd_14_core3='I felt lonely (at exam 3)'
      cesd_15_core3='People were unfriendly (at exam 3)'
      cesd_16_core3='I enjoyed life (at exam 3)'
      cesd_17_core3='I had crying spells (at exam 3)'
      cesd_18_core3='I felt sad (at exam 3)'
      cesd_19_core3='I felt that people disliked me (at exam 3)'
      cesd_20_core3='I could not "get going" (at exam 3)';
run;


*Sort all three datasets by using the macro-sort;
%sort(exam1_2372_1, framid);
%sort(exam2_2372_1, framid);
%sort(exam3_2372_1, framid);

*Merge all three datasets together by framid,and export as a permanent dataset;
data CESD_2372;
retain framid; 
merge exam1_2372_1 exam2_2372_1 exam3_2372_1;
by framid;
run;





******************************************************************************************************************************************
Education information 
******************************************************************************************************************************************

*Education information from FHS questionnaires; 
data edu_exam1_2372; 
retain framid; 
set nos_exam1 gen3_exam1 omni2_exam1;
keep framid G3A491; 
rename 
G3A491=edu_core1; 
run; 
data edu_exam2_2372; 
retain framid; 
set in1.e_exam_2011_m_0017_v1;
*Creating universal identifer variables - framid;
if idtype=2 then framid=id+20000;
else if idtype=3 then framid=id+30000;
else framid=id+720000;
keep framid G3B0631; 
rename 
G3B0631=edu_core2; 
run; 
data edu_exam3_2372; 
retain framid; 
set in1.e_exam_ex03_3b_1069;
*Creating universal identifer variables - framid;
if idtype=2 then framid=id+20000;
else if idtype=3 then framid=id+30000;
else framid=id+720000;
keep framid G3C0889; 
rename 
G3C0889=edu_core3; 
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

*Sort all four datasets by using the macro-sort;
%sort(edu_exam1_2372, framid);
%sort(edu_exam2_2372, framid);
%sort(edu_exam3_2372, framid);
%sort(edu_all_2372, framid);

*Append four FHS education datasets together;
data edu_2372_0; 
merge edu_exam1_2372 edu_exam2_2372 edu_exam3_2372 edu_all_2372; 
by framid; 
run; 

*Additional check using NP test and core exam 3; 

data edu_2372; 
set edu_2372_0; 
if edu_all = . then do; 
	if edu_core2 in (0,1,2) then edu_all = 0; 
	else if edu_core2 = 3 then edu_all = 1;
	else if edu_core2 in (4,5,6) then edu_all = 2; 
	else if edu_core2 in (7,8) then edu_all = 3;
	else if edu_core2 in (9,.) then do; 
		if edu_core1 in (0,1,2) then edu_all = 0;
		else if edu_core1 = 3 then edu_all = 1;
		else if edu_core1 in (4,5,6) then edu_all = 2; 
		else if edu_core1 in (7,8) then edu_all = 3;
		else if edu_core1 = . then do; 
			if edu_core3 in (0,1,2) then edu_all = 0;
			else if edu_core3 = 3 then edu_all = 1;
			else if edu_core3 in (4,5,6) then edu_all = 2; 
			else if edu_core3 in (7,8) then edu_all = 3;
			else edu_all = .; 
		end;
	end;
end; 
run; 




******************************************************************************************************************************************
Neuropathology data availability
******************************************************************************************************************************************

*Read in the verified cancer dataset by using a data step;
data neuropath_cohort0_1 neuropath_cohort17_1 neuropath_cohort2372_1;
set in1.neuropath_through2023_260;
*Creating universal identifer variables - framid;
if idtype=0 then framid=id;
else if idtype=1 then framid=id+80000;
else if idtype=2 then framid=id+20000;
else if idtype=3 then framid=id+30000;
else if idtype=7 then framid=id+700000;
else framid=id+720000;
neuropath_avail = 1; 
npbraak_neuropath = npbraak;
nia_reagan_neuropath = NPNIT;
*The following four variables are only available from the 2023 neuropath dataset onwards;
ad_neuropath = PATHAD;
part_neuropath = RELATAUO; 
LBD_neuropath = PATHLBD;
MND_neuropath = PATHMND; 
if idtype = 0 then output neuropath_cohort0_1;
else if idtype in (1,7) then output neuropath_cohort17_1;
else output neuropath_cohort2372_1;
keep framid neuropath_avail npbraak_neuropath nia_reagan_neuropath ad_neuropath part_neuropath LBD_neuropath MND_neuropath;
run;








******************************************************************************************************************************************
Creation of FHS CVD risk scores
******************************************************************************************************************************************

/*Calculating FHS CVD Risk Score - Please refer to the original publication*/
/*D'Agostino Sr, R. B., Vasan, R. S., Pencina, M. J., Wolf, P. A., Cobain, M., Massaro, J. M., & Kannel, W. B. (2008). General cardiovascular risk profile for use in primary care: the Framingham Heart Study. Circulation, 117(6), 743-753.*/;

data fhscvd_2372;
set backbone_2372; 
array date_core[*] date_core:; 
array age_core[*] age_core:; 
array age_fhscvd_core[3]; 

array hdl_core[*] hdl_core:; 
array hdl_fhscvd_core[3]; 

array TC_core[*] TC_core:; 
array tc_fhscvd_core[3]; 

array smoking_core[*] smoking_core:; 
array smoking_fhscvd_core[3]; 

array Hx_dm_core[*] Hx_dm_core:; 
array dm_fhscvd_core[3]; 

array hrx_core[*] hrx_core:; 
array sbp_core[*] sbp_core:; 
array sbp_fhscvd_core[3]; 

array fhscvd_core[3]; 

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

		if sex = 2 then do; /*Women FHS CVD risk score*/
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


data fsrp_2372;
set prevalence_cohort2372; 
array date_core[*] date_core:; 
array age_core[*] age_core:; 
array age_fsrp_core[3]; 

array sbp_core[*] sbp_core:; 
array sbp_fsrp_core[3]; 

array hrx_core[*] hrx_core:; 
array hrx_fsrp_core[3]; 

array Hx_dm_core[*] Hx_dm_core:; 
array dm_fsrp_core[3]; 

array smoking_core[*] smoking_core:; 
array smoking_fsrp_core[3]; 

array precvd_core[*] prevalent_strokerisk_core:; 
array precvd_fsrp_core[3]; 

array preaf_core[*] prevalent_af_core:; 
array preaf_fsrp_core[3]; 

array DLVH_core[*] DLVH_core:; 
array dlvh_fsrp_core[3]; 

array fsrp_core[3]; 
array revised_fsrp_core[3]; 

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
Creation of FHS Gen 3/Omni 2/NOS curated dataset
******************************************************************************************************************************************

*Sort all datasets by using the macro-sort;
%sort(backbone_2372, framid);
%sort(NP_cohort2372_2, framid);
%sort(date_matching_2, framid);
%sort(demrv_cohort2372_1, framid);
%sort(chd_cohort2372_1, framid);
%sort(stroke_cohort2372_1, framid);
%sort(AF_cohort2372_1, framid);
%sort(cancer_cohort2372_1, framid);
%sort(surv_cohort2372_1, framid);
%sort(prevalence_cohort2372_1, framid);
%sort(fhscvd_2372, framid);
%sort(fsrp_2372, framid);
%sort(CESD_2372, framid);
%sort(edu_2372, framid);
%sort(neuropath_cohort2372_1, framid);

*Read in all derived datasets to create curated dataset for FHS Gen 3/Omni 2/NOS cohorts; 
data out1.curated_bap_2372_09152024;
retain idtype id framid sex race_code race date_core1-date_core3 age_core1-age_core3 edu_core1-edu_core3 edu_all;
merge  
backbone_2372
NP_cohort2372_2
date_matching_2
demrv_cohort2372_1
chd_cohort2372_1
stroke_cohort2372_1
AF_cohort2372_1
cancer_cohort2372_1
surv_cohort2372_1
prevalence_cohort2372_1
fhscvd_2372
fsrp_2372
CESD_2372
edu_2372
neuropath_cohort2372_1;

by framid; 
if neuropath_avail = . then neuropath_avail = 0;  

/*Recategorizing edu_all variable using priority list - refer to coding manual*/
if edu_all = . then do; 
	if educg_np1 ne . then edu_all = educg_np1;
end;

run; 

*Check format and accuracy; 
proc print data=out1.curated_bap_2372_09152024;
*Should have 8 observations with 5 NP assessments; 
where examdate_np5 ne .;
run; 

*Remove label for csv file; 
data csv_curated_2372; 
set out1.curated_bap_2372_09152024;
run; 
proc datasets lib=work memtype=data;
   modify csv_curated_2372;
     attrib _all_ label=' ';
run;
quit;
PROC EXPORT DATA= WORK.csv_curated_2372
            OUTFILE= "C:\Users\angtf\SAS_files\Output_files\curated_bap_2372_09152024_nolabel.csv" 
            DBMS=CSV LABEL REPLACE;
     PUTNAMES=YES;
RUN;
