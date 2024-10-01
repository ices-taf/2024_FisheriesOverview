# Initial formatting of the data

library(icesTAF)
library(icesFO)
library(dplyr)

mkdir("data")


# load species list
species_list <- read.taf("bootstrap/initial/data/FAO_ASFIS_species/species_list.csv")
sid <- read.taf("bootstrap/initial/data/ICES_StockInformation/sid.csv")


# 1: ICES official catch statistics

hist <- read.taf("bootstrap/initial/data/ICES_nominal_catches/ICES_historical_catches.csv")
official <- read.taf("bootstrap/initial/data/ICES_nominal_catches/ICES_2006_2019_catches.csv")
prelim <- read.taf("bootstrap/initial/data/ICES_nominal_catches/ICES_preliminary_catches.csv")

catch_dat <- 
        format_catches(2024, ecoregion, 
                       hist, official, NULL, species_list, sid)

catch_dat$COUNTRY[which(catch_dat$COUNTRY == "Russian Federation")] <- "Russia"
catch_dat$COMMON_NAME[which(catch_dat$COMMON_NAME == "Atlantic mackerel")] <- "mackerel"
catch_dat$COMMON_NAME[which(catch_dat$COMMON_NAME == "Atlantic horse mackerel")] <- "horse mackerel"
catch_dat$COMMON_NAME[which(catch_dat$COMMON_NAME == "Atlantic cod")] <- "cod"
catch_dat$COMMON_NAME[which(catch_dat$COMMON_NAME == "Atlantic herring")] <- "herring"

# catches_frmt <- format_catches_noecoregion(hist, official, species_list, sid)


write.taf(catches_frmt, dir = "data", quote = TRUE)


# need to improve the attribution to guilds already from here.




# 2: SAG

#glitches common to all ecoregions here: 

#for 2023 update this seem already there
# sag_complete$FMSY[which(sag_complete$FishStock == "dgs.27.nea")] <- 0.0429543
# sag_complete$MSYBtrigger[which(sag_complete$FishStock == "dgs.27.nea")] <- 336796
# sag_complete$StockSize[which(sag_complete$FishStock == "dgs.27.nea")] <- sag_complete$TBiomass[which(sag_complete$FishStock == "dgs.27.nea")]
# sag_complete$FMSY[which(sag_complete$FishStock == "pok.27.1-2")] <- 0.32
# sag_complete$MSYBtrigger[which(sag_complete$FishStock == "pok.27.1-2")] <- 220000
# sag_complete$MSYBtrigger[which(sag_complete$FishStock == "reg.27.1-2")] <- 68600 #PA
# sag_complete$MSYBtrigger[which(sag_complete$FishStock == "cap.27.1-2")] <- 200000 #PA



#2023 update: This cods are still to be checked, this one is not showing up, I guess because of SID
sag_complete$FMSY[which(sag_complete$FishStock == "cod.27.1-2.coastN")] <- 0.176
sag_complete$MSYBtrigger[which(sag_complete$FishStock == "cod.27.1-2.coastN")] <- 67743

sag_complete$FMSY[which(sag_complete$FishStock == "cod.27.1-2.coastN")] <- 0.176
sag_complete$MSYBtrigger[which(sag_complete$FishStock == "cod.27.1-2.coastN")] <- 67743





sag_complete_frmt <- format_sag(sag, sid)

sag_complete_frmt <- sag_complete_frmt %>% filter(StockKeyLabel %in% sid$StockKeyLabel)

#In greenland sea? does it still apply?
sag_complete_frmt$MSYBtrigger[which(sag_complete_frmt$StockKeyLabel == "bli.27.5a14")] <- "802"


#2023 update, do these still apply?, they do not show up
sag_complete_frmt$MSYBtrigger[which(sag_complete_frmt$StockKeyLabel == "ple.27.7e")] <- "0.39"
sag_complete_frmt$MSYBtrigger[which(sag_complete_frmt$StockKeyLabel == "spr.27.7de")] <- "11527.9"
sag_complete_frmt$FMSY[which(sag_complete_frmt$StockKeyLabel == "spr.27.7de")] <- "0.0857"





write.taf(sag_complete_frmt, dir = "data", quote = TRUE)



sag_status <- icesFO::load_sag_status(2024)

# names(sag_status)

# GS_stocks <-  c("aru.27.5a14",
                "usk.27.5a14",
                # "her.27.1-24a514a",
                "rng.27.1245a8914ab",
                "cod.2127.1f14",
                "rhg.27.nea",
                # "cap.27.2a514",
                # "whb.27.1-91214",
                "bli.27.5a14",
                # "pra.27.1-2",
                "ghl.27.561214",
                # "mac.27.nea",
                "reb.2127.dp",
                "reb.2127.sp",
                "reb.27.14b",
                "reg.27.561214"
# )

stocks <- unique(sag_complete_frmt$StockKeyLabel)
sag_status <- dplyr::filter(sag_status, StockKeyLabel %in% stocks)

# sag_status <- dplyr::filter(sag_status, StockKeyLabel %in% GS_stocks)
clean_status <- format_sag_status(sag_status, 2024, ecoregion)
unique(clean_status$StockKeyLabel)
# 
# clean_status <- dplyr::mutate(clean_status, X3A_CODE = substr(clean_status$StockKeyLabel, start = 1, stop = 3))
# clean_status$X3A_CODE <- toupper(clean_status$X3A_CODE)
# clean_status <- merge(clean_status,fish_category, all.x = T, all.y = F)




# 3: STECF landings and effort

# need to group gears, Sarah help.
unique(STECF_landings$Gear.Type)

STECF_landings <- dplyr::mutate(STECF_landings, gear_class = case_when(
  grepl("TBB", Gear.Type) ~ "Beam trawl",
  grepl("DRB|DRH|HMD", Gear.Type) ~ "Dredge",
  grepl("GNS|GND|GNC|GTN|LHP|LLS|FPN|GTR|FYK|LLD|SDN|LTL|LNB", Gear.Type) ~ "Static/Gill net/LL",
  grepl("OTT|OTB|PTB|SSC|SB|SPR|SV", Gear.Type) ~ "Otter trawl/seine",
  grepl("PTM|OTM|PS", Gear.Type) ~ "Pelagic trawl/seine",
  grepl("FPO", Gear.Type) ~ "Pots",
  grepl("NK|NO|LHM", Gear.Type) ~ "other",
  is.na(Gear.Type) ~ "other",
  TRUE ~ "other"
)
)


STECF_effort <- dplyr::mutate(STECF_effort, gear_class = case_when(
  grepl("TBB", Gear.Type) ~ "Beam trawl",
  grepl("DRB|DRH|HMD", Gear.Type) ~ "Dredge",
  grepl("GNS|GND|GNC|GTN|LHP|LLS|FPN|GTR|FYK|LLD|SDN|LTL|LNB", Gear.Type) ~ "Static/Gill net/LL",
  grepl("OTT|OTB|PTB|SSC|SB|SPR|SV", Gear.Type) ~ "Otter trawl/seine",
  grepl("PTM|OTM|PS", Gear.Type) ~ "Pelagic trawl/seine",
  grepl("FPO", Gear.Type) ~ "Pots",
  grepl("NK|NO|LHM", Gear.Type) ~ "other",
  is.na(Gear.Type) ~ "other",
  TRUE ~ "other"
)
)

unique(STECF_landings[c("Gear.Type", "gear_class")])
unique(STECF_effort[c("Gear.Type", "gear_class")])

write.taf(STECF_landings, dir = "data", quote = TRUE)
write.taf(STECF_effort, dir = "data", quote = TRUE)

