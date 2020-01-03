clear 
set more off

use 2005-07.dta, clear //dataset created from repository Vietnamdata>merge_data.do 
*******************************************************
*========        Share of financial factors   ========*
*******************************************************

label def percent 0 "<10%" 10 "10% - 25%" 25 "25% - 50%" 50 "50% - 75%" 75 "75% - 90%" 90 ">90%"
foreach var of varlist output sales totalasset totaldebt {
  egen `var'cut= cut(`var'), at(0,10,25,50,75,90,101) /* Note: 0 means 0 to 10, but not include 10*/
}

*Table 2 - Panel A
eststo finance1: quietly estpost tab outputcut
eststo finance2: quietly estpost tab salescut
eststo finance3: quietly estpost tab totalassetcut
eststo finance4: quietly estpost tab totaldebtcut
esttab  finance*  using sum_3.rtf, replace cells("pct(fmt(2) label(%))") mtitles ("Output" "Sales" "Total Assets" "Total debt") title("Financial factors by percentage") addnotes(Sources: Calculations by authors)
