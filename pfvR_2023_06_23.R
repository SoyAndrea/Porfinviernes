# En este ejemplo aprenderermos a obtener informacion de propiedades edaficas 
# de soil data base, de cualquier punto georefenciado

# Packages ----
# install.packages("pacman")
library(pacman)
p_load(tidyverse,  soilDB, aqp)

# Puntos de interés ----
puntos <- 
  tribble(
    ~id,         ~lon,         ~lat,
    "Balcarce", -58.308995, -37.759436, 
    "Pergamino", -60.559427, -33.943984, 
    "Bariloche",  -71.246986, -41.131179
  )

# Obtener datos de suelo ----
puntos_soil <- puntos %>% fetchSoilGrids()

# Grafico
# https://ncss-tech.github.io/AQP/aqp/aqp-intro.html#1_Introduction
pal <- colorRampPalette(colors = c("navajowhite", "navajowhite4"))
plotSPC(puntos_soil, color = 'socQ50', col.palette = pal(10))

# Final 
puntos_profiles <- left_join(
  puntos, 
  puntos_soil@horizons %>% select(id, hzdept, ends_with("Q50")),
  by = "id"
)