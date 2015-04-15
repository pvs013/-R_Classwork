corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    files <- paste(directory, "/", dir(directory), sep="") 
    result <- vector(mode="numeric", length=0)
    for (i in 1:length(files)) {
        ## Read in file
        
        dset <- read.csv(files[i])
        
        ## Count # of valid tests and put in new dataset
        comp <- sum(complete.cases(dset))
        
        ## if complete cases > threshold, continue
        if (comp > threshold) {
            ##  perform correlation
            mycor <- cor(dset[,2],dset[,3], use="complete.obs")
            
            ## Build new output data set
            result <- c(result, mycor)
            
        }
 
    }
    ## return result
    result    
}
