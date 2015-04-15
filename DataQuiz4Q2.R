fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/GDPdata.csv", method = "curl")

dateDownloaded <- date()
dateDownloaded

dset <- read.csv("./data/GDPdata.csv")

## remove commas from GDP numbers in millions of dollars and average them
dset2 <- dset[5:194,]
v1 <- dset2$X.3
mean(as.numeric(gsub(",","",v1)))





