clear 
set more off

use 2005-07.dta, clear //dataset created from repository Vietnamdata>merge_data.do 
*******************************************************
*========        Percentage cuts   ========*
*******************************************************
*1. USE "CUT" COMMAND for share of financial factors
label def percent 0 "<10%" 10 "10% - 25%" 25 "25% - 50%" 50 "50% - 75%" 75 "75% - 90%" 90 ">90%"
foreach var of varlist output sales totalasset totaldebt {
  egen `var'cut= cut(`var'), at(0,10,25,50,75,90,101) /* Note: 0 means 0 to 10, but not include 10*/
}

eststo finance1: quietly estpost tab outputcut
eststo finance2: quietly estpost tab salescut
eststo finance3: quietly estpost tab totalassetcut
eststo finance4: quietly estpost tab totaldebtcut
esttab  finance*  using sum_3.rtf, replace cells("pct(fmt(2) label(%))") mtitles ("Output" "Sales" "Total Assets" "Total debt") title("Financial factors by percentage") addnotes(Sources: Calculations by authors)

********************************************************
*2. USE "PCTILE" COMMAND for Output (in logs)
g lnoutput=log(lnoutput)
_pctile lnoutput, p(5 10 25 50 75 90 95)
forv i=1/7 {
	gen lnoutputq_`i'=r(r`i')
}
gen quart=1 if lnoutput<=lnoutputq_1
replace quart=2 if lnoutput>lnoutputq_1 & lnoutput<=lnoutputq_2
replace quart=3 if lnoutput>lnoutputq_2 & lnoutput<=lnoutputq_3
replace quart=4 if lnoutput>lnoutputq_3 & lnoutput<=lnoutputq_4
replace quart=5 if lnoutput>lnoutputq_4 & lnoutput<=lnoutputq_5
replace quart=6 if lnoutput>lnoutputq_5 & lnoutput<=lnoutputq_6
replace quart=7 if lnoutput>lnoutputq_6 & lnoutput<=lnoutputq_7
replace quart=8 if lnoutput>lnoutputq_7 

su lnoutputq_*
tabstat lnoutput, stat (n mean min max sd p50) by(quart) 
