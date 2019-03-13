library("data.table")
library("RCurl")
library("tidyverse")
library("skimr")
library("ggplot2")
library("lubridate")
library("rjson")
cc=function(x,y="\\ "){
  strsplit(x,y)[[1]]
}
GenMatrix=function(cns,name){
  y=matrix(ncol=length(cns),nrow=0)
  colnames(y)=cns
  assign(paste(name),y,envir=.GlobalEnv)
}
reordordt=function(dt,names){
  r=dt[[names[1]]]
  r=adt(r)
  for (i in names[2:length(names)]){
    r=cbind(r,dt[[i]])
  }
  colnames(r)=names
  return(r)
}
adt=function(x){
  as.data.table(x)
}

json_file="https://gbfs.fordgobike.com/gbfs/en/station_information.json"
StationInfo=fromJSON(paste(readLines(json_file), collapse=","))

StationList=StationInfo[[3]][[1]]
#unlist(lapply(StationList,function(x) length(names(x))))
GenMatrix(names(StationList[[1]]),"y")
y=as.data.table(y)
for (i in 1:length(StationList)){
  y=rbindlist(list(y,as.data.table(StationList[[i]])),fill=T)
}
Stations=y
Stations=Stations[!duplicated(Stations[["station_id"]]),]


json_file="https://gbfs.fordgobike.com/gbfs/en/system_regions.json"
SystemRegions=fromJSON(paste(readLines(json_file), collapse=","))

x=as.vector(unlist(SystemRegions$data[[1]]))
GenMatrix(c("region_id","City"),"y")
for (i in seq(1,length(x)-1,2)){
  y=rbind(y,c(x[i],x[i+1]))
}
RegionIDs=data.table(y)
mode(RegionIDs[["region_id"]])="numeric"
RegionIDs
Stations=merge(Stations,RegionIDs,by="region_id")
Stations=Stations[,!"eightd_station_services",with=F]


EastBayCities=c("Oakland","Emeryville","Berkeley")

EastBayCities

EastBayStations=Stations[Stations[["City"]] %in% EastBayCities,]
SFStations=Stations[Stations[["City"]] %in% "San Francisco",]
SanJoseStations=Stations[Stations[["City"]] %in% "San Jose",]

CityList=list(SFStations,EastBayStations,SanJoseStations)
### Logic Check
nrow(EastBayStations)+nrow(SanJoseStations)+nrow(SFStations)==nrow(Stations)
lapply(CityList,function(x) length(unique(x[['station_id']]))==nrow(x))
### Logic Check
nrow(EastBayStations)*nrow(EastBayStations)+nrow(SanJoseStations)*nrow(SanJoseStations)+nrow(SFStations)*nrow(SFStations)
# load("FGB Distances.RData")
# rm(out)
# GenMatrix(cc("StartStationID StartLatitude StartLongitude EndStationID EndLatitude EndLongitude City StartName EndName Status Distance Distance2 Duration Duration2"),'out')
# out=as.data.table(out)
# colnames(out)[7]="StartCity"
# out[["EndCity"]]=""
#out[["EndCity"]]="San Francisco"
out=reordordt(out,c(setdiff(colnames(out),c("StartCity","EndCity")),c("StartCity","EndCity")))
ApiKey="XXXXSyB-cdXo7m7UTcJBZD58dRLgR5iOlto-t68"
ApiKey="XXXXSyAa4hXQNJby1V3vhQP4GW7KTkcO4MKo-4Y"
for (db in CityList[1:3]){
  db[["station_id"]]
  sts=unique(db[["station_id"]])
  for (o in sts){
    print(o)
    timestamp()
    for (d in setdiff(sts,o)){
      yx=out[out[["StartStationID"]]==o & out[["EndStationID"]]==d,]
      if (nrow(yx)==0){
        addon=as.numeric(c(o,
                           db[db[["station_id"]]==o,][["lat"]],
                           db[db[["station_id"]]==o,][["lon"]],
                           d,
                           db[db[["station_id"]]==d,][["lat"]],
                           db[db[["station_id"]]==d,][["lon"]]
        ))
        url=paste0('https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=',paste0(addon[2:3],collapse=","),
                   '&destinations=',paste0(addon[5:6],collapse=","),'&mode=bicycling&key=',ApiKey)
        r=jsonlite::fromJSON(url,flatten=T)    
        if (r$status=="OK"){
          addon=c(addon,
                  r$origin_addresses,
                  r$destination_addresses,
                  unlist(as.vector(r$row)))
          addon=c(addon,db[db[["station_id"]]==o,][["City"]])
          addon=c(addon,db[db[["station_id"]]==d,][["City"]])
          
          length(addon)
          addon=as.data.table(t(as.data.table(addon)))
          out=rbindlist(list(out,addon))
        } else {
          sys
        }
      }
    }
  }
}
nrow(out)
save.image("FGB Distances.RData") #43476
table(out[["Status"]])
colnames(out)[colnames(out)=="Distance2"]="Meters"
colnames(out)[colnames(out)=="Duration2"]="Seconds"
out[["Distance"]]=as.numeric(unlist(lapply(out[["Distance"]],function(x) strsplit(x,"\\ ")[[1]][1])))
out[["Hour"]]=0
out[["Time"]]=as.numeric(unlist(lapply(out[["Duration"]],function(x) strsplit(x,"\\ ")[[1]][length(strsplit(x,"\\ ")[[1]])-1])))
out[unlist(lapply(out[["Duration"]],function(x) length(strsplit(x,"\\ ")[[1]])))!=2,][["Hour"]]=1
out[out[["Hour"]]==1,][["Time"]]=out[out[["Hour"]]==1,][["Time"]]+60
out[["Minutes"]]=out[["Time"]]
out[["Miles"]]=out[["Distance"]]
out=out[,!"Duration"]
out=out[,!"Hour"]
out=out[,!"Distance"]
out=out[,!"Time"]
out=out[,!"Status"]


out=reordordt(out,c(setdiff(colnames(out),c("Meters","Seconds","Minutes","Miles")),c("Miles","Meters","Minutes","Seconds")))
apply(out,2,mode)
ac=function(x){
  return(as.character(x))
}
al=function(x){
  return(as.list(x))
}
av=function(x){
  return(as.vector(x))
}
ul=function(x){
  return(unlist(x))
}
un=function(x){
  return(unique(x))
}
an=function(x){
  return(as.numeric(x))
}
am=function(x){
  return(as.matrix(x))
}
nr=function(x){
  return(nrow(x))
}
nc=function(x){
  return(ncol(x))
}
am=function(x){
  return(as.matrix(x))
}
ann=function(x){
  if (is.matrix(x)){
    for (i in seq(1,ncol(x))){
      #z=all(an(unique(x[,i]))==unique(x[[i]]))
      z=all(an(unique(x[,i]))==ul(lapply(lapply(strsplit(un(x[,i]),""),function(x) x[x!="" & x!=" "]),function(x)paste(x,collapse=""))))
      if(!is.na(z) | sum(is.na(an(x[,i])))==0){
        if (z){
          mode(x[,i])='numeric'
        }
      }
    }
  } else {
    for (i in seq(1,ncol(x))){
      #        print(i)
      z=all(an(unique(x[[i]]))==ul(lapply(lapply(strsplit(ac(un(x[[i]])),""),function(x) x[x!="" & x!=" "]),function(x)paste(x,collapse=""))))
      #        z=z | all(an(ac(x[[i]]))==an(ac(x[[i]])))
      if (!is.na(z)){
        yz="0 " %in% x[[i]] | " 0" %in% x[[i]]
        if (sum(is.na(an(x[[i]])))==0 | z | yz){
          if (!(colnames(x)[i] %in% c("Ticket","action","VAR1","Ticket_SN","Smart_Card_SN"))){
            mode(x[[i]])='numeric'
          }
        } 
        
      }
    }
  }
  return(x)
}

out=ann(out)
out
for (i in seq(1,ncol(out))){
  print(paste(colnames(out)[i],mode(out[[i]])))
}
# temp=head(out)
# out[["GoogleAPIURL"]]=paste0('https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=',paste0(out[["StartLatitude"]],out[["StartLongitude"]],collapse=","),
                             # '&destinations=',paste0(out[["EndLatitude"]],out[["EndLongitude"]],collapse=","),'&mode=bicycling&key=XXXXX')


out[["GoogleAPIURL"]]=paste0('https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=',out[["StartLatitude"]],",",out[["StartLongitude"]],
                             '&destinations=',out[["EndLatitude"]],",",out[["EndLongitude"]],'&mode=bicycling&key=XXXXX')
timestamp()

save(out,file="FGB Google API Distance and Times.RData")
timestamp()


# BART Stations
Stations[agrepl("BART",Stations[["name"]]),]


### EXTRA CODE











hms(names(table(out[["Duration"]])))

out[out[["StartCity"]]=="Berkeley" & agrepl("BART",out[["StationName"]]),]

out[out[[1]]==245,]


table(out[["Distance"]])



url='https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=Washington,DC&destinations=New+York+City,NY&key=YOUR_API_KEY'

"https://maps.googleapis.com/maps/api/distancematrix/json?origins=Vancouver+BC|Seattle&destinations=San+Francisco|Victoria+BC&mode=bicycling&language=fr-FR&key=YOUR_API_KEY"
