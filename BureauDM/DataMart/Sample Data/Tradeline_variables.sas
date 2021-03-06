&�  Tradeline_variables.sas C:\Users\V3040\Desktop\Tradeline_variables.sas    =   C:\Users\SHIVAN~1\AppData\Local\Temp\Tradeline_variables.sas �� 
libname agn2 "G:\User_folder\V3040\bureau agnostic overall\Data\SAS data";
options compress=yes;

/****************Variable roll ups**************/

proc sql;
create table agn2.merged_tl_rollup  as 
select Masked_Key,

/************count related variables*****************/

/****overall(Live+Closed)*****/

Count(*) as All_trades,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans,
sum(case when int_flag=1 then 1 else 0 end) as HDFC_trades,
sum(case when int_flag=0 then 1 else 0 end) as Othbk_trades,

sum(case when V_F_CIBIL_ACCT_TYPE = "Auto Loan" then 1 else 0 end) as AL_trades,
sum(case when V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as HL_trades,
sum(case when V_F_CIBIL_ACCT_TYPE = "Personal Loan" then 1 else 0 end) as PL_trades,
sum(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then 1 else 0 end) as CC_trades,
sum(case when V_F_CIBIL_ACCT_TYPE = "CONSUMER LOAN" then 1 else 0 end) as Consu_trades,
sum(case when V_F_CIBIL_ACCT_TYPE = "GOLD LOAN" then 1 else 0 end) as GL_trades,
sum(case when V_F_CIBIL_ACCT_TYPE = "Two Wheeler" then 1 else 0 end) as TW_trades,
sum(case when V_F_CIBIL_ACCT_TYPE = "BUSINESS LOAN-GENERAL" then 1 else 0 end) as BL_trades,
sum(case when Cash_loan_flag = "Y" then 1 else 0 end) as CL_trades,
sum(case when trades_flag = "Sec" then 1 else 0 end) as Sec_trades,
sum(case when trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans,

sum(case when vin_trade <= 3 then 1 else 0 end) as L3m_trades,
sum(case when vin_trade <= 6 then 1 else 0 end) as L6m_trades,
sum(case when vin_trade <= 12 then 1 else 0 end) as L12m_trades,
sum(case when vin_trade <= 24 then 1 else 0 end) as L24m_trades,
sum(case when vin_trade <= 36 then 1 else 0 end) as L36m_trades,

sum(case when int_flag=1 and vin_trade <= 3 then 1 else 0 end) as HDFC_L3m_trades,
sum(case when int_flag=1 and vin_trade <= 6 then 1 else 0 end) as HDFC_L6m_trades,
sum(case when int_flag=1 and vin_trade <= 12 then 1 else 0 end) as HDFC_L12m_trades,
sum(case when int_flag=1 and vin_trade <= 24 then 1 else 0 end) as HDFC_L24m_trades,
sum(case when int_flag=1 and vin_trade <= 36 then 1 else 0 end) as HDFC_L36m_trades,

sum(case when int_flag=0 and vin_trade <= 3 then 1 else 0 end) as Othbk_L3m_trades,
sum(case when int_flag=0 and vin_trade <= 6 then 1 else 0 end) as Othbk_L6m_trades,
sum(case when int_flag=0 and vin_trade <= 12 then 1 else 0 end) as Othbk_L12m_trades,
sum(case when int_flag=0 and vin_trade <= 24 then 1 else 0 end) as Othbk_L24m_trades,
sum(case when int_flag=0 and vin_trade <= 36 then 1 else 0 end) as Othbk_L36m_trades,

sum(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then 1 else 0 end) as HDFC_AL_trades,
sum(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as HDFC_HL_trades,
sum(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then 1 else 0 end) as HDFC_PL_trades,
sum(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then 1 else 0 end) as HDFC_CC_trades,
sum(case when int_flag=1 and trades_flag = "Sec" then 1 else 0 end) as HDFC_Sec_trades,
sum(case when int_flag=1 and trades_flag = "Unsec" then 1 else 0 end) as HDFC_Unsec_trades,

sum(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then 1 else 0 end) as Othbk_AL_trades,
sum(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as Othbk_HL_trades,
sum(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then 1 else 0 end) as Othbk_PL_trades,
sum(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then 1 else 0 end) as Othbk_CC_trades,
sum(case when int_flag=0 and trades_flag = "Sec" then 1 else 0 end) as Othbk_Sec_trades,
sum(case when int_flag=0 and trades_flag = "Unsec" then 1 else 0 end) as Othbk_Unsec_trades,

sum(case when vin_trade <= 3 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then 1 else 0 end) as L3m_AL_trades,
sum(case when vin_trade <= 3 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as L3m_HL_trades,
sum(case when vin_trade <= 3 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then 1 else 0 end) as L3m_PL_trades,
sum(case when vin_trade <= 3 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then 1 else 0 end) as L3m_CC_trades,
sum(case when vin_trade <= 3 and trades_flag = "Sec" then 1 else 0 end) as L3m_Sec_trades,
sum(case when vin_trade <= 3 and trades_flag = "Unsec" then 1 else 0 end) as L3m_Unsec_trades,

sum(case when vin_trade <= 6 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then 1 else 0 end) as L6m_AL_trades,
sum(case when vin_trade <= 6 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as L6m_HL_trades,
sum(case when vin_trade <= 6 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then 1 else 0 end) as L6m_PL_trades,
sum(case when vin_trade <= 6 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then 1 else 0 end) as L6m_CC_trades,
sum(case when vin_trade <= 6 and trades_flag = "Sec" then 1 else 0 end) as L6m_Sec_trades,
sum(case when vin_trade <= 6 and trades_flag = "Unsec" then 1 else 0 end) as L6m_Unsec_trades,

sum(case when vin_trade <= 12 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then 1 else 0 end) as L12m_AL_trades,
sum(case when vin_trade <= 12 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as L12m_HL_trades,
sum(case when vin_trade <= 12 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then 1 else 0 end) as L12m_PL_trades,
sum(case when vin_trade <= 12 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then 1 else 0 end) as L12m_CC_trades,
sum(case when vin_trade <= 12 and trades_flag = "Sec" then 1 else 0 end) as L12m_Sec_trades,
sum(case when vin_trade <= 12 and trades_flag = "Unsec" then 1 else 0 end) as L12m_Unsec_trades,

sum(case when vin_trade <= 24 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then 1 else 0 end) as L24m_AL_trades,
sum(case when vin_trade <= 24 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as L24m_HL_trades,
sum(case when vin_trade <= 24 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then 1 else 0 end) as L24m_PL_trades,
sum(case when vin_trade <= 24 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then 1 else 0 end) as L24m_CC_trades,
sum(case when vin_trade <= 24 and trades_flag = "Sec" then 1 else 0 end) as L24m_Sec_trades,
sum(case when vin_trade <= 24 and trades_flag = "Unsec" then 1 else 0 end) as L24m_Unsec_trades,

sum(case when vin_trade <= 36 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then 1 else 0 end) as L36m_AL_trades,
sum(case when vin_trade <= 36 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as L36m_HL_trades,
sum(case when vin_trade <= 36 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then 1 else 0 end) as L36m_PL_trades,
sum(case when vin_trade <= 36 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then 1 else 0 end) as L36m_CC_trades,
sum(case when vin_trade <= 36 and trades_flag = "Sec" then 1 else 0 end) as L36m_Sec_trades,
sum(case when vin_trade <= 36 and trades_flag = "Unsec" then 1 else 0 end) as L36m_Unsec_trades,


/****(Only Live)*****/

sum(case when closed_flag="N" then 1 else 0 end) as All_live_trades,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_live_loans,

sum(case when closed_flag="N" and int_flag=1 then 1 else 0 end) as HDFC_live_trades,
sum(case when closed_flag="N" and int_flag=0 then 1 else 0 end) as Othbk_live_trades,

sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then 1 else 0 end) as AL_live_trades,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as HL_live_trades,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then 1 else 0 end) as PL_live_trades,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then 1 else 0 end) as CC_live_trades,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "GOLD LOAN" then 1 else 0 end) as GL_live_trades,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "CONSUMER LOAN" then 1 else 0 end) as Consu_live_trades,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "Two Wheeler" then 1 else 0 end) as TW_live_trades,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "BUSINESS LOAN-GENERAL" then 1 else 0 end) as BL_live_trades,
sum(case when closed_flag="N" and Cash_loan_flag = "Y" then 1 else 0 end) as CL_live_trades,
sum(case when closed_flag="N" and trades_flag = "Sec" then 1 else 0 end) as Sec_live_trades,
sum(case when closed_flag="N" and trades_flag = "Unsec" then 1 else 0 end) as Unsec_live_trades,
sum(case when closed_flag="N" and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_live_loans,

sum(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then 1 else 0 end) as HDFC_AL_live_trades,
sum(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as HDFC_HL_live_trades,
sum(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then 1 else 0 end) as HDFC_PL_live_trades,
sum(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then 1 else 0 end) as HDFC_CC_live_trades,
sum(case when closed_flag="N" and int_flag=1 and trades_flag = "Sec" then 1 else 0 end) as HDFC_Sec_live_trades,
sum(case when closed_flag="N" and int_flag=1 and trades_flag = "Unsec" then 1 else 0 end) as HDFC_Unsec_live_trades,

sum(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then 1 else 0 end) as Othbk_AL_live_trades,
sum(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then 1 else 0 end) as Othbk_HL_live_trades,
sum(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then 1 else 0 end) as Othbk_PL_live_trades,
sum(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then 1 else 0 end) as Othbk_CC_live_trades,
sum(case when closed_flag="N" and int_flag=0 and trades_flag = "Sec" then 1 else 0 end) as Othbk_Sec_live_trades,
sum(case when closed_flag="N" and int_flag=0 and trades_flag = "Unsec" then 1 else 0 end) as Othbk_Unsec_live_trades,



/************High credit/sanctioned amount related variables*****************/

/****overall(Live+Closed)*****/

sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as All_loans_a,
sum(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as HDFC_loans_a,
sum(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as Othbk_loans_a,

sum(case when V_F_CIBIL_ACCT_TYPE = "Auto Loan" then loan_amt else 0 end) as AL_trades_a,
sum(case when V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then loan_amt else 0 end) as HL_trades_a,
sum(case when V_F_CIBIL_ACCT_TYPE = "Personal Loan" then loan_amt else 0 end) as PL_trades_a,
sum(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then loan_amt else 0 end) as CC_trades_a,
sum(case when V_F_CIBIL_ACCT_TYPE = "CONSUMER LOAN" then loan_amt else 0 end) as Consu_trades_a,
sum(case when V_F_CIBIL_ACCT_TYPE = "GOLD LOAN" then loan_amt else 0 end) as GL_trades_a,
sum(case when V_F_CIBIL_ACCT_TYPE = "Two Wheeler" then loan_amt else 0 end) as TW_trades_a,
sum(case when V_F_CIBIL_ACCT_TYPE = "BUSINESS LOAN-GENERAL" then loan_amt else 0 end) as BL_trades_a,
sum(case when Cash_loan_flag = "Y" then loan_amt else 0 end) as CL_trades_a,
sum(case when trades_flag = "Sec" then loan_amt else 0 end) as Sec_trades_a,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as Unsec_loans_a,

sum(case when vin_trade <= 3 then loan_amt else 0 end) as L3m_trades_a,
sum(case when vin_trade <= 6 then loan_amt else 0 end) as L6m_trades_a,
sum(case when vin_trade <= 12 then loan_amt else 0 end) as L12m_trades_a,
sum(case when vin_trade <= 24 then loan_amt else 0 end) as L24m_trades_a,
sum(case when vin_trade <= 36 then loan_amt else 0 end) as L36m_trades_a,

sum(case when int_flag=1 and vin_trade <= 3 then loan_amt else 0 end) as HDFC_L3m_trades_a,
sum(case when int_flag=1 and vin_trade <= 6 then loan_amt else 0 end) as HDFC_L6m_trades_a,
sum(case when int_flag=1 and vin_trade <= 12 then loan_amt else 0 end) as HDFC_L12m_trades_a,
sum(case when int_flag=1 and vin_trade <= 24 then loan_amt else 0 end) as HDFC_L24m_trades_a,
sum(case when int_flag=1 and vin_trade <= 36 then loan_amt else 0 end) as HDFC_L36m_trades_a,

sum(case when int_flag=0 and vin_trade <= 3 then loan_amt else 0 end) as Othbk_L3m_trades_a,
sum(case when int_flag=0 and vin_trade <= 6 then loan_amt else 0 end) as Othbk_L6m_trades_a,
sum(case when int_flag=0 and vin_trade <= 12 then loan_amt else 0 end) as Othbk_L12m_trades_a,
sum(case when int_flag=0 and vin_trade <= 24 then loan_amt else 0 end) as Othbk_L24m_trades_a,
sum(case when int_flag=0 and vin_trade <= 36 then loan_amt else 0 end) as Othbk_L36m_trades_a,

sum(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then loan_amt else 0 end) as HDFC_AL_trades_a,
sum(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then loan_amt else 0 end) as HDFC_HL_trades_a,
sum(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then loan_amt else 0 end) as HDFC_PL_trades_a,
sum(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then loan_amt else 0 end) as HDFC_CC_trades_a,
sum(case when int_flag=1 and trades_flag = "Sec" then loan_amt else 0 end) as HDFC_Sec_trades_a,
sum(case when int_flag=1 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as HDFC_Unsec_loans_a,

sum(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then loan_amt else 0 end) as Othbk_AL_trades_a,
sum(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then loan_amt else 0 end) as Othbk_HL_trades_a,
sum(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then loan_amt else 0 end) as Othbk_PL_trades_a,
sum(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then loan_amt else 0 end) as Othbk_CC_trades_a,
sum(case when int_flag=0 and trades_flag = "Sec" then loan_amt else 0 end) as Othbk_Sec_trades_a,
sum(case when int_flag=0 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as Othbk_Unsec_loans_a,

sum(case when vin_trade <= 3 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then loan_amt else 0 end) as L3m_AL_trades_a,
sum(case when vin_trade <= 3 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then loan_amt else 0 end) as L3m_HL_trades_a,
sum(case when vin_trade <= 3 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then loan_amt else 0 end) as L3m_PL_trades_a,
sum(case when vin_trade <= 3 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then loan_amt else 0 end) as L3m_CC_trades_a,
sum(case when vin_trade <= 3 and trades_flag = "Sec" then loan_amt else 0 end) as L3m_Sec_trades_a,
sum(case when vin_trade <= 3 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as L3m_Unsec_loans_a,

sum(case when vin_trade <= 6 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then loan_amt else 0 end) as L6m_AL_trades_a,
sum(case when vin_trade <= 6 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then loan_amt else 0 end) as L6m_HL_trades_a,
sum(case when vin_trade <= 6 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then loan_amt else 0 end) as L6m_PL_trades_a,
sum(case when vin_trade <= 6 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then loan_amt else 0 end) as L6m_CC_trades_a,
sum(case when vin_trade <= 6 and trades_flag = "Sec" then loan_amt else 0 end) as L6m_Sec_trades_a,
sum(case when vin_trade <= 6 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as L6m_Unsec_loans_a,

sum(case when vin_trade <= 12 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then loan_amt else 0 end) as L12m_AL_trades_a,
sum(case when vin_trade <= 12 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then loan_amt else 0 end) as L12m_HL_trades_a,
sum(case when vin_trade <= 12 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then loan_amt else 0 end) as L12m_PL_trades_a,
sum(case when vin_trade <= 12 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then loan_amt else 0 end) as L12m_CC_trades_a,
sum(case when vin_trade <= 12 and trades_flag = "Sec" then loan_amt else 0 end) as L12m_Sec_trades_a,
sum(case when vin_trade <= 12 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as L12m_Unsec_loans_a,

sum(case when vin_trade <= 24 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then loan_amt else 0 end) as L24m_AL_trades_a,
sum(case when vin_trade <= 24 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then loan_amt else 0 end) as L24m_HL_trades_a,
sum(case when vin_trade <= 24 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then loan_amt else 0 end) as L24m_PL_trades_a,
sum(case when vin_trade <= 24 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then loan_amt else 0 end) as L24m_CC_trades_a,
sum(case when vin_trade <= 24 and trades_flag = "Sec" then loan_amt else 0 end) as L24m_Sec_trades_a,
sum(case when vin_trade <= 24 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as L24m_Unsec_loans_a,

sum(case when vin_trade <= 36 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then loan_amt else 0 end) as L36m_AL_trades_a,
sum(case when vin_trade <= 36 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then loan_amt else 0 end) as L36m_HL_trades_a,
sum(case when vin_trade <= 36 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then loan_amt else 0 end) as L36m_PL_trades_a,
sum(case when vin_trade <= 36 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then loan_amt else 0 end) as L36m_CC_trades_a,
sum(case when vin_trade <= 36 and trades_flag = "Sec" then loan_amt else 0 end) as L36m_Sec_trades_a,
sum(case when vin_trade <= 36 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as L36m_Unsec_loans_a,

/*CC_new_variables**/
max(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then trade_util else . end) as CC_max_util,
min(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then trade_util else . end) as CC_min_util,
mean(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then trade_util else . end) as CC_mean_util,
max(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" and int_flag=1 then trade_util else . end) as hdfc_CC_max_util,
min(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" and int_flag=1 then trade_util else . end) as hdfc_CC_min_util,
mean(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" and int_flag=1 then trade_util else . end) as hdfc_CC_mean_util,
max(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" and int_flag=0 then trade_util else . end) as Oth_CC_max_util,
min(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" and int_flag=0 then trade_util else . end) as Oth_CC_min_util,
mean(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" and int_flag=0 then trade_util else . end) as Oth_CC_mean_util,
max(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" and closed_flag="N" then trade_util else . end) as live_CC_max_util,
min(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" and closed_flag="N" then trade_util else . end) as live_CC_min_util,
mean(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" and closed_flag="N" then trade_util else . end) as live_CC_mean_util,
max(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" and closed_flag="N" and int_flag=1 then trade_util else . end) as hdfc_live_CC_max_util,
min(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" and closed_flag="N" and int_flag=1 then trade_util else . end) as hdfc_live_CC_min_util,
mean(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" and closed_flag="N" and int_flag=1 then trade_util else . end) as hdfc_live_CC_mean_util,
max(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" and closed_flag="N" and int_flag=0 then trade_util else . end) as Oth_live_CC_max_util,
min(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" and closed_flag="N" and int_flag=0 then trade_util else . end) as Oth_live_CC_min_util,
mean(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" and closed_flag="N" and int_flag=0 then trade_util else . end) as Oth_live_CC_mean_util,


/****(Only Live)*****/

sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as All_live_loans_a,
sum(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as HDFC_live_loans_a,
sum(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as Othbk_live_loans_a,

sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then loan_amt else 0 end) as AL_live_trades_a,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then loan_amt else 0 end) as HL_live_trades_a,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then loan_amt else 0 end) as PL_live_trades_a,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then loan_amt else 0 end) as CC_live_trades_a,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "GOLD LOAN" then loan_amt else 0 end) as GL_live_trades_a,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "CONSUMER LOAN" then loan_amt else 0 end) as Consu_live_trades_a,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "BUSINESS LOAN-GENERAL" then loan_amt else 0 end) as BL_live_trades_a,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "Two Wheeler" then loan_amt else 0 end) as TW_live_trades_a,
sum(case when closed_flag="N" and Cash_loan_flag = "Y" then loan_amt else 0 end) as CL_live_trades_a,
sum(case when closed_flag="N" and trades_flag = "Sec" then loan_amt else 0 end) as Sec_live_trades_a,
sum(case when closed_flag="N" and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as Unsec_live_loans_a,

sum(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then loan_amt else 0 end) as HDFC_AL_live_trades_a,
sum(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then loan_amt else 0 end) as HDFC_HL_live_trades_a,
sum(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then loan_amt else 0 end) as HDFC_PL_live_trades_a,
sum(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then loan_amt else 0 end) as HDFC_CC_live_trades_a,
sum(case when closed_flag="N" and int_flag=1 and trades_flag = "Sec" then loan_amt else 0 end) as HDFC_Sec_live_trades_a,
sum(case when closed_flag="N" and int_flag=1 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as HDFC_Unsec_live_loans_a,

sum(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then loan_amt else 0 end) as Othbk_AL_live_trades_a,
sum(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then loan_amt else 0 end) as Othbk_HL_live_trades_a,
sum(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then loan_amt else 0 end) as Othbk_PL_live_trades_a,
sum(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then loan_amt else 0 end) as Othbk_CC_live_trades_a,
sum(case when closed_flag="N" and int_flag=0 and trades_flag = "Sec" then loan_amt else 0 end) as Othbk_Sec_live_trades_a,
sum(case when closed_flag="N" and int_flag=0 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as Othbk_Unsec_live_loans_a,


/************Curr Balance amount related variables*****************/

/****overall(Live+Closed)*****/

sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as All_loans_cbal,
sum(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as HDFC_loans_cbal,
sum(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as Othbk_loans_cbal,

sum(case when V_F_CIBIL_ACCT_TYPE = "Auto Loan" then curr_bal else . end) as AL_trades_cbal,
sum(case when V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then curr_bal else . end) as HL_trades_cbal,
sum(case when V_F_CIBIL_ACCT_TYPE = "Personal Loan" then curr_bal else . end) as PL_trades_cbal,
sum(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then curr_bal else . end) as CC_trades_cbal,
sum(case when V_F_CIBIL_ACCT_TYPE = "GOLD LOAN" then curr_bal else . end) as GL_trades_cbal,
sum(case when V_F_CIBIL_ACCT_TYPE = "CONSUMER LOAN" then curr_bal else . end) as Consu_trades_cbal,
sum(case when V_F_CIBIL_ACCT_TYPE = "BUSINESS LOAN-GENERAL" then curr_bal else . end) as BL_trades_cbal,
sum(case when V_F_CIBIL_ACCT_TYPE = "Two Wheeler" then curr_bal else . end) as TW_trades_cbal,
sum(case when Cash_loan_flag = "Y" then curr_bal else . end) as CL_trades_cbal,

sum(case when trades_flag = "Sec" then curr_bal else . end) as Sec_trades_cbal,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as Unsec_loans_cbal,

sum(case when vin_trade <= 3 then curr_bal else . end) as L3m_trades_cbal,
sum(case when vin_trade <= 6 then curr_bal else . end) as L6m_trades_cbal,
sum(case when vin_trade <= 12 then curr_bal else . end) as L12m_trades_cbal,
sum(case when vin_trade <= 24 then curr_bal else . end) as L24m_trades_cbal,
sum(case when vin_trade <= 36 then curr_bal else . end) as L36m_trades_cbal,

sum(case when int_flag=1 and vin_trade <= 3 then curr_bal else . end) as HDFC_L3m_trades_cbal,
sum(case when int_flag=1 and vin_trade <= 6 then curr_bal else . end) as HDFC_L6m_trades_cbal,
sum(case when int_flag=1 and vin_trade <= 12 then curr_bal else . end) as HDFC_L12m_trades_cbal,
sum(case when int_flag=1 and vin_trade <= 24 then curr_bal else . end) as HDFC_L24m_trades_cbal,
sum(case when int_flag=1 and vin_trade <= 36 then curr_bal else . end) as HDFC_L36m_trades_cbal,

sum(case when int_flag=0 and vin_trade <= 3 then curr_bal else . end) as Othbk_L3m_trades_cbal,
sum(case when int_flag=0 and vin_trade <= 6 then curr_bal else . end) as Othbk_L6m_trades_cbal,
sum(case when int_flag=0 and vin_trade <= 12 then curr_bal else . end) as Othbk_L12m_trades_cbal,
sum(case when int_flag=0 and vin_trade <= 24 then curr_bal else . end) as Othbk_L24m_trades_cbal,
sum(case when int_flag=0 and vin_trade <= 36 then curr_bal else . end) as Othbk_L36m_trades_cbal,

sum(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then curr_bal else . end) as HDFC_AL_trades_cbal,
sum(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then curr_bal else . end) as HDFC_HL_trades_cbal,
sum(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then curr_bal else . end) as HDFC_PL_trades_cbal,
sum(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then curr_bal else . end) as HDFC_CC_trades_cbal,
sum(case when int_flag=1 and trades_flag = "Sec" then curr_bal else . end) as HDFC_Sec_trades_cbal,
sum(case when int_flag=1 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as HDFC_Unsec_loans_cbal,

sum(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then curr_bal else . end) as Othbk_AL_trades_cbal,
sum(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then curr_bal else . end) as Othbk_HL_trades_cbal,
sum(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then curr_bal else . end) as Othbk_PL_trades_cbal,
sum(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then curr_bal else . end) as Othbk_CC_trades_cbal,
sum(case when int_flag=0 and trades_flag = "Sec" then curr_bal else . end) as Othbk_Sec_trades_cbal,
sum(case when int_flag=0 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as Othbk_Unsec_loans_cbal,

sum(case when vin_trade <= 3 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then curr_bal else . end) as L3m_AL_trades_cbal,
sum(case when vin_trade <= 3 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then curr_bal else . end) as L3m_HL_trades_cbal,
sum(case when vin_trade <= 3 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then curr_bal else . end) as L3m_PL_trades_cbal,
sum(case when vin_trade <= 3 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then curr_bal else . end) as L3m_CC_trades_cbal,
sum(case when vin_trade <= 3 and trades_flag = "Sec" then curr_bal else . end) as L3m_Sec_trades_cbal,
sum(case when vin_trade <= 3 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as L3m_Unsec_loans_cbal,

sum(case when vin_trade <= 6 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then curr_bal else . end) as L6m_AL_trades_cbal,
sum(case when vin_trade <= 6 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then curr_bal else . end) as L6m_HL_trades_cbal,
sum(case when vin_trade <= 6 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then curr_bal else . end) as L6m_PL_trades_cbal,
sum(case when vin_trade <= 6 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then curr_bal else . end) as L6m_CC_trades_cbal,
sum(case when vin_trade <= 6 and trades_flag = "Sec" then curr_bal else . end) as L6m_Sec_trades_cbal,
sum(case when vin_trade <= 6 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as L6m_Unsec_loans_cbal,

sum(case when vin_trade <= 12 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then curr_bal else . end) as L12m_AL_trades_cbal,
sum(case when vin_trade <= 12 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then curr_bal else . end) as L12m_HL_trades_cbal,
sum(case when vin_trade <= 12 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then curr_bal else . end) as L12m_PL_trades_cbal,
sum(case when vin_trade <= 12 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then curr_bal else . end) as L12m_CC_trades_cbal,
sum(case when vin_trade <= 12 and trades_flag = "Sec" then curr_bal else . end) as L12m_Sec_trades_cbal,
sum(case when vin_trade <= 12 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as L12m_Unsec_loans_cbal,

sum(case when vin_trade <= 24 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then curr_bal else . end) as L24m_AL_trades_cbal,
sum(case when vin_trade <= 24 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then curr_bal else . end) as L24m_HL_trades_cbal,
sum(case when vin_trade <= 24 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then curr_bal else . end) as L24m_PL_trades_cbal,
sum(case when vin_trade <= 24 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then curr_bal else . end) as L24m_CC_trades_cbal,
sum(case when vin_trade <= 24 and trades_flag = "Sec" then curr_bal else . end) as L24m_Sec_trades_cbal,
sum(case when vin_trade <= 24 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as L24m_Unsec_loans_cbal,

sum(case when vin_trade <= 36 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then curr_bal else . end) as L36m_AL_trades_cbal,
sum(case when vin_trade <= 36 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then curr_bal else . end) as L36m_HL_trades_cbal,
sum(case when vin_trade <= 36 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then curr_bal else . end) as L36m_PL_trades_cbal,
sum(case when vin_trade <= 36 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then curr_bal else . end) as L36m_CC_trades_cbal,
sum(case when vin_trade <= 36 and trades_flag = "Sec" then curr_bal else . end) as L36m_Sec_trades_cbal,
sum(case when vin_trade <= 36 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as L36m_Unsec_loans_cbal,


/****(Only Live)*****/

sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as All_live_loans_cbal,
sum(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as HDFC_live_loans_cbal,
sum(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as Othbk_live_loans_cbal,

sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then curr_bal else . end) as AL_live_trades_cbal,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then curr_bal else . end) as HL_live_trades_cbal,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then curr_bal else . end) as PL_live_trades_cbal,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then curr_bal else . end) as CC_live_trades_cbal,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "GOLD LOAN" then curr_bal else . end) as GL_live_trades_cbal,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "CONSUMER LOAN" then curr_bal else . end) as Consu_live_trades_cbal,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "Two Wheeler" then curr_bal else . end) as TW_live_trades_cbal,
sum(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "BUSINESS LOAN-GENERAL" then curr_bal else . end) as BL_live_trades_cbal,
sum(case when closed_flag="N" and Cash_loan_flag = "Y" then curr_bal else . end) as CL_live_trades_cbal,

sum(case when closed_flag="N" and trades_flag = "Sec" then curr_bal else . end) as Sec_live_trades_cbal,
sum(case when closed_flag="N" and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as Unsec_live_loans_cbal,

sum(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then curr_bal else . end) as HDFC_AL_live_trades_cbal,
sum(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then curr_bal else . end) as HDFC_HL_live_trades_cbal,
sum(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then curr_bal else . end) as HDFC_PL_live_trades_cbal,
sum(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then curr_bal else . end) as HDFC_CC_live_trades_cbal,
sum(case when closed_flag="N" and int_flag=1 and trades_flag = "Sec" then curr_bal else . end) as HDFC_Sec_live_trades_cbal,
sum(case when closed_flag="N" and int_flag=1 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as HDFC_Unsec_live_loans_cbal,

sum(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then curr_bal else . end) as Othbk_AL_live_trades_cbal,
sum(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then curr_bal else . end) as Othbk_HL_live_trades_cbal,
sum(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then curr_bal else . end) as Othbk_PL_live_trades_cbal,
sum(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then curr_bal else . end) as Othbk_CC_live_trades_cbal,
sum(case when closed_flag="N" and int_flag=0 and trades_flag = "Sec" then curr_bal else . end) as Othbk_Sec_live_trades_cbal,
sum(case when closed_flag="N" and int_flag=0 and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as Othbk_Unsec_live_loans_cbal,


/*************Vintage related variables************/

/****Overall(Live+Closed)*****/

max(vin_trade) as max_vint,
max(case when int_flag=1 then vin_trade else . end) as HDFC_max_vint,
max(case when int_flag=0 then vin_trade else . end) as Othbk_max_vint,

max(case when V_F_CIBIL_ACCT_TYPE = "Auto Loan" then vin_trade else . end) as AL_max_vint,
max(case when V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then vin_trade else . end) as HL_max_vint,
max(case when V_F_CIBIL_ACCT_TYPE = "Personal Loan" then vin_trade else . end) as PL_max_vint,
max(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then vin_trade else . end) as CC_max_vint,
max(case when V_F_CIBIL_ACCT_TYPE = "GOLD LOAN" then vin_trade else . end) as GL_max_vint,
max(case when V_F_CIBIL_ACCT_TYPE = "CONSUMER LOAN" then vin_trade else . end) as Consu_max_vint,
max(case when V_F_CIBIL_ACCT_TYPE = "Two Wheeler" then vin_trade else . end) as TW_max_vint,
max(case when V_F_CIBIL_ACCT_TYPE = "BUSINESS LOAN-GENERAL" then vin_trade else . end) as BL_max_vint,
max(case when Cash_loan_flag = "Y" then vin_trade else . end) as CL_max_vint,

max(case when trades_flag = "Sec" then vin_trade else . end) as Sec_max_vint,
max(case when trades_flag = "Unsec" then vin_trade else . end) as Unsec_max_vint,
max(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then vin_trade else . end) as loan_max_vint,


max(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then vin_trade else . end) as HDFC_loan_max_vint,
max(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then vin_trade else . end) as Othbk_loan_max_vint,

min(vin_trade) as min_vint,
min(case when int_flag=1 then vin_trade else . end) as HDFC_min_vint,
min(case when int_flag=0 then vin_trade else . end) as Othbk_min_vint,

min(case when V_F_CIBIL_ACCT_TYPE = "Auto Loan" then vin_trade else . end) as AL_min_vint,
min(case when V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then vin_trade else . end) as HL_min_vint,
min(case when V_F_CIBIL_ACCT_TYPE = "Personal Loan" then vin_trade else . end) as PL_min_vint,
min(case when V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then vin_trade else . end) as CC_min_vint,
min(case when V_F_CIBIL_ACCT_TYPE = "GOLD LOAN" then vin_trade else . end) as GL_min_vint,
min(case when V_F_CIBIL_ACCT_TYPE = "CONSUMER LOAN" then vin_trade else . end) as Consu_min_vint,
min(case when V_F_CIBIL_ACCT_TYPE = "Two Wheeler" then vin_trade else . end) as TW_min_vint,
min(case when V_F_CIBIL_ACCT_TYPE = "BUSINESS LOAN-GENERAL" then vin_trade else . end) as BL_min_vint,
min(case when Cash_loan_flag = "Y" then vin_trade else . end) as CL_min_vint,
min(case when trades_flag = "Sec" then vin_trade else . end) as Sec_min_vint,
min(case when trades_flag = "Unsec" then vin_trade else . end) as Unsec_min_vint,
min(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then vin_trade else . end) as loan_min_vint,


min(case when int_flag=1 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then vin_trade else . end) as HDFC_loan_min_vint,
min(case when int_flag=0 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then vin_trade else . end) as Othbk_loan_min_vint,


/****(Only Live)*****/

max(case when closed_flag="N" then vin_trade else . end) as max_vint_l,
max(case when closed_flag="N" and int_flag=1 then vin_trade else . end) as HDFC_max_vint_l,
max(case when closed_flag="N" and int_flag=0 then vin_trade else . end) as Othbk_max_vint_l,

max(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then vin_trade else . end) as AL_max_vint_l,
max(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then vin_trade else . end) as HL_max_vint_l,
max(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then vin_trade else . end) as PL_max_vint_l,
max(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then vin_trade else . end) as CC_max_vint_l,
max(case when closed_flag="N" and trades_flag = "Sec" then vin_trade else . end) as Sec_max_vint_l,
max(case when closed_flag="N" and trades_flag = "Unsec" then vin_trade else . end) as Unsec_max_vint_l,
max(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then vin_trade else . end) as loan_max_vint_l,

max(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then vin_trade else . end) as HDFC_loan_max_vint_l,
max(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then vin_trade else . end) as Othbk_loan_max_vint_l,

min(case when closed_flag="N" then vin_trade else . end) as min_vint_l,
min(case when closed_flag="N" and int_flag=1 then vin_trade else . end) as HDFC_min_vint_l,
min(case when closed_flag="N" and int_flag=0 then vin_trade else . end) as Othbk_min_vint_l,

min(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "Auto Loan" then vin_trade else . end) as AL_min_vint_l,
min(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE in ("HOUSING LOAN","PROPERTY LOAN") then vin_trade else . end) as HL_min_vint_l,
min(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "Personal Loan" then vin_trade else . end) as PL_min_vint_l,
min(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then vin_trade else . end) as CC_min_vint_l,
min(case when closed_flag="N" and trades_flag = "Sec" then vin_trade else . end) as Sec_min_vint_l,
min(case when closed_flag="N" and trades_flag = "Unsec" then vin_trade else . end) as Unsec_min_vint_l,
min(case when closed_flag="N" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then vin_trade else . end) as loan_min_vint_l,

min(case when closed_flag="N" and int_flag=1 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then vin_trade else . end) as HDFC_loan_min_vint_l,
min(case when closed_flag="N" and int_flag=0 and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then vin_trade else . end) as Othbk_loan_min_vint_l,

/*******Ownership Indicator***********/

sum(case when V_F_CIBIL_OWNERSHIP_INDICATOR ne "Individual" then 1 else 0 end) as own_ind_cnt, 
sum(case when V_F_CIBIL_OWNERSHIP_INDICATOR ne "Individual" then loan_amt else 0 end) as own_ind_amt,

sum(case when V_F_CIBIL_OWNERSHIP_INDICATOR in ("Joint","Guarantor") then 1 else 0 end) as own_joint_gua_cnt, 
sum(case when V_F_CIBIL_OWNERSHIP_INDICATOR in ("Joint","Guarantor") then loan_amt else 0 end) as own_joint_gua_amt,

sum(case when closed_flag="N" and V_F_CIBIL_OWNERSHIP_INDICATOR ne "Individual" then 1 else 0 end) as own_ind_cnt_l, 
sum(case when closed_flag="N" and V_F_CIBIL_OWNERSHIP_INDICATOR ne "Individual" then loan_amt else 0 end) as own_ind_amt_l,

sum(case when closed_flag="N" and V_F_CIBIL_OWNERSHIP_INDICATOR in ("Joint","Guarantor") then 1 else 0 end) as own_joint_gua_cnt_l, 
sum(case when closed_flag="N" and V_F_CIBIL_OWNERSHIP_INDICATOR in ("Joint","Guarantor") then loan_amt else 0 end) as own_joint_gua_amt_l,



/*************delinquency related variables***********************/

/****overall(Live+Closed)*****/

sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_x_6,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_x_6,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_x_6,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_x_6,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_x_6,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_x_6,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_x_6,

sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_x_12,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_x_12,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_x_12,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_x_12,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_x_12,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_x_12,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_x_12,

sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_x_24,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_x_24,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_x_24,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_x_24,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_x_24,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_x_24,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_x_24,

sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_x_36,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_x_36,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_x_36,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_x_36,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_x_36,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_x_36,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_x_36,

sum(case when ( num_30_6 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_30_6,
sum(case when ( num_30_6 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_30_6,
sum(case when ( num_30_6 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_30_6,
sum(case when ( num_30_6 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_30_6,
sum(case when ( num_30_6 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_30_6,
sum(case when ( num_30_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_30_6,
sum(case when ( num_30_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_30_6,

sum(case when ( num_30_12 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_30_12,
sum(case when ( num_30_12 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_30_12,
sum(case when ( num_30_12 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_30_12,
sum(case when ( num_30_12 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_30_12,
sum(case when ( num_30_12 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_30_12,
sum(case when ( num_30_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_30_12,
sum(case when ( num_30_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_30_12,

sum(case when ( num_30_24 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_30_24,
sum(case when ( num_30_24 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_30_24,
sum(case when ( num_30_24 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_30_24,
sum(case when ( num_30_24 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_30_24,
sum(case when ( num_30_24 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_30_24,
sum(case when ( num_30_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_30_24,
sum(case when ( num_30_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_30_24,

sum(case when ( num_30_36 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_30_36,
sum(case when ( num_30_36 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_30_36,
sum(case when ( num_30_36 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_30_36,
sum(case when ( num_30_36 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_30_36,
sum(case when ( num_30_36 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_30_36,
sum(case when ( num_30_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_30_36,
sum(case when ( num_30_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_30_36,

sum(case when ( num_60_6 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_60_6,
sum(case when ( num_60_6 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_60_6,
sum(case when ( num_60_6 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_60_6,
sum(case when ( num_60_6 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_60_6,
sum(case when ( num_60_6 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_60_6,
sum(case when ( num_60_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_60_6,
sum(case when ( num_60_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_60_6,

sum(case when ( num_60_12 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_60_12,
sum(case when ( num_60_12 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_60_12,
sum(case when ( num_60_12 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_60_12,
sum(case when ( num_60_12 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_60_12,
sum(case when ( num_60_12 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_60_12,
sum(case when ( num_60_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_60_12,
sum(case when ( num_60_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_60_12,

sum(case when ( num_60_24 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_60_24,
sum(case when ( num_60_24 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_60_24,
sum(case when ( num_60_24 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_60_24,
sum(case when ( num_60_24 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_60_24,
sum(case when ( num_60_24 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_60_24,
sum(case when ( num_60_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_60_24,
sum(case when ( num_60_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_60_24,

sum(case when ( num_60_36 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_60_36,
sum(case when ( num_60_36 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_60_36,
sum(case when ( num_60_36 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_60_36,
sum(case when ( num_60_36 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_60_36,
sum(case when ( num_60_36 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_60_36,
sum(case when ( num_60_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_60_36,
sum(case when ( num_60_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_60_36,


sum(case when ( num_90_6 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_90_6,
sum(case when ( num_90_6 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_90_6,
sum(case when ( num_90_6 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_90_6,
sum(case when ( num_90_6 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_90_6,
sum(case when ( num_90_6 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_90_6,
sum(case when ( num_90_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_90_6,
sum(case when ( num_90_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_90_6,

sum(case when ( num_90_12 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_90_12,
sum(case when ( num_90_12 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_90_12,
sum(case when ( num_90_12 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_90_12,
sum(case when ( num_90_12 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_90_12,
sum(case when ( num_90_12 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_90_12,
sum(case when ( num_90_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_90_12,
sum(case when ( num_90_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_90_12,

sum(case when ( num_90_24 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_90_24,
sum(case when ( num_90_24 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_90_24,
sum(case when ( num_90_24 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_90_24,
sum(case when ( num_90_24 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_90_24,
sum(case when ( num_90_24 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_90_24,
sum(case when ( num_90_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_90_24,
sum(case when ( num_90_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_90_24,

sum(case when ( num_90_36 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_90_36,
sum(case when ( num_90_36 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_90_36,
sum(case when ( num_90_36 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_90_36,
sum(case when ( num_90_36 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_90_36,
sum(case when ( num_90_36 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_90_36,
sum(case when ( num_90_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_90_36,
sum(case when ( num_90_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_90_36,


/*****loan amount*********/

sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") then loan_amt else 0 end) as All_trades_x_6_a,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as All_loans_x_6_a,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and int_flag=1 then loan_amt else 0 end) as HDFC_trades_x_6_a,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and int_flag=0 then loan_amt else 0 end) as Othbk_trades_x_6_a,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then loan_amt else 0 end) as Sec_trades_x_6_a,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then loan_amt else 0 end) as Unsec_trades_x_6_a,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as Unsec_loans_x_6_a,

sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") then loan_amt else 0 end) as All_trades_x_12_a,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as All_loans_x_12_a,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and int_flag=1 then loan_amt else 0 end) as HDFC_trades_x_12_a,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and int_flag=0 then loan_amt else 0 end) as Othbk_trades_x_12_a,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then loan_amt else 0 end) as Sec_trades_x_12_a,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then loan_amt else 0 end) as Unsec_trades_x_12_a,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as Unsec_loans_x_12_a,

sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") then loan_amt else 0 end) as All_trades_x_24_a,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as All_loans_x_24_a,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and int_flag=1 then loan_amt else 0 end) as HDFC_trades_x_24_a,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and int_flag=0 then loan_amt else 0 end) as Othbk_trades_x_24_a,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then loan_amt else 0 end) as Sec_trades_x_24_a,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then loan_amt else 0 end) as Unsec_trades_x_24_a,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as Unsec_loans_x_24_a,

sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") then loan_amt else 0 end) as All_trades_x_36_a,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as All_loans_x_36_a,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and int_flag=1 then loan_amt else 0 end) as HDFC_trades_x_36_a,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and int_flag=0 then loan_amt else 0 end) as Othbk_trades_x_36_a,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then loan_amt else 0 end) as Sec_trades_x_36_a,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then loan_amt else 0 end) as Unsec_trades_x_36_a,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as Unsec_loans_x_36_a,


/******curr balance*********/

sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") then curr_bal else . end) as All_trades_x_6_cbal,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as All_loans_x_6_cbal,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and int_flag=1 then curr_bal else . end) as HDFC_trades_x_6_cbal,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and int_flag=0 then curr_bal else . end) as Othbk_trades_x_6_cbal,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then curr_bal else . end) as Sec_trades_x_6_cbal,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then curr_bal else . end) as Unsec_trades_x_6_cbal,
sum(case when ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as Unsec_loans_x_6_cbal,

sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") then curr_bal else . end) as All_trades_x_12_cbal,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as All_loans_x_12_cbal,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and int_flag=1 then curr_bal else . end) as HDFC_trades_x_12_cbal,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and int_flag=0 then curr_bal else . end) as Othbk_trades_x_12_cbal,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then curr_bal else . end) as Sec_trades_x_12_cbal,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then curr_bal else . end) as Unsec_trades_x_12_cbal,
sum(case when ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as Unsec_loans_x_12_cbal,

sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") then curr_bal else . end) as All_trades_x_24_cbal,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as All_loans_x_24_cbal,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and int_flag=1 then curr_bal else . end) as HDFC_trades_x_24_cbal,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and int_flag=0 then curr_bal else . end) as Othbk_trades_x_24_cbal,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then curr_bal else . end) as Sec_trades_x_24_cbal,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then curr_bal else . end) as Unsec_trades_x_24_cbal,
sum(case when ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as Unsec_loans_x_24_cbal,

sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") then curr_bal else . end) as All_trades_x_36_cbal,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as All_loans_x_36_cbal,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and int_flag=1 then curr_bal else . end) as HDFC_trades_x_36_cbal,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and int_flag=0 then curr_bal else . end) as Othbk_trades_x_36_cbal,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then curr_bal else . end) as Sec_trades_x_36_cbal,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then curr_bal else . end) as Unsec_trades_x_36_cbal,
sum(case when ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as Unsec_loans_x_36_cbal,


/****(Only Live)*****/

sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_x_6_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_x_6_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_x_6_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_x_6_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_x_6_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_x_6_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_x_6_l,

sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_x_12_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_x_12_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_x_12_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_x_12_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_x_12_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_x_12_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_x_12_l,

sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_x_24_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_x_24_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_x_24_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_x_24_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_x_24_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_x_24_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_x_24_l,

sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_x_36_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_x_36_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_x_36_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_x_36_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_x_36_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_x_36_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_x_36_l,

sum(case when closed_flag="N" and ( num_30_6 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_30_6_l,
sum(case when closed_flag="N" and ( num_30_6 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_30_6_l,
sum(case when closed_flag="N" and ( num_30_6 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_30_6_l,
sum(case when closed_flag="N" and ( num_30_6 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_30_6_l,
sum(case when closed_flag="N" and ( num_30_6 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_30_6_l,
sum(case when closed_flag="N" and ( num_30_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_30_6_l,
sum(case when closed_flag="N" and ( num_30_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_30_6_l,

sum(case when closed_flag="N" and ( num_30_12 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_30_12_l,
sum(case when closed_flag="N" and ( num_30_12 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_30_12_l,
sum(case when closed_flag="N" and ( num_30_12 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_30_12_l,
sum(case when closed_flag="N" and ( num_30_12 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_30_12_l,
sum(case when closed_flag="N" and ( num_30_12 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_30_12_l,
sum(case when closed_flag="N" and ( num_30_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_30_12_l,
sum(case when closed_flag="N" and ( num_30_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_30_12_l,

sum(case when closed_flag="N" and ( num_30_24 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_30_24_l,
sum(case when closed_flag="N" and ( num_30_24 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_30_24_l,
sum(case when closed_flag="N" and ( num_30_24 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_30_24_l,
sum(case when closed_flag="N" and ( num_30_24 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_30_24_l,
sum(case when closed_flag="N" and ( num_30_24 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_30_24_l,
sum(case when closed_flag="N" and ( num_30_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_30_24_l,
sum(case when closed_flag="N" and ( num_30_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_30_24_l,

sum(case when closed_flag="N" and ( num_30_36 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_30_36_l,
sum(case when closed_flag="N" and ( num_30_36 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_30_36_l,
sum(case when closed_flag="N" and ( num_30_36 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_30_36_l,
sum(case when closed_flag="N" and ( num_30_36 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_30_36_l,
sum(case when closed_flag="N" and ( num_30_36 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_30_36_l,
sum(case when closed_flag="N" and ( num_30_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_30_36_l,
sum(case when closed_flag="N" and ( num_30_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_30_36_l,

sum(case when closed_flag="N" and ( num_60_6 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_60_6_l,
sum(case when closed_flag="N" and ( num_60_6 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_60_6_l,
sum(case when closed_flag="N" and ( num_60_6 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_60_6_l,
sum(case when closed_flag="N" and ( num_60_6 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_60_6_l,
sum(case when closed_flag="N" and ( num_60_6 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_60_6_l,
sum(case when closed_flag="N" and ( num_60_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_60_6_l,
sum(case when closed_flag="N" and ( num_60_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_60_6_l,

sum(case when closed_flag="N" and ( num_60_12 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_60_12_l,
sum(case when closed_flag="N" and ( num_60_12 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_60_12_l,
sum(case when closed_flag="N" and ( num_60_12 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_60_12_l,
sum(case when closed_flag="N" and ( num_60_12 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_60_12_l,
sum(case when closed_flag="N" and ( num_60_12 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_60_12_l,
sum(case when closed_flag="N" and ( num_60_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_60_12_l,
sum(case when closed_flag="N" and ( num_60_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_60_12_l,

sum(case when closed_flag="N" and ( num_60_24 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_60_24_l,
sum(case when closed_flag="N" and ( num_60_24 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_60_24_l,
sum(case when closed_flag="N" and ( num_60_24 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_60_24_l,
sum(case when closed_flag="N" and ( num_60_24 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_60_24_l,
sum(case when closed_flag="N" and ( num_60_24 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_60_24_l,
sum(case when closed_flag="N" and ( num_60_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_60_24_l,
sum(case when closed_flag="N" and ( num_60_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_60_24_l,

sum(case when closed_flag="N" and ( num_60_36 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_60_36_l,
sum(case when closed_flag="N" and ( num_60_36 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_60_36_l,
sum(case when closed_flag="N" and ( num_60_36 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_60_36_l,
sum(case when closed_flag="N" and ( num_60_36 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_60_36_l,
sum(case when closed_flag="N" and ( num_60_36 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_60_36_l,
sum(case when closed_flag="N" and ( num_60_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_60_36_l,
sum(case when closed_flag="N" and ( num_60_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_60_36_l,


sum(case when closed_flag="N" and ( num_90_6 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_90_6_l,
sum(case when closed_flag="N" and ( num_90_6 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_90_6_l,
sum(case when closed_flag="N" and ( num_90_6 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_90_6_l,
sum(case when closed_flag="N" and ( num_90_6 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_90_6_l,
sum(case when closed_flag="N" and ( num_90_6 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_90_6_l,
sum(case when closed_flag="N" and ( num_90_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_90_6_l,
sum(case when closed_flag="N" and ( num_90_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_90_6_l,

sum(case when closed_flag="N" and ( num_90_12 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_90_12_l,
sum(case when closed_flag="N" and ( num_90_12 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_90_12_l,
sum(case when closed_flag="N" and ( num_90_12 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_90_12_l,
sum(case when closed_flag="N" and ( num_90_12 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_90_12_l,
sum(case when closed_flag="N" and ( num_90_12 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_90_12_l,
sum(case when closed_flag="N" and ( num_90_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_90_12_l,
sum(case when closed_flag="N" and ( num_90_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_90_12_l,


sum(case when closed_flag="N" and ( num_90_24 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_90_24_l,
sum(case when closed_flag="N" and ( num_90_24 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_90_24_l,
sum(case when closed_flag="N" and ( num_90_24 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_90_24_l,
sum(case when closed_flag="N" and ( num_90_24 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_90_24_l,
sum(case when closed_flag="N" and ( num_90_24 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_90_24_l,
sum(case when closed_flag="N" and ( num_90_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_90_24_l,
sum(case when closed_flag="N" and ( num_90_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_90_24_l,


sum(case when closed_flag="N" and ( num_90_36 > 0 or Suitfile_flag="Y") then 1 else 0 end) as All_trades_90_36_l,
sum(case when closed_flag="N" and ( num_90_36 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as All_loans_90_36_l,
sum(case when closed_flag="N" and ( num_90_36 > 0 or Suitfile_flag="Y") and int_flag=1 then 1 else 0 end) as HDFC_trades_90_36_l,
sum(case when closed_flag="N" and ( num_90_36 > 0 or Suitfile_flag="Y") and int_flag=0 then 1 else 0 end) as Othbk_trades_90_36_l,
sum(case when closed_flag="N" and ( num_90_36 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then 1 else 0 end) as Sec_trades_90_36_l,
sum(case when closed_flag="N" and ( num_90_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then 1 else 0 end) as Unsec_trades_90_36_l,
sum(case when closed_flag="N" and ( num_90_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as Unsec_loans_90_36_l,


/*****loan amount*********/

sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") then loan_amt else 0 end) as All_trades_x_6_a_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as All_loans_x_6_a_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and int_flag=1 then loan_amt else 0 end) as HDFC_trades_x_6_a_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and int_flag=0 then loan_amt else 0 end) as Othbk_trades_x_6_a_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then loan_amt else 0 end) as Sec_trades_x_6_a_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then loan_amt else 0 end) as Unsec_trades_x_6_a_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as Unsec_loans_x_6_a_l,

sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") then loan_amt else 0 end) as All_trades_x_12_a_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as All_loans_x_12_a_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and int_flag=1 then loan_amt else 0 end) as HDFC_trades_x_12_a_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and int_flag=0 then loan_amt else 0 end) as Othbk_trades_x_12_a_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then loan_amt else 0 end) as Sec_trades_x_12_a_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then loan_amt else 0 end) as Unsec_trades_x_12_a_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as Unsec_loans_x_12_a_l,

sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") then loan_amt else 0 end) as All_trades_x_24_a_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as All_loans_x_24_a_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and int_flag=1 then loan_amt else 0 end) as HDFC_trades_x_24_a_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and int_flag=0 then loan_amt else 0 end) as Othbk_trades_x_24_a_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then loan_amt else 0 end) as Sec_trades_x_24_a_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then loan_amt else 0 end) as Unsec_trades_x_24_a_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as Unsec_loans_x_24_a_l,

sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") then loan_amt else 0 end) as All_trades_x_36_a_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as All_loans_x_36_a_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and int_flag=1 then loan_amt else 0 end) as HDFC_trades_x_36_a_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and int_flag=0 then loan_amt else 0 end) as Othbk_trades_x_36_a_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then loan_amt else 0 end) as Sec_trades_x_36_a_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then loan_amt else 0 end) as Unsec_trades_x_36_a_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then loan_amt else 0 end) as Unsec_loans_x_36_a_l,


/******curr balance*********/

sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") then curr_bal else . end) as All_trades_x_6_cbal_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as All_loans_x_6_cbal_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and int_flag=1 then curr_bal else . end) as HDFC_trades_x_6_cbal_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and int_flag=0 then curr_bal else . end) as Othbk_trades_x_6_cbal_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then curr_bal else . end) as Sec_trades_x_6_cbal_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then curr_bal else . end) as Unsec_trades_x_6_cbal_l,
sum(case when closed_flag="N" and ( num_x_6 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as Unsec_loans_x_6_cbal_l,

sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") then curr_bal else . end) as All_trades_x_12_cbal_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as All_loans_x_12_cbal_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and int_flag=1 then curr_bal else . end) as HDFC_trades_x_12_cbal_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and int_flag=0 then curr_bal else . end) as Othbk_trades_x_12_cbal_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then curr_bal else . end) as Sec_trades_x_12_cbal_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then curr_bal else . end) as Unsec_trades_x_12_cbal_l,
sum(case when closed_flag="N" and ( num_x_12 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as Unsec_loans_x_12_cbal_l,


sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") then curr_bal else . end) as All_trades_x_24_cbal_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as All_loans_x_24_cbal_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and int_flag=1 then curr_bal else . end) as HDFC_trades_x_24_cbal_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and int_flag=0 then curr_bal else . end) as Othbk_trades_x_24_cbal_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then curr_bal else . end) as Sec_trades_x_24_cbal_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then curr_bal else . end) as Unsec_trades_x_24_cbal_l,
sum(case when closed_flag="N" and ( num_x_24 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as Unsec_loans_x_24_cbal_l,

sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") then curr_bal else . end) as All_trades_x_36_cbal_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as All_loans_x_36_cbal_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and int_flag=1 then curr_bal else . end) as HDFC_trades_x_36_cbal_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and int_flag=0 then curr_bal else . end) as Othbk_trades_x_36_cbal_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Sec" then curr_bal else . end) as Sec_trades_x_36_cbal_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" then curr_bal else . end) as Unsec_trades_x_36_cbal_l,
sum(case when closed_flag="N" and ( num_x_36 > 0 or Suitfile_flag="Y") and trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then curr_bal else . end) as Unsec_loans_x_36_cbal_l,


/****** Frequency of delinquency***************/

sum(num_x_6) as All_trades_x_6_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_x_6 else . end) as All_loans_x_6_freq,
sum(case when int_flag=1 then num_x_6 else . end) as HDFC_trades_x_6_freq,
sum(case when int_flag=0 then num_x_6 else . end) as Othbk_trades_x_6_freq,
sum(case when trades_flag = "Sec" then num_x_6 else . end) as Sec_trades_x_6_freq,
sum(case when trades_flag = "Unsec" then num_x_6 else . end) as Unsec_trades_x_6_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_x_6 else . end) as Unsec_loans_x_6_freq,

sum(num_x_12) as All_trades_x_12_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_x_12 else . end) as All_loans_x_12_freq,
sum(case when int_flag=1 then num_x_12 else . end) as HDFC_trades_x_12_freq,
sum(case when int_flag=0 then num_x_12 else . end) as Othbk_trades_x_12_freq,
sum(case when trades_flag = "Sec" then num_x_12 else . end) as Sec_trades_x_12_freq,
sum(case when trades_flag = "Unsec" then num_x_12 else . end) as Unsec_trades_x_12_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_x_12 else . end) as Unsec_loans_x_12_freq,


sum(num_x_24) as All_trades_x_24_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_x_24 else . end) as All_loans_x_24_freq,
sum(case when int_flag=1 then num_x_24 else . end) as HDFC_trades_x_24_freq,
sum(case when int_flag=0 then num_x_24 else . end) as Othbk_trades_x_24_freq,
sum(case when trades_flag = "Sec" then num_x_24 else . end) as Sec_trades_x_24_freq,
sum(case when trades_flag = "Unsec" then num_x_24 else . end) as Unsec_trades_x_24_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_x_24 else . end) as Unsec_loans_x_24_freq,

sum(num_x_36) as All_trades_x_36_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_x_36 else . end) as All_loans_x_36_freq,
sum(case when int_flag=1 then num_x_36 else . end) as HDFC_trades_x_36_freq,
sum(case when int_flag=0 then num_x_36 else . end) as Othbk_trades_x_36_freq,
sum(case when trades_flag = "Sec" then num_x_36 else . end) as Sec_trades_x_36_freq,
sum(case when trades_flag = "Unsec" then num_x_36 else . end) as Unsec_trades_x_36_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_x_36 else . end) as Unsec_loans_x_36_freq,


sum(num_30_6) as All_trades_30_6_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_30_6 else . end) as All_loans_30_6_freq,
sum(case when int_flag=1 then num_30_6 else . end) as HDFC_trades_30_6_freq,
sum(case when int_flag=0 then num_30_6 else . end) as Othbk_trades_30_6_freq,
sum(case when trades_flag = "Sec" then num_30_6 else . end) as Sec_trades_30_6_freq,
sum(case when trades_flag = "Unsec" then num_30_6 else . end) as Unsec_trades_30_6_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_30_6 else . end) as Unsec_loans_30_6_freq,

sum(num_30_12) as All_trades_30_12_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_30_12 else . end) as All_loans_30_12_freq,
sum(case when int_flag=1 then num_30_12 else . end) as HDFC_trades_30_12_freq,
sum(case when int_flag=0 then num_30_12 else . end) as Othbk_trades_30_12_freq,
sum(case when trades_flag = "Sec" then num_30_12 else . end) as Sec_trades_30_12_freq,
sum(case when trades_flag = "Unsec" then num_30_12 else . end) as Unsec_trades_30_12_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_30_12 else . end) as Unsec_loans_30_12_freq,


sum(num_30_24) as All_trades_30_24_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_30_24 else . end) as All_loans_30_24_freq,
sum(case when int_flag=1 then num_30_24 else . end) as HDFC_trades_30_24_freq,
sum(case when int_flag=0 then num_30_24 else . end) as Othbk_trades_30_24_freq,
sum(case when trades_flag = "Sec" then num_30_24 else . end) as Sec_trades_30_24_freq,
sum(case when trades_flag = "Unsec" then num_30_24 else . end) as Unsec_trades_30_24_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_30_24 else . end) as Unsec_loans_30_24_freq,

sum(num_30_36) as All_trades_30_36_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_30_36 else . end) as All_loans_30_36_freq,
sum(case when int_flag=1 then num_30_36 else . end) as HDFC_trades_30_36_freq,
sum(case when int_flag=0 then num_30_36 else . end) as Othbk_trades_30_36_freq,
sum(case when trades_flag = "Sec" then num_30_36 else . end) as Sec_trades_30_36_freq,
sum(case when trades_flag = "Unsec" then num_30_36 else . end) as Unsec_trades_30_36_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_30_36 else . end) as Unsec_loans_30_36_freq,

sum(num_60_6) as All_trades_60_6_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_60_6 else . end) as All_loans_60_6_freq,
sum(case when int_flag=1 then num_60_6 else . end) as HDFC_trades_60_6_freq,
sum(case when int_flag=0 then num_60_6 else . end) as Othbk_trades_60_6_freq,
sum(case when trades_flag = "Sec" then num_60_6 else . end) as Sec_trades_60_6_freq,
sum(case when trades_flag = "Unsec" then num_60_6 else . end) as Unsec_trades_60_6_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_60_6 else . end) as Unsec_loans_60_6_freq,

sum(num_60_12) as All_trades_60_12_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_60_12 else . end) as All_loans_60_12_freq,
sum(case when int_flag=1 then num_60_12 else . end) as HDFC_trades_60_12_freq,
sum(case when int_flag=0 then num_60_12 else . end) as Othbk_trades_60_12_freq,
sum(case when trades_flag = "Sec" then num_60_12 else . end) as Sec_trades_60_12_freq,
sum(case when trades_flag = "Unsec" then num_60_12 else . end) as Unsec_trades_60_12_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_60_12 else . end) as Unsec_loans_60_12_freq,


sum(num_60_24) as All_trades_60_24_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_60_24 else . end) as All_loans_60_24_freq,
sum(case when int_flag=1 then num_60_24 else . end) as HDFC_trades_60_24_freq,
sum(case when int_flag=0 then num_60_24 else . end) as Othbk_trades_60_24_freq,
sum(case when trades_flag = "Sec" then num_60_24 else . end) as Sec_trades_60_24_freq,
sum(case when trades_flag = "Unsec" then num_60_24 else . end) as Unsec_trades_60_24_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_60_24 else . end) as Unsec_loans_60_24_freq,

sum(num_60_36) as All_trades_60_36_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_60_36 else . end) as All_loans_60_36_freq,
sum(case when int_flag=1 then num_60_36 else . end) as HDFC_trades_60_36_freq,
sum(case when int_flag=0 then num_60_36 else . end) as Othbk_trades_60_36_freq,
sum(case when trades_flag = "Sec" then num_60_36 else . end) as Sec_trades_60_36_freq,
sum(case when trades_flag = "Unsec" then num_60_36 else . end) as Unsec_trades_60_36_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_60_36 else . end) as Unsec_loans_60_36_freq,

sum(num_90_6) as All_trades_90_6_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_90_6 else . end) as All_loans_90_6_freq,
sum(case when int_flag=1 then num_90_6 else . end) as HDFC_trades_90_6_freq,
sum(case when int_flag=0 then num_90_6 else . end) as Othbk_trades_90_6_freq,
sum(case when trades_flag = "Sec" then num_90_6 else . end) as Sec_trades_90_6_freq,
sum(case when trades_flag = "Unsec" then num_90_6 else . end) as Unsec_trades_90_6_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_90_6 else . end) as Unsec_loans_90_6_freq,

sum(num_90_12) as All_trades_90_12_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_90_12 else . end) as All_loans_90_12_freq,
sum(case when int_flag=1 then num_90_12 else . end) as HDFC_trades_90_12_freq,
sum(case when int_flag=0 then num_90_12 else . end) as Othbk_trades_90_12_freq,
sum(case when trades_flag = "Sec" then num_90_12 else . end) as Sec_trades_90_12_freq,
sum(case when trades_flag = "Unsec" then num_90_12 else . end) as Unsec_trades_90_12_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_90_12 else . end) as Unsec_loans_90_12_freq,

sum(num_90_24) as All_trades_90_24_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_90_24 else . end) as All_loans_90_24_freq,
sum(case when int_flag=1 then num_90_24 else . end) as HDFC_trades_90_24_freq,
sum(case when int_flag=0 then num_90_24 else . end) as Othbk_trades_90_24_freq,
sum(case when trades_flag = "Sec" then num_90_24 else . end) as Sec_trades_90_24_freq,
sum(case when trades_flag = "Unsec" then num_90_24 else . end) as Unsec_trades_90_24_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_90_24 else . end) as Unsec_loans_90_24_freq,


sum(num_90_36) as All_trades_90_36_freq,
sum(case when V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_90_36 else . end) as All_loans_90_36_freq,
sum(case when int_flag=1 then num_90_36 else . end) as HDFC_trades_90_36_freq,
sum(case when int_flag=0 then num_90_36 else . end) as Othbk_trades_90_36_freq,
sum(case when trades_flag = "Sec" then num_90_36 else . end) as Sec_trades_90_36_freq,
sum(case when trades_flag = "Unsec" then num_90_36 else . end) as Unsec_trades_90_36_freq,
sum(case when trades_flag = "Unsec" and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then num_90_36 else . end) as Unsec_loans_90_36_freq,

max(DATE_OPENED_DISBURSED_TL) as max_open_date format date9.,
min(DATE_OPENED_DISBURSED_TL) as min_open_date format date9.,

/************variables  for segmentation and filters*******/
sum(case when val_tl24_flag="Y" then 1 else 0 end) as val_tl24_cnt,
sum(case when val_tl12_flag="Y" then 1 else 0 end) as val_tl12_cnt,
max(case when val_tl24_flag="Y" then vin_trade else . end) as val_tl24_max_vint,

sum(case when val_tl24_flag="Y" then rep_l24_cnt else 0 end) as sum_val24_rep_l24_cnt,
max(case when val_tl24_flag="Y" then rep_l24_cnt else 0 end) as max_val24_rep_l24_cnt,

sum(case when val_tl24_flag="Y" then rep_l12_cnt else 0 end) as sum_val24_rep_l12_cnt,
max(case when val_tl24_flag="Y" then rep_l12_cnt else 0 end) as max_val24_rep_l12_cnt,

sum(case when val_tl12_flag="Y" then rep_l12_cnt else 0 end) as sum_val12_rep_l12_cnt,
max(case when val_tl12_flag="Y" then rep_l12_cnt else 0 end) as max_val12_rep_l12_cnt,


sum(case when (num_60_12 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then 1 else 0 end) as cc_60_12,
sum(case when (num_60_12 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE = "CREDIT CARD" then curr_bal else . end) as cc_60_12_bal,
sum(case when (num_30_12 > 0 or Suitfile_flag="Y") and V_F_CIBIL_ACCT_TYPE ne "CREDIT CARD" then 1 else 0 end) as loan_30_12


from  agn2.Assets_merged_output
group by Masked_Key;
quit;


data agn2.merged_tl_rollup;
set agn2.merged_tl_rollup;

/***********residual ratio on live loans and credit cards********/

All_live_loans_r1=round(All_live_loans_cbal/All_live_loans_a,0.01);
HDFC_live_loans_r1=round(HDFC_live_loans_cbal/HDFC_live_loans_a,0.01);
Othbk_live_loans_r1=round(Othbk_live_loans_cbal/Othbk_live_loans_a,0.01);
AL_live_trades_r1=round(AL_live_trades_cbal/AL_live_trades_a,0.01);
HL_live_trades_r1=round(HL_live_trades_cbal/HL_live_trades_a,0.01);
PL_live_trades_r1=round(PL_live_trades_cbal/PL_live_trades_a,0.01);
CC_live_trades_r1=round(CC_live_trades_cbal/CC_live_trades_a,0.01);
Sec_live_trades_r1=round(Sec_live_trades_cbal/Sec_live_trades_a,0.01);
unsec_live_loans_r1=round(unsec_live_loans_cbal/unsec_live_loans_a,0.01);
HDFC_AL_live_trades_r1=round(HDFC_AL_live_trades_cbal/HDFC_AL_live_trades_a,0.01);
HDFC_HL_live_trades_r1=round(HDFC_HL_live_trades_cbal/HDFC_HL_live_trades_a,0.01);
HDFC_PL_live_trades_r1=round(HDFC_PL_live_trades_cbal/HDFC_PL_live_trades_a,0.01);
HDFC_CC_live_trades_r1=round(HDFC_CC_live_trades_cbal/HDFC_CC_live_trades_a,0.01);
HDFC_Sec_live_trades_r1=round(HDFC_Sec_live_trades_cbal/HDFC_Sec_live_trades_a,0.01);
HDFC_unsec_live_loans_r1=round(HDFC_unsec_live_loans_cbal/HDFC_unsec_live_loans_a,0.01);
Othbk_AL_live_trades_r1=round(Othbk_AL_live_trades_cbal/Othbk_AL_live_trades_a,0.01);
Othbk_HL_live_trades_r1=round(Othbk_HL_live_trades_cbal/Othbk_HL_live_trades_a,0.01);
Othbk_PL_live_trades_r1=round(Othbk_PL_live_trades_cbal/Othbk_PL_live_trades_a,0.01);
Othbk_CC_live_trades_r1=round(Othbk_CC_live_trades_cbal/Othbk_CC_live_trades_a,0.01);
Othbk_Sec_live_trades_r1=round(Othbk_Sec_live_trades_cbal/Othbk_Sec_live_trades_a,0.01);
Othbk_unsec_live_loans_r1=round(Othbk_unsec_live_loans_cbal/Othbk_unsec_live_loans_a,0.01);

/***********residual ratio on live loans and credit cards- defaulted amounts********/

/*All_live_loans_r2=round(All_live_loans_ovdu/All_live_loans_cbal,0.01);*/
/*AL_live_trades_r2=round(AL_live_trades_ovdu/AL_live_trades_cbal,0.01);*/
/*HL_live_trades_r2=round(HL_live_trades_ovdu/HL_live_trades_cbal,0.01);*/
/*PL_live_trades_r2=round(PL_live_trades_ovdu/PL_live_trades_cbal,0.01);*/
/*CC_live_trades_r2=round(CC_live_trades_ovdu/CC_live_trades_cbal,0.01);*/
/*Sec_live_trades_r2=round(Sec_live_trades_ovdu/Sec_live_trades_cbal,0.01);*/
/*unsec_live_loans_r2=round(unsec_live_loans_ovdu/unsec_live_loans_cbal,0.01);*/


/***********No. of closed loans or trades**********************/

All_close_trades=All_trades-All_live_trades;
All_close_loans=All_loans-All_live_loans;
HDFC_close_trades=HDFC_trades-HDFC_live_trades;
Othbk_close_trades=Othbk_trades-Othbk_live_trades;
AL_close_trades=AL_trades-AL_live_trades;
HL_close_trades=HL_trades-HL_live_trades;
PL_close_trades=PL_trades-PL_live_trades;
CC_close_trades=CC_trades-CC_live_trades;m
Sec_close_trades=Sec_trades-Sec_live_trades;
Unsec_close_trades=Unsec_trades-Unsec_live_trades;
Unsec_close_loans=Unsec_loans-Unsec_live_loans;

/******No. of accounts opened per unit time********************/

if All_trades=1 then accnt_unit_time= -999;
if All_trades > 1 then
accnt_unit_time=round(All_trades/round((max_open_date-min_open_date)/30.5),0.01);/*confirm with sayan*/

run;


data agn2.merged_tl_rollup;
set agn2.merged_tl_rollup;

/*********proportion of live trades/loans to total no. of trades/loans**********/

num_prop_live_all_trades=round(All_live_trades/All_trades,0.01);
num_prop_live_all_loans=round(All_live_loans/All_loans,0.01);

/*********proportion of HDFC trades to total no. of trades**********/

num_prop_hdfc_all_trades=round(HDFC_trades/All_trades,0.01);

r_hdfc_all_l3m=round(HDFC_L3m_trades/L3m_trades,0.01);
r_hdfc_all_l6m=round(HDFC_L6m_trades/L6m_trades,0.01);
r_hdfc_all_l12m=round(HDFC_L12m_trades/L12m_trades,0.01);
r_hdfc_all_l24m=round(HDFC_L24m_trades/L24m_trades,0.01);
r_hdfc_all_l36m=round(HDFC_L36m_trades/L36m_trades,0.01);

/*********proportion of Unsecured curr balance to total curr balance**********/

unsec_live_loans_r3=round(unsec_live_loans_cbal/All_live_loans_cbal,0.01);

/********Proportion of loans opened in the recent 3/6/9/12 months to the total number of loans**/

r_L3m_all_trades=round(L3m_trades/All_trades,0.01);
r_L6m_all_trades=round(L6m_trades/All_trades,0.01);
r_L12m_all_trades=round(L12m_trades/All_trades,0.01);
r_L24m_all_trades=round(L24m_trades/All_trades,0.01);
r_L36m_all_trades=round(L36m_trades/All_trades,0.01);

/*****no of cards as a proportion of total trades (count)*********/

r