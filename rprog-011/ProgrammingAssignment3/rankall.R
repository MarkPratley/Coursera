# Coursera rprog-011
#   Mark Pratley
#     Assignment #3
#       23-Feb-2015

# Returns a 2 column df (hospital,state) of the nth ranked
#  hospital in each state for the outcome

rankall <- function(outcome, num = "best") {
    
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv",
                     colClasses = "character", na.strings="Not Available")
    data[, 11] <- as.numeric(data[, 11])
    data[, 17] <- as.numeric(data[, 17])
    data[, 23] <- as.numeric(data[, 23])
    
    # Create vector for outcomes and their columns
    outcomes = c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
    outcol   = outcomes[outcome]

    # Check if the required outcome is valid
    if ( is.na( outcol ) ) {
        stop("invalid outcome")
    }
    
    # Shrink data to relevant bits
    data = data[,c(2,7,outcol)]
    
    # Get n
    # Parse num into n
    if (num=="best") {
        n = 1
    } else if (num=="worst") {
        n = nrow(data)
    } else if (is.numeric(num)) {
        n = num;
    } else {
        stop("Invalid Num")
    }
    
    if (n>nrow(data))
        return (NA)
    
    # Get states
    states = unique(data[,"State"])
    
    # Create output
    hosps <- c()
    
    # Loop through states & add each ones nth value for the outcome
    for (state in states) {
        
        # order by outcome & hospital
        sdata = data[data$State==state,]
        sdata = sdata[order(sdata[,3], sdata[,1]),]

        # Can only find out worst here
        if (num=="worst")
            n = nrow(sdata)

        hosps = c(hosps,sdata[n,1])
    }
    
    # Create df result of hospitals & states
    result = data.frame(hosps,states)
    colnames(result) <- c("hospital", "state")
        
    
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    return (result)
}