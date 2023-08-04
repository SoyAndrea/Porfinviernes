## fuente https://github.com/AgRoMeteorologiaINTA/agromet
remotes::install_github("AgRoMeteorologiaINTA/agromet", build_vignettes = TRUE)

library(agromet)
library(dplyr)

archivo <- system.file("extdata", "NH0358.DAT", package = "agromet")

datos <- leer_nh(archivo)

# Genero datos aleatorios 
set.seed(496)
datos_aleatorios <- data.frame(metadatos_nh(), pp = rgamma(nrow(metadatos_nh()), 0.5, scale = 1)*70)

datos_aleatorios %>% 
  with(mapear(pp, lon, lat, cordillera = TRUE,
              escala = escala_pp_diaria,
              titulo = "Precipitación aleatoria", 
              fuente = "Fuente: datos de ejemplo"))