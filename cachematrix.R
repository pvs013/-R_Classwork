## -------------------------------------------------------------
##  R Programming - Assignment 2
##  
##  2 functions to create and cache the inverse of a Matrix
##  makeCacheMatix - build matrix and functions to get, set
##                   the matrix and inverse.  Caches inverse
##  cachesolve - retrives inverse from cache if available
##               otherwise runs functions to get inverse
## -------------------------------------------------------------

## -------------------------------------------------------------
##  makeCacheMatrix
##     argument - matrix 
##     returns a list of functions for the matrix
##     set - sets the orginal matrix
##     get - returns the original matrix
##     getinverse - returns the inverse of the matrix
##     setinverse - sets the inverse of the matrix (cache result)
## -------------------------------------------------------------
makeCacheMatrix <- function(m = matrix()) {
    i <- NULL   # initialize local i (inverse) to NULL

    ## set - sets a matrix to arg y,  global i (inverse) to NULL
    set <- function(y) {
        m <<- y
        i <<- NULL
    }

    ## get - returns the matrix m
    get <- function() m

    ## setinverse - sets the inverse of the matrix with solve
    ##   global i (inverse) set
    setinverse <- function(solve) i <<- solve

    ## getinverse - returns the inverse matrix
    getinverse <- function() i

    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}


## -------------------------------------------------------------
##  cacheSolve
##     argument - list of functions from makeCacheMatrix 
##     returns the inverse of the matrix, from cache or builds it
## -------------------------------------------------------------
cacheSolve <- function(m, ...) {
    # get the inverse of the matrix
    i <- m$getinverse()
    
    # if inverse is not null, found in cache, return
    if(!is.null(i)) {
        message("getting cached data")
        return(i)
    }
    # compute the inverse, wasn't cached
    #  - get the original matrix, create inverse,
    #    set inverse, return inverse matrix
    data <- m$get()
    i <- solve(data, ...)
    m$setinverse(i)
    i
}

