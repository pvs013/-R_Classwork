library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

library(lubridate)

## how many values collected in 2012?
v2 <- grep("2012", year(sampleTimes))
str(v2)

## how many values were collected on mondays in 2012?
v3 <- grep("2", wday(sampleTimes[v2]))
str(v3)
