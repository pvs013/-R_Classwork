
##  Read file
fname <- "data/getdata-wksst8110.for"
widths <- c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4)
dset <- read.fwf(fname, widths, skip=4, )
class(dset)
summary(dset)
head(dset)
sum(dset[,4])
