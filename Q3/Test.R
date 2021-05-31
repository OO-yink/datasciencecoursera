## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) { # assume that the matrix supplied is always invertible.
  i <- NULL
  set <- function(y) { # Set value of the matrix with another functon
    x <<- y
    i <<- NULL
  }
  get <- function() x # Get value of the matrix
  setinverse <- function(inverse) i <<- inverse # Set value of the inverse
  getinverse <- function() i # Get the value of the inverse
  # Create a list
  list(set = set,
       get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}

## Write a short comment describing this function

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  i <- x$getinverse() # Returns value that is inverse of x
  if (!is.null(i)) { # If inverse has already been calculated
    message("getting cached data")
    return(i) # Return cached value
  }
  data <- x$get() # initiated only if a cache value if not avaliable.
  i <- solve(data, ...) # Compute solve
  x$setinverse(i) # et nverse
  i
}
