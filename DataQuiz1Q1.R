fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/IdahoHousing.csv", method = "curl")

dateDownloaded <- date()
dateDownloaded

housing <- read.csv("./data/IdahoHousing.csv")
sum(housing$VAL==24, na.rm=TRUE)  ## code 24 is 1M+ value homes
