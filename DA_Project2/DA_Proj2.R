#########################################################################
## Exploratory Analysis
## Project #2
## ---------------------------------------
## Files downloaded and unzipped in ../data directory
## - NEI file - Emissions Data - 1999,2002,2005,2008
## - SCC file - SCC # definitions
## ---------------------------------------
## Question #1:
## Have total emissions from PM2.5 decreased in the United States 
##   from 1999 to 2008? Using the base plotting system, make a plot
##   showing the total PM2.5 emission from all sources for each of
##    the years 1999, 2002, 2005, and 2008.
## File: plot1.R
## Output:  plot1.png
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
## Plot 1
## Determine the total emissions per year
#########################################################################
## Sum the total emissions by year
tot_emis <- tapply(dset$Emissions, dset$year, sum)

# Open Graphics Device - png file 480x480
png(filename = "plot1.png", width = 480, height = 480)

## plot a bar plot showing the data  (divided by 1000 and labeled appropriately)
barplot(tot_emis/1000, width = 4, names.arg = names(tot_emis), 
        main="Total Emissions", xlab="Year", 
        ylab="Emissions (1000 tons)", col="blue")

#Close Graphics Device
dev.off()



#########################################################################
## Plot 2
## Determine the total emissions per year 
##    for Baltimore City, MD (FIPS 24510)
#########################################################################
## subset the data (just FIPS 24510)
bc_md <- dset[dset$fips=="24510",]

## sum the emissions by year
tot_emis <- tapply(bc_md$Emissions, bc_md$year, sum)

# Open Graphics Device - png file 480x480
png(filename = "plot2.png", width = 480, height = 480)

## plot a bar plot showing the data )
barplot(tot_emis, width = 4, names.arg = names(tot_emis), 
        main="Baltimore City, MD - Total Emissions", xlab="Year", 
        ylab="Emissions (tons)", col="blue")

#Close Graphics Device
dev.off()

#########################################################################
## Plot 3
## Determine the emission source type(s) that have seen decreases 
##    from 1999-2008 for Baltimore City, MD (FIPS 24510)
#########################################################################
## subset the data (just FIPS 24510)
bc_md <- dset[dset$fips=="24510",]

# Open Graphics Device - png file 960x480
png(filename = "plot3.png", width = 960, height = 480)

## plot using qplot
library(ggplot2)
g <- qplot(year, Emissions, data=bc_md, facets=.~type)
g + geom_smooth() + labs(title = "Baltimore City MD, Emissions by Type by Year")

#Close Graphics Device
dev.off()

#########################################################################
## Plot 4
## Determine the emission from Coal combustion-related sources 
##    from 1999-2008 for the entire US
#########################################################################
## subset the data (just Combustion "Comb" Coal sources)
cc_data <- dset[grepl(" [cC]omb .+ [cC]oal", dset$Short.Name), ]

## sum the emissions by year
tot_emis <- tapply(cc_data$Emissions, cc_data$year, sum)

# Open Graphics Device - png file 480x480
png(filename = "plot4.png", width = 480, height = 480)

## plot a bar plot showing the data (divided by 1000 with Label))
barplot(tot_emis/1000, width = 4, names.arg = names(tot_emis), main="Coal Combustion - Total Emissions", xlab="Year", 
        ylab="Emissions (1,000 tons)", col="blue")

#Close Graphics Device
dev.off()


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

## sum the emissions by year
bc_emis <- tapply(bc_md$Emissions, bc_md$year, sum)
la_emis <- tapply(la_ca$Emissions, la_ca$year, sum)

dset <- as.data.frame(bc_emis)
dset$la_emis <- la_emis

# Open Graphics Device - png file 480x480
png(filename = "plot6.png", width = 480, height = 480)

## plot showing the data 
plot(rownames(dset), dset$la_emis, type="n",
     xlab="Year", ylab="Emissions (tons)",
     main="Motor Vehicle Emissions\n Balt City, MD vs LA, CA")
points(rownames(dset), dset$bc_emis, type="l", col='red')
points(rownames(dset), dset$la_emis, type="l", col='blue')
legend("topright", lwd = 2, col= c("red","blue"), 
       legend = c("Baltimore City, MD", "Los Angeles, CA"))


#Close Graphics Device
dev.off()









