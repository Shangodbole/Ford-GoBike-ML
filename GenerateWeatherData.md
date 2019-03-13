---
title: "Historic Download Weather Data (2017-2018)"
author: "Alec Lepe"
date: "03/05/2018"
output: 
  html_document:
    keep_md: true
---






### Lookup Hourly Weather Data for San Francisco and Oakland

```
## Warning in dir.create("~/Desktop/Projects/Ford-GoBike-ML/Raw Data"): '/
## Users/alec/Desktop/Projects/Ford-GoBike-ML/Raw Data' already exists
```

```
## Warning in dir.create("~/Desktop/Projects/Ford-GoBike-ML/Clean Data"): '/
## Users/alec/Desktop/Projects/Ford-GoBike-ML/Clean Data' already exists
```

```
##          Site               Date Hour Temperature Dewpoint RH WindDir
##       1: CYXX 11/15/2017 0:00:00    7          46       39 76     140
##       2: CYXX 11/15/2017 0:00:00    8          45       39 81     170
##       3: CYXX 11/15/2017 0:00:00    9          45       41 86     170
##       4: CYXX 11/15/2017 0:00:00   10          45       43 93     200
##       5: CYXX 11/15/2017 0:00:00    6          46       40 79     140
##      ---                                                             
## 7194188: MMOX 12/31/2018 0:00:00   19          70       65 84     270
## 7194189: MMOX 12/31/2018 0:00:00   20          68       63 84     270
## 7194190: MMOX 12/31/2018 0:00:00   21          64       61 90     270
## 7194191: MMOX 12/31/2018 0:00:00   22          62       58 87     270
## 7194192: MMOX 12/31/2018 0:00:00   23          60       56 87     270
##          Windspeed CldFrac  MSLP Weather Precip Source
##       1:        14       1 29.60     -RA      0    NWS
##       2:        16       1 29.63     OVC      0    NWS
##       3:        14       1 29.64     OVC     NA Filled
##       4:        13       1 29.64   -SHRA      0    NWS
##       5:        12       1 29.61     OVC     NA Filled
##      ---                                              
## 7194188:         3      NA    NA              0 Filled
## 7194189:         3      NA    NA              0 Filled
## 7194190:         3      NA    NA              0 Filled
## 7194191:         3      NA    NA              0 Filled
## 7194192:         3      NA    NA              0 Filled
```

```
##     Site4          City TimeZone OffUTC State   Lat     Lon
##  1:  KACV        EUREKA      PST     -8    CA 40.98 -124.10
##  2:  KBFL   BAKERSFIELD      PST     -8    CA 35.43 -119.05
##  3:  KBUR       BURBANK      PST     -8    CA 34.20 -118.35
##  4:  KCQT   LOS ANGELES      PST     -8    CA 34.03 -118.30
##  5:  KDAG       DAGGETT      PST     -8    CA 34.87 -116.78
##  6:  KFAT        FRESNO      PST     -8    CA 36.78 -119.71
##  7:  KLAX   LOS ANGELES      PST     -8    CA 33.93 -118.40
##  8:  KLGB    LONG BEACH      PST     -8    CA 33.82 -118.16
##  9:  KMYF     SAN DIEGO      PST     -8    CA 32.82 -117.15
## 10:  KOAK       OAKLAND      PST     -8    CA 37.71 -122.21
## 11:  KRDD       REDDING      PST     -8    CA 40.31 -122.18
## 12:  KRIV     RIVERSIDE      PST     -8    CA 33.90 -117.25
## 13:  KSAC    SACRAMENTO      PST     -8    CA 38.50 -121.49
## 14:  KSAN     SAN DIEGO      PST     -8    CA 32.73 -117.16
## 15:  KSBA SANTA BARBARA      PST     -8    CA 34.43 -119.85
## 16:  KSFO SAN FRANCISCO      PST     -8    CA 37.61 -122.39
## 17:  KUKI         UKIAH      PST     -8    CA 39.13 -123.20
##     Elevation(feet)
##  1:             220
##  2:             495
##  3:             712
##  4:             184
##  5:            1926
##  6:             341
##  7:             151
##  8:              33
##  9:             446
## 10:              85
## 11:             509
## 12:            1539
## 13:              36
## 14:              39
## 15:              10
## 16:              10
## 17:             614
```

```
##    Site4          City TimeZone OffUTC State   Lat     Lon Elevation(feet)
## 1:  KOAK       OAKLAND      PST     -8    CA 37.71 -122.21              85
## 2:  KSFO SAN FRANCISCO      PST     -8    CA 37.61 -122.39              10
```

```
##    Site
## 1: KOAK
## 2: KSFO
```

### Merge Data

```
## Warning in ann(all): NAs introduced by coercion

## Warning in ann(all): NAs introduced by coercion

## Warning in ann(all): NAs introduced by coercion

## Warning in ann(all): NAs introduced by coercion

## Warning in ann(all): NAs introduced by coercion
```

```
## Warning in ann(as.data.table(as.data.frame(sfdaily))): NAs introduced by
## coercion

## Warning in ann(as.data.table(as.data.frame(sfdaily))): NAs introduced by
## coercion
```
