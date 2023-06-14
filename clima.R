pacman::p_load(tidyverse)

puntos <- 
  tribble(
    ~eea,         ~lon,         ~lat,
    "Balcarce", -58.308995, -37.759436, 
    "Pergamino", -60.559427, -33.943984, 
    "Bariloche",  -71.246986, -41.131179
  )


# library(kgc)

# puntos_kgc <-  puntos %>%
#   mutate(rndCoord.lat = RoundCoordinates(.$lat),
#          rndCoord.lon = RoundCoordinates(.$lon)) %>% 
#   mutate(ClimateZ=LookupCZ(.))
# puntos_kgc

# library(nasapower) 
# puntos_nasa <- puntos %>% 
#   group_by(eea) %>% 
#   mutate(clima = map2(
#     lon, lat, 
#     .f = ~ get_power(
#       community = "ag", 
#       lonlat = c(..1, ..2),
#       temporal_api = "climatology",
#       pars = c("T2M", "ALLSKY_SFC_SW_DWN")
#     ))) 
# 
# puntos_nasa <- puntos_nasa %>% 
#   select(eea, clima) %>% 
#   unnest(clima) %>% 
#   pivot_wider(names_from = "PARAMETER", 
#               values_from = c("JAN":"ANN")) 