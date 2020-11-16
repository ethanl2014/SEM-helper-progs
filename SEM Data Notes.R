#inputs to change: folderlocation(19), filename(28)

library(openxlsx)
library(dplyr)

makepalatable <- function(semdata) {
  newsem <- as.data.frame(semdata)
  names(newsem) <- as.matrix(newsem[1, ])
  newsem <- newsem[-1, ]
  newsem <- head(newsem,-4)
  return(newsem)
}

appendsem <- function(semtable, semdata){
  palatsem <- makepalatable(semdata)
  dplyr::bind_rows(semtable,palatsem)
}

filenames <- list.files("E20103A sem", pattern="*all.txt", full.names=TRUE)
newdata <- lapply(filenames, function(i){read.table(i, sep = "\t", fileEncoding = "UCS-2LE", skip = 1)})

firstsem <- makepalatable(newdata[1])

for (i in newdata[-1]) {
  firstsem <- appendsem(firstsem,i)
  }

write.xlsx(firstsem,"E20103A_Pointscan.xlsx")

#------------------------------------------------
master <- read.xlsx("Master_Pointscan.xlsx")
master <- dplyr::bind_rows(firstsem,master)
write.xlsx(master,"Master_Pointscan.xlsx")