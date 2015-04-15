#########################################################################
## Exploratory Analysis
## Project #2
## ---------------------------------------
## Files downloaded and unzipped in ../data directory
## - NEI file - Emissions Data - 1999,2002,2005,2008
## - SCC file - SCC # definitions
## ---------------------------------------
## Question #4:
## Across the United States, how have emissions from 
##    coal combustion-related sources changed from 1999–2008?
## File: plot4.R
## Output:  plot4.png
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
barplot(tot_emis/1000, width = 4, names.arg = names(tot_emis), 
        main="Coal Combustion - Total Emissions", xlab="Year", 
        ylab="Emissions (1,000 tons)", col="blue")

#Close Graphics Device
dev.off()


