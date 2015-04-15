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
#mdata2 <- merge(gdp, edu, by.x="X", by.y="CountryCode", all=TRUE)
#  how many ID's match
dim(mdata)
 
# sort in descending order by GDP rank (USA will be last)
#  what is the 13th country
sdata <- mdata[order(as.numeric(as.character(mdata$Gross.domestic.product.2012)), decreasing=TRUE), ]
sdata[13,]


## Question 4 
tdata <- sdata[, c(1,2,11,12)]
zdata <- tdata[tdata$Income.Group %in% c("High income: OECD", "High income: nonOECD"),]

odata <- tdata[tdata$Income.Group %in% c("High income: OECD"),]
ndata <- tdata[tdata$Income.Group %in% c("High income: nonOECD"),]
mean(as.numeric(as.character(odata$Gross.domestic.product.2012)))
mean(as.numeric(as.character(ndata$Gross.domestic.product.2012)))

summary(zdata)

## Question 5
# 5 quantile groups by gdp


