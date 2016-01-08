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
list_ls8 <- list.files('data/', pattern = 'LC.*band[45].tif', full.names = TRUE)
list_ls5 <- list.files('data/', pattern = 'LT.*band[34].tif', full.names = TRUE)

ls8 <- stack(list_ls8)
ls5 <- stack(list_ls5)

# writing to file - DELETE?
#writeRaster(x=Landsat5, filename='data/Landsat5.grd', datatype='INT2S')
#writeRaster(x=Landsat8, filename='data/Landsat8.grd', datatype='INT2S')

# ensuring both datasets have the same extent
ls5_int <- intersect(ls5, ls8)
ls8_int <- intersect(ls8, ls5)

# Extract cloud Mask rasterLayer
fmask <- ls5_int[[7]]
# Remove fmask layer from the Landsat stack
tahiti6 <- dropLayer(tahiti, 7)
# First define a value replacement function
cloud2NA <- function(x, y){
	x[y != 0] <- NA
	return(x)
}
# Let's create a new 6 layers object since tahiti6 has been masked already
tahiti6_2 <- dropLayer(tahiti, 7)

# Apply the function on the two raster objects using overlay
tahitiCloudFree <- overlay(x = tahiti6_2, y = fmask, fun = cloud2NA)
