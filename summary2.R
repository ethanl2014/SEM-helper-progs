library(openxlsx)
library(DescTools)

DOE <- read.xlsx("E20267A test.xlsx")
no_epoxy <- DOE[(DOE$C<3 & DOE$O<1),]
surf_wt <- mean(no_epoxy$Al[1:15])      #can change to Cr or w/e
surf_um <- no_epoxy$microns[1]

x <- DOE$microns
y <- DOE$Al
smooth_data <- loess.smooth(x, y) #best fit data
slope_ish <- diff(smooth_data$y) 
min_pt <- min(which(slope_ish > 0))#used to find point when slope changes signs
transition_um <- smooth_data$x[min_pt]
min_index <- which((DOE$microns<transition_um*1.1)&(DOE$microns>transition_um*0.9))
transition_wt <- mean(DOE$Al[min_index])

area_australia <- AUC(x=smooth_data$x[1:min_pt], y=smooth_data$y[1:min_pt], method="spline") 
gathered_data <- c(surf_um,surf_wt,transition_um,transition_wt,area_australia)