#########################################################################
## Exploratory Analysis
## Project #2
## ---------------------------------------
## Files downloaded and unzipped in ../data directory
## - NEI file - Emissions Data - 1999,2002,2005,2008
## - SCC file - SCC # definitions
## ---------------------------------------
## Question #3:
## Of the four types of sources indicated by the type 
##    (point, nonpoint, onroad, nonroad) variable, which of these 
##    four sources have seen decreases in emissions from 1999–2008
##    for Baltimore City? Which have seen increases in emissions 
##    from 1999–2008? 
##    Use the ggplot2 plotting system to make a plot answer this question.
## File: plot3.R
## Output:  plot3.png
#########################################################################
setwd("~/Documents/dev/R/class/DA_Project2")

datadir <- "../data/exdata-data-NEI_data/"
NEIfile <- "summarySCC_PM25.rds"
dset <- readRDS(paste(datadir,NEIfile, sep=""))


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

