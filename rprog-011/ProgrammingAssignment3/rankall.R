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
    names(data) <- c("Name", "State", "Outcome")

    # Get n
    # Parse num into n
    bDecreasing <- FALSE
    if (num=="best") {
        n <- 1
    } else if (num=="worst") {
        n <- 1
        bDecreasing <- TRUE
    } else if (is.numeric(num)) {
        n <- num;
    } else {
        stop("Invalid Num")
    }

    # Split data into states then use sapply f(x) to order each state
    #  and select the (num)th state
    # Returns a character vector hosps
    hosps <- sapply(split(data, data$State), function(state) {
        
        state[ order(state$Outcome, state$Name, decreasing=bDecreasing)[n], ]$Name
    })
    
    # Create df result of hospitals & states
    result <- data.frame(hospital=hosps,state=names(hosps))
}