# Function to replace cloud cover with NA values
cloud2NA <- function(x, y){
	x[y != 0] <- NA
	return(x)
}