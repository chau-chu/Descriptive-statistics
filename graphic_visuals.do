clear 
set more off

use 2005-07.dta, clear //dataset created from repository Vietnamdata>merge_data.do 
*******************************************************
*========      Graphic visualisations         ========*
*******************************************************
*1. Kernel density distribution for output (in logs) visualisation of firms with and without export behaviours and those operating in and outside industrial zone
kdensity lnoutput if export==1 & industrialzone==1, addplot (kdensity lnoutput if export==1 & industrialzone==0 || kdensity lnoutput if export==0 & industrialzone==1 || kdensity lnoutput if export==0 & industrialzone==0) legend (label (1 "Export, in Industrial Zone") label(2 "Export, outside Industrial Zone") label(3 "no Export, in Industrial Zone") label(4 "no Export, outside Industrial Zone"))   

*******************************************************

*2. Histogram distribution to visualise these above characteristics of firms
twoway (histogram lnoutput if export==1 & industrialzone==1, color(red))(histogram lnoutput if export==1 & industrialzone==0, fcolor(none) lcolor(black)), legend(order(1 "Export, in Industrial Zone" 2 "Export, outside Industrial Zone")) name(fig1)

twoway (histogram lnoutput if export==0 & industrialzone==1, color(red))(histogram lnoutput if export==0 & industrialzone==0, fcolor(none) lcolor(black)), legend(order(1 "no Export, in Industrial Zone" 2 "no Export, outside Industrial Zone")) name(fig2)




