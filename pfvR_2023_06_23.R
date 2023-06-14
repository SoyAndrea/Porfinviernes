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
pal_soil <- colorRampPalette(colors = c("navajowhite", "navajowhite4"))
pal_ag <- colorRampPalette(colors = c("lightblue", "blue"))
pal_N <- colorRampPalette(colors = c("orange", "green"))


plotSPC(puntos_soil, color = 'socQ50', col.palette = pal_soil(10))
plotSPC(puntos_soil, color = 'clayQ50', col.palette = pal_soil(10))
plotSPC(puntos_soil, color = 'nitrogenQ50', col.palette = pal_N(10))
plotSPC(puntos_soil, color = 'phh2oQ50', col.palette = pal_ag(10))


# Final 
puntos_profiles <- left_join(
  puntos, 
  puntos_soil@horizons %>% select(id, hzdept, ends_with("Q50")),
  by = "id"
)
