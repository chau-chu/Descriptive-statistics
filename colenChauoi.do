clear 
set more off

//3rd Jan2019: Chau chot lay K=physical assets year end; L=full-time workers year end (--> cac bien lay trong Economic Account nhe) 

*1. RENAME
*cd M:\vietnam\2016   // If you download files to your folders, make sure you change this directory path.
use sme2005_distributionOK.dta, clear 
sort q1

keep q1 q5 q6ab q7a q12 q14b_09 q14b_10 q17a  q26d q47a q102k q104a q79b_01 kt3_01 kt3_02 kt3_03 kt3_05 kt3_08 kt3_09 kt3_10 kt3_11 kt3_16 kt3_22 
recode q5 (2 3=1) (1 4=2), gen(q5new) //industrial zone/park = code 1
rename q5new industrialzone
rename q6ab yearstart
rename q7a taxcode //1=Yes, 2= No
rename q12 ownership
rename q14b_09 accessroad
rename q14b_10 accessrail
rename q17a isic
rename q26d owneredu
rename q47a export
rename q102k totalasset
rename q104a totaldebt
rename q79b_01 labourall

rename kt3_01 sales
rename kt3_02 output
rename kt3_03 extraincome
rename kt3_05 directcosts
rename kt3_08 grossprofit
rename kt3_09 depreciation
rename kt3_10 ipaymentpnl
rename kt3_11 tax
rename kt3_16 capital
rename kt3_22 labour

gen t=2005
save 2005.dta,replace
********************************************************************************

use sme2007_distributionOK.dta, clear 

sort q1

keep q1 q5 q6a q7a q12 q14a q14c q17a q26d q44 q93c q95 q73b_1 kt3_01 kt3_02 kt3_03 kt3_05 kt3_09 kt3_10 kt3_11 kt3_12 kt3_17 kt3_23 

rename q5new industrialzone // 1= Industrial zone/park, 2= No
rename q6a yearstart
rename q7a taxcode //1=Yes, 2= No
rename q12 ownership
rename q14a accessroad
rename q14c accessrail
rename q17a isic
rename q26d owneredu
rename q44 export
rename q93c totalasset
rename q95 totaldebt
rename q73b_1 labourall

rename kt3_01 sales
rename kt3_02 output
rename kt3_03 extraincome
rename kt3_05 directcosts
rename kt3_09 grossprofit
rename kt3_10 depreciation
rename kt3_11 ipaymentpnl
rename kt3_12 tax
rename kt3_17 capital
rename kt3_23 labour

gen t=2007
save 2007.dta,replace


******************************************************************
*2. APPEND
use m:\vietnam\2016\2005.dta, clear
drop if q1==.
sort q1
save m:\vietnam\2016\2005a.dta, replace

use m:\vietnam\2016\2007.dta, clear
drop if q1==.
sort q1
save m:\vietnam\2016\2007a.dta, replace


use m:\vietnam\2016\2005a.dta, clear
append using m:\vietnam\2016\2007a.dta
sort q1
save m:\vietnam\2016\2005-07b.dta , replace

******************************************************************
*3. LABEL

label var q1 "Firm ID"
label var industrialzone "Firms belong to Industrial zone/Park"
label var yearstart "Year of establishment"
label var taxcode "Firms have tax code"
label var ownership "Types of ownership"
label var accessroad "Easy access to main road"
label var accessrail "Easy access to rail"
label var isic "Name of goods/services" 
label var owneredu "Education levels of owners/managers"
label var export "Export"
label var totalasset "Total assets "
label var totaldebt "Total liabilities last year "
label var labourall "Total work force number " 

label var sales "Revenue from sales"
label var output "Production output"
label var extraincome "Additional income" 
label var directcosts "Value of direct costs"
label var grossprofit "Total grossprofit"
label var depreciation "Value of depreciation"
label var ipaymentpnl "total interest payment"
label var tax "Total fee and taxes (formal)"
label var capital "Market value of total physical assets "
label var labour "Total work force number -Full-time equivalent workers" 

saveold "M:\vietnam\2016\vietnamnhieu.dta", version(12) replace




*Difference Mean ttest neeeee. 
use 2005-07b.dta, clear
mat T = J(8,4,.)
ttest output, by(taxcode)
mat T[1,1] = r(mu_1)
mat T[1,2] = r(mu_2)
mat T[1,3] = r(mu_1) - r(mu_2)
mat T[1,4] = r(p)

ttest sales, by(taxcode)
mat T[2,1] = r(mu_1)
mat T[2,2] = r(mu_2)
mat T[2,3] = r(mu_1) - r(mu_2)
mat T[2,4] = r(p)

ttest capital, by(taxcode)
mat T[3,1] = r(mu_1)
mat T[3,2] = r(mu_2)
mat T[3,3] = r(mu_1) - r(mu_2)
mat T[3,4] = r(p)

ttest accessroad, by(taxcode)
mat T[4,1] = r(mu_1)
mat T[4,2] = r(mu_2)
mat T[4,3] = r(mu_1) - r(mu_2)
mat T[4,4] = r(p)

ttest accessrail, by(taxcode)
mat T[5,1] = r(mu_1)
mat T[5,2] = r(mu_2)
mat T[5,3] = r(mu_1) - r(mu_2)
mat T[5,4] = r(p)

ttest export, by(taxcode)
mat T[6,1] = r(mu_1)
mat T[6,2] = r(mu_2)
mat T[6,3] = r(mu_1) - r(mu_2)
mat T[6,4] = r(p)

ttest totalasset, by(taxcode)
mat T[7,1] = r(mu_1)
mat T[7,2] = r(mu_2)
mat T[7,3] = r(mu_1) - r(mu_2)
mat T[7,4] = r(p)

ttest totaldebt, by(taxcode)
mat T[8,1] = r(mu_1)
mat T[8,2] = r(mu_2)
mat T[8,3] = r(mu_1) - r(mu_2)
mat T[8,4] = r(p)

mat rownames T = output sales capital accessroad accessrail export totalasset totaldebt
frmttable using ttest.doc, statmat(T) varlabels replace ctitle("",Sample1mean, Sample1mean, Difference "(p-value)")


*TABLE 1: Find number of firms existing in all waves:
by q1, sort: gen freq=_N
eststo freq: estpost tabulate freq
esttab freq using sum_2.rtf, modelwidth(16) cells("b(fmt(%9.0gc) label(Number of firms)) pct(fmt(2) label(Percentage)) cumpct(fmt(2) label(Cumulative))") eqlabel(,lhs("No. of years per firm")) noobs replace
display "No. of Firms existing in all waves is " = 5780/5 /*1156, total firms: 13136*/


*Time frequency
eststo freq1: estpost tabulate t
esttab freq1 using sum_3.rtf, modelwidth(16) cells("b(fmt(%9.0gc) label(Number of firms)) pct(fmt(2) label(Percentage)) cumpct(fmt(2) label(Cumulative))") noobs replace

*******************************************************
*TABLE 2: Questions of firm share of financing sources 
*drop if invcost==0

label def percent 0 "<10%" 10 "10% - 25%" 25 "25% - 50%" 50 "50% - 75%" 75 "75% - 90%" 90 ">90%"
egen outputcut= cut(output), at(0,10,25,50,75,90,101) /* Note: 0 means 0 to 10, but not include 10*/
egen salescut= cut(sales), at(0,10,25,50,75,90,101) 
egen totalassetcut= cut(totalasset), at(0,10,25,50,75,90,101) 
egen totaldebtcut= cut(totaldebt), at(0,10,25,50,75,90,101) 

*Table 2 - Panel A
eststo finance1: quietly estpost tab outputcut
eststo finance2: quietly estpost tab salescut
eststo finance3: quietly estpost tab totalassetcut
eststo finance4: quietly estpost tab totaldebtcut
esttab  finance1 finance2 finance3 finance4  using sum_3.rtf, replace cells("pct(fmt(2) label(%))") mtitles ("Output" "Sales" "Total Assets" "Total debt") title("Financial factors by percentage") addnotes(Sources: Calculations by authors)





*********************************************************






********************************************************************************



