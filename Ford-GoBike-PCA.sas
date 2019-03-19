PROC IMPORT OUT= SumTripWeather 
            DATAFILE= "Summarized Trip Data and Weather Data.csv"
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2;
	 label
		StartDate = Starting Date
	 	StartDayTypeN = Start Day
		StartDayType = Starting Day
		StartHr = Start Hour
		StartCity = Starting City
		StartCityN = Start City
		EndCity = Ending City
		EndCityN = End City
		KFSOTemperature = San Francisco Temperature
		KFSODewpoint = San Francisco Dewpoint
		KOAKTemperature = Oakland Temperature
		KOAKDewpoint = Oakland Dewpoint
		KOAKWindspeed = Oakland Windspeed
		KOAKWindDir = Oakland Wind Direction
		KFSOWindspeed = San Francisco Windspeed
		KFSOWindDir = San Francisco Direction
		KOAKRH = Oakland Relative Humidity
		KFSORH = San Francisco Relative Humidity
		KOAKCldFrac = Oakland fraction of sky covered
		KFSOCldFrac = San Francisco fraction of sky covered
		KFSOMSLP = San Francisco Mean Sea Level Pressure
		KOAKMSLP = Oakland Mean Sea Level Pressure
;
run;

*Convert data to numeric / clean up;
data SumTripWeather;
set SumTripWeather;
If StartDayType='Sat' then StartDayTypeN=1;
If StartDayType='Sun' then StartDayTypeN=2;
If StartDayType='Mon' then StartDayTypeN=3;
If StartDayType='Tue' then StartDayTypeN=4;
If StartDayType='Wed' then StartDayTypeN=5;
If StartDayType='Thu' then StartDayTypeN=6;
If StartDayType='Fri' then StartDayTypeN=7;
If StartCity='Berkeley' then StartCityN=1;
If StartCity='Emeryville' then StartCityN=2;
If StartCity='Oakland' then StartCityN=3;
If StartCity='San Francisco' then StartCityN=4;
If StartCity='San Jose' then StartCityN=5;
If EndCity='Berkeley' then EndCityN=1;
If EndCity='Emeryville' then EndCityN=2;
If EndCity='Oakland' then EndCityN=3;
If EndCity='San Francisco' then EndCityN=4;
If EndCity='San Jose' then EndCityN=5;
If StartMonthLabel='Jan' then StartMonthLabelN=1;
If StartMonthLabel='Feb' then StartMonthLabelN=2;
If StartMonthLabel='Mar' then StartMonthLabelN=3;
If StartMonthLabel='Apr' then StartMonthLabelN=4;
If StartMonthLabel='May' then StartMonthLabelN=5;
If StartMonthLabel='Jun' then StartMonthLabelN=6;
If StartMonthLabel='Jul' then StartMonthLabelN=7;
If StartMonthLabel='Aug' then StartMonthLabelN=8;
If StartMonthLabel='Sep' then StartMonthLabelN=9;
If StartMonthLabel='Oct' then StartMonthLabelN=10;
If StartMonthLabel='Nov' then StartMonthLabelN=11;
If StartMonthLabel='Dec' then StartMonthLabelN=12;
If KFSOWeather='BCFG' then KFSOWeatherN=1;
If KFSOWeather='BKN' then KFSOWeatherN=2;
If KFSOWeather='BR' then KFSOWeatherN=3;
If KFSOWeather='CLR' then KFSOWeatherN=4;
If KFSOWeather='FEW' then KFSOWeatherN=5;
If KFSOWeather='FU' then KFSOWeatherN=6;
If KFSOWeather='HZ' then KFSOWeatherN=7;
If KFSOWeather='HZ FU' then KFSOWeatherN=8;
If KFSOWeather='OVC' then KFSOWeatherN=9;
If KFSOWeather='SCT' then KFSOWeatherN=10;
If KFSOWeather='#NAME?' then KFSOWeatherN=11;
If KFSOWeather='RA' then KFSOWeatherN=12;
If KFSOWeather='RA BR' then KFSOWeatherN=13;
If KFSOWeather='VCTS' then KFSOWeatherN=14;
If KFSOWeather='MIFG' then KFSOWeatherN=15;
If KFSOWeather='FG' then KFSOWeatherN=16;
If KFSOWeather='BR FU' then KFSOWeatherN=17;
If KFSOWeather='BR MF' then KFSOWeatherN=18;
If KFSOWeather='BR MIF' then KFSOWeatherN=19;
If KFSOWeather='MIFG B' then KFSOWeatherN=20;
If KFSOWeather='BR BCF' then KFSOWeatherN=21;
If KFSOWeather='TS' then KFSOWeatherN=22;
If KFSOWeather='' then KFSOWeatherN=23;
If KOAKWeather='BCFG' then KOAKWeatherN=1;
If KOAKWeather='BKN' then KOAKWeatherN=2;
If KOAKWeather='BR' then KOAKWeatherN=3;
If KOAKWeather='CLR' then KOAKWeatherN=4;
If KOAKWeather='FEW' then KOAKWeatherN=5;
If KOAKWeather='FU' then KOAKWeatherN=6;
If KOAKWeather='HZ' then KOAKWeatherN=7;
If KOAKWeather='HZ FU' then KOAKWeatherN=8;
If KOAKWeather='OVC' then KOAKWeatherN=9;
If KOAKWeather='SCT' then KOAKWeatherN=10;
If KOAKWeather='#NAME?' then KOAKWeatherN=11;
If KOAKWeather='RA' then KOAKWeatherN=12;
If KOAKWeather='RA BR' then KOAKWeatherN=13;
If KOAKWeather='VCTS' then KOAKWeatherN=14;
If KOAKWeather='MIFG' then KOAKWeatherN=15;
If KOAKWeather='FG' then KOAKWeatherN=16;
If KOAKWeather='BR FU' then KOAKWeatherN=17;
If KOAKWeather='BR MF' then KOAKWeatherN=18;
If KOAKWeather='BR MIF' then KOAKWeatherN=19;
If KOAKWeather='MIFG B' then KOAKWeatherN=20;
If KOAKWeather='BR BCF' then KOAKWeatherN=21;
If KOAKWeather='TS' then KOAKWeatherN=22;
If KOAKWeather='' then KOAKWeatherN=23;
If KOAKWindDir =<0 then KOAKWindDir=0;
If KFSOWindDir =<0 then KFSOWindDir=0;
If Count =<0 then Count=0;
*Use LogCount to help with visualization;
LogCount = log(Count+1);
If LogCount =<1 then LogCount=.;
RUN;


*Sort and print data to help find missing entries;
PROC SORT data = SumTripWeather;
by KOAKWindDir;
run;
Proc Print data=SumTripWeather (obs=100);
run;


*Some data exploration;
PROC SORT data = SumTripWeather;
by StartHr;
run;
title 'Shares Per Hours';
proc boxplot data=SumTripWeather;
   plot LogCount*StartHr;
   inset min mean max stddev /
      header = 'Overall Statistics'
      pos    = tm;
run;

PROC SORT data = SumTripWeather;
by StartDayType;
run;
title 'Shares Per Day';
proc boxplot data=SumTripWeather;
   plot LogCount*StartDayType;
   inset min mean max stddev /
      header = 'Overall Statistics'
      pos    = tm;
   insetgroup min max /
      header = 'Extremes by Day';
run;

PROC SORT data = SumTripWeather;
by StartMonthLabelN;
run;
title 'Shares Per Month';
proc boxplot data=SumTripWeather;
   plot LogCount*StartMonthLabelN;
   inset min mean max stddev /
      header = 'Overall Statistics'
      pos    = tm;
   insetgroup min max /
      header = 'Extremes by Month';
run;

PROC SORT data = SumTripWeather;
by StartCity;
run;
title 'Shares Per Starting City';
proc boxplot data=SumTripWeather;
   plot LogCount*StartCity;
   inset min mean max stddev /
      header = 'Overall Statistics'
      pos    = tm;
   insetgroup min max /
      header = 'Extremes by Starting City';
run;

*title ;
*proc univariate data=SumTripWeather;
*  histogram;
*run;


*StartDate StartHr StartCityN EndCityN StartMonthLabelN StartYear StartDayTypeN Count KFSOTemperature KFSODewpoint KFSORH KFSOWindspeed KFSOCldFrac 
KFSOMSLP KFSOWeatherN KFSOPrecip KOAKTemperature KOAKDewpoint KOAKRH KOAKWindspeed KOAKCldFrac KOAKMSLP KOAKWeatherN KOAKPrecip;



*SAS code for first run
principal components factor analysis
no rotation
all output printed
SAS select m the number of factors;
title ;
proc factor data=SumTripWeather
			method=prin
			REORDER
			ROUND
			rotate=none;
VAR StartDate StartHr StartCityN EndCityN StartMonthLabelN StartYear StartDayTypeN Count KFSOTemperature KFSODewpoint KFSORH KFSOWindDir KFSOWindspeed KFSOCldFrac KFSOMSLP KFSOWeatherN KFSOPrecip KOAKTemperature KOAKDewpoint KOAKRH KOAKWindDir KOAKWindspeed KOAKCldFrac KOAKMSLP KOAKWeatherN KOAKPrecip;
run;

*9 factors
varimax rotation
plotting the factor loadings
before and after rotation;
proc factor data=SumTripWeather
			m=prin
			NFACTORS=9
			rotate=v
			preplot
			plot all;
VAR StartDate StartHr StartCityN EndCityN StartMonthLabelN StartYear StartDayTypeN Count KFSOTemperature KFSODewpoint KFSORH KFSOWindDir KFSOWindspeed KFSOCldFrac KFSOMSLP KFSOWeatherN KFSOPrecip KOAKTemperature KOAKDewpoint KOAKRH KOAKWindDir KOAKWindspeed KOAKCldFrac KOAKMSLP KOAKWeatherN KOAKPrecip;
run;

*iterated principal factor analysis with varimax rotation.
The option heywood permits iteration to continue if the estimated uniqueness of a variable drops below 0;
proc factor data=SumTripWeather m=prinit NFACTORS=10 rotate=v preplot plot all heywood;
VAR StartDate StartHr StartCityN EndCityN StartMonthLabelN StartYear StartDayTypeN Count KFSOTemperature KFSODewpoint KFSORH KFSOWindDir KFSOWindspeed KFSOCldFrac KFSOMSLP KFSOWeatherN KFSOPrecip KOAKTemperature KOAKDewpoint KOAKRH KOAKWindDir KOAKWindspeed KOAKCldFrac KOAKMSLP KOAKWeatherN KOAKPrecip;
run;

*maximum likelihood;
title ;
proc factor data=SumTripWeather m=ml NFACTORS=10 ROTATE=VARIMAX preplot plot all heywood;
VAR StartDate StartHr StartCityN EndCityN StartMonthLabelN StartYear StartDayTypeN Count KFSOTemperature KFSODewpoint KFSORH KFSOWindDir KFSOWindspeed KFSOCldFrac KFSOMSLP KFSOWeatherN KFSOPrecip KOAKTemperature KOAKDewpoint KOAKRH KOAKWindDir KOAKWindspeed KOAKCldFrac KOAKMSLP KOAKWeatherN KOAKPrecip;
run;


*Main Test;
proc factor data=SumTripWeather
			SIMPLE
			METHOD=PRIN
			MINEIGEN=1
			SCREE
			REORDER
			ROUND
			ROTATE=VARIMAX
			FLAG=.50;
VAR StartDate StartHr StartCityN EndCityN StartMonthLabelN StartYear StartDayTypeN Count KFSOTemperature KFSODewpoint KFSORH KFSOWindDir KFSOWindspeed KFSOCldFrac KFSOMSLP KFSOWeatherN KFSOPrecip KOAKTemperature KOAKDewpoint KOAKRH KOAKWindDir KOAKWindspeed KOAKCldFrac KOAKMSLP KOAKWeatherN KOAKPrecip;
run;
proc factor data=SumTripWeather
			simple
			METHOD=PRIN
			COV
			PRIORS=ONE
			NFACTORS=9
			SCREE
			REORDER
			ROUND
			FLAG=.50
			ROTATE=VARIMAX
			OUT=PCATripWeather;
VAR StartDate StartHr StartCityN EndCityN StartMonthLabelN StartYear StartDayTypeN Count KFSOTemperature KFSODewpoint KFSORH KFSOWindDir KFSOWindspeed KFSOCldFrac KFSOMSLP KFSOWeatherN KFSOPrecip KOAKTemperature KOAKDewpoint KOAKRH KOAKWindDir KOAKWindspeed KOAKCldFrac KOAKMSLP KOAKWeatherN KOAKPrecip;
run;
proc corr data=PCATripWeather;
	var Factor1 Factor2 Factor3 Factor4 Factor5 Factor6 Factor7 Factor8 Factor9;
	with StartDate StartHr StartCityN EndCityN StartMonthLabelN StartYear StartDayTypeN Count KFSOTemperature KFSODewpoint KFSORH KFSOWindDir KFSOWindspeed KFSOCldFrac KFSOMSLP KFSOWeatherN KFSOPrecip KOAKTemperature KOAKDewpoint KOAKRH KOAKWindDir KOAKWindspeed KOAKCldFrac KOAKMSLP KOAKWeatherN KOAKPrecip Factor1 Factor2 Factor3 Factor4 Factor5 Factor6 Factor7 Factor8 Factor9;
run;

ods graphics on;
proc princomp data=SumTripWeather (drop=LogCount) COV n=4 standard plots=patternprofile out=PCATripWeather;
run;
ods graphics off;

*Plot Factor1 vs. Factor2 PC;
proc gplot;	
axis1 length=10 in;
axis2 length=10 in;
plot Factor1*Factor2 / vaxis=axis1 haxis=axis2;
symbol v=J f=special h=2 i=none color=black;
run;


proc pls data=SumTripWeather method=PCR nfac=5; /* PCR onto 5 factors */
   model StartHr = StartDate StartCityN EndCityN StartMonthLabelN StartYear StartDayTypeN Count KFSOTemperature KFSODewpoint KFSORH KFSOWindspeed KFSOCldFrac KFSOMSLP KFSOWeatherN KFSOPrecip KOAKTemperature KOAKDewpoint KOAKRH KOAKWindspeed KOAKCldFrac KOAKMSLP KOAKWeatherN KOAKPrecip / solution;
run;



/* Keep the first 1000 observations for scoring. 
 Compute the two first principal components on the rest */
proc princomp data=SumTripWeather(firstobs=1001) n=5 cov;
VAR StartDate StartHr StartCityN EndCityN StartMonthLabelN StartYear StartDayTypeN Count KFSOTemperature KFSODewpoint KFSORH KFSOWindspeed KFSOCldFrac KFSOMSLP KFSOWeatherN KFSOPrecip KOAKTemperature KOAKDewpoint KOAKRH KOAKWindspeed KOAKCldFrac KOAKMSLP KOAKWeatherN KOAKPrecip;
ods output Eigenvectors=EV;
run;

proc transpose data=ev out=evTransposed;
var Prin1 Prin2 Prin3 Prin4 Prin5;
id Variable;
run;

data prinScore;
set evTransposed;
_TYPE_ = "SCORE";
run;

/* Compute the first two component scores for the 
 first 1000 observations */
proc score data=SumTripWeather(obs=1000) score=prinScore out=scoredTripWeather; 
run;
