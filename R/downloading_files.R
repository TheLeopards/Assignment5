

download <- function(url, name) {
	download.file(url = url, destfile = paste("data/", name, ".tar.gz", sep = ""), method="wget", quiet = FALSE)
}










