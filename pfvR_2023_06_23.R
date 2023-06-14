# En este ejemplo aprenderermos a obtener informacion de propiedades edaficas de soil data base, de cualquier punto georefenciado, de

pacman::p_load(tidyverse,  soilDB)
puntos <- 
  tribble(
  ~eea,         ~lon,         ~lat,
  "Balcarce", -58.308995, -37.759436, 
  "Pergamino", -60.559427, -33.943984, 
  "Bariloche",  -71.246986, -41.131179
)

puntos_soil <- puntos %>% 
  select(id="eea", lat, lon)%>% 
  fetchSoilGrids() 

library(aqp)
# https://ncss-tech.github.io/AQP/aqp/aqp-intro.html#1_Introduction
plotSPC(puntos_soil, color = 'ex_Ca_to_Mg')

puntos_profiles <- data.frame(
  expand_grid(coordinates(puntos_soil), unique(puntos_soil$label)),
  puntos_soil$bdodQ50, 
  puntos_soil$cecQ50, 
  puntos_soil$clayQ50, 
  puntos_soil$nitrogenQ50, 
  puntos_soil$phh2oQ50, 
  puntos_soil$sandQ50, 
  puntos_soil$siltQ50, 
  puntos_soil$socQ50)


puntos_full <- puntos_kgc %>%
  # mutate_at(vars("rndCoord.lon","rndCoord.lat"), as.character) %>% 
  dplyr::rename("LON"="lon" , "LAT"="lat" ) %>% 
  left_join(tibble(puntos_nasa))
