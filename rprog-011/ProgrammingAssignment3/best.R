# Coursera rprog-011
#   Mark Pratley
#     Assignment #3
#       21-Feb-2015

# Function to return the best hospital in the required state
#  for the chosen outcome

best <- function(state, outcome) {
    
    # Temp Supress warnings 
    options(warn=-1)

    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    data[, 11] <- as.numeric(data[, 11])
    data[, 17] <- as.numeric(data[, 17])
    data[, 23] <- as.numeric(data[, 23])
    
    # Turn warnings back on
    options(warn=1)

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

    ## Order data by outcome & by hospital (alphabetically)
    ordered = order(data[,outcomes[outcome]],data[,2])
    
    # Return Hospital Name
    data[ordered[1],2]
    
    ## DEBUG
    # Return Top 10 - Name & Value - 
#    data[ordered[1:10],c(2,11,17,23)]
    ## END DEBUG
}