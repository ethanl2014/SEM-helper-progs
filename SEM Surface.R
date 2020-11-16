library(openxlsx)
library(dplyr)

avglinescan <- function(linescan){
  linescanfile <- read.xlsx(linescan)
  linescanfile <- linescanfile[(linescanfile$C<3 & linescanfile$O<1),]
  return(mean(linescanfile$Al[1:10]))
}

semdata <-  read.xlsx("E20134A_Pointscan.xlsx")

semdata <- semdata[!grepl("1-2", x$Spectrum),]
semdata <- semdata[!grepl("1-3", x$Spectrum),]
semdata <- semdata[!grepl("1-4", x$Spectrum),]

filenames <- list.files("E20103A sem", pattern="*linescan.xlsx", full.names=TRUE)

linescanlist <- lapply(filenames, function(i){avglinescan(i)})

semdata$linescan = linescanlist

semdata$ID <- seq.int(nrow(semdata))
semdata2 <- subset(semdata, select=-c(Spectrum))
semdata1 <- subset(semdata, select=c(Spectrum,ID))
semdata2[] <- lapply(semdata2, function(d) as.numeric(as.character(d)))
semdata3 <- merge(semdata1,semdata2, by="ID")

write.xlsx(semdata3,"E20103A_Surface.xlsx")