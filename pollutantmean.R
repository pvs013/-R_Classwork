pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    files <- paste(directory, "/", dir(directory), sep="") 
    
    tables <- do.call(rbind, lapply(files, read.csv)) 
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    data <- tables[which(tables[, "ID"] %in% id), ]
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    mean(data[,pollutant], na.rm=TRUE)
}