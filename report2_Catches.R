
library(icesTAF)
taf.library(icesFO)
library(sf)
library(ggplot2)
library(dplyr)

# set values for automatic naming of files:
year_cap = "2024"
ecoreg = ecoregion
cap_year <- 2024

##########
#Load data
##########

catch_dat <- read.taf("data/catch_dat.csv")


#################################################
##1: ICES nominal catches and historical catches#
#################################################

#~~~~~~~~~~~~~~~#
# By common name
#~~~~~~~~~~~~~~~#
#Plot
plot_catch_trends(catch_dat, type = "COMMON_NAME", line_count = 10, plot_type = "line")
plot_catch_trends(catch_dat, type = "COMMON_NAME", line_count = 6, plot_type = "line")
ggplot2::ggsave(paste0(year_cap, "_", ecoreg,"_FO_Catches_speciestop10.png"), path = "report/", width = 170, height = 100.5, units = "mm", dpi = 300)

#data
dat <- plot_catch_trends(catch_dat, type = "COMMON_NAME", line_count = 11, plot_type = "line", return_data = TRUE)
write.taf(dat, paste0(year_cap, "_", ecoreg,"_FO_Catches_species.csv"), dir = "report")


#for North sea:

dat <- plot_catch_trends(catch_dat, type = "COMMON_NAME", line_count = 11, plot_type = "line", return_data = TRUE)
dat <- dat %>% group_by(type_var) %>% mutate(rank = sum(typeTotal)) 
dat1 <- dat %>% group_by(type_var)%>% filter(top_n(5, rank))
dat1 <- dat %>% group_by(type_var)%>%
  arrange(desc(rank)) %>%  # Sort by 'Value' in descending order
  slice_head(n = 5) 


#~~~~~~~~~~~~~~~#
# By country
#~~~~~~~~~~~~~~~#
#Plot
<<<<<<< HEAD
plot_catch_trends(catch_dat, type = "COUNTRY", line_count = 9, plot_type = "area")
catch_dat%>%filter(YEAR>1954)%>%plot_catch_trends(catch_dat, type = "COUNTRY", line_count = 9, plot_type = "area")
catch_dat$COUNTRY[which(catch_dat$COUNTRY == "Russian Federation")] <- "Russia"
plot_catch_trends(catch_dat, type = "COUNTRY", line_count = 5, plot_type = "area")
>>>>>>> ea4aae232f87f06e1ccf029629d42c9108689e96
ggplot2::ggsave(paste0(year_cap, "_", ecoreg,"_FO_Catches_country.png"), path = "report/", width = 178, height = 130, units = "mm", dpi = 300)

#data
dat <- plot_catch_trends(catch_dat, type = "COUNTRY", line_count = 9, plot_type = "area", return_data = TRUE)
write.taf(dat, file= paste0(year_cap, "_", ecoreg,"_FO_Catches_country.csv"), dir = "report")

#~~~~~~~~~~~~~~~#
# By guild
#~~~~~~~~~~~~~~~#

#Plot
#shoudl be able to remove the "other" part
plot_catch_trends(catch_dat, type = "GUILD", line_count = 6, plot_type = "line")
#for Baltic, remove elasmobranch line
catch_dat2 <- catch_dat %>% filter(GUILD != "elasmobranch")
plot_catch_trends(catch_dat2, type = "GUILD", line_count = 5, plot_type = "line")

ggplot2::ggsave(paste0(year_cap, "_", ecoreg,"_FO_Catches_guild.png"), path = "report/", width = 178, height = 130, units = "mm", dpi = 300)

#data
dat <- plot_catch_trends(catch_dat, type = "GUILD", line_count = 6, plot_type = "line", return_data = TRUE)
write.taf(dat, file= paste0(year_cap, "_", ecoreg,"_FO_Catches_guild.csv"), dir = "report")
