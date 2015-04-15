fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
library(XML)
BaltRestdata <- xmlTreeParse(fileUrl, useInternal=TRUE)

dateDownloaded <- date()
dateDownloaded

rootNode <- xmlRoot(BaltRestdata)
xmlName(rootNode)
names(rootNode)

zipvector <- xpathSApply(BaltRestdata,"//row/zipcode", xmlValue)
length(zipvector[zipvector=="21231"])
