# Author: TheLeopards (samantha Krawczyk, Georgios Anastasiou)
# 8th January 2016
# Pre-processing chain to assess change in NDVI over time

library(raster)

source("R/downloading_files.R")

download("https://www.dropbox.com/s/akb9oyye3ee92h3/LT51980241990098-SC20150107121947.tar.gz?dl=0", "landsat5")
download("https://www.dropbox.com/s/i1ylsft80ox6a32/LC81970242014109-SC20141230042441.tar.gz?dl=0", "landsat8")

# unziping files
untar('data/landsat5.tar.gz', exdir = "data/")
untar('data/landsat8.tar.gz', exdir = "data/")

# creating stacks for Landsat data
list_ls <- list.files('data/', pattern = '*.tif', full.names = TRUE)

ls5 <- stack(list_ls[10:24])
ls8 <- stack(list_ls[1:9])

# writing to file
ls5_2f <- writeRaster(x=ls5, filename='data/Ls5.grd', datatype='INT2S', overwrite=TRUE)
ls8_2f <- writeRaster(x=ls8, filename='data/Ls8.grd', datatype='INT2S', overwrite=TRUE)

# ensuring both datasets have the same extent
ls5_int <- intersect(ls5_2f, ls8)
ls8_int <- intersect(ls8, ls5_2f)


# Extract cloud Mask rasterLayer
fmask5 <- ls5_int[[1]]
fmask8 <- ls8_int[[1]]

# Remove fmask layer from the Landsat stack
ls5_NoCloudLayer <- dropLayer(ls5_int, 1)
ls8_NoCloudLayer <- dropLayer(ls8_int, 1)

# First define a value replacement function
cloud2NA <- function(x, y){
	x[y != 0] <- NA
	return(x)
}

# Apply the function on the two raster objects using overlay
ls5_CloudFree <- overlay(x = ls5_NoCloudLayer, y = fmask5, fun = cloud2NA)
ls8_CloudFree <- overlay(x = ls8_NoCloudLayer, y = fmask5, fun = cloud2NA)
ls5_CloudFree

#stakcing only Red and NIR for both landsats
list_ls5 <- list.files('data/', pattern = 'LC.*band[34].tif', full.names = TRUE)
list_ls8 <- list.files('data/', pattern = 'LC.*band[45].tif', full.names = TRUE)


# NDVI calculations
ndvOver <- function(x, y) {
	ndvi <- (y - x) / (x + y)
	return(ndvi)
}
ndvi5 <- overlay(x=list_ls5[[1]], y=list_ls5[[2]], fun=ndvOver)
ndvi8 <- overlay(x=list_ls5[[1]], y=list_ls5[[2]], fun=ndvOver)

list_ls8[[1]]
list_ls8[[2]]
