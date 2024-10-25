library(icesTAF)
library(icesFO)
library(dplyr)



sag <- getSAG_ecoregion(2024, ecoregion)

write.taf(sag, file = "sag.csv", quote=TRUE, dir = "boot/initial/data")
