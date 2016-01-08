

download <- function(url, name) {
	dir.create(paste("/", name, sep=""))
	download.file(url = url, destfile = paste(name, "/", name, ".tar.gz", sep = ""), method="wget", quiet = FALSE)
	untar(paste(name, ".tar.gz", sep = ""), exdir = paste(name, sep = ""))
}










