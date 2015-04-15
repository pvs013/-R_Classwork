fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
download.file(fileUrl, destfile = "./data/CommSurvey.csv", method = "curl")

dateDownloaded <- date()
dateDownloaded

dset <- read.csv("./data/CommSurvey.csv")

splitnames <- strsplit(names(dset), "wgtp")
splitnames[123]
