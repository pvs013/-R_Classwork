#########################################################################
## Exploratory Analysis
## Project #2
## ---------------------------------------
## Files downloaded and unzipped in ../data directory
## - NEI file - Emissions Data - 1999,2002,2005,2008
## - SCC file - SCC # definitions
## ---------------------------------------
## Question #2:
## Have total emissions from PM2.5 decreased in the 
##    Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
##    Use the base plotting system to make a plot answering this question.
## File: plot2.R
## Output:  plot2.png
#########################################################################
setwd("~/Documents/dev/R/class/DA_Project2")

datadir <- "../data/exdata-data-NEI_data/"
NEIfile <- "summarySCC_PM25.rds"
dset <- readRDS(paste(datadir,NEIfile, sep=""))

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
