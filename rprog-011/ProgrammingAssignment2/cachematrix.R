# Coursera rprog-011
#   Mark Pratley
#     Assignment #2
#       20-Feb-2015

## A pair of functions to cache the inverse of a matrix

## makeCacheMatrix returns an object with getters/setters to store the inverse

makeCacheMatrix <- function(x = matrix()) {
    i <- NULL
    set <- function(y) {
        x <<- y
        i <<- NULL
    }
    get <- function() x
    setinv <- function(inv) i <<- inv
    getinv <- function() i
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}


## cacheSolve checks to see if there is a stored inverse value, if there is
##  it is retrieved and returned, otherwise the inverse is calculated,
##  stored and returned

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
    i <- x$getinv()
    if(!is.null(i)) {
        message("getting cached data")
        return(i)
    }
    data <- x$get()
    i <- solve(data, ...)
    x$setinv(i)
    i    
}
