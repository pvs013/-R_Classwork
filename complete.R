complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    ##  For each file :  id
    first <- TRUE
    for (i in id) {
        ## Read in file
        dset <- read.csv(paste(directory, "/", sprintf("%03d",i), ".csv", sep=""))
        
        ## Count # of valid tests and put in new dataset
        comp <- sum(complete.cases(dset))
        
        ## Build new output data set 
        ##   first time, build data frame,  after that add a row
        if (first) {
            result <- (data.frame(id=i, nobs=comp))
            first <- FALSE
        }
        else {
            newrow <- (data.frame(id=i, nobs=comp))
            result <- rbind(result, newrow)
        }
        
    }
    ## return result dataframe
    result    
}