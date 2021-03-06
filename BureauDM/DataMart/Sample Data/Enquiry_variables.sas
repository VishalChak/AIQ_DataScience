��   Enquiry_variables.sas C:\Users\V3040\Desktop\Enquiry_variables.sas    ?   C:\Users\SHIVAN~1\AppData\Local\Temp\Enquiry_variables (2).sas ��  libname agn2 "G:\User_folder\V3040\bureau agnostic overall\Data\SAS data";
options compress=yes;

proc sql;
select count(*),count(distinct Masked_Key) 
from agn2.CIBIL_ENQ_JUL12_MAR14_PRIM;
quit; 
/*2033204, 267921 */

data agn2.CIBIL_ENQ_JUL12_MAR14_PRIM;
set agn2.CIBIL_ENQ_JUL12_MAR14_PRIM;
format LAA_Date $10.;
LAA_Date =substr(LAA_FIELD_6,1,10);
run;
/*2033752*/

data agn2.CIBIL_ENQ_JUL12_MAR14_PRIM;
set agn2.CIBIL_ENQ_JUL12_MAR14_PRIM;
format LAA_date1 date9.;
if length(compress(put(LAA_Date,$20.)))=10 then 
LAA_date1=input(compress(substr(compress(put(LAA_Date,$20.)),1,2)||'/'||substr(compress(put(LAA_Date,$20.)),4,2)||'/'||substr(compress(put(LAA_Date,$20.)),7,4)),ddmmyy10.);
run;

data agn2.Cibil_enq_jul12_mar14_prim;
set agn2.Cibil_enq_jul12_mar14_prim;
where Masked_Key ne .;
run;
/*2033751*/

/*checks and filters**/
data agn2.Cibil_enq_jul12_mar14_prim;
set agn2.Cibil_enq_jul12_mar14_prim;
where DATE_OF_ENQUIRY_IQ <=LAA_date1;
run;
/*547 cases lost- 2033204**/

proc sql;
select count(*) from agn2.Cibil_enq_jul12_mar14_prim
where DATE_OF_ENQUIRY_IQ =LAA_date1;
quit;
/*37335*/

proc  freq data =agn2.Cibil_enq_jul12_mar14_prim order=freq;
tables  ENQUIRY_PURPOSE_IQ*ENQ_MEMBER_SHORT_NAME_IQ/norow nocol nocum ;
run;

proc means data=agn2.Cibil_enq_jul12_mar14_prim n nmiss min max mean p1 p10 p5 p25 p50 p75 p90 p95 p99;
var ENQIURY_AMOUNT_IQ;
run;

proc means data=agn2.Cibil_enq_jul12_mar14_prim n nmiss min max mean p1 p5 p10 p25 p50 p75 p90 p95 p99;
var ENQIURY_AMOUNT_IQ;
class ENQUIRY_PURPOSE_IQ;
run;

data agn2.Cibil_enq_jul12_mar14_prim;
set agn2.Cibil_enq_jul12_mar14_prim;
drop enq_date enq_amt IQ_D_MIS_DATE;
run;

data agn2.Cibil_enq_jul12_mar14_prim;
set agn2.Cibil_enq_jul12_mar14_prim;
rename DATE_OF_ENQUIRY_IQ=enq_date;
rename ENQIURY_AMOUNT_IQ=enq_amt;
run;

data agn2.Cibil_enq_jul12_mar14_prim;
set agn2.Cibil_enq_jul12_mar14_prim;

format int_flag 1.;
if ENQ_MEMBER_SHORT_NAME_IQ = "HDFC BANK" then int_flag = 1;
else int_flag = 0;

format enq_time best12.;
enq_time = round((LAA_date1-enq_date)/30.5);

run;

data agn2.Cibil_enq_jul12_mar14_prim;
set agn2.Cibil_enq_jul12_mar14_prim;
format V_F_CIBIL_ENQ_PURP $150.;
if ENQUIRY_PURPOSE_IQ in ("CONSUMER LOAN","Consumer Loan") then V_F_CIBIL_ENQ_PURP="CONSUMER LOAN"; 
else if ENQUIRY_PURPOSE_IQ in ("BUSINESS LOAN-PRIORIT","BUSINESS LOAN-PRIORITY SECTOR-OTHERS",
"Business Loan ? Priority Sector ? Others",
"Business Non-Funded Credit Facility ? Priority Sector ?",
"Business Loan ? Priority Sector ? Agriculture",
"BUSINESS LOAN-PRIORIT","BUSINESS LOAN-PRIORITY SECTOR-OTHERS",
"Business Loan ? Priority Sector ? Others",
"Business Non-Funded Credit Facility ? Priority Sector ?",
"BUSINESS LOAN-PRIORITY SECTOR-SMALL BUSINESS",
"Business Loan ? Priority Sector ? Small Business",
"Non-Funded Credit Facility","NON-FUNDED CREDIT FACILITY",
"NON-FUNDED CREDIT FAC",
"Business Non-Funded Credit Facility-Priority Sector-Oth",
"BUSINESS NON-FUNDED CREDIT FACILITY-PRIORITY-SECT",
"BUSINESS NON-FUNDED CREDIT FACILITY-PRIORITY-SECTO",
"BUSINESS NON-FUNDED CREDIT FACILITY-PRIORITY-SECT",
"Business Non-Funded Credit Facility ? Priority Sector ?",
"Non-Funded Credit Facility","NON-FUNDED CREDIT FACILITY",
"NON-FUNDED CREDIT FAC","BUSINESS LOAN AGAINST","BUSINESS LOAN AGAINST BANK DEPOSITS",
"Business Loan Against Bank Deposits")
then V_F_CIBIL_ENQ_PURP="BUSINESS LOAN-PRIORITY SECTOR-OTHERS";
else if ENQUIRY_PURPOSE_IQ in ("Personal Loan") then V_F_CIBIL_ENQ_PURP="Personal Loan";
else if ENQUIRY_PURPOSE_IQ in ("Auto Loan") then V_F_CIBIL_ENQ_PURP="Auto Loan";

else if ENQUIRY_PURPOSE_IQ in ("Loan Against Bank Deposits","LOAN AGAINST BANK DEPOSITS",
"LOAN AGAINST BANK DEP") then V_F_CIBIL_ENQ_PURP="LOAN AGAINST BANK DEPOSITS";

else if ENQUIRY_PURPOSE_IQ in ("CREDIT CARD","Credit Card") then V_F_CIBIL_ENQ_PURP="CREDIT CARD";
else if ENQUIRY_PURPOSE_IQ in ("Housing Loan","HOUSING LOAN") then V_F_CIBIL_ENQ_PURP="HOUSING LOAN";
else if ENQUIRY_PURPOSE_IQ in ("BUSINESS LOAN-GENERAL","Business Loan ? General",
"BUSINESS NON-FUNDED C","BUSINESS NON-FUNDED CREDIT FACILITY-GENERAL",
"Business Non-Funded Credit Facility ? General") then V_F_CIBIL_ENQ_PURP="BUSINESS LOAN-GENERAL";
else if ENQUIRY_PURPOSE_IQ in ("Two-wheeler Loan","Two Wheeler") then V_F_CIBIL_ENQ_PURP="Two Wheeler";
else if ENQUIRY_PURPOSE_IQ in ("NA","Other","OTHER","Fleet Card","FLEET CARD",
"Leasing","LEASING") then V_F_CIBIL_ENQ_PURP="OTHER";
else if ENQUIRY_PURPOSE_IQ in ("PROPERTY LOAN","Property Loan") then V_F_CIBIL_ENQ_PURP="PROPERTY LOAN";
else if ENQUIRY_PURPOSE_IQ in ("CVT","Commercial Vehicle Loan") then V_F_CIBIL_ENQ_PURP="Commercial Vehicle Loan"; 
else if ENQUIRY_PURPOSE_IQ in ("Overdraft","OVERDRAFT") then V_F_CIBIL_ENQ_PURP="OVERDRAFT";
else if ENQUIRY_PURPOSE_IQ in ("EDUCATION LOAN","Education Loan") then V_F_CIBIL_ENQ_PURP="EDUCATION LOAN"; 
else if ENQUIRY_PURPOSE_IQ in ("GOLD LOAN","Gold Loan") then V_F_CIBIL_ENQ_PURP="GOLD LOAN"; 
else if ENQUIRY_PURPOSE_IQ in ("FEQ") then V_F_CIBIL_ENQ_PURP="FEQ"; 
else if ENQUIRY_PURPOSE_IQ in ("LOAN AGAINST SHARES/S",
"LOAN AGAINST SHARES/SECURITIES","Loan Against Shares/Securities") 
then V_F_CIBIL_ENQ_PURP="LOAN AGAINST SHARES/SECURITIES";
else if ENQUIRY_PURPOSE_IQ in ("LOAN TO PROFESSIONAL","Loan to Professional") then V_F_CIBIL_ENQ_PURP="LOAN TO PROFESSIONAL";
run;

proc freq data=agn2.Cibil_enq_jul12_mar14_prim;
tables ENQUIRY_PURPOSE_IQ*V_F_CIBIL_ENQ_PURP / norow nocol nocum nopercent missing;
run;

proc sql;
select distinct V_F_CIBIL_ENQ_PURP from 
agn2.Cibil_enq_jul12_mar14_prim;
quit;

proc import datafile ="G:\User_folder\V3040\bureau agnostic overall\Data\Masters.xls"
out =  enq_master
dbms = 	xls replace;
sheet = 'Enq Master';
run;

proc sort data= enq_master nodupkey ;
by V_F_CIBIL_ENQ_PURP;
run;

proc sort data= agn2.Cibil_enq_jul12_mar14_prim;
by V_F_CIBIL_ENQ_PURP;
run;

proc sql;
create table agn2.CIBIL_ENQ_JUL12_MAR14_PRIM  as 
select 	a.*,b.Sec_Unsec_Flag as enq_flag ,b.Cash_loan_flag
from  agn2.Cibil_enq_jul12_mar14_prim as a 
left outer join enq_master as b 
on (a.V_F_CIBIL_ENQ_PURP = b.V_F_CIBIL_ENQ_PURP);
quit;


proc sql;
create table agn2.CIBIL_ENQ_JUL12_MAR14_PRIM as
select *,
max(enq_amt) as max_enq_amt,
max(enq_date) as max_enq_date format date9.
from agn2.CIBIL_ENQ_JUL12_MAR14_PRIM
group by MASKED_KEY;
quit;


proc sql;
create table agn2.merged_enquiry_rollup as 
select MASKED_KEY,

/************count related variables*****************/

Count(*) as All_enq,
sum(case when int_flag=1 then 1 else 0 end) as HDFC_enq,
sum(case when int_flag=0 then 1 else 0 end) as Othbk_enq,


sum(case when V_F_CIBIL_ENQ_PURP = "Auto Loan" then 1 else 0 end) as AL_enq,
sum(case when V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as HL_enq,
sum(case when V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as PL_enq,
sum(case when V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then 1 else 0 end) as CC_enq,
sum(case when V_F_CIBIL_ENQ_PURP = "BUSINESS LOAN-GENERAL" then 1 else 0 end) as BL_enq,
sum(case when V_F_CIBIL_ENQ_PURP = "Two Wheeler" then 1 else 0 end) as TW_enq,
sum(case when V_F_CIBIL_ENQ_PURP = "CONSUMER LOAN" then 1 else 0 end) as Consu_enq,
sum(case when Cash_loan_flag = "Y" then 1 else 0 end) as CL_enq,
sum(case when enq_flag = "Sec" then 1 else 0 end) as Sec_enq,
sum(case when enq_flag = "Unsec" then 1 else 0 end) as Unsec_enq,

sum(case when enq_time <= 3 then 1 else 0 end) as L3m_enq,
sum(case when enq_time <= 6 then 1 else 0 end) as L6m_enq,
sum(case when enq_time <= 9 then 1 else 0 end) as L9m_enq,
sum(case when enq_time <= 12 then 1 else 0 end) as L12m_enq,
sum(case when enq_time <= 24 then 1 else 0 end) as L24m_enq,
sum(case when enq_time <= 36 then 1 else 0 end) as L36m_enq,

sum(case when int_flag=1 and enq_time <= 3 then 1 else 0 end) as HDFC_L3m_enq,
sum(case when int_flag=1 and enq_time <= 6 then 1 else 0 end) as HDFC_L6m_enq,
sum(case when int_flag=1 and enq_time <= 9 then 1 else 0 end) as HDFC_L9m_enq,
sum(case when int_flag=1 and enq_time <= 12 then 1 else 0 end) as HDFC_L12m_enq,
sum(case when int_flag=1 and enq_time <= 24 then 1 else 0 end) as HDFC_L24m_enq,
sum(case when int_flag=1 and enq_time <= 36 then 1 else 0 end) as HDFC_L36m_enq,

sum(case when int_flag=0 and enq_time <= 3 then 1 else 0 end) as Othbk_L3m_enq,
sum(case when int_flag=0 and enq_time <= 6 then 1 else 0 end) as Othbk_L6m_enq,
sum(case when int_flag=0 and enq_time <= 9 then 1 else 0 end) as Othbk_L9m_enq,
sum(case when int_flag=0 and enq_time <= 12 then 1 else 0 end) as Othbk_L12m_enq,
sum(case when int_flag=0 and enq_time <= 24 then 1 else 0 end) as Othbk_L24m_enq,
sum(case when int_flag=0 and enq_time <= 36 then 1 else 0 end) as Othbk_L36m_enq,

sum(case when int_flag=1 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then 1 else 0 end) as HDFC_AL_enq,
sum(case when int_flag=1 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as HDFC_HL_enq,
sum(case when int_flag=1 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as HDFC_PL_enq,
sum(case when int_flag=1 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then 1 else 0 end) as HDFC_CC_enq,
sum(case when int_flag=1 and enq_flag = "Sec" then 1 else 0 end) as HDFC_Sec_enq,
sum(case when int_flag=1 and enq_flag = "Unsec" then 1 else 0 end) as HDFC_Unsec_enq,

sum(case when int_flag=0 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then 1 else 0 end) as Othbk_AL_enq,
sum(case when int_flag=0 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as Othbk_HL_enq,
sum(case when int_flag=0 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as Othbk_PL_enq,
sum(case when int_flag=0 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then 1 else 0 end) as Othbk_CC_enq,
sum(case when int_flag=0 and enq_flag = "Sec" then 1 else 0 end) as Othbk_Sec_enq,
sum(case when int_flag=0 and enq_flag = "Unsec" then 1 else 0 end) as Othbk_Unsec_enq,

/**/
sum(case when enq_time <= 3 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then 1 else 0 end) as L3m_AL_enq,
sum(case when enq_time <= 3 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as L3m_HL_enq,
sum(case when enq_time <= 3 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as L3m_PL_enq,
sum(case when enq_time <= 3 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then 1 else 0 end) as L3m_CC_enq,
sum(case when enq_time <= 3 and enq_flag = "Sec" then 1 else 0 end) as L3m_Sec_enq,
sum(case when enq_time <= 3 and enq_flag = "Unsec" then 1 else 0 end) as L3m_Unsec_enq,

sum(case when enq_time <= 6 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then 1 else 0 end) as L6m_AL_enq,
sum(case when enq_time <= 6 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as L6m_HL_enq,
sum(case when enq_time <= 6 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as L6m_PL_enq,
sum(case when enq_time <= 6 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then 1 else 0 end) as L6m_CC_enq,
sum(case when enq_time <= 6 and enq_flag = "Sec" then 1 else 0 end) as L6m_Sec_enq,
sum(case when enq_time <= 6 and enq_flag = "Unsec" then 1 else 0 end) as L6m_Unsec_enq,

sum(case when enq_time <= 9 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then 1 else 0 end) as L9m_AL_enq,
sum(case when enq_time <= 9 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as L9m_HL_enq,
sum(case when enq_time <= 9 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as L9m_PL_enq,
sum(case when enq_time <= 9 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then 1 else 0 end) as L9m_CC_enq,
sum(case when enq_time <= 9 and enq_flag = "Sec" then 1 else 0 end) as L9m_Sec_enq,
sum(case when enq_time <= 9 and enq_flag = "Unsec" then 1 else 0 end) as L9m_Unsec_enq,

sum(case when enq_time <= 12 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then 1 else 0 end) as L12m_AL_enq,
sum(case when enq_time <= 12 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as L12m_HL_enq,
sum(case when enq_time <= 12 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as L12m_PL_enq,
sum(case when enq_time <= 12 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then 1 else 0 end) as L12m_CC_enq,
sum(case when enq_time <= 12 and enq_flag = "Sec" then 1 else 0 end) as L12m_Sec_enq,
sum(case when enq_time <= 12 and enq_flag = "Unsec" then 1 else 0 end) as L12m_Unsec_enq,

sum(case when enq_time <= 24 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then 1 else 0 end) as L24m_AL_enq,
sum(case when enq_time <= 24 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as L24m_HL_enq,
sum(case when enq_time <= 24 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as L24m_PL_enq,
sum(case when enq_time <= 24 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then 1 else 0 end) as L24m_CC_enq,
sum(case when enq_time <= 24 and enq_flag = "Sec" then 1 else 0 end) as L24m_Sec_enq,
sum(case when enq_time <= 24 and enq_flag = "Unsec" then 1 else 0 end) as L24m_Unsec_enq,

sum(case when enq_time <= 36 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then 1 else 0 end) as L36m_AL_enq,
sum(case when enq_time <= 36 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as L36m_HL_enq,
sum(case when enq_time <= 36 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as L36m_PL_enq,
sum(case when enq_time <= 36 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then 1 else 0 end) as L36m_CC_enq,
sum(case when enq_time <= 36 and enq_flag = "Sec" then 1 else 0 end) as L36m_Sec_enq,
sum(case when enq_time <= 36 and enq_flag = "Unsec" then 1 else 0 end) as L36m_Unsec_enq,


/**/
sum(case when int_flag=0 and enq_time <= 3 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then 1 else 0 end) as Othbk_L3m_AL_enq,
sum(case when int_flag=0 and enq_time <= 3 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as Othbk_L3m_HL_enq,
sum(case when int_flag=0 and enq_time <= 3 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as Othbk_L3m_PL_enq,
sum(case when int_flag=0 and enq_time <= 3 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then 1 else 0 end) as Othbk_L3m_CC_enq,
sum(case when int_flag=0 and enq_time <= 3 and enq_flag = "Sec" then 1 else 0 end) as Othbk_L3m_Sec_enq,
sum(case when int_flag=0 and enq_time <= 3 and enq_flag = "Unsec" then 1 else 0 end) as Othbk_L3m_Unsec_enq,

sum(case when int_flag=0 and enq_time <= 6 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then 1 else 0 end) as Othbk_L6m_AL_enq,
sum(case when int_flag=0 and enq_time <= 6 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as Othbk_L6m_HL_enq,
sum(case when int_flag=0 and enq_time <= 6 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as Othbk_L6m_PL_enq,
sum(case when int_flag=0 and enq_time <= 6 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then 1 else 0 end) as Othbk_L6m_CC_enq,
sum(case when int_flag=0 and enq_time <= 6 and enq_flag = "Sec" then 1 else 0 end) as Othbk_L6m_Sec_enq,
sum(case when int_flag=0 and enq_time <= 6 and enq_flag = "Unsec" then 1 else 0 end) as Othbk_L6m_Unsec_enq,

sum(case when int_flag=0 and enq_time <= 9 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then 1 else 0 end) as Othbk_L9m_AL_enq,
sum(case when int_flag=0 and enq_time <= 9 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as Othbk_L9m_HL_enq,
sum(case when int_flag=0 and enq_time <= 9 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as Othbk_L9m_PL_enq,
sum(case when int_flag=0 and enq_time <= 9 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then 1 else 0 end) as Othbk_L9m_CC_enq,
sum(case when int_flag=0 and enq_time <= 9 and enq_flag = "Sec" then 1 else 0 end) as Othbk_L9m_Sec_enq,
sum(case when int_flag=0 and enq_time <= 9 and enq_flag = "Unsec" then 1 else 0 end) as Othbk_L9m_Unsec_enq,

sum(case when int_flag=0 and enq_time <= 12 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then 1 else 0 end) as Othbk_L12m_AL_enq,
sum(case when int_flag=0 and enq_time <= 12 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as Othbk_L12m_HL_enq,
sum(case when int_flag=0 and enq_time <= 12 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as Othbk_L12m_PL_enq,
sum(case when int_flag=0 and enq_time <= 12 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then 1 else 0 end) as Othbk_L12m_CC_enq,
sum(case when int_flag=0 and enq_time <= 12 and enq_flag = "Sec" then 1 else 0 end) as Othbk_L12m_Sec_enq,
sum(case when int_flag=0 and enq_time <= 12 and enq_flag = "Unsec" then 1 else 0 end) as Othbk_L12m_Unsec_enq,

sum(case when int_flag=0 and enq_time <= 24 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then 1 else 0 end) as Othbk_L24m_AL_enq,
sum(case when int_flag=0 and enq_time <= 24 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as Othbk_L24m_HL_enq,
sum(case when int_flag=0 and enq_time <= 24 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as Othbk_L24m_PL_enq,
sum(case when int_flag=0 and enq_time <= 24 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then 1 else 0 end) as Othbk_L24m_CC_enq,
sum(case when int_flag=0 and enq_time <= 24 and enq_flag = "Sec" then 1 else 0 end) as Othbk_L24m_Sec_enq,
sum(case when int_flag=0 and enq_time <= 24 and enq_flag = "Unsec" then 1 else 0 end) as Othbk_L24m_Unsec_enq,

sum(case when int_flag=0 and enq_time <= 36 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then 1 else 0 end) as Othbk_L36m_AL_enq,
sum(case when int_flag=0 and enq_time <= 36 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as Othbk_L36m_HL_enq,
sum(case when int_flag=0 and enq_time <= 36 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as Othbk_L36m_PL_enq,
sum(case when int_flag=0 and enq_time <= 36 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then 1 else 0 end) as Othbk_L36m_CC_enq,
sum(case when int_flag=0 and enq_time <= 36 and enq_flag = "Sec" then 1 else 0 end) as Othbk_L36m_Sec_enq,
sum(case when int_flag=0 and enq_time <= 36 and enq_flag = "Unsec" then 1 else 0 end) as Othbk_L36m_Unsec_enq,


/************Amount related variables*****************/

sum(enq_amt) as All_Enq_amt,
sum(case when int_flag=1 then enq_amt else 0 end) as HDFC_enq_amt,
sum(case when int_flag=0 then enq_amt else 0 end) as Othbk_enq_amt,

sum(case when V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_amt else 0 end) as AL_enq_amt,
sum(case when V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_amt else 0 end) as HL_enq_amt,
sum(case when V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_amt else 0 end) as PL_enq_amt,
sum(case when V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_amt else 0 end) as CC_enq_amt,
sum(case when V_F_CIBIL_ENQ_PURP = "BUSINESS LOAN-GENERAL" then enq_amt else 0 end) as BL_enq_amt,
sum(case when V_F_CIBIL_ENQ_PURP = "Two Wheeler" then enq_amt else 0 end) as TW_enq_amt,
sum(case when V_F_CIBIL_ENQ_PURP = "CONSUMER LOAN" then enq_amt else 0 end) as Consu_enq_amt,
sum(case when Cash_loan_flag = "Y" then enq_amt else 0 end) as CL_enq_amt,
sum(case when enq_flag = "Sec" then enq_amt else 0 end) as Sec_enq_amt,
sum(case when enq_flag = "Unsec" then enq_amt else 0 end) as Unsec_enq_amt,

sum(case when enq_time <= 3 then enq_amt else 0 end) as L3m_enq_amt,
sum(case when enq_time <= 6 then enq_amt else 0 end) as L6m_enq_amt,
sum(case when enq_time <= 9 then enq_amt else 0 end) as L9m_enq_amt,
sum(case when enq_time <= 12 then enq_amt else 0 end) as L12m_enq_amt,
sum(case when enq_time <= 24 then enq_amt else 0 end) as L24m_enq_amt,
sum(case when enq_time <= 36 then enq_amt else 0 end) as L36m_enq_amt,

sum(case when int_flag=1 and enq_time <= 3 then enq_amt else 0 end) as HDFC_L3m_enq_amt,
sum(case when int_flag=1 and enq_time <= 6 then enq_amt else 0 end) as HDFC_L6m_enq_amt,
sum(case when int_flag=1 and enq_time <= 9 then enq_amt else 0 end) as HDFC_L9m_enq_amt,
sum(case when int_flag=1 and enq_time <= 12 then enq_amt else 0 end) as HDFC_L12m_enq_amt,
sum(case when int_flag=1 and enq_time <= 24 then enq_amt else 0 end) as HDFC_L24m_enq_amt,
sum(case when int_flag=1 and enq_time <= 36 then enq_amt else 0 end) as HDFC_L36m_enq_amt,

sum(case when int_flag=0 and enq_time <= 3 then enq_amt else 0 end) as Othbk_L3m_enq_amt,
sum(case when int_flag=0 and enq_time <= 6 then enq_amt else 0 end) as Othbk_L6m_enq_amt,
sum(case when int_flag=0 and enq_time <= 9 then enq_amt else 0 end) as Othbk_L9m_enq_amt,
sum(case when int_flag=0 and enq_time <= 12 then enq_amt else 0 end) as Othbk_L12m_enq_amt,
sum(case when int_flag=0 and enq_time <= 24 then enq_amt else 0 end) as Othbk_L24m_enq_amt,
sum(case when int_flag=0 and enq_time <= 36 then enq_amt else 0 end) as Othbk_L36m_enq_amt,

sum(case when int_flag=1 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_amt else 0 end) as HDFC_AL_enq_amt,
sum(case when int_flag=1 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_amt else 0 end) as HDFC_HL_enq_amt,
sum(case when int_flag=1 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_amt else 0 end) as HDFC_PL_enq_amt,
sum(case when int_flag=1 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_amt else 0 end) as HDFC_CC_enq_amt,
sum(case when int_flag=1 and enq_flag = "Sec" then enq_amt else 0 end) as HDFC_Sec_enq_amt,
sum(case when int_flag=1 and enq_flag = "Unsec" then enq_amt else 0 end) as HDFC_Unsec_enq_amt,

sum(case when int_flag=0 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_amt else 0 end) as Othbk_AL_enq_amt,
sum(case when int_flag=0 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_amt else 0 end) as Othbk_HL_enq_amt,
sum(case when int_flag=0 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_amt else 0 end) as Othbk_PL_enq_amt,
sum(case when int_flag=0 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_amt else 0 end) as Othbk_CC_enq_amt,
sum(case when int_flag=0 and enq_flag = "Sec" then enq_amt else 0 end) as Othbk_Sec_enq_amt,
sum(case when int_flag=0 and enq_flag = "Unsec" then enq_amt else 0 end) as Othbk_Unsec_enq_amt,

/**/
sum(case when enq_time <= 3 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_amt else 0 end) as L3m_AL_enq_amt,
sum(case when enq_time <= 3 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_amt else 0 end) as L3m_HL_enq_amt,
sum(case when enq_time <= 3 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_amt else 0 end) as L3m_PL_enq_amt,
sum(case when enq_time <= 3 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_amt else 0 end) as L3m_CC_enq_amt,
sum(case when enq_time <= 3 and enq_flag = "Sec" then enq_amt else 0 end) as L3m_Sec_enq_amt,
sum(case when enq_time <= 3 and enq_flag = "Unsec" then enq_amt else 0 end) as L3m_Unsec_enq_amt,

sum(case when enq_time <= 6 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_amt else 0 end) as L6m_AL_enq_amt,
sum(case when enq_time <= 6 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_amt else 0 end) as L6m_HL_enq_amt,
sum(case when enq_time <= 6 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_amt else 0 end) as L6m_PL_enq_amt,
sum(case when enq_time <= 6 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_amt else 0 end) as L6m_CC_enq_amt,
sum(case when enq_time <= 6 and enq_flag = "Sec" then enq_amt else 0 end) as L6m_Sec_enq_amt,
sum(case when enq_time <= 6 and enq_flag = "Unsec" then enq_amt else 0 end) as L6m_Unsec_enq_amt,

sum(case when enq_time <= 9 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_amt else 0 end) as L9m_AL_enq_amt,
sum(case when enq_time <= 9 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_amt else 0 end) as L9m_HL_enq_amt,
sum(case when enq_time <= 9 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_amt else 0 end) as L9m_PL_enq_amt,
sum(case when enq_time <= 9 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_amt else 0 end) as L9m_CC_enq_amt,
sum(case when enq_time <= 9 and enq_flag = "Sec" then enq_amt else 0 end) as L9m_Sec_enq_amt,
sum(case when enq_time <= 9 and enq_flag = "Unsec" then enq_amt else 0 end) as L9m_Unsec_enq_amt,

sum(case when enq_time <= 12 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_amt else 0 end) as L12m_AL_enq_amt,
sum(case when enq_time <= 12 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_amt else 0 end) as L12m_HL_enq_amt,
sum(case when enq_time <= 12 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_amt else 0 end) as L12m_PL_enq_amt,
sum(case when enq_time <= 12 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_amt else 0 end) as L12m_CC_enq_amt,
sum(case when enq_time <= 12 and enq_flag = "Sec" then enq_amt else 0 end) as L12m_Sec_enq_amt,
sum(case when enq_time <= 12 and enq_flag = "Unsec" then enq_amt else 0 end) as L12m_Unsec_enq_amt,

sum(case when enq_time <= 24 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_amt else 0 end) as L24m_AL_enq_amt,
sum(case when enq_time <= 24 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_amt else 0 end) as L24m_HL_enq_amt,
sum(case when enq_time <= 24 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_amt else 0 end) as L24m_PL_enq_amt,
sum(case when enq_time <= 24 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_amt else 0 end) as L24m_CC_enq_amt,
sum(case when enq_time <= 24 and enq_flag = "Sec" then enq_amt else 0 end) as L24m_Sec_enq_amt,
sum(case when enq_time <= 24 and enq_flag = "Unsec" then enq_amt else 0 end) as L24m_Unsec_enq_amt,

sum(case when enq_time <= 36 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_amt else 0 end) as L36m_AL_enq_amt,
sum(case when enq_time <= 36 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_amt else 0 end) as L36m_HL_enq_amt,
sum(case when enq_time <= 36 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_amt else 0 end) as L36m_PL_enq_amt,
sum(case when enq_time <= 36 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_amt else 0 end) as L36m_CC_enq_amt,
sum(case when enq_time <= 36 and enq_flag = "Sec" then enq_amt else 0 end) as L36m_Sec_enq_amt,
sum(case when enq_time <= 36 and enq_flag = "Unsec" then enq_amt else 0 end) as L36m_Unsec_enq_amt,


sum(case when int_flag=0 and enq_time <= 3 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_amt else 0 end) as Othbk_L3m_AL_enq_amt,
sum(case when int_flag=0 and enq_time <= 3 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_amt else 0 end) as Othbk_L3m_HL_enq_amt,
sum(case when int_flag=0 and enq_time <= 3 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_amt else 0 end) as Othbk_L3m_PL_enq_amt,
sum(case when int_flag=0 and enq_time <= 3 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_amt else 0 end) as Othbk_L3m_CC_enq_amt,
sum(case when int_flag=0 and enq_time <= 3 and enq_flag = "Sec" then enq_amt else 0 end) as Othbk_L3m_Sec_enq_amt,
sum(case when int_flag=0 and enq_time <= 3 and enq_flag = "Unsec" then enq_amt else 0 end) as Othbk_L3m_Unsec_enq_amt,

sum(case when int_flag=0 and enq_time <= 6 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_amt else 0 end) as Othbk_L6m_AL_enq_amt,
sum(case when int_flag=0 and enq_time <= 6 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_amt else 0 end) as Othbk_L6m_HL_enq_amt,
sum(case when int_flag=0 and enq_time <= 6 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_amt else 0 end) as Othbk_L6m_PL_enq_amt,
sum(case when int_flag=0 and enq_time <= 6 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_amt else 0 end) as Othbk_L6m_CC_enq_amt,
sum(case when int_flag=0 and enq_time <= 6 and enq_flag = "Sec" then enq_amt else 0 end) as Othbk_L6m_Sec_enq_amt,
sum(case when int_flag=0 and enq_time <= 6 and enq_flag = "Unsec" then enq_amt else 0 end) as Othbk_L6m_Unsec_enq_amt,

sum(case when int_flag=0 and enq_time <= 9 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_amt else 0 end) as Othbk_L9m_AL_enq_amt,
sum(case when int_flag=0 and enq_time <= 9 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_amt else 0 end) as Othbk_L9m_HL_enq_amt,
sum(case when int_flag=0 and enq_time <= 9 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_amt else 0 end) as Othbk_L9m_PL_enq_amt,
sum(case when int_flag=0 and enq_time <= 9 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_amt else 0 end) as Othbk_L9m_CC_enq_amt,
sum(case when int_flag=0 and enq_time <= 9 and enq_flag = "Sec" then enq_amt else 0 end) as Othbk_L9m_Sec_enq_amt,
sum(case when int_flag=0 and enq_time <= 9 and enq_flag = "Unsec" then enq_amt else 0 end) as Othbk_L9m_Unsec_enq_amt,

sum(case when int_flag=0 and enq_time <= 12 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_amt else 0 end) as Othbk_L12m_AL_enq_amt,
sum(case when int_flag=0 and enq_time <= 12 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_amt else 0 end) as Othbk_L12m_HL_enq_amt,
sum(case when int_flag=0 and enq_time <= 12 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_amt else 0 end) as Othbk_L12m_PL_enq_amt,
sum(case when int_flag=0 and enq_time <= 12 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_amt else 0 end) as Othbk_L12m_CC_enq_amt,
sum(case when int_flag=0 and enq_time <= 12 and enq_flag = "Sec" then enq_amt else 0 end) as Othbk_L12m_Sec_enq_amt,
sum(case when int_flag=0 and enq_time <= 12 and enq_flag = "Unsec" then enq_amt else 0 end) as Othbk_L12m_Unsec_enq_amt,

sum(case when int_flag=0 and enq_time <= 24 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_amt else 0 end) as Othbk_L24m_AL_enq_amt,
sum(case when int_flag=0 and enq_time <= 24 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_amt else 0 end) as Othbk_L24m_HL_enq_amt,
sum(case when int_flag=0 and enq_time <= 24 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_amt else 0 end) as Othbk_L24m_PL_enq_amt,
sum(case when int_flag=0 and enq_time <= 24 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_amt else 0 end) as Othbk_L24m_CC_enq_amt,
sum(case when int_flag=0 and enq_time <= 24 and enq_flag = "Sec" then enq_amt else 0 end) as Othbk_L24m_Sec_enq_amt,
sum(case when int_flag=0 and enq_time <= 24 and enq_flag = "Unsec" then enq_amt else 0 end) as Othbk_L24m_Unsec_enq_amt,

sum(case when int_flag=0 and enq_time <= 36 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_amt else 0 end) as Othbk_L36m_AL_enq_amt,
sum(case when int_flag=0 and enq_time <= 36 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_amt else 0 end) as Othbk_L36m_HL_enq_amt,
sum(case when int_flag=0 and enq_time <= 36 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_amt else 0 end) as Othbk_L36m_PL_enq_amt,
sum(case when int_flag=0 and enq_time <= 36 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_amt else 0 end) as Othbk_L36m_CC_enq_amt,
sum(case when int_flag=0 and enq_time <= 36 and enq_flag = "Sec" then enq_amt else 0 end) as Othbk_L36m_Sec_enq_amt,
sum(case when int_flag=0 and enq_time <= 36 and enq_flag = "Unsec" then enq_amt else 0 end) as Othbk_L36m_Unsec_enq_amt,

/*************time related variables******************/


min(enq_time) as All_min_enq_time,
min(case when int_flag=1 then enq_time else . end) as HDFC_min_enq_time,
min(case when int_flag=0 then enq_time else . end) as Othbk_min_enq_time,

min(case when V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_time else . end) as AL_min_enq_time,
min(case when V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_time else . end) as HL_min_enq_time,
min(case when V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_time else . end) as PL_min_enq_time,
min(case when V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_time else . end) as CC_min_enq_time,
min(case when V_F_CIBIL_ENQ_PURP = "BUSINESS LOAN-GENERAL" then enq_time else . end) as BL_min_enq_time,
min(case when V_F_CIBIL_ENQ_PURP = "Two Wheeler" then enq_time else . end) as TW_min_enq_time,
min(case when V_F_CIBIL_ENQ_PURP = "CONSUMER LOAN" then enq_time else . end) as Consu_min_enq_time,
min(case when Cash_loan_flag = "Y" then enq_time else . end) as CL_min_enq_time,
min(case when enq_flag = "Sec" then enq_time else . end) as Sec_min_enq_time,
min(case when enq_flag = "Unsec" then enq_time else . end) as Unsec_min_enq_time,

min(case when int_flag=1 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_time else . end) as HDFC_AL_min_enq_time,
min(case when int_flag=1 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_time else . end) as HDFC_HL_min_enq_time,
min(case when int_flag=1 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_time else . end) as HDFC_PL_min_enq_time,
min(case when int_flag=1 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_time else . end) as HDFC_CC_min_enq_time,
min(case when int_flag=1 and enq_flag = "Sec" then enq_time else . end) as HDFC_Sec_min_enq_time,
min(case when int_flag=1 and enq_flag = "Unsec" then enq_time else . end) as HDFC_Unsec_min_enq_time,

min(case when int_flag=0 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_time else . end) as Othbk_AL_min_enq_time,
min(case when int_flag=0 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_time else . end) as Othbk_HL_min_enq_time,
min(case when int_flag=0 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_time else . end) as Othbk_PL_min_enq_time,
min(case when int_flag=0 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_time else . end) as Othbk_CC_min_enq_time,
min(case when int_flag=0 and enq_flag = "Sec" then enq_time else . end) as Othbk_Sec_min_enq_time,
min(case when int_flag=0 and enq_flag = "Unsec" then enq_time else . end) as Othbk_Unsec_min_enq_time,

max(enq_time) as All_max_enq_time,
max(case when int_flag=1 then enq_time else . end) as HDFC_max_enq_time,
max(case when int_flag=0 then enq_time else . end) as Othbk_max_enq_time,

max(case when V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_time else . end) as AL_max_enq_time,
max(case when V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_time else . end) as HL_max_enq_time,
max(case when V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_time else . end) as PL_max_enq_time,
max(case when V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_time else . end) as CC_max_enq_time,
max(case when V_F_CIBIL_ENQ_PURP = "BUSINESS LOAN-GENERAL" then enq_time else . end) as BL_max_enq_time,
max(case when V_F_CIBIL_ENQ_PURP = "Two Wheeler" then enq_time else . end) as TW_max_enq_time,
max(case when V_F_CIBIL_ENQ_PURP = "CONSUMER LOAN" then enq_time else . end) as Consu_max_enq_time,
max(case when Cash_loan_flag = "Y" then enq_time else . end) as CC_max_enq_time,
max(case when enq_flag = "Sec" then enq_time else . end) as Sec_max_enq_time,
max(case when enq_flag = "Unsec" then enq_time else . end) as Unsec_max_enq_time,

max(case when int_flag=1 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_time else . end) as HDFC_AL_max_enq_time,
max(case when int_flag=1 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_time else . end) as HDFC_HL_max_enq_time,
max(case when int_flag=1 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_time else . end) as HDFC_PL_max_enq_time,
max(case when int_flag=1 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_time else . end) as HDFC_CC_max_enq_time,
max(case when int_flag=1 and enq_flag = "Sec" then enq_time else . end) as HDFC_Sec_max_enq_time,
max(case when int_flag=1 and enq_flag = "Unsec" then enq_time else . end) as HDFC_Unsec_max_enq_time,

max(case when int_flag=0 and V_F_CIBIL_ENQ_PURP = "Auto Loan" then enq_time else . end) as Othbk_AL_max_enq_time,
max(case when int_flag=0 and V_F_CIBIL_ENQ_PURP in ("HOUSING LOAN","PROPERTY LOAN") then enq_time else . end) as Othbk_HL_max_enq_time,
max(case when int_flag=0 and V_F_CIBIL_ENQ_PURP = "Personal Loan" then enq_time else . end) as Othbk_PL_max_enq_time,
max(case when int_flag=0 and V_F_CIBIL_ENQ_PURP = "CREDIT CARD" then enq_time else . end) as Othbk_CC_max_enq_time,
max(case when int_flag=0 and enq_flag = "Sec" then enq_time else . end) as Othbk_Sec_max_enq_time,
max(case when int_flag=0 and enq_flag = "Unsec" then enq_time else . end) as Othbk_Unsec_max_enq_time,

max(case when enq_amt=max_enq_amt then enq_date else . end) as max_enq_dt_enq_amt format date9.,
sum(case when (max_enq_date=enq_date) and V_F_CIBIL_ENQ_PURP = "Personal Loan" then 1 else 0 end) as rec_enq_pl_cnt,

max(enq_date) as max_enq_date format date9.,
min(enq_date) as min_enq_date format date9.,

/*Unsecured loans-count and amount**/
sum(case when int_flag=0 and enq_flag = "Unsec" and V_F_CIBIL_ENQ_PURP ne "CREDIT CARD" then enq_amt else 0 end) as Othbk_Unsec_loan_enq_amt,
sum(case when int_flag=1 and enq_flag = "Unsec" and V_F_CIBIL_ENQ_PURP ne "CREDIT CARD" then enq_amt else 0 end) as Hdfc_Unsec_loan_enq_amt,
sum(case when enq_flag = "Unsec" and V_F_CIBIL_ENQ_PURP ne "CREDIT CARD" then enq_amt else 0 end) as Unsec_loan_enq_amt,

sum(case when int_flag=0 and enq_flag = "Unsec" and V_F_CIBIL_ENQ_PURP ne "CREDIT CARD" then 1 else 0 end) as Othbk_Unsec_loan_enq_cnt,
sum(case when int_flag=1 and enq_flag = "Unsec" and V_F_CIBIL_ENQ_PURP ne "CREDIT CARD" then 1 else 0 end) as Hdfc_Unsec_loan_enq_cnt,
sum(case when enq_flag = "Unsec" and V_F_CIBIL_ENQ_PURP ne "CREDIT CARD" then 1 else 0 end) as Unsec_loan_enq_cnt


from  agn2.CIBIL_ENQ_JUL12_MAR14_PRIM
group by MASKED_KEY;
quit;

data agn2.Merged_enquiry_rollup;
set agn2.Merged_enquiry_rollup;

/*** To check the proportion of AL/HL/PL/CC/Unsec enq of the total enq-by count and value ***/

num_prop_al_all=round(AL_enq/All_enq,0.01);
num_prop_hl_all=round(HL_enq/All_enq,0.01);
num_prop_pl_all=round(PL_enq/All_enq,0.01);
num_prop_cc_all=round(CC_enq/All_enq,0.01);
num_prop_unsec_all=round(Unsec_enq/All_enq,0.01);
amt_prop_al_all=round(AL_enq_amt/All_enq_amt,0.01);
amt_prop_hl_all=round(HL_enq_amt/All_enq_amt,0.01);
amt_prop_pl_all=round(PL_enq_amt/All_enq_amt,0.01);
amt_prop_cc_all=round(CC_enq_amt/All_enq_amt,0.01);
amt_prop_unsec_all=round(Unsec_enq_amt/All_enq_amt,0.01);

/******No. of enquiries made per unit time********************/

if All_enq=1 then enq_unit_time= -999;
if All_enq > 1 then
enq_unit_time=round(All_enq/round((max_enq_date-min_enq_date)/30.5),0.01);/*confirm with sayan*/

/*****time since most recent maximum enquiry amount**********/

time_max_enq_amt=round((LAA_date1-max_enq_dt_enq_amt)/30.5);

run;

data agn2.Merged_enquiry_rollup;
set agn2.Merged_enquiry_rollup;

array num_enq{5} L3m_enq L6m_enq L9m_enq L12m_enq L24m_enq ;
array amt_enq{5} L3m_enq_amt L6m_enq_amt L9m_enq_amt L12m_enq_amt L24m_enq_amt ;

array num_unsec{5} L3m_Unsec_enq L6m_Unsec_enq L9m_Unsec_enq L12m_Unsec_enq L24m_Unsec_enq ;
array amt_unsec{5} L3m_Unsec_enq_amt L6m_Unsec_enq_amt L9m_Unsec_enq_amt L12m_Unsec_enq_amt L24m_Unsec_enq_amt ;

array num_cc{5} L3m_cc_enq L6m_cc_enq L9m_cc_enq L12m_cc_enq L24m_cc_enq ;
array amt_cc{5} L3m_cc_enq_amt L6m_cc_enq_amt L9m_cc_enq_amt L12m_cc_enq_amt L24m_cc_enq_amt ;

array num_pl{5} L3m_pl_enq L6m_pl_enq L9m_pl_enq L12m_pl_enq L24m_pl_enq ;
array amt_pl{5} L3m_pl_enq_amt L6m_pl_enq_amt L9m_pl_enq_amt L12m_pl_enq_amt L24m_pl_enq_amt ;

array num_al{5} L3m_al_enq L6m_al_enq L9m_al_enq L12m_al_enq L24m_al_enq ;
array amt_al{5} L3m_al_enq_amt L6m_al_enq_amt L9m_al_enq_amt L12m_al_enq_amt L24m_al_enq_amt ;

array num_hl{5} L3m_hl_enq L6m_hl_enq L9m_hl_enq L12m_hl_enq L24m_hl_enq ;
array amt_hl{5} L3m_hl_enq_amt L6m_hl_enq_amt L9m_hl_enq_amt L12m_hl_enq_amt L24m_hl_enq_amt ;

array num_prop_unsec{5} num_prop_unsec_3 num_prop_unsec_6 num_prop_unsec_9 num_prop_unsec_12 num_prop_unsec_24 ;
array amt_prop_unsec{5} amt_prop_unsec_3 amt_prop_unsec_6 amt_prop_unsec_9 amt_prop_unsec_12 amt_prop_unsec_24 ;

array num_prop_cc{5} num_prop_cc_3 num_prop_cc_6 num_prop_cc_9 num_prop_cc_12 num_prop_cc_24 ;
array amt_prop_cc{5} amt_prop_cc_3 amt_prop_cc_6 amt_prop_cc_9 amt_prop_cc_12 amt_prop_cc_24 ;

array num_prop_pl{5} num_prop_pl_3 num_prop_pl_6 num_prop_pl_9 num_prop_pl_12 num_prop_pl_24 ;
array amt_prop_pl{5} amt_prop_pl_3 amt_prop_pl_6 amt_prop_pl_9 amt_prop_pl_12 amt_prop_pl_24 ;

array num_prop_al{5} num_prop_al_3 num_prop_al_6 num_prop_al_9 num_prop_al_12 num_prop_al_24 ;
array amt_prop_al{5} amt_prop_al_3 amt_prop_al_6 amt_prop_al_9 amt_prop_al_12 amt_prop_al_24 ;

array num_prop_hl{5} num_prop_hl_3 num_prop_hl_6 num_prop_hl_9 num_prop_hl_12 num_prop_hl_24 ;
array amt_prop_hl{5} amt_prop_hl_3 amt_prop_hl_6 amt_prop_hl_9 amt_prop_hl_12 amt_prop_hl_24 ;


do i = 1 to 5;

num_prop_unsec{i} = num_unsec{i}/num_enq{i};
amt_prop_unsec{i} = amt_unsec{i}/amt_enq{i};

num_prop_cc{i} = num_cc{i}/num_enq{i};
amt_prop_cc{i} = amt_cc{i}/amt_enq{i};

num_prop_pl{i} = num_pl{i}/num_enq{i};
amt_prop_pl{i} = amt_pl{i}/amt_enq{i};

num_prop_al{i} = num_al{i}/num_enq{i};
amt_prop_al{i} = amt_al{i}/amt_enq{i};

num_prop_hl{i} = num_hl{i}/num_enq{i};
amt_prop_hl{i} = amt_hl{i}/amt_enq{i};

end;

run;

data agn2.Merged_enquiry_rollup;
set agn2.Merged_enquiry_rollup;

format r_enq_3_6 best12.;
format r_cc_enq_3_6 best12.;
format r_pl_enq_3_6 best12.;
format r_unsec_enq_3_6 best12.;

format r_enq_6_12 best12.;
format r_cc_enq_6_12 best12.;
format r_pl_enq_6_12 best12.;
format r_unsec_enq_6_12 best12.;


 r_enq_3_6 =round(L3m_enq/L6m_enq,0.01);
 r_cc_enq_3_6 =round(L3m_CC_enq/L6m_CC_enq,0.01);
 r_pl_enq_3_6 =round(L3m_PL_enq/L6m_PL_enq,0.01);
 r_unsec_enq_3_6 =round(L3m_Unsec_enq/L6m_Unsec_enq,0.01);

 r_enq_6_12 =round(L6m_enq/L12m_enq,0.01);
 r_cc_enq_6_12 =round(L6m_CC_enq/L12m_CC_enq,0.01);
 r_pl_enq_6_12 =round(L6m_PL_enq/L12m_PL_enq,0.01);
 r_unsec_enq_6_12 =round(L6m_Unsec_enq/L12m_Unsec_enq,0.01);

 run;


data agn2.Merged_enquiry_rollup;
set agn2.Merged_enquiry_rollup;

/*** To check the proportion of PL and CC enq of the total UNSEC enq-by count and value ***/

num_prop_pl_unsec=round(PL_enq/Unsec_enq,0.01);
amt_prop_pl_unsec=round(PL_enq_amt/Unsec_enq_amt,0.01);

num_prop_cc_unsec=round(CC_enq/Unsec_enq,0.01);
amt_prop_cc_unsec=round(CC_enq_amt/Unsec_enq_amt,0.01);

run;



proc sort data=agn2.Merged_enquiry_rollup;
by 