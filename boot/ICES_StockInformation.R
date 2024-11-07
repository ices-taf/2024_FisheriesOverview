
library(icesTAF)
library(icesSD)
taf.library(icesFO)

sid <- getSD(NULL, 2024)

write.taf(sid, file = "sid.csv", quote=TRUE, dir = "boot/initial/data")

#check fish guilds
fish_category <- dplyr::mutate(sid, X3A_CODE = substr(sid$StockKeyLabel, start = 1, stop = 3))
fish_category <- dplyr::select(fish_category, X3A_CODE, FisheriesGuild)
fish_category$X3A_CODE <- toupper(fish_category$X3A_CODE)
fish_category <- unique(fish_category)
fish_category$FisheriesGuild[which(fish_category$X3A_CODE == "POK")] <- "Demersal"
#CAA, SEH, SEZ  have no guild
#REB is both pelagic and demersal


sid$FisheriesGuild[which(sid$StockKeyLabel == "caa.27.5a")] <- "Demersal"
sid$FisheriesGuild[which(sid$StockKeyLabel == "cod.21.1d-f")] <- "Demersal"
sid$FisheriesGuild[which(sid$StockKeyLabel == "pok.27.7-10 ")] <- "Demersal"
#Should we include seals? maybe not

sid <- sid %>% filter(SpeciesScientificName != "Pagophilus groenlandicus")
sid <- sid %>% filter(SpeciesScientificName != "Cystophora cristata")


