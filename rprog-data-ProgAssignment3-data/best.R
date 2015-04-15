# ------------------------------------------------------
#  best.R  - search US Dept of Heath records for best hospital
#            in a provided state for a specific outcome (lowest #)
#  - arg1 - 2 char abbrviated name for state
#  - arg2 - outcome name
#
#  errors
#  - "invalid state" - if unknown state abbreviation is provided
#  - "invalid outcome" - if unknown outcome is provided
# ------------------------------------------------------
best <- function(state, outcome) {
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
 
    ## Return hospital name in that state with lowest 30-day 
    ## death rate
    print(sset[1,1])    
}