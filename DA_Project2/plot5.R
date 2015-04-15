#########################################################################
## Exploratory Analysis
## Project #2
## ---------------------------------------
## Files downloaded and unzipped in ../data directory
## - NEI file - Emissions Data - 1999,2002,2005,2008
## - SCC file - SCC # definitions
## ---------------------------------------
## Question #5:
## How have emissions from motor vehicle sources 
##     changed from 1999–2008 in Baltimore City?
## File: plot5.R
## Output:  plot5.png
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
## Plot 5
## Determine the emission from motor vehicle sources 
##    from 1999-2008 in Baltimore City, MD FIPS(24510)
##
## NOTE:  reviewing the SCC information i decided to use all of
##        the vehicle's SCC codes as determined by the SCC.EI.Sector
##        its my judgement that this is motor vehicle emissions 
##        based on the legal definition of motor vehicle
##        http://www.law.cornell.edu/cfr/text/40/85.1703
#########################################################################
## subset the data (FIPS 24510)
bc_md <- dset[dset$fips=="24510",]
## subset the "motor vehicle data"
mv_data <- bc_md[grepl("[Vv]ehicle", bc_md$EI.Sector), ]

## sum the emissions by year
tot_emis <- tapply(mv_data$Emissions, mv_data$year, sum)

# Open Graphics Device - png file 480x480
png(filename = "plot5.png", width = 480, height = 480)

## plot a bar plot showing the data 
barplot(tot_emis, width = 4, names.arg = names(tot_emis), 
        main="Motor Vehicles Emissions - Baltimore City MD", xlab="Year", 
        ylab="Emissions (tons)", col="blue")

#Close Graphics Device
dev.off()


