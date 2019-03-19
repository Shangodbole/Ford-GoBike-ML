library("lubridate")
library("reshape")
library("data.table")
library("RCurl")
library("tidyverse")
library("skimr")
library("ggplot2")
library("lubridate")
library("rjson")

### Merge all summarized FGB, Weather, and distance/weather data
rm(list=ls())
cc=function(x,y="\\ "){
  strsplit(x,y)[[1]]
}

setwd("~/ford-gobike-ml/Raw Data")
load("FGB.RData") #FGB
byv=c("StartCity","EndCity","StartDate","StartHr","StartMonthLabel","StartYear","StartDayType")
FGB[["Count"]]=1

setwd("~/ford-gobike-ml")
dis=fread("FGB Google API Distance and Times.csv")
mode(FGB[["EndStationID"]])='numeric'
mode(FGB[["StartStationID"]])='numeric'
FGB=merge(FGB,dis,by=c("EndStationID","StartStationID","StartCity","EndCity"),all.x=T)

hourly=FGB[,sum(Count),byv]
colnames(hourly)[ncol(hourly)]="Count"
hourly=hourly[!(is.na(hourly[["StartCity"]]) | is.na(hourly[["EndCity"]])),]


hourly2=FGB[,sum(na.omit(DurationSec)),byv]
colnames(hourly2)[ncol(hourly2)]="TotalActualSeconds"
hourly2=hourly2[!(is.na(hourly2[["StartCity"]]) | is.na(hourly2[["EndCity"]])),]
hourly=merge(hourly,hourly2)

hourly2=FGB[,sum(na.omit(Meters)),byv]
colnames(hourly2)[ncol(hourly2)]="TotalGoogpleAPIMeters"
hourly2=hourly2[!(is.na(hourly2[["StartCity"]]) | is.na(hourly2[["EndCity"]])),]
hourly=merge(hourly,hourly2)

hourly2=FGB[,sum(na.omit(Seconds)),byv]
colnames(hourly2)[ncol(hourly2)]="TotalGoogpleAPISeconds"
hourly2=hourly2[!(is.na(hourly2[["StartCity"]]) | is.na(hourly2[["EndCity"]])),]
hourly=merge(hourly,hourly2)



cities=unique(hourly[["StartCity"]])
dates=unique(hourly[["StartDate"]])

hrs=unique(hourly[["StartHr"]])
setwd("~/ford-gobike-ml/Clean Data")
  all=merge(cities,cities)
  all=merge(all,as.data.table(dates))
  all=merge(all,as.data.table(hrs))
  all=as.data.table(all)
  colnames(all)=cc("StartCity EndCity StartDate StartHr")
  all=merge(all,hourly,by=colnames(all),all.x = TRUE)
  all[["StartMonthLabel"]]=lubridate::month(all[["StartDate"]],T)
  all[["StartYear"]]=year(all[["StartDate"]])
  all[["StartDayType"]]=as.character(lubridate::wday(all[["StartDate"]],T))
  all[is.na(all[["Count"]]),][["Count"]]=0
  all[is.na(all),]=0
  

setwd("~/Ford-GoBike-ML/Clean Data")
weather=fread("Hourly SF OAK Weather.csv")

setwd("~/Ford-GoBike-ML")
load("FGB Google API Distance and Times.RData") #out

all


table(weather[["Site"]])
weather[is.na(weather)]=0
weather=weather[,!"Source"]

weather[["Date"]]=ymd(weather[["Date"]])
mode(weather[["Date"]])
colnames(weather)[colnames(weather)=="Date"]="StartDate"
colnames(weather)[colnames(weather)=="Hour"]="StartHr"
weather[["v"]]=paste(weather[["StartDate"]],weather[["StartHr"]],weather[["Site"]])
weather=weather[!duplicated(weather[["v"]]),]
weather=weather[,!"v"]


koak=weather[weather[["Site"]]=="KOAK",]
ksfo=weather[weather[["Site"]]=="KSFO",]
colnames(koak)[4:ncol(koak)]=paste0("KOAK",colnames(koak)[4:ncol(koak)])
colnames(ksfo)[4:ncol(ksfo)]=paste0("KFSO",colnames(ksfo)[4:ncol(ksfo)])
kfso=ksfo[,!"Site"]
koak=koak[,!"Site"]


all=all[year(all[["StartDate"]])!=2019,]

all=merge(all,kfso,all.x=T,by=c("StartDate","StartHr"))
all=merge(all,koak,all.x=T,by=c("StartDate","StartHr"))


mode(all[["StartDate"]])
mode(weather[["StartDate"]])
mode(all[["StartHr"]])
mode(weather[["StartHr"]])
fwrite(all,"Summarized Trip Data (with google api) and Weather Data.csv")
all
