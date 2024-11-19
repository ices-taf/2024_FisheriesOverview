# file name utilitiy
file_name <- function(year, ecoregion, name, ext = "", dir = c("bootstrap", "data", "model", "report")) {
  name <- gsub(" ", "_", name)
  if (nzchar(ext)) ext <- paste0(".", ext)
  paste0(dir,"/", year, "_", ecoregion, "_", "FO_", name, ext)
  # sprintf("%s_%s_FO_%s%s",year,ecoregion,name, ext)
}
ecoregion <- "Celtic Seas"


ecoregions <- c("Baltic Sea", "Bay of Biscay and the Iberian Coast", "Celtic Seas", "Greater North Sea",  "Norwegian Sea", "Icelandic Waters", "Barents Sea", "Greenland Sea", "Faroes", "Oceanic Northeast Atlantic", "Azores")


ecoreg_code <- "CS"
cap_month <- "November"
cap_year <- 2024
year_cap <- cap_year
ecoreg <- ecoreg_code
