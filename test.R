

tar <- 

untar('data/LC81970242014109-SC20141230042441.tar.gz', exdir = "data/")
untar('data/LT51980241990098-SC20150107121947.tar.gz', exdir = "data/")

list <- list.files('data/', pattern = glob2rx('*.tif'), full.names = TRUE)
list

Landsat8 <- stack(list[1:9])
Landsat8

Landsat5 <- stack(list[10:24])
Landsat5

writeRaster(x=Landsat5, filename='data/Landsat5.grd', datatype='INT2S')

writeRaster(x=Landsat8, filename='data/Landsat8.grd', datatype='INT2S')
