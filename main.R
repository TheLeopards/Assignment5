# Author: TheLeopards (samantha Krawczyk, Georgios Anastasiou)
# 8th January 2016
# Pre-processing chain to assess change in NDVI over time

library(raster)

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

