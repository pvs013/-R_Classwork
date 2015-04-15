fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/NaturalGasAcq.xlsx", method = "curl")

dateDownloaded <- date()
dateDownloaded

library(xlsx)
##NaturalGasData <- read.xlsx("./data/NaturalGasAcq.xlsx", sheetIndex=1, header=TRUE)
##head(NaturalGasData)

colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("./data/NaturalGasAcq.xlsx", sheetIndex=1, colIndex=colIndex, rowIndex = rowIndex)

sum(dat$Zip*dat$Ext,na.rm=T) 
