
# Here we run a few intermediate formatting steps done on SAG. 


library(icesTAF)
library(dplyr)
taf.library(icesFO)

mkdir("model")

#For GS 2024  we remove mac and her?
# sag_complete_frmt <- sag_complete_frmt%>% filter(StockKeyLabel != "mac.27.nea")
# sag_complete_frmt <- sag_complete_frmt%>% filter(StockKeyLabel != "her.27.1-24a514a")

unique(sag_complete_frmt$StockKeyLabel)

#A. Trends by guild

sag_complete_frmt <- read.taf("data/sag_complete_frmt.csv")

sag_trends <- stock_trends(sag_complete_frmt)

#Check if this still applies in 2023

sag_trends <- sag_trends[!(sag_trends$StockKeyLabel == "whb.27.1-91214" & sag_trends$Metric == "F_FMEAN" & sag_trends$Year == 2022) &
                         !(sag_trends$StockKeyLabel == "whb.27.1-91214" & sag_trends$Metric == "F_FMSY" & sag_trends$Year == 2022) &
                         !(sag_trends$StockKeyLabel == "MEAN" & sag_trends$Metric == "F_FMSY" & sag_trends$Year == 2022) &
                         !(sag_trends$StockKeyLabel == "whb.27.1-91214" & sag_trends$Metric == "SSB_MSYBtrigger" & sag_trends$Year == 2023) &
                         !(sag_trends$StockKeyLabel == "MEAN" & sag_trends$Metric == "SSB_MSYBtrigger" & sag_trends$Year == 2023),]


# test <- sag_complete_frmt %>% filter(StockKeyLabel == "dgs.27.nea")
sag_guild <- guild_trends(sag_complete_frmt)

write.taf(sag_trends, dir = "model")
write.taf(sag_guild, dir = "model")

#B.Trends and current catches, landings and discards

sag_catch_trends <- CLD_trends(sag_complete_frmt)
# sag_catch_trends <- unique(sag_catch_trends)
sag_catch_current <- stockstatus_CLD_current(sag_complete_frmt)

write.taf(sag_catch_trends, dir = "model")
write.taf(sag_catch_current, dir = "model")
