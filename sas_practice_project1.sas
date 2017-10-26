data Mark.Quarter2;
/*Department followed by dollar sign and 7. Means max of 7 variables */
length Department $7 Site $8;
/*you are inputting all the categories */
input Department Site Quarter Sales;
/*datalines is inputting the actual data*/
datalines;
Parts Sydney 1 403.97
Parts Atlanta 1 6225.26
Parts Paris 1 3543.97
Repairs Sydney 1 5592.82
Repairs Atlanta 1 9210.21
Repairs Paris 1 8591.98
Tools Sydney 1 1775.74
Tools Atlanta 1 2424.19
Tools Paris 1 5914.25
;
run;

/*now we split them all up into categories. */
Data Mark.Parts Mark.Repairs Mark.Tools;
set Mark.Quarter2;
/*if you use if 3 times, it'll also work */
if department="Parts" then output Mark.Parts;
if department="Repairs" then output Mark.Repairs;
/*else if followed by else Mark.Tools also works */
if department="Tools" then output Mark.Tools;
run;
/*make it so that bed table other has a table all for itself */
data Mark.Bed Mark.Table Mark.Other;
set Prdsale;
if product = "Bed" then output Mark.Bed;
If product = "Table" then output Mark.Table;
if product = "Other" then output Mark.Other;
run;

data Mark.Diabetes; 
/*no need for length command. Only a variable and space. The Sex$ has to be there, it doesn't register without */
input ID Sex $ Age Height Weight Pulse FastGlucose PostGlucose;
datalines;
2304 F 16 61 102 100 568 625  
1128 M 43 71 218 76 156 208 
4425 F 48 66 162 80 244 322 
1387 F 57 64 142 70 177 206 
9012 F 39 63 157 68 257 318 
6312 M 52 72 240 77 362 413 
5438 F 42 62 168 83 247 304 
3788 M 38 73 234 71 486 544 
;
run;
/*get new variables. Gluecostchange is postgluecost-fastglucost. Changegluecose is fastglucost+fastglucose. Avglucose is the 
mean of postgluecose and changeglucost*/
data Mark.GlucoseVar;
set Mark.Diabetes;
GluecoseChange = PostGlucose-FastGlucose;
/**.10 means 10% increase*/
ChangeGlucose = FastGlucose+FastGlucose*.10;
AvgGlucose= mean(PostGlucose, ChangeGlucose);
run;
