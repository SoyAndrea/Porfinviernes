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
