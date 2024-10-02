library(icesTAF)
taf.library(icesFO)

shape_ecoregion <- icesFO::load_ecoregion(ecoregion)

sf::st_write(shape_ecoregion, paste0("shape_ecoregion_",ecoregion,".csv"), layer_options = "GEOMETRY=AS_WKT")
