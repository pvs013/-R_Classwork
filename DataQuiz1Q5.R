fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/IdahoHousing2.csv", method = "curl")

dateDownloaded <- date()
dateDownloaded

library(data.table)

DT <- fread("./data/IdahoHousing2.csv", sep=",")

system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))  ## fastest
##mean(DT$pwgtp15,by=DT$SEX)   # wrong answer
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15)); system.time(mean(DT[DT$SEX==2,]$pwgtp15))
#rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]    # wrong answer