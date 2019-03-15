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


setwd("~/Ford-GoBike-ML/Clean Data")
load("Summarized FGB.RData") #all
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
all



