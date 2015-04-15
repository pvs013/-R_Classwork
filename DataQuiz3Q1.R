url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
acs <- read.csv(url)

# > 10 acres
#  ACR    Lot size = 3 - House on 10 or more acres
# > $10,000 agr sold  
#  AGS    Sales of Agr Products = 6 - > $10,000

acs[acs$ACR==3 & acs$AGS==6, ]


acs[which(acs$ACR==3 & acs$AGS==6), ]



