# wd: bootstrap/data/ICES_nominal_catches

library(icesTAF)
taf.library(icesFO)

hist <- load_historical_catches()
hist$Country[which(hist$Country == "Germany, New L\xe4nder")]<- "Germany"
write.taf(hist, file = "bootstrap/data/ICES_nominal_catches/ICES_historical_catches.csv", quote = TRUE)

official <- load_official_catches()
official <- official[, -1]
# colnames(official)[1] <- "Species"

write.taf(official, file = "bootstrap/data/ICES_nominal_catches/ICES_2006_2020_catches.csv", quote = TRUE)


