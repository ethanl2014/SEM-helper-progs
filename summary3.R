library(openxlsx)
library(dplyr)

x <-  read.xlsx("E20134A_Pointscan.xlsx")

x <- x[!grepl("1-2", x$Spectrum),]
x <- x[!grepl("1-3", x$Spectrum),]
x <- x[!grepl("1-4", x$Spectrum),]



x$ID <- seq.int(nrow(x))
x2 <- subset(x, select=-c(Spectrum))
x1 <- subset(x, select=c(Spectrum,ID))
x2[] <- lapply(x2, function(d) as.numeric(as.character(d)))
x3 <- merge(x1,x2, by="ID")
#Stats <- summarize_all(x3, mean) maybe not useful for multiple pucks + since it is now numeric...
#x3 <- rbind(x3, Stats)



