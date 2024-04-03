******************************************************************************************************************************************
Introduction to Gen2/Omni1 curated dataset source code
******************************************************************************************************************************************

Created by Sophia Lu
Revised by Alvin Ang 
Last updated: Feb 2024


The purpose of this SAS code is to allow users to create similar data structure and naming convention to that of the Gen2/Omni1 
curated dataset, as shown in the coding manual. The order of the variable may vary from the manual.

Please ensure you have these listed datasets to run this SAS code optimally. It is highly recommended to have them in the same location.


Generic names are used for these datasets within this SAS code. 
Tip: You can copy and paste this SAS code onto a Word document and use the "find and replace" function to customize to your dataset names 

1)  vr_wkthru_ex10_1b_1488 (Gen 2/Omni 1 workthru)
	vr_raceall_2008_a_0712 (FHS race/ethnicity information) 
	vr_educ_2018_a_1307 (Harmonized education dataset for all cohorts)

2)  np_summary_through2022_18053 (NP Summary Score)

3)  demrev_through2022_4308 (Dementia Review)

4)  Commonly used outcomes (CHD, Stroke, AF, Diabetes and Cancer): 
	vr_soe_2022_a_1424 (Verified Sequence of Events (SOE) Cardiovascular Endpoints)
	vr_afcum_2022_a_1412 (verified Atrial Fibrillation/Flutter dataset)
	vr_diab_ex10_1b_1489 (Verified Diabetes dataset for Gen 2/Omni 1)
	vr_cancer_2019_a_1162_v1 (Verified Cancer dataset)
	vr_survdth_2021_a_1452 (Verified Survival Status dataset) 

5) 	Individual FHS exam questionnaires: 
	e_exam_ex02_1_0080_v1 (Gen 2 exam 2)
	e_exam_ex06_1_0084 (Gen 2 exam 6)
	e_exam_ex07_1_0085_v1 (Gen 2 exam 7)
	e_exam_ex08_1_0005 (Gen 2 exam 8)
	e_exam_ex01_7_0020 (Omni 1 exam 1)
	e_exam_ex02_7_0003 (Omni 1 exam 2)
	e_exam_ex03_7_0426 (Omni 1 exam 3)
	q_cesd_2009_m_0570 (Gen 1/Gen 2/Omni 1 CESD exam 8 interim) 
	e_exam_ex09_1b_0844 (Gen 2/Omni 1 exam 9)
	e_exam_ex10_1b_1409 (Gen 2/Omni 1 televisit/exam 10) 
	vr_mmse_ex10_1b_1395 (Verified Gen 2/Omni1 MMSE dataset)

6)  Neuropathology Data 
	neuropath_through2023_260 (FHS Brain Donor Neuropathology Data) 

*Provide the location of these datasets to import from before you run the SAS code. ;
libname in1 'C:\Users\angtf\Desktop\Test_SAS\Input_data';
*Provide the location of the derived datasets to export to before you run the SAS code. ;
libname out1 'C:\Users\angtf\Desktop\Test_SAS\Output_data';




******************************************************************************************************************************************
Renaming variables within Gen 2/Omni 1 workthru dataset
******************************************************************************************************************************************

*Read in the Gen 2/Omni 1 workthru dataset by using a data step;
data wt_1_1;
set in1.vr_wkthru_ex10_1b_1488;
if idtype =1; 
*Creating universal identifer variables - framid;
framid=id+80000;
*drop ATT1-ATT10 (attended exams 1-10) from the dataset;
drop att1-att10 ATT5_STATUS date5_fu creat3 creat4 FASTING_BG1 FASTING_BG2 HIP1 HIP2 WAIST1 WAIST2 WAIST3 dmmed5 htnmed5 lipmed5 statin5;
run;

*rename the variables w/ a generic name variable_core()with the rename function for the Gen 2 workthru dataset in another data step;
data wt_1_2;
set wt_1_1;
*Create smoking history variable; 
array currsmk{*} currsmk2-currsmk10; 
array smksum{*} currsmk1 smksum2-smksum10; 
array smoking_ever{*} smoking_ever_core2-smoking_ever_core10; 
do k = 1 to dim(currsmk);
smksum{k+1} = sum(smksum{k},currsmk{k});
end;
do i = 1 to dim(currsmk); 
if currsmk(i) = . then smoking_ever(i) =.; 
else if  currsmk(i) = 1 then smoking_ever(i) =1; 
else if smksum(i+1) > 0 then smoking_ever(i) = 2; 
else smoking_ever(i) = 0; 
end; 
if LIPMED10 = 1 then LIPRX10 = 1;
else if LIPMED10 = 0 then LIPRX10 = 0; 
else LIPRX10 = . ;
drop i k smksum:; 
rename 
	age1-age10=age_core1-age_core10   	
	bg1-bg10=BG_core1-BG_core10
   	bmi1-bmi10=BMI_core1-BMI_core10
   	calc_LDL1-calc_LDL10=calc_LDL_core1-calc_LDL_core10
   	cpd1-cpd10=CPD_core1-CPD_core10
   	creat2=Creatinine_core2
   	creat5-creat10=Creatinine_core5-Creatinine_core10
   	currsmk1-currsmk10=Smoking_core1-Smoking_core10
   	date1-date10=Date_core1-Date_core10
   	dbp1-dbp10=DBP_core1-DBP_core10
   	dlvh1-dlvh10=DLVH_core1-DLVH_core10
   	Fasting_BG3-Fasting_BG10=Fasting_BG_core3-Fasting_BG_core10
   	HDL1-HDL10=HDL_core1-HDL_core10
   	hgt1-hgt10=height_core1-height_core10
   	hip4=Hip_core4
   	hip5=Hip_core5
   	hip6=Hip_core6
   	hip7=Hip_core7
	hip9=Hip_core9
   	hip10=Hip_core10
   	sbp1-sbp10=SBP_core1-SBP_core10
   	tc1-tc10=TC_core1-TC_core10
   	trig1-trig10=Triglycerides_core1-Triglycerides_core10
   	vent_rt1-vent_rt10=Vent_rt_core1-Vent_rt_core10
   	waist4-waist10=Waist_core4-Waist_core10
	wgt1-wgt10=Weight_core1-Weight_core10
   	dmrx1-dmrx10=DMRX_core1-DMRX_core10
   	hrx1-hrx10=HRX_core1-HRX_core10
   	liprx1-liprx10=LIPRX_core1-LIPRX_core10
	ATT10_STATUS=Status_core10
	Date10_FU=Date_FU_core10
	dmmed10=dmmed_core10 
	htnmed10=htnmed_core10
	lipmed10=lipmed_core10
	statin10=statin_core10
;
run;

/*read in the Omni 1 workthru dataset*/
data wt_7_1;
set in1.vr_wkthru_ex10_1b_1488;
if idtype =7; 
*Creating universal identifer variables - framid;
framid=id+700000;
*drop ATT1-ATT5 from (attended exams 1-5) from the dataset;
drop att1-att10 ATT10_STATUS Date10_FU age6-age10 bg6-bg10 bmi6-bmi10 calc_ldl6-calc_ldl10 cpd6-cpd10 creat6-creat10 currsmk6-currsmk10 date6-date10 dbp6-dbp10 dlvh6-dlvh10 dmrx6-dmrx10 FASTING_BG6-FASTING_BG10 HDL6-HDL10 HGT6-HGT10 HIP6 HIP7 HIP9 HIP10 HRX6-HRX10 LIPRX6-LIPRX9 SBP6-SBP10 TC6-TC10 TRIG6 -TRIG10 VENT_RT6-VENT_RT10 WAIST6-WAIST10 WGT6-WGT10 dmmed10 htnmed10 lipmed10 statin10;
run;
/*rename the variables w/ a generic name variable_core() for Omni 1 workthru dataset
by using the rename function in another data step*/
data wt_7_2;
set wt_7_1;
array currsmk{*} currsmk2-currsmk5; 
array smksum{*} currsmk1 smksum2-smksum5; 
array smoking_ever{*} smoking_ever_core7-smoking_ever_core10; 
do k = 1 to dim(currsmk);
smksum{k+1} = sum(smksum{k},currsmk{k});
end;
do i = 1 to dim(currsmk); 
if currsmk(i) = . then smoking_ever(i) =.; 
else if  currsmk(i) = 1 then smoking_ever(i) =1; 
else if smksum(i+1) > 0 then smoking_ever(i) = 2; 
else smoking_ever(i) = 0; 
end; 
if LIPMED5 = 1 then LIPRX5 = 1;
else if LIPMED5 = 0 then LIPRX5 = 0; 
else LIPRX5 = . ;
drop i k smksum:; 
rename 
	age1=age_core5
   	age2=age_core7
   	age3=age_core8
   	age4=age_core9
	age5=age_core10
   	bg1=BG_core5
   	bg2=BG_core7
   	bg3=BG_core8
   	bg4=BG_core9
   	bg5=BG_core10
   	bmi1=BMI_core5
   	bmi2=BMI_core7
   	bmi3=BMI_core8
   	bmi4=BMI_core9
   	bmi5=BMI_core10
   	calc_LDL1=calc_LDL_core5
   	calc_LDL2=calc_LDL_core7
   	calc_LDL3=calc_LDL_core8
   	calc_LDL4=calc_LDL_core9
   	calc_LDL5=calc_LDL_core10
   	cpd1=CPD_core5
   	cpd2=CPD_core7
   	cpd3=CPD_core8
   	cpd4=CPD_core9
   	cpd5=CPD_core10
   	creat2=Creatinine_core7
   	creat3=Creatinine_core8
   	creat4=Creatinine_core9
	creat5=Creatinine_core10
   	currsmk1=Smoking_core5
   	currsmk2=Smoking_core7
   	currsmk3=Smoking_core8
   	currsmk4=Smoking_core9
   	currsmk5=Smoking_core10
   	date1=date_core5
   	date2=date_core7
   	date3=date_core8
   	date4=date_core9
	date5=date_core10
   	DBP1=DBP_core5
   	dbp2=DBP_core7
   	dbp3=DBP_core8
   	dbp4=DBP_core9
	dbp5=DBP_core10
    dlvh1=DLVH_core5
   	dlvh2=DLVH_core7
   	dlvh3=DLVH_core8
   	dlvh4=DLVH_core9
	dlvh5=DLVH_core10
   	fasting_BG1=Fasting_BG_core5
   	fasting_BG2=Fasting_BG_core7
   	fasting_BG3=Fasting_BG_core8
   	fasting_BG4=Fasting_BG_core9
   	fasting_BG5=Fasting_BG_core10
   	hdl1=HDL_core5
   	hdl2=HDL_core7
   	hdl3=HDL_core8
   	hdl4=HDL_core9
   	hdl5=HDL_core10
   	hgt1=Height_core5
   	hgt2=Height_core7
   	hgt3=Height_core8
   	hgt4=Height_core9
   	hgt5=Height_core10
   	hip1=Hip_core5
   	hip2=Hip_core7
   	hip4=Hip_core9
	hip5=Hip_core10 	
   	sbp1=SBP_core5
   	sbp2=SBP_core7
   	sbp3=SBP_core8
   	sbp4=SBP_core9
	sbp5=SBP_core10
   	tc1=TC_core5
   	tc2=TC_core7
   	tc3=TC_core8
   	tc4=TC_core9
	tc5=TC_core10
   	trig1=Triglycerides_core5
   	trig2=Triglycerides_core7
   	trig3=Triglycerides_core8
   	trig4=Triglycerides_core9
   	trig5=Triglycerides_core10
   	vent_rt1=Vent_rt_core5
   	vent_rt2=Vent_rt_core7
   	vent_rt3=Vent_rt_core8
   	vent_rt4=Vent_rt_core9
	vent_rt5=Vent_rt_core10
   	waist1=Waist_core5
   	waist2=Waist_core7
   	waist3=Waist_core8
   	waist4=Waist_core9
   	waist5=Waist_core10
   	wgt1=Weight_core5
   	wgt2=Weight_core7
   	wgt3=Weight_core8
   	wgt4=Weight_core9
   	wgt5=Weight_core10
   	DMRX1=DMRX_core5
   	DMRX2=DMRX_core7
   	DMRX3=DMRX_core8
   	DMRX4=DMRX_core9
	DMRX5=DMRX_core10
   	HRX1=HRX_core5
   	HRX2=HRX_core7
   	HRX3=HRX_core8
   	HRX4=HRX_core9
   	HRX5=HRX_core10
   	LIPRX1=LIPRX_core5
   	LIPRX2=LIPRX_core7
   	LIPRX3=LIPRX_core8
   	LIPRX4=LIPRX_core9
	LIPRX5=LIPRX_core10
	ATT5_STATUS=Status_core10
	Date5_FU=Date_FU_core10
	dmmed5=dmmed_core10 
	htnmed5=htnmed_core10
	lipmed5=lipmed_core10
	statin5=statin_core10
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
%sort(wt_1_2, framid);
%sort(wt_7_2, framid);

/*append the datasets together by FRAMID*/
data wt_17_1;
*fix the length of groups of before appending the datasets together if there are warnings about multiple lengths being specified for those variables;
length Height_core1-Height_core10 HDL_core1-HDL_core10 TC_core1-TC_core10 Triglycerides_core1-Triglycerides_core10 Vent_RT_core1-Vent_RT_core10 Weight_core1-Weight_core10 8;
set wt_1_2 wt_7_2;
by framid;
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

*Read in verified Gen 2/Omni 1 diabetes dataset by using a data step;
data diabetes_1; 
retain framid; 
set in1. vr_diab_ex10_1b_1489; 
*Select and keep Gen 2 participants;
if idtype = 1;
*Creating universal identifer variables - framid;
framid=id+80000;
drop idtype id; 
rename
CURR_DIAB1-CURR_DIAB10=Curr_dm_core1-Curr_dm_core10
HX_DIAB1-HX_DIAB10=Hx_dm_core1-Hx_dm_core10
;
run; 

*Read in verified Gen 2/Omni 1 diabetes dataset by using a data step;
data diabetes_7; 
retain framid; 
set in1. vr_diab_ex10_1b_1489; 
*Select and keep Omni 1 participants;
if idtype = 7;
*Creating universal identifer variables - framid;
framid=id+700000;
drop idtype id CURR_DIAB6-CURR_DIAB10 HX_DIAB6-HX_DIAB10 ; 
rename
CURR_DIAB1=Curr_dm_core5
CURR_DIAB2-CURR_DIAB5=Curr_dm_core7-Curr_dm_core10
HX_DIAB1=Hx_dm_core5
HX_DIAB2-HX_DIAB5=Hx_dm_core7-Hx_dm_core10
;
run; 


*Sort all three datasets by using the macro-sort;
%sort(wt_17_1, framid);
%sort(race_17, framid);
%sort(diabetes_1, framid);
%sort(diabetes_7, framid);


*Combined workthru, race and diabetes datasets;
data wt_17_2; 
merge wt_17_1 race_17 diabetes_1 diabetes_7;
by framid; 
run; 

/*Reordering variables*/
data backbone_17;
retain idtype id framid sex race_code race; 
if 0 then set wt_17_2 (keep=Date_core:) wt_17_2 (keep=Date_FU_core10) wt_17_2 (keep=Status_core10) wt_17_2 (keep=Age_core:) wt_17_2 (keep=Height_core:) wt_17_2 (keep=Weight_core:) wt_17_2 (keep=BMI_core:) wt_17_2 (keep=Hip_core:) wt_17_2 (keep=Waist_core:) wt_17_2 (keep=Smoking_core:) wt_17_2 (keep=Smoking_ever_core:) wt_17_2 (keep=CPD_core:) wt_17_2 (keep=SBP_core:) wt_17_2 (keep=DBP_core:) wt_17_2 (keep=Vent_RT_core:) wt_17_2 (keep=DLVH_core:) wt_17_2 (keep=HRX_core:) wt_17_2 (keep=htnmed_core10) wt_17_2 (keep=BG_core:) wt_17_2 (keep=Fasting_BG_core:) wt_17_2 (keep=DMRX_core:) wt_17_2 (keep=dmmed_core10) wt_17_2 (keep=Curr_dm_core:) wt_17_2 (keep=hx_dm_core:) wt_17_2 (keep=TC_core:) wt_17_2 (keep=HDL_core:) wt_17_2 (keep=Triglycerides_core:) wt_17_2 (keep=Calc_LDL_core:) wt_17_2 (keep=LIPRX_core:) wt_17_2 (keep=lipmed_core10) wt_17_2 (keep=statin_core10) wt_17_2 (keep=Creatinine_core:);
set wt_17_2;
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
(out=NP_cohort17_2,
data=NP_cohort17_1,
vars= examdate age battery marital handedness employment education_b1 education_b2 educg occup_b1 occup_b2 lmi lmd lmr lmi_joe lmd_joe lmr_joe LM_story vri vrd vrr pasi pasi_e pasi_h pasd pasd_e pasd_h pasr dsf dsb trailsA trailsB sim hvot bnt10 bnt10_semantic bnt10_phonemic bnt30 bnt30_semantic bnt30_phonemic bnt36 bnt36_semantic bnt36_phonemic FingTapR FingTapL wrat fas fas_animal bd wais coding_correct coding_incorrect Incidental_paired Incidental_free Math_correct Math_incorrect_add Math_incorrect_sub Math_incorrect_mul right_open left_open right_close left_close mri352 test_language,
by=framid,
pivot=NP_exam,
dropMissingPivot=0,
library=work);







******************************************************************************************************************************************
Date-matching between NP dates and core exam dates
******************************************************************************************************************************************

*Read in workthru and NP Summary Score dataset by using a data step;

data date_matching1 date_matching7; 
merge wt_17_2 NP_cohort17_2; 
by framid; 
if idtype = 1 then output date_matching1; 
else output date_matching7; 
keep framid date_core: examdate_np:;
run; 



/*Date-matching for Gen 2 participants*/ 

data date_matching1_1 (drop = i); 
set date_matching1; 
array examdate_np[*] examdate_np1-examdate_np12; 
array date_core[*] date_core1-date_core10; 
array np_closest_exam_date[12] ; 
array np_days_apart[12] ; 
array np_exam_cycle[12] ; 
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

data date_matching1_2 (drop = i j); 
set date_matching1_1; 
array examdate_np[*] examdate_np1-examdate_np12; 
array date_core[*] date_core1-date_core10;
array np_closest_exam_date[12] np_closest_exam_date:; 
array np_days_apart[12] np_days_apart:; 
array np_exam_cycle[12] np_exam_cycle:;
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


/*Date-matching for Omni 1 participants*/ 

data date_matching7_1 (drop = i); 
set date_matching7; 
array examdate_np[*] examdate_np1-examdate_np12; 
array date_core[*] date_core5 date_core7 date_core8 date_core9 date_core10; 
array np_closest_exam_date[12] ; 
array np_days_apart[12] ; 
array np_exam_cycle[12] ; 
do i = 1 to dim(examdate_np); 
if examdate_np(i) ne . then np_closest_exam_date(i) = date_core5; 
else  np_closest_exam_date(i) = .; 
if examdate_np(i) ne . then np_days_apart(i) = date_core5-examdate_np(i); 
else np_days_apart(i) = .; 
if examdate_np(i) ne . then np_exam_cycle(i)= 5; 
else np_exam_cycle(i) = .; 
end; 
format np_closest_exam_date: MMDDYY10. ;
run;

data date_matching7_2 (drop = i j); 
set date_matching7_1; 
array examdate_np[*] examdate_np1-examdate_np12; 
array date_core[*] date_core5 date_core7 date_core8 date_core9 date_core10;
array np_closest_exam_date[12] np_closest_exam_date:; 
array np_days_apart[12] np_days_apart:; 
array np_exam_cycle[12] np_exam_cycle:;
do i = 1 to dim(examdate_np); 
if examdate_np[i] ne . then do j = 2 to dim(date_core); 
if . < abs(date_core[j] - examdate_np[i]) < abs(np_days_apart[i]) then do; 
np_closest_exam_date[i] = date_core[j]; 
np_days_apart[i] = date_core[j] - examdate_np[i];
np_exam_cycle[i] = j + 5; 
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
Prevalent variables for Gen 2/Omni 1 
******************************************************************************************************************************************

*Sort datasets by framid; 
%sort(backbone_17, framid);
%sort(NP_cohort17_2, framid);
%sort(demrv_cohort17_1, framid);
%sort(chd_cohort17_1, framid);
%sort(stroke_cohort17_1, framid);
%sort(AF_cohort17_1, framid);
%sort(cancer_cohort17_1, framid);
%sort(strokerisk_cohort17_1, framid);

data prevalence_derivation17; 
merge backbone_17 NP_cohort17_2 demrv_cohort17_1 chd_cohort17_1 stroke_cohort17_1 AF_cohort17_1 cancer_cohort17_1 strokerisk_cohort17_1;
by framid; 
run;


data prevalence_cohort17; 
set prevalence_derivation17; 
array date_core[*] date_core:; 
array examdate_np[*] examdate_np1-examdate_np12; 

*Derived prevalent variables for each FHS core exam;
array prevalent_chd_core[10] ; 
array prevalent_stroke_core[10] ; 
array prevalent_af_core[10] ;
array prevalent_dementia_core[10] ; 
array prevalent_cancer_core[10] ;
array prevalent_strokerisk_core[10] ;


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
array prevalent_chd_NP[12] ; 
array prevalent_stroke_NP[12] ; 
array prevalent_af_NP[12] ;
array prevalent_dementia_NP[12] ; 
array prevalent_cancer_NP[12] ;
array prevalent_strokerisk_NP[12] ;


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


data prevalence_cohort17_1; 
set prevalence_cohort17; 
keep framid prevalent_chd_core: prevalent_stroke_core: prevalent_af_core: prevalent_dementia_core: prevalent_cancer_core: prevalent_chd_np: prevalent_stroke_np: prevalent_af_np: prevalent_dementia_np: prevalent_cancer_np: ;    
run;









******************************************************************************************************************************************
MMSE variables from verified MMSE dataset
******************************************************************************************************************************************
*read in verified MMSE dataset with a data step;
data mmse_17;
set in1.vr_mmse_ex10_1b_1395;
*Creating universal identifer variables - framid;
if idtype =1 then framid=id+80000;
else framid=id+700000;
*Aligning Omni 1 core exam with Gen 2 core exam numbering;
if idtype = 7 then do; 
if exam = 1 then exam = 5; 
else if exam = 2 then exam = 7; 
else if exam = 3 then exam = 8; 
else if exam = 4 then exam = 9; 
else if exam = 5 then exam = 10;
end; 
keep framid exam cogscr maxcog; 
run; 

proc transpose data=mmse_17 out=widecogscr prefix=cogscr_core;
   by framid;
   id exam;
   var cogscr;
run;

proc transpose data=mmse_17 out=widemaxcog prefix=maxcog_core;
   by framid;
   id exam;
   var maxcog;
run;

data mmse_17_1;
retain framid cogscr_core5-cogscr_core10 maxcog_core5-maxcog_core10; 
merge  widecogscr(drop=_name_) widemaxcog(drop=_name_);
    by framid;
drop _LABEL_;
run;








******************************************************************************************************************************************
CES-D variables from individual FHS exam questionnaires
******************************************************************************************************************************************

*Read in Gen2 Exam 6 dataset by using a data step;

data exam6_1;
set in1.e_exam_ex06_1_0084;
*Creating universal identifer variables - framid;
framid=id+80000;
*Reverse score for positive-worded questions;
Positive_core6 = 12 - sum(F154 + F158 + F162 + F166);
*Total CES-D scores for all 20 answered questions;
if nmiss(of F151-F170) = 0 then CESD_TOTAL_core6 = sum(of F151-F170) - (F154 + F158 + F162 + F166) + Positive_core6;
else CESD_TOTAL_core6 = .;
keep framid F151-F170 CESD_TOTAL_core6;
rename F151=CESD_1_core6
   	F152=CESD_2_core6
   	F153=CESD_3_core6
   	F154=CESD_4_core6
   	F155=CESD_5_core6
   	F156=CESD_6_core6
   	F157=CESD_7_core6
   	F158=CESD_8_core6
   	F159=CESD_9_core6
   	F160=CESD_10_core6
   	F161=CESD_11_core6
   	F162=CESD_12_core6
   	F163=CESD_13_core6
   	F164=CESD_14_core6
   	F165=CESD_15_core6
   	F166=CESD_16_core6
   	F167=CESD_17_core6
   	F168=CESD_18_core6
   	F169=CESD_19_core6
   	F170=CESD_20_core6;
run;

*Read in Gen2 Exam 7 dataset by using a data step;

data gen2_exam7;
set in1.e_exam_ex07_1_0085_v1;
*Creating universal identifer variables - framid;
framid=id+80000;
*Reverse score for positive-worded questions;
Positive_core7 = 12 - sum(G590 + G594 + G598 + G602);
*Total CES-D scores for all 20 answered questions;
if nmiss(of G587-G606) = 0 then CESD_TOTAL_core7 = sum(of G587-G606) - (G590 + G594 + G598 + G602) + Positive_core7;
else CESD_TOTAL_core7 = .;
keep framid G587-G606 CESD_TOTAL_core7;
rename G587=CESD_1_core7
   	G588=CESD_2_core7
   	G589=CESD_3_core7
   	G590=CESD_4_core7
   	G591=CESD_5_core7
   	G592=CESD_6_core7
   	G593=CESD_7_core7
   	G594=CESD_8_core7
   	G595=CESD_9_core7
   	G596=CESD_10_core7
   	G597=CESD_11_core7
   	G598=CESD_12_core7
   	G599=CESD_13_core7
   	G600=CESD_14_core7
   	G601=CESD_15_core7
   	G602=CESD_16_core7
   	G603=CESD_17_core7
   	G604=CESD_18_core7
   	G605=CESD_19_core7
   	G606=CESD_20_core7;
run;

*Read in Omni1 Exam 2 dataset by using a data step;

data Omni1_exam7;
set in1.e_exam_ex02_7_0003;
*Creating universal identifer variables - framid;
framid=id+700000;
*Reverse score for positive-worded questions;
Positive_core7 = 12 - sum(G590 + G594 + G598 + G602);
*Total CES-D scores for all 20 answered questions;
if nmiss(of G587-G606) = 0 then CESD_TOTAL_core7 = sum(of G587-G606) - (G590 + G594 + G598 + G602) + Positive_core7;
else CESD_TOTAL_core7 = .;
keep framid G587-G606 CESD_TOTAL_core7;
rename G587=CESD_1_core7
   	G588=CESD_2_core7
   	G589=CESD_3_core7
   	G590=CESD_4_core7
   	G591=CESD_5_core7
   	G592=CESD_6_core7
   	G593=CESD_7_core7
   	G594=CESD_8_core7
   	G595=CESD_9_core7
   	G596=CESD_10_core7
   	G597=CESD_11_core7
   	G598=CESD_12_core7
   	G599=CESD_13_core7
   	G600=CESD_14_core7
   	G601=CESD_15_core7
   	G602=CESD_16_core7
   	G603=CESD_17_core7
   	G604=CESD_18_core7
   	G605=CESD_19_core7
   	G606=CESD_20_core7;
run;


*Append the two Exam 7 datasets together;
data exam7_17;
set gen2_exam7 Omni1_exam7;
run;


*Read in Gen1.Gen2.Omni1 Exam 8 (interim) dataset by using a data step;

data CESD_exam8_17;
set in1.q_cesd_2009_m_0570; 
*Creating universal identifer variables - framid;
if idtype =1 then framid=id+80000;
else if idtype = 7 then framid=id+700000;
*Keep only Gen 2 and Omni 1 participants;
else delete;
run;

*Sort CESD exam 8 data by framid and testdate; 
proc sort data=CESD_exam8_17; 
by framid testdate; 
run; 

data CESD_exam8_17_2; 
*Framid and testdate as first two variables;
retain framid testdate; 
set CESD_exam8_17; 
by framid; 
*Select the first set of CESD assessment;
if first.framid;  
*Reverse score for positive-worded questions;
Positive_core8 = 12 - sum(good, hopeful, happy, enjoy);
*Total CES-D scores for all 20 answered questions;
if nmiss(of bother, eat, blues, good, mind, depre, effort, hopeful, failure, fearful, sleep, happy, talk, lonely, unfriend, enjoy, cry, sad, dislike, get_going) = 0 then CESD_TOTAL_core8 = sum(of bother, eat, blues, good, mind, depre, effort, hopeful, failure, fearful, sleep, happy, talk, lonely, unfriend, enjoy, cry, sad, dislike, get_going) - (good + hopeful + happy + enjoy) + Positive_core8;
else CESD_TOTAL_core8 = .;
drop idtype id Positive_core8;
rename bother=CESD_1_core8
   	eat=CESD_2_core8
   	blues=CESD_3_core8
   	good=CESD_4_core8
   	mind=CESD_5_core8
   	depre=CESD_6_core8
   	effort=CESD_7_core8
   	hopeful=CESD_8_core8
   	failure=CESD_9_core8
   	fearful=CESD_10_core8
   	sleep=CESD_11_core8
   	happy=CESD_12_core8
   	talk=CESD_13_core8
   	lonely=CESD_14_core8
   	unfriend=CESD_15_core8
   	enjoy=CESD_16_core8
   	cry=CESD_17_core8
   	sad=CESD_18_core8
   	dislike=CESD_19_core8
   	get_going=CESD_20_core8
	testdate=CESD_date_core8; 
run; 

*Read in Gen2.Omni1 Exam 9 dataset by using a data step;

data exam9_17;
set in1.e_exam_ex09_1b_0844;
*Creating universal identifer variables - framid;
if idtype =1 then framid=id+80000;
else framid=id+700000;
*Reverse score for positive-worded questions;
Positive_core9 = 12 - sum(J730 + J734 + J738 + J742);
*Total CES-D scores for all 20 answered questions;
if nmiss(of J727-J746) = 0 then CESD_TOTAL_core9 = sum(of J727-J746) - (J730 + J734 + J738 + J742) + Positive_core9;
else CESD_TOTAL_core9 = .;
keep framid J727-J746 CESD_TOTAL_core9;
rename J727=CESD_1_core9
   	J728=CESD_2_core9
   	J729=CESD_3_core9
   	J730=CESD_4_core9
   	J731=CESD_5_core9
   	J732=CESD_6_core9
   	J733=CESD_7_core9
   	J734=CESD_8_core9
   	J735=CESD_9_core9
   	J736=CESD_10_core9
   	J737=CESD_11_core9
   	J738=CESD_12_core9
   	J739=CESD_13_core9
   	J740=CESD_14_core9
   	J741=CESD_15_core9
   	J742=CESD_16_core9
   	J743=CESD_17_core9
   	J744=CESD_18_core9
   	J745=CESD_19_core9
   	J746=CESD_20_core9;
run;

*Read in Gen2.Omni1 Exam 10 dataset by using a data step;

data exam10_17;
set in1. e_exam_ex10_1b_1409;
*Creating universal identifer variables - framid;
if idtype =1 then framid=id+80000;
else framid=id+700000;
*Reverse score for positive-worded questions;
Positive_core10 = 12 - sum(K1200 + K1204 + K1208 + K1212);
*Total CES-D scores for all 20 answered questions;
if nmiss(of K1197-K1216) = 0 then CESD_TOTAL_core10 = sum(of K1197-K1216) - (K1200 + K1204 + K1208 + K1212) + Positive_core10;
else CESD_TOTAL_core10 = .;
keep framid K1197-K1216 CESD_TOTAL_core10;
rename K1197=CESD_1_core10
   	K1198=CESD_2_core10
   	K1199=CESD_3_core10
   	K1200=CESD_4_core10
   	K1201=CESD_5_core10
   	K1202=CESD_6_core10
   	K1203=CESD_7_core10
   	K1204=CESD_8_core10
   	K1205=CESD_9_core10
   	K1206=CESD_10_core10
   	K1207=CESD_11_core10
   	K1208=CESD_12_core10
   	K1209=CESD_13_core10
   	K1210=CESD_14_core10
   	K1211=CESD_15_core10
   	K1212=CESD_16_core10
   	K1213=CESD_17_core10
   	K1214=CESD_18_core10
   	K1215=CESD_19_core10
   	K1216=CESD_20_core10;
run;


*Relabel all the variables in each dataset;
data exam6_1_1;
set exam6_1;
label cesd_1_core6='I was bothered by things that usually don_t bother me (at exam 6)'
      cesd_2_core6='I did not feel like eating; my appetite was poor (at exam 6)'
      cesd_3_core6='I felt that I could not shake off the blues, even with the help of family and friends (at exam 6)'
	  cesd_4_core6='I felt that I was just as good as other people (at exam 6)'
      cesd_5_core6='I had trouble keeping my mind on what I was doing (at exam 6)'
      cesd_6_core6='I felt depressed (at exam 6)'
      cesd_7_core6='I felt that everything I did was an effort (at exam 6)'
      cesd_8_core6='I felt hopeful about the future (at exam 6)'
      cesd_9_core6='I thought my life had been a failure (at exam 6)'
      cesd_10_core6='I felt fearful (at exam 6)'
      cesd_11_core6='My sleep was restless (at exam 6)'
      cesd_12_core6='I was happy (at exam 6)'
      cesd_13_core6='I talked less than usual (at exam 6)'
      cesd_14_core6='I felt lonely (at exam 6)'
      cesd_15_core6='People were unfriendly (at exam 6)'
      cesd_16_core6='I enjoyed life (at exam 6)'
      cesd_17_core6='I had crying spells (at exam 6)'
      cesd_18_core6='I felt sad (at exam 6)'
      cesd_19_core6='I felt that people disliked me (at exam 6)'
      cesd_20_core6='I could not "get going" (at exam 6)';
run;
data exam7_17_1;
set exam7_17;
label cesd_1_core7='I was bothered by things that usually don_t bother me (at exam 7)'
      cesd_2_core7='I did not feel like eating; my appetite was poor (at exam 7)'
      cesd_3_core7='I felt that I could not shake off the blues, even with the help of family and friends (at exam 7)'
	  cesd_4_core7='I felt that I was just as good as other people (at exam 7)'
      cesd_5_core7='I had trouble keeping my mind on what I was doing (at exam 7)'
      cesd_6_core7='I felt depressed (at exam 7)'
      cesd_7_core7='I felt that everything I did was an effort (at exam 7)'
      cesd_8_core7='I felt hopeful about the future (at exam 7)'
      cesd_9_core7='I thought my life had been a failure (at exam 7)'
      cesd_10_core7='I felt fearful (at exam 7)'
      cesd_11_core7='My sleep was restless (at exam 7)'
      cesd_12_core7='I was happy (at exam 7)'
      cesd_13_core7='I talked less than usual (at exam 7)'
      cesd_14_core7='I felt lonely (at exam 7)'
      cesd_15_core7='People were unfriendly (at exam 7)'
      cesd_16_core7='I enjoyed life (at exam 7)'
      cesd_17_core7='I had crying spells (at exam 7)'
      cesd_18_core7='I felt sad (at exam 7)'
      cesd_19_core7='I felt that people disliked me (at exam 7)'
      cesd_20_core7='I could not "get going" (at exam 7)';
run;
data exam8_17_1;
set CESD_exam8_17_2;
label cesd_1_core8='I was bothered by things that usually don_t bother me (at exam 8 interim)'
      cesd_2_core8='I did not feel like eating; my appetite was poor (at exam 8 interim)'
      cesd_3_core8='I felt that I could not shake off the blues, even with the help of family and friends (at exam 8 interim)'
	  cesd_4_core8='I felt that I was just as good as other people (at exam 8 interim)'
      cesd_5_core8='I had trouble keeping my mind on what I was doing (at exam 8 interim)'
      cesd_6_core8='I felt depressed (at exam 8 interim)'
      cesd_7_core8='I felt that everything I did was an effort (at exam 8 interim)'
      cesd_8_core8='I felt hopeful about the future (at exam 8 interim)'
      cesd_9_core8='I thought my life had been a failure (at exam 8 interim)'
      cesd_10_core8='I felt fearful (at exam 8 interim)'
      cesd_11_core8='My sleep was restless (at exam 8 interim)'
      cesd_12_core8='I was happy (at exam 8 interim)'
      cesd_13_core8='I talked less than usual (at exam 8 interim)'
      cesd_14_core8='I felt lonely (at exam 8 interim)'
      cesd_15_core8='People were unfriendly (at exam 8 interim)'
      cesd_16_core8='I enjoyed life (at exam 8 interim)'
      cesd_17_core8='I had crying spells (at exam 8 interim)'
      cesd_18_core8='I felt sad (at exam 8 interim)'
      cesd_19_core8='I felt that people disliked me (at exam 8 interim)'
      cesd_20_core8='I could not "get going" (at exam 8 interim)';
run;
data exam9_17_1;
set exam9_17;
label cesd_1_core9='I was bothered by things that usually don_t bother me (at exam 9)'
      cesd_2_core9='I did not feel like eating; my appetite was poor (at exam 9)'
      cesd_3_core9='I felt that I could not shake off the blues, even with the help of family and friends (at exam 9)'
	  cesd_4_core9='I felt that I was just as good as other people (at exam 9)'
      cesd_5_core9='I had trouble keeping my mind on what I was doing (at exam 9)'
      cesd_6_core9='I felt depressed (at exam 9)'
      cesd_7_core9='I felt that everything I did was an effort (at exam 9)'
      cesd_8_core9='I felt hopeful about the future (at exam 9)'
      cesd_9_core9='I thought my life had been a failure (at exam 9)'
      cesd_10_core9='I felt fearful (at exam 9)'
      cesd_11_core9='My sleep was restless (at exam 9)'
      cesd_12_core9='I was happy (at exam 9)'
      cesd_13_core9='I talked less than usual (at exam 9)'
      cesd_14_core9='I felt lonely (at exam 9)'
      cesd_15_core9='People were unfriendly (at exam 9)'
      cesd_16_core9='I enjoyed life (at exam 9)'
      cesd_17_core9='I had crying spells (at exam 9)'
      cesd_18_core9='I felt sad (at exam 9)'
      cesd_19_core9='I felt that people disliked me (at exam 9)'
      cesd_20_core9='I could not "get going" (at exam 9)';
run;
data exam10_17_1;
set exam10_17;
label cesd_1_core10='I was bothered by things that usually don_t bother me (at exam 10)'
      cesd_2_core10='I did not feel like eating; my appetite was poor (at exam 10)'
      cesd_3_core10='I felt that I could not shake off the blues, even with the help of family and friends (at exam 10)'
	  cesd_4_core10='I felt that I was just as good as other people (at exam 10)'
      cesd_5_core10='I had trouble keeping my mind on what I was doing (at exam 10)'
      cesd_6_core10='I felt depressed (at exam 10)'
      cesd_7_core10='I felt that everything I did was an effort (at exam 10)'
      cesd_8_core10='I felt hopeful about the future (at exam 10)'
      cesd_9_core10='I thought my life had been a failure (at exam 10)'
      cesd_10_core10='I felt fearful (at exam 10)'
      cesd_11_core10='My sleep was restless (at exam 10)'
      cesd_12_core10='I was happy (at exam 10)'
      cesd_13_core10='I talked less than usual (at exam 10)'
      cesd_14_core10='I felt lonely (at exam 10)'
      cesd_15_core10='People were unfriendly (at exam 10)'
      cesd_16_core10='I enjoyed life (at exam 10)'
      cesd_17_core10='I had crying spells (at exam 10)'
      cesd_18_core10='I felt sad (at exam 10)'
      cesd_19_core10='I felt that people disliked me (at exam 10)'
      cesd_20_core10='I could not "get going" (at exam 10)';
run;

*Sort all five datasets by using the macro-sort;
%sort(exam6_1_1, framid);
%sort(exam7_17_1, framid);
%sort(exam8_17_1, framid);
%sort(exam9_17_1, framid);
%sort(exam10_17_1, framid);


*Merge all five datasets together by framid;
data CESD_17;
retain framid; 
merge exam6_1_1 exam7_17_1 exam8_17_1 exam9_17_1 exam10_17_1;
by framid;
run;










******************************************************************************************************************************************
Education information
******************************************************************************************************************************************

*Education information from Gen 2 Exam 2 FHS questionnaire; 
data edu_exam2_1; 
retain framid; 
set in1.e_exam_ex02_1_0080_v1;
framid = id + 80000;
keep framid B43; 
rename 
B43=edu_core2; 
run; 

*Education information from Gen 2 Exam 8 FHS questionnaire; 
data edu_exam8_1; 
retain framid; 
set in1.e_exam_ex08_1_0005;
framid = id + 80000;
keep framid H708; 
rename 
H708=edu_core8; 
run; 

*Education information from Omni 1 Exam 3 FHS questionnaire; 
data edu_exam8_7; 
retain framid; 
set in1.e_exam_ex03_7_0426;
framid = id + 700000;
keep framid H708; 
rename 
H708=edu_core8; 
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
%sort(edu_exam2_1, framid);
%sort(edu_exam8_1, framid);
%sort(edu_exam8_7, framid);
%sort(edu_all_17, framid);


*Append four FHS education datasets together;
data edu_17_0; 
merge edu_exam2_1 edu_exam8_1 edu_exam8_7 edu_all_17; 
by framid; 
run; 

*Additional check for Gen 2 participants; 

data edu_17; 
set edu_17_0; 
if framid < 90000 and edu_all = . then do; 
if edu_core8 in (0,1,2) then edu_all = 0; 
else if edu_core8 = 3 then edu_all = 1;
else if edu_core8 in (4,5,6) then edu_all = 2; 
else if edu_core8 in (7,8) then edu_all = 3;
else edu_all = .;
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
/*D_Agostino Sr, R. B., Vasan, R. S., Pencina, M. J., Wolf, P. A., Cobain, M., Massaro, J. M., & Kannel, W. B. (2008). General cardiovascular risk profile for use in primary care: the Framingham Heart Study. Circulation, 117(6), 743-753.*/;

data fhscvd_17;
set backbone_17; 
array date_core[*] date_core:; 
array age_core[*] age_core:; 
array age_fhscvd_core[10]; 

array hdl_core[*] hdl_core:; 
array hdl_fhscvd_core[10]; 

array TC_core[*] TC_core:; 
array tc_fhscvd_core[10]; 

array smoking_core[*] smoking_core:; 
array smoking_fhscvd_core[10]; 

array Hx_dm_core[*] Hx_dm_core:; 
array dm_fhscvd_core[10]; 


array hrx_core[*] hrx_core:; 
array sbp_core[*] sbp_core:; 
array sbp_fhscvd_core[10]; 

array fhscvd_core[10]; 

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


data fsrp_17;
set prevalence_cohort17; 
array date_core[*] date_core:; 
array age_core[*] age_core:; 
array age_fsrp_core[10]; 

array sbp_core[*] sbp_core:; 
array sbp_fsrp_core[10]; 

array hrx_core[*] hrx_core:; 
array hrx_fsrp_core[10]; 

array Hx_dm_core[*] Hx_dm_core:; 
array dm_fsrp_core[10]; 

array smoking_core[*] smoking_core:; 
array smoking_fsrp_core[10]; 

array precvd_core[*] prevalent_strokerisk_core:; 
array precvd_fsrp_core[10]; 

array preaf_core[*] prevalent_af_core:; 
array preaf_fsrp_core[10]; 

array DLVH_core[*] DLVH_core:; 
array dlvh_fsrp_core[10]; 

array fsrp_core[10]; 
array revised_fsrp_core[10]; 

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
Creation of FHS Gen 2/Omni 1 curated dataset
******************************************************************************************************************************************

*Sort all datasets by using the macro-sort;
%sort(backbone_17, framid);
%sort(NP_cohort17_2, framid);
%sort(date_matching1_2, framid);
%sort(date_matching7_2, framid);
%sort(demrv_cohort17_1, framid);
%sort(chd_cohort17_1, framid);
%sort(stroke_cohort17_1, framid);
%sort(AF_cohort17_1, framid);
%sort(cancer_cohort17_1, framid);
%sort(surv_cohort17_1, framid);
%sort(prevalence_cohort17_1, framid);
%sort(fhscvd_17, framid);
%sort(fsrp_17, framid);
%sort(mmse_17_1, framid);
%sort(CESD_17, framid);
%sort(edu_17, framid);
%sort(neuropath_cohort17_1, framid);

*Read in all derived datasets to create curated dataset for FHS Gen 2/Omni 1 cohorts; 
data out1.curated_bap_17_03312024;
retain idtype id framid sex race_code race date_core1-date_core10 date_fu_core10 status_core10 age_core1-age_core10 edu_core2 edu_core8 edu_all;
merge  
backbone_17 (in=in1)
NP_cohort17_2
date_matching1_2
date_matching7_2
demrv_cohort17_1
chd_cohort17_1
stroke_cohort17_1
AF_cohort17_1
cancer_cohort17_1
surv_cohort17_1
prevalence_cohort17_1
fhscvd_17
fsrp_17
mmse_17_1
CESD_17
edu_17
neuropath_cohort17_1; 

by framid; 
if neuropath_avail = . then neuropath_avail = 0;  
*One Omni 1 participant did not show up for the baseline clinic visit, standard FHS practice removes this participant;
if idtype = 7 and date_core5 = . then delete; 
if in1;
run; 



*Check format and accuracy; 
proc print data=out1.curated_bap_17_03312024;
*Should have 1 observations with 12 NP assessments; 
where examdate_np12 ne .;
run; 

*Remove label for csv file; 
data csv_curated_17; 
set out1.curated_bap_17_03312024;
run; 
proc datasets lib=work memtype=data;
   modify csv_curated_17;
     attrib _all_ label=' ';
run;
quit;
PROC EXPORT DATA= WORK.csv_curated_17
            OUTFILE= "C:\Users\angtf\Desktop\Test_SAS\Output_data\curated_bap_17_03312024_nolabel.csv" 
            DBMS=CSV LABEL REPLACE;
     PUTNAMES=YES;
RUN;


