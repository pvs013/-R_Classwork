makeCacheMatrix <- function(m = matrix()) {
    i <- NULL   # initialize local i (inverse) to NULL
    
    ## set - sets a matrix to arg y,  global i (inverse) to NULL
    set <- function(y) {
        m <<- y
        i <<- NULL
    }
    
    ## get - returns the matrix m
    get <- function() m
    
    ## setinverse - sets the inverse of the matrix with solve,  global i (inverse) set
    setinverse <- function(solve) i <<- solve
    
    ## getinverse - returns the inverse matrix
    getinverse <- function() i
    
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}