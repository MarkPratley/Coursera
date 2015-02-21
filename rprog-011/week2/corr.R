# Coursera rprog-011
#   Mark Pratley
#     Assignment #1
#       Part #2
#        18-Feb-2015 

corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    
    # Get files from dir
    files = list.files(directory, full.names=TRUE)
    
    # Create a new vector for the corrs - cant say the size yet
    corrs <- vector('numeric')
    
    # Loop through and check each file
    for (i in 1:length(files)) {
        
        f = read.csv(files[i])
        if ( sum( complete.cases(f) ) > threshold ) {
            
            # Do corr thing
            corrs = append(corrs, cor(f$sulfate, f$nitrate, use="complete.obs"))
        }

    }
    
    return (corrs)
}