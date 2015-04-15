cacheSolve <- function(m, ...) {
    # get the inverse of the matrix
    i <- m$getinverse()
    
    # if inverse is not null, found in cache, return
    if(!is.null(i)) {
        message("getting cached data")
        return(i)
    }
    # compute the inverse, wasn't cached
    #  - get the original matrix, create inverse, set inverse, return inverse matrix
    data <- m$get()
    i <- solve(data, ...)
    m$setinverse(i)
    i
}