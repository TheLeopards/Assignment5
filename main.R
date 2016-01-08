# Author: TheLeopards (samantha Krawczyk, Georgios Anastasiou)
# 8th January 2016
# Pre-processing chain to assess change in NDVI over time

library(raster)
source("R/downloading_files.R")

download("https://www.dropbox.com/s/akb9oyye3ee92h3/LT51980241990098-SC20150107121947.tar.gz?dl=0", "landsat5")
download("https://www.dropbox.com/s/i1ylsft80ox6a32/LC81970242014109-SC20141230042441.tar.gz?dl=0", "landsat8")

# unziping files
untar('data/LC81970242014109-SC20141230042441.tar.gz', exdir = "data/")
untar('data/LT51980241990098-SC20150107121947.tar.gz', exdir = "data/")

# creating stacks for Landsat data
list <- list.files('data/', pattern = glob2rx('*.tif'), full.names = TRUE)
Landsat8 <- stack(list[1:9])
Landsat5 <- stack(list[10:24])

# writing to file - DELETE?
writeRaster(x=Landsat5, filename='data/Landsat5.grd', datatype='INT2S')
writeRaster(x=Landsat8, filename='data/Landsat8.grd', datatype='INT2S')

# ensuring both datasets have the same extent
ls5_int <- intersect(Landsat5, Landsat8)
ls8_int <- intersect(Landsat8, Landsat5)

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
