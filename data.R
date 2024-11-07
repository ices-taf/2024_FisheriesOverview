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
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "cod")] <- "Demersal"
catch_dat$GUILD[which(catch_dat$SPECIES_CODE == "POK")] <- "Demersal"
catch_dat$GUILD[which(catch_dat$SPECIES_CODE == "REB")] <- "Demersal"


catch_dat$COMMON_NAME[which(catch_dat$COMMON_NAME == "European pilchard(=Sardine)")] <- "Sardine"
catch_dat$COMMON_NAME[which(catch_dat$COMMON_NAME == "Scomber mackerels nei")] <- "Mackerels"
catch_dat$COMMON_NAME[which(catch_dat$COMMON_NAME == "Mackerels nei")] <- "Mackerels"
catch_dat$COMMON_NAME[which(catch_dat$COMMON_NAME == "Atlantic chub mackerel")] <- "Chub mackerel"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Mackerels")] <- "pelagic"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Chub mackerel")] <- "pelagic"
catch_dat$COMMON_NAME[which(catch_dat$COMMON_NAME == "Jack and horse mackerels nei")] <- "Jack and horse mackerels"
catch_dat$COMMON_NAME[which(catch_dat$COMMON_NAME == "Atlantic horse mackerel")] <- "Jack and horse mackerels"
catch_dat$COMMON_NAME[which(catch_dat$COMMON_NAME == "Atlantic mackerel")] <- "mackerel"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Jack and horse mackerels")] <- "pelagic"
catch_dat$COMMON_NAME[which(catch_dat$COMMON_NAME == "Monkfishes nei")] <- "Anglerfishes nei"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Anglerfishes nei")] <- "benthic"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Pelagic fishes nei")] <- "pelagic"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Raja rays nei")] <- "elasmobranch"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Bathyraja rays nei")] <- "elasmobranch"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Albacore")] <- "pelagic"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Pouting(=Bib)")] <- "demersal"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Gadiformes nei")] <- "demersal"
catch_dat$COMMON_NAME[which(catch_dat$COMMON_NAME == "Octopuses, etc. nei")] <- "Octopuses"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Blue mussel")] <- "crustacean"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Sea mussels nei")] <- "crustacean"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Cockles nei")] <- "crustacean"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Common edible cockle")] <- "crustacean"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Tuberculate cockle")] <- "crustacean"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Pouting(=Bib)")] <- "demersal"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Gadiformes nei")] <- "demersal"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Cupped oysters nei")] <- "crustacean"
catch_dat$GUILD[which(catch_dat$COMMON_NAME == "Pacific cupped oyster")] <- "crustacean"

catch_dat$GUILD <- tolower(catch_dat$GUILD)

catch_dat <- unique(catch_dat)

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

#This should not do much, maybe we can delete
sag_complete_frmt <- sag_complete_frmt %>% filter(StockKeyLabel %in% sid$StockKeyLabel)

# Removing Russian stocks for Barents Sea
out <- c("cap.27.1-2","cod.27.1-2","ghl.27.1-2","had.27.1-2", "reb.27.1-2")
library(operators)
sag_complete_frmt <- dplyr::filter(sag_complete_frmt, StockKeyLabel %!in% out)
detach("package:operators", unload=TRUE)

#2024 update
sag_complete_frmt$MSYBtrigger[which(sag_complete_frmt$StockKeyLabel == "bli.27.5a14")] <- "800"


#2023 update, do these still apply?, they do not show up
sag_complete_frmt$MSYBtrigger[which(sag_complete_frmt$StockKeyLabel == "ple.27.7e")] <- "0.39"
sag_complete_frmt$MSYBtrigger[which(sag_complete_frmt$StockKeyLabel == "spr.27.7de")] <- "11527.9"
sag_complete_frmt$FMSY[which(sag_complete_frmt$StockKeyLabel == "spr.27.7de")] <- "0.0857"




# 
# write.taf(sag_complete_frmt, dir = "data", quote = TRUE)



sag_status <- load_sag_status_new(sag)


#rename the components of North Sea cod and ane in 9a and remove the general assessment:

sag_complete_frmt$StockKeyLabel[which(sag_complete_frmt$AssessmentKey == "18715")] <- "cod.27.46a7d20V"
sag_complete_frmt$StockKeyLabel[which(sag_complete_frmt$AssessmentKey == "18719")] <- "cod.27.46a7d20NW"
sag_complete_frmt$StockKeyLabel[which(sag_complete_frmt$AssessmentKey == "18716")] <- "cod.27.46a7d20S"
sag_complete_frmt$StockKeyLabel[which(sag_complete_frmt$AssessmentKey == "19045")] <- "ane.27.9aW"
sag_complete_frmt$StockKeyLabel[which(sag_complete_frmt$AssessmentKey == "19017")] <- "ane.27.9aS"

sag_complete_frmt <- sag_complete_frmt %>% filter(AssessmentKey != "18680")

sag_status$StockKeyLabel[which(sag_status$AssessmentKey == "18715")] <- "cod.27.46a7d20V"
sag_status$StockKeyLabel[which(sag_status$AssessmentKey == "18719")] <- "cod.27.46a7d20NW"
sag_status$StockKeyLabel[which(sag_status$AssessmentKey == "18716")] <- "cod.27.46a7d20S"
sag_status$StockKeyLabel[which(sag_status$AssessmentKey == "19045")] <- "ane.27.9aW"
sag_status$StockKeyLabel[which(sag_status$AssessmentKey == "19017")] <- "ane.27.9aS"

sag_status <- sag_status %>% filter(AssessmentKey != "18680")

library(operators)
sag_status <- dplyr::filter(sag_status, StockKeyLabel %!in% out)
detach("package:operators", unload=TRUE)

clean_status <- format_sag_status_new(sag_status)
names(clean_status)
colnames(clean_status)<- c("StockKeyLabel", "AssessmentKey","lineDescription","FishingPressure", "StockSize","SBL")
guild <- sid %>% select(StockKeyLabel, FisheriesGuild)

clean_status <- left_join(clean_status, guild)
# clean_status <- format_sag_status(sag_status)
clean_status$FisheriesGuild[which(clean_status$AssessmentKey == "18715")] <- "Demersal"
clean_status$FisheriesGuild[which(clean_status$AssessmentKey == "18719")] <- "Demersal"
clean_status$FisheriesGuild[which(clean_status$AssessmentKey == "18716")] <- "Demersal"

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

