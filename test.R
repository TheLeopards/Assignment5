

tar <- 

untar('data/LC81970242014109-SC20141230042441.tar.gz', exdir = "data/")
untar('data/LT51980241990098-SC20150107121947.tar.gz', exdir = "data/")

list <- list.files('data/', pattern = glob2rx('*.tif'), full.names = TRUE)
list

turaStack <- stack(list[1:9])

Landsat8 <- brick(list[1:9])
warning()
debug(stack)
traceback()





