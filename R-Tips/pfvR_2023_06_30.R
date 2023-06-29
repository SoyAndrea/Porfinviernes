
# Cada cultivo de grano tiene su humedad standard de recibo, por ej. el girasol se recibe a 11% de humedad.
# Ademas, el girasol puede obtener bonificaciones por el contenido de aceite, 
# esto es: para valores superiores a 42% se bonifica a razón de 2% mas de rendimiento por cada punto %.
# http://www.agro.unc.edu.ar/~wpweb/cereales/wp-content/uploads/sites/31/2018/07/TABLA-TIPIFICACION-Calidad-Comercial-de-granos.pdf

# Al presentar resultados de ensayos de girasol es común ver el rendimiento ajustado a 11% y sobre este, 
# se aplica la bonificación correspondiente según % de aceite. 

# Al tratarse de un cálculo de rutina, nos conviene tener a mano funciones que nos faciliten los cálculos 
# en algun script. Veamos como hariamos esas funciones

# (Siempre es bueno verificar en un Hoja de cálculo de excel como este link)
# https://docs.google.com/spreadsheets/d/1WqLNuOCriRdXaND7xF3OZL939WaaJl_Iy-kzc6jmoOo/edit?usp=sharing


library(tidyverse)
dat <- tibble::tribble(
  ~trt, ~rep, ~rinde_cosecha, ~humedad_a_cosecha, ~aceite_porc,
  1,    1,           3011,                9.1,         53.2,
  2,    1,           3200,                8.8,         54.3,
  3,    1,           3004,               11.2,         53.5,
  4,    1,           2450,                 11,         53.2,
  2,    2,           2900,               11.9,         53.2,
  3,    2,           2850,               10.9,         54.3,
  4,    2,           2467,               10.8,         53.5,
  1,    2,           3001,               10.8,         53.2
)

# funcion para ajustar rinde por humedad

ajustar_por_humedad <- function(rinde_cosecha, humedad_a_cosecha, hum_recibo){
  agua = rinde_cosecha*humedad_a_cosecha/100
  rinde_seco = rinde_cosecha - agua 
  factor_ajuste = 1-hum_recibo/100
  rinde_aj_comercial = rinde_seco/factor_ajuste
}

# poniendo a prueba la funcion 
dat %>% 
  mutate(rinde_aj_humedad = ajustar_por_humedad(rinde_cosecha, humedad_a_cosecha, hum_recibo=11))

# funcion para ajustar rinde por binificacion 

ajustar_por_aceite <- function(rinde_aj_humedad, aceite_porcen){
  bonificacion = 1+((aceite_porcen-42)*2)/100
  rinde_bonificado = rinde_aj_humedad * bonificacion
}

#
dat <- dat %>% 
  mutate(rinde_aj_humedad = ajustar_por_humedad(rinde_cosecha, humedad_a_cosecha, hum_recibo=11),
         rinde_bonificado = ajustar_por_aceite(rinde_aj_humedad, aceite_porc))


dat %>%
  ggplot() + 
  aes(x=trt, group=factor(rep), linetype=factor(rep)) + 
  stat_summary(fun=mean, aes(y = rinde_aj_humedad, label=round(after_stat(y))), geom="text", size=3) + 
  stat_summary(fun=mean, aes(y = rinde_aj_humedad, color="rinde_aj_humedad"), geom="line") + 
  stat_summary(fun=mean, aes(y = rinde_bonificado, label=round(after_stat(y))), geom="text", size=3)  + 
  stat_summary(fun=mean, aes(y = rinde_bonificado, color="rinde_bonificado"), geom="line") +
  scale_color_manual(name='Tipo ajuste',
                     breaks=c("rinde_aj_humedad", "rinde_bonificado"),
                     values=c('rinde_aj_humedad'='blue', 'rinde_bonificado'='red')) + 
  labs(linetype="Rep")
