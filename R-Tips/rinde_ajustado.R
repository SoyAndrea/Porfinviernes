
#script con el conjunto de funciones a utilizar 

# Una forma práctica de disponibilizar funciones es mediante source(script_con_funciones.R), y este puede 
# estar alojado en nuestras propias PCs o bien en algun repositorio online como en este caso. Para eso 
# necesitamos tener instalado el paquete "devtools"
#devtools::source_url("https://github.com/RenINTA/Porfinviernes/blob/main/R-Tips/rinde_ajustado.R")
#en este caso el script_con_funciones.R es rinde_ajustado.R

ajustar_por_humedad <- function(rinde_cosecha, humedad_a_cosecha, hum_recibo){
  agua <- rinde_cosecha*humedad_a_cosecha/100
  rinde_seco <- rinde_cosecha - agua 
  factor_ajuste <- 1-hum_recibo/100
  rinde_aj_comercial <- rinde_seco/factor_ajuste
}

# poniendo a prueba la funcion 
# print(ajustar_por_humedad(3000, 10, hum_recibo=11))

# funcion para ajustar rinde por binificacion 

ajustar_por_aceite <- function(rinde_aj_humedad, aceite_porcen){
  bonificacion <- 1+((aceite_porcen-42)*2)/100
  rinde_bonificado <- rinde_aj_humedad * bonificacion
}

# poniendo a prueba la funcion 
# print(ajustar_por_aceite(3033.708, 45))


