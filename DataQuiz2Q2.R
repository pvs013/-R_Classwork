url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
acs <- read.csv(url)

library(sqldf)
sqldf("select pwgtp1 from acs where AGEP < 50")
#sqldf("select * from acs where AGEP < 50")
#sqldf("select * from acs where AGEP < 50 and pwgtp1")
#sqldf("select pwgtp1 from acs")

a <- unique(acs$AGEP)
b <- sqldf("select distinct AGEP from acs")
a == b


