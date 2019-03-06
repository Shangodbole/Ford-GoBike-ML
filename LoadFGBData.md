---
title: "Ford GoBike Load Data"
author: "Alec Lepe"
date: "02/12/2018"
output: 
  html_document:
    keep_md: true
---







### Load Data


### Generate Station Library and Attach Starting and Ending Cities to FGB

```
## Warning in readLines(json_file): incomplete final line found on 'https://
## gbfs.fordgobike.com/gbfs/en/station_information.json'
```

```
## Warning in ann(Stations): NAs introduced by coercion

## Warning in ann(Stations): NAs introduced by coercion

## Warning in ann(Stations): NAs introduced by coercion

## Warning in ann(Stations): NAs introduced by coercion

## Warning in ann(Stations): NAs introduced by coercion

## Warning in ann(Stations): NAs introduced by coercion

## Warning in ann(Stations): NAs introduced by coercion

## Warning in ann(Stations): NAs introduced by coercion

## Warning in ann(Stations): NAs introduced by coercion
```

```
## Warning in readLines(json_file): incomplete final line found on 'https://
## gbfs.fordgobike.com/gbfs/en/system_regions.json'
```

### Extract date data from start_time and end_time variables

