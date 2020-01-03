clear 
set more off

use 2005-07.dta, clear //dataset created from repository Vietnamdata>merge_data.do 
*******************************************************
*========     Correlation Matrix      ========*
*******************************************************
g lnoutput=log(output+1)  //tranform variables in natural logarithm
g lncapital=log(capital+1)
g lnlabour=log(labour+1)

pwcorr lnoutput lncapital lnlabour accessroad accessrail owneredu export, sig star(.05) bonferroni  // use Bonferroni-adjusted significance levels
ssc install logout 
local mylist "lnoutput lncapital lnlabour accessroad accessrail owneredu export"
logout, save("pwcorr.xls") excel replace: pwcorr `mylist', sig star(.05) bonferroni //export the excel file
