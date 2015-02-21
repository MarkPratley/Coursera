# Coursera rprog-011
#   Mark Pratley
#     Assignment #1
#       Part #2
#        18-Feb-2015
 
complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    
    # Get Files
    files = list.files(directory, full.names=TRUE)
    
    # our subset
#    files = files[id] # Doing in loop instead
    
    # Create a new vector of the right size for 'nobs' numbers
    nobs <- rep(0, length(id))

    # Counter
    count = 1
    
    # Read the (selected) files into a list
    for (i in id) {
        
        f = read.csv(files[i])
        nobs[count] = sum( complete.cases(f) )
        count = count + 1
    }
    
    result <- data.frame(id = id, nobs = nobs)
    
    return(result)
}