# Coursera rprog-011
#   Mark Pratley
#     Assignment #3
#       23-Feb-2015

# Function to return the nth ranked hospital for the given state for the
#  given outcome

rankhospital <- function(state, outcome, num = "best") {

    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv",
                     colClasses = "character", na.strings="Not Available")
    data[, 11] <- as.numeric(data[, 11])
    data[, 17] <- as.numeric(data[, 17])
    data[, 23] <- as.numeric(data[, 23])

    ## Check that state and outcome are valid
    if ( !state %in% data[,7] ) {
        stop("invalid state")
    }
    
    # Create vector for outcomes and their columns
    outcomes = c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
    
    # Check if the required outcome is valid
    if ( is.na(outcomes[outcome]) ) {
        stop("invalid outcome")
    }
    
    ## Subset by state
    data = subset(data, State==state)
    # Filter to the 2 cols we need
    data = data[,c(2,outcomes[outcome])]
    # Omit NA rows
    data = na.omit(data)
    
    ## Order data by outcome & by hospital (alphabetically)
    ordered = order(data[,2],data[,1])
    
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

    # Return Hospital Name
    data[ordered[n],1]
}