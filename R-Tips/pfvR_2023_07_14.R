
#les dejamos como R-tip de este viernes una forma simple de descargar datos desde otra fuente
#de datos meteorológicos y climáticos.
# Recuerden que podemos disponer de datos meteorológicos desde estaciones meteorológicas del SMN o INTA (Argentina), 
#los cuales son datos observados
#pero también hay disponibles base de datos que surgen de combinar los datos observados
#con datos satelitales y datos de modelos climáticos

#en este caso les proponemos explorar los datos de NASAPOWER


#paquete y librerias para usar

#la siquiente forma de instalar (si no tenes el paquete) y abrirlo es utilizando el paquete
#PACMAN, que lo usamos en otros de los R-tip por eso seguro que lo tienen instalado
pacman::p_load(tidyverse, nasapower,kgc)



#generamos un objeto con la lat y long de los puntos de interés, para los cuales queremos
#bajarnos los datos

puntos <- 
  tribble(
    ~localidad,         ~lon,         ~lat,
    "Balcarce", -58.308995, -37.759436, 
    "Pergamino", -60.559427, -33.943984, 
    "Bariloche",  -71.246986, -41.131179
  )


#el paquete kgc permite identificar la zona climática utilizando la clasificación de Koeppen-Geiger (KG)
#https://cran.r-project.org/web/packages/kgc/kgc.pdf
#se lo propones para que vean como podemos obtener esa clasificación

 puntos_kgc <-  puntos %>%
           mutate(rndCoord.lat = RoundCoordinates(.$lat),
          rndCoord.lon = RoundCoordinates(.$lon)) %>%
   mutate(ClimateZ=LookupCZ(.))
puntos_kgc



#aqui descargamos los datos desde NasaPower, de los puntos que armamos arriba
#en este caso bajamos la climatologia, que ya viene directamente pero hay disponible 
#otros lapsos de tiempo

## Con este comando averiguamos la lista de variables de agroclimatology(ag)
#recuerden que si se paran sobre la función y apretan F1 pueden ver la descripción de la misma

que=query_parameters(community = "ag", par = NULL, temporal_api = "daily")


#bajamos los datos
 puntos_nasa <- puntos %>%
   group_by(localidad) %>%
  mutate(clima = map2(   #fijensé que utilizamos la función map2() del paquete PURR...ya lo utilizaremos!!
    lon, lat,
    .f = ~ get_power(
      community = "ag",
      lonlat = c(..1, ..2),
      temporal_api = "climatology",  #con esta función le asignamos el paso temporal que queremos
      pars = c("T2M", "ALLSKY_SFC_SW_DWN")  #aqui las variables
    )))

 
 
#aquí cambiamos el formato de nuestro objeto o archivo anterior 
puntos_nasa2 <- puntos_nasa %>%
  select(localidad, clima) %>%
  unnest(clima) %>% 
  pivot_wider(names_from = "PARAMETER",
              values_from = c("JAN":"ANN"))


###ESTO ES TODO!!!

