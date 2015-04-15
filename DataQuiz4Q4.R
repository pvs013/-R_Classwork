url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
gdp <- read.csv(url)

url2 <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
edu <- read.csv(url2)

summary(gdp)
summary(edu)

# cleanup gdp
c_gdp <- gdp[which(gdp$Gross.domestic.product.2012 !=""), ]
# match data on country shortcode
# Perform a merge
mdata <- merge(c_gdp, edu, by.x="X", by.y="CountryCode")#, all=FALSE)


## how many countries fiscal year ends in June
grep("Fiscal year end: June", v1, value=TRUE)