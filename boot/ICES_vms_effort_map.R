

library("icesVMS")

# icesVMS::update_token("luca.lamoni")
vms_effort <- icesVMS::get_effort_map(ecoregion, year = 2022)

# convert to sf
vms_effort$wkt <- sf::st_as_sfc(vms_effort$wkt)
vms_effort <- sf::st_sf(vms_effort, sf_column_name = "wkt", crs = 4326)

sf::st_write(vms_effort, paste0("vms_effort_", ecoregion, ".csv"), layer_options = "GEOMETRY=AS_WKT")
