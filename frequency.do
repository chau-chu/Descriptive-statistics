use 2005-2007.dta, clear   // Dataset created from Vietnamdata>merge_data.do 
*===================================================================*
*=========   Find number of firms existing in all waves    =========*
*===================================================================*

by q1, sort: gen freq=_N
eststo freq: estpost tabulate freq
esttab freq using sum_2.rtf, modelwidth(16) cells("b(fmt(%9.0gc) label(Number of firms)) pct(fmt(2) label(Percentage)) cumpct(fmt(2) label(Cumulative))") eqlabel(,lhs("No. of years per firm")) noobs replace

*===================================================================*
*========================   Time frequency    ======================*
*===================================================================*
eststo freq1: estpost tabulate t
esttab freq1 using sum_3.rtf, modelwidth(16) cells("b(fmt(%9.0gc) label(Number of firms)) pct(fmt(2) label(Percentage)) cumpct(fmt(2) label(Cumulative))") noobs replace






