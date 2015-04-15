#########################################################################
## Exploratory Analysis
## Project #2
## ---------------------------------------
## Files downloaded and unzipped in ../data directory
## - NEI file - Emissions Data - 1999,2002,2005,2008
## - SCC file - SCC # definitions
## ---------------------------------------
## Question #6:
## Compare emissions from motor vehicle sources in Baltimore City 
##    with emissions from motor vehicle sources in Los Angeles County,
##    California (fips == "06037"). 
##    Which city has seen greater changes over time in motor vehicle emissions?
## File: plot6.R
## Output:  plot6.png
#########################################################################
setwd("~/Documents/dev/R/class/DA_Project2")

datadir <- "../data/exdata-data-NEI_data/"
NEIfile <- "summarySCC_PM25.rds"
SCCfile <- "Source_Classification_Code.rds"
NEI_data <- readRDS(paste(datadir,NEIfile, sep=""))
SCC_data <- readRDS(paste(datadir,SCCfile, sep=""))

## join the data on SCC code
dset <- merge(NEI_data, SCC_data, by="SCC", all.x=TRUE)

## cleanup other files
remove(NEI_data)
remove(SCC_data)


#########################################################################
## Plot 6
## Determine the emission from motor vehicle sources 
##    from 1999-2008 in Baltimore City, MD FIPS(24510)
##    compared to Los Angeles County, CA FIPS(06037)

##
## NOTE:  reviewing the SCC information i decided to use all of
##        the vehicle's SCC codes as determined by the SCC.EI.Sector
##        its my judgement that this is motor vehicle emissions 
##        based on the legal definition of motor vehicle
##        http://www.law.cornell.edu/cfr/text/40/85.1703
#########################################################################
## subset the "motor vehicle data"
mv_data <- dset[grepl("[Vv]ehicle", dset$EI.Sector), ]
## subset the data (FIPS 24510)
bc_md <- mv_data[dset$fips=="24510",]
## subset the data (FIPS 24510)
la_ca <- mv_data[dset$fips=="06037",]

## sum the emissions by year for each
bc_emis <- tapply(bc_md$Emissions, bc_md$year, sum)
la_emis <- tapply(la_ca$Emissions, la_ca$year, sum)

## build new data frame with results
dset <- as.data.frame(bc_emis)
dset$la_emis <- la_emis

# Open Graphics Device - png file 480x480
png(filename = "plot6.png", width = 480, height = 480)

## plot showing the data 
##   comparing two counties emission data
plot(rownames(dset), dset$la_emis, type="n",
     xlab="Year", ylab="Emissions (tons)",
     main="Motor Vehicle Emissions\n Balt City, MD vs LA, CA")
points(rownames(dset), dset$bc_emis, type="l", col='red')
points(rownames(dset), dset$la_emis, type="l", col='blue')
legend("topright", lwd = 2, col= c("red","blue"), 
       legend = c("Baltimore City, MD", "Los Angeles, CA"))


#Close Graphics Device
dev.off()


