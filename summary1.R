library(openxlsx)

y <- read.xlsx("E20267A test.xlsx")
y <- y[(y$C<3 & y$O<1),]
y2 <- mean(y$Al[1:15])      #can change to Cr or w/e
test <- y$microns[1]

elem_prime <- diff(y$Al)
threshold <- .15
elem_prime2 <- diff((which(abs(elem_prime)<threshold)))
sequence_fndr <- rle(elem_prime2)
threshold2 <- 5
indextest <- min(which(sequence_fndr$lengths >= threshold2))
transition_um <- y$microns[indextest]
transition_el <- y$Al[indextest]

depth <- transition_um - test

