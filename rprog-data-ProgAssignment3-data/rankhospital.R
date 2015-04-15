# ------------------------------------------------------
#  rankhospital.R  - search US Dept of Heath records and pulls the hospital
#            in a provided state for a specific outcome (lowest #) for the rank provided
#  - arg1 - 2 char abbrviated name for state
#  - arg2 - outcome name
#  - arg3 - num - rank of the hospital, best/worst
#
#  errors
#  - "invalid state" - if unknown state abbreviation is provided
#  - "invalid outcome" - if unknown outcome is provided
# ------------------------------------------------------
rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Subset by state and columns were interested in
    dset <- data[data$State == state, c(2,11,17,23)]
    ## Check that state is valid  (something exists for the state)
    if (nrow(dset) == 0) {
        stop("invalid state")
    }
    
    ## Remove "Not Avaliable"
    dset[dset=="Not Available"]<-NA
    dset <- na.omit(dset)
    #dset <- dset[dset!="Not Available" & !is.na(dset)]
    
    ## Sort based on outcome, hospital, error if outcome is invalid
    if (outcome == "heart attack") {
        sset <- dset[order(as.numeric(dset[,2]), dset[,1]),]
    }
    else if (outcome == "heart failure") {
        sset <- dset[order(as.numeric(dset[,3]), dset[,1]),]
    }
    else if (outcome == "pneumonia") {
        sset <- dset[order(as.numeric(dset[,4]), dset[,1]),]
    }
    else
    {
        stop("invalid outcome")
    }
    
    
    ## Check the rank input provided and return as appropriate
    ## Return hospital name in that state with rank requested
    ##  - best - 1,  worst - last
    ##  - rank beyond # of rows - NA
    ##  - exact rank
    if (num == "best") {
        print(sset[1,1])
    }
    else if (num == "worst") {
        print(sset[nrow(sset),1]) 
    }
    else if (num > nrow(sset)) {
        print("NA")
    }
    else {
        print(sset[num, 1])
    }
}