

#downloaded from here:
# https://stecf.ec.europa.eu/data-dissemination/fdi_en

landings1 <- read.taf("bootstrap/initial/data/FDI Landings EU 2013.csv", check.names = TRUE)
landings2 <- read.taf("bootstrap/initial/data/FDI Landings EU 2014.csv", check.names = TRUE)
landings3 <- read.taf("bootstrap/initial/data/FDI Landings EU 2015.csv", check.names = TRUE)
landings4 <- read.taf("bootstrap/initial/data/FDI Landings EU 2016.csv", check.names = TRUE)
landings5 <- read.taf("bootstrap/initial/data/FDI Landings EU 2017.csv", check.names = TRUE)
landings6 <- read.taf("bootstrap/initial/data/FDI Landings EU 2018.csv", check.names = TRUE)
landings7 <- read.taf("bootstrap/initial/data/FDI Landings EU 2019.csv", check.names = TRUE)
landings8 <- read.taf("bootstrap/initial/data/FDI Landings EU 2020.csv", check.names = TRUE)
landings9 <- read.taf("bootstrap/initial/data/FDI Landings EU 2021.csv", check.names = TRUE)
landings10 <- read.taf("bootstrap/initial/data/FDI Landings EU 2022.csv", check.names = TRUE)

STECF_landings <- rbind(landings1, landings2, landings3, landings4, landings5, landings6, landings7, landings8, landings9, landings10)
STECF_effort <- read.taf("bootstrap/initial/data/FDI effort by country.csv", check.names = TRUE)
