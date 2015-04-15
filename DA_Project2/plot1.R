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
dset <- readRDS(paste(datadir,NEIfile, sep=""))

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

