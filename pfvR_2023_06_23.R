# En este ejemplo ubicaremos los puntos de interes del viernes pasado en un mapa de Argentina

# Packages ----
# install.packages("pacman")
pacman::p_load(tidyverse,  mapview, sf, geodata, here)

# Puntos de interés ----
puntos <- 
  tribble(
    ~id,         ~lon,         ~lat,
    "Balcarce", -58.308995, -37.759436, 
    "Pergamino", -60.559427, -33.943984, 
    "Bariloche",  -71.246986, -41.131179
  )

puntos_geo <- puntos %>% 
  st_as_sf(coords = c('lon', 'lat'), crs = 4326) 

# opcion dinamica
puntos_geo %>% 
  mapview(map.types = mapviewGetOption("basemaps"))


# opcion estática

theme_set(theme_bw()+
            theme(
              panel.grid.major = element_line(color = gray(0.5), 
                                              linetype = "dashed", 
                                              linewidth = 0.1), 
              panel.background = element_rect(fill = "aliceblue"),
              axis.text.x =  element_text(size = 6),
              axis.text.y = element_text(size = 6)))

AR <- geodata::gadm(country = "ARG", level = 1, path=here::here()) %>% 
  st_as_sf() 

mapa <- puntos %>% 
  st_as_sf(coords = c('lon', 'lat'), crs = 4326) %>% 
  ggplot()+
  geom_sf(data=AR)+
  geom_sf_label(aes(label = id), alpha=.5, vjust=1)+
  geom_sf() + 
  labs(x="", y="")

mapa

ggsave(mapa, filename = "mapa_sitios.png")
