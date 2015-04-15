# ------------------------------------------------------
#  rankall.R  - search US Dept of Heath records for best hospital
#            for each state for a specific outcome (lowest #) for the rank provided
#  - arg1 - outcome name
#  - arg2 - num - rank of the hospital, best/worst
#
#  errors
#  - "invalid outcome" - if unknown outcome is provided
# ------------------------------------------------------
rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Subset by columns were interested in
    dset <- data[, c(7,2,11,17,23)]
       
    ## Remove "Not Avaliable"
    dset[dset=="Not Available"]<-NA
    dset <- na.omit(dset)
    
    ## Sort based on outcome, hospital, error if outcome is invalid
    if (outcome == "heart attack") {
        sset <- dset[order(dset[,1], as.numeric(dset[,3]), dset[,2]),]
    }
    else if (outcome == "heart failure") {
        sset <- dset[order(dset[,1], as.numeric(dset[,4]), dset[,2]),]
    }
    else if (outcome == "pneumonia") {
        sset <- dset[order(dset[,1], as.numeric(dset[,5]), dset[,2]),]
    }
    else
    {
        stop("invalid outcome")
    }
    
    ## Split the data by State
    spset <- split(sset,sset$State)

    ## Loop thru the List of data frames
    first <- TRUE
    for(i in 1:length(spset))
    {
        s <- spset[[i]]
        
        ## Check the rank input provided and return as appropriate
        ## Return hospital name in that state with rank requested
        ##  - best - 1,  worst - last
        ##  - rank beyond # of rows - NA
        ##  - exact rank
        if (num == "best") {
            st <- s[1,1]   # state
            h <- s[1,2]    # hospital
        }
        else if (num == "worst") {
            st <- s[nrow(s),1]   # state
            h <- s[nrow(s),2]    # hospital
        }
        else if (num > nrow(s)) {
            st <- s[1,1]   # state
            h <- "NA"    # hospital
        }
        else {
            st <- s[num,1]   # state
            h <- s[num,2]    # hospital
        }
        
        ## Build the dataframe with results
        if (first) {
            result <- (data.frame(hospital=h, state=st))
            first <- FALSE
        }
        else {
            newrow <- (data.frame(hospital=h, state=st))
            result <- rbind(result, newrow)
        }
        
    }
    ## return results
    result
}