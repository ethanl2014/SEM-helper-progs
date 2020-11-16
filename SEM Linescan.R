#inputs to change: folderlocation(2), length(11), filename(29)
filenames <- list.files("E20267A sem", pattern="*um.txt", full.names=TRUE)
newdata <- lapply(filenames, function(i){read.table(i, sep = ",", header = TRUE)})

# micronconc <- function(lscan,index){
#   lscan <- data.frame(lscan)
#   upperbound <- ceiling(max(lscan$Al))
#   teststr <- paste("\n",filenames[index],sep ="")
#   while (upperbound > 0) {
#     lowerbound <- upperbound - 1
#     teststr <- paste(teststr, "\nAl content between",as.character(lowerbound), "and", as.character(upperbound), "percent", "for", nrow(subset(lscan, Al>lowerbound & Al<upperbound))*160/256, "microns",sep = " ")
#     upperbound <- lowerbound
#   }
#   return(teststr)
# }
# 
# index <- 1
# lscan <- micronconc(newdata[index],index)
# 
# l <- vector("character", length(filenames))
# l[1] <- lscan
# 
# for (i in newdata[-1]) {
#   index <- index + 1
#   j <- micronconc(i,index)
#   l[index] <- j
# }
# 
# lapply(l, write, "E20125A_Linescan(500x).txt", append=TRUE, ncolumns=100)

filestr <- filenames[1]
linelength <- as.numeric(substr(filestr,45,47)) #should always be at this location for 500x linescans

newdf <- newdata[[1]]
microncol <- seq(linelength/256,linelength,linelength/256)
newdf$microns <- microncol

library(xlsx)
write.xlsx(newdf, "E20267A test.xlsx")


