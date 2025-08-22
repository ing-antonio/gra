#install.packages("here")
#install.packages("readr")
#install.packages("dplyr")
#install.packages("plotly")

library(here)
library(readr)
library(dplyr)
library(plotly)

ruta_datos <- here("datos", "carpetas_graficas.csv")
datos <- read_csv(ruta_datos)

t <- list(
  family = "arial",
  size = 9,
  color = toRGB("blue"
  ))

p <- datos %>%
  plot_ly(
    x = ~total_delitos_primera,
    y = ~total_delitos_segunda,
    type = 'scatter',
    mode = 'markers',
    marker = list(size = 15, color = ~total_delitos_segunda, colors = c("#00FF00", "#FFFB00", "#FF0000")),
    text = ~nombre_sec,
    textfont = t,
    textposition = "top center",
    hovertemplate = ~paste(
      "<b>Sector:</b>",nombre_sec,"<br>",
      "<b>Alcaldía:</b>",alcaldia,"<br>",
      "<b>Primera Evaluación:</b>",total_delitos_primera,"<br>",
      "<b>Segunda Evaluación:</b>",total_delitos_segunda,"<br>",
      "<b>Variación Porcentual:</b>",variacion_porcentual,"%<br>",
      "<extra></extra>"
    )
  ) %>%
  layout(
    title = "Diagrama de Dispersión de Carpetas Procesadas por Sector",
    xaxis = list(title = "Total de Delitos (Segundo Periodo)"),
    yaxis = list(title = "Total de Delitos (Primer Periodo)"),
    hoverlabel = list(bgcolor = "white", font = list(color = "black"))
  )

ruta_salida_html <- here("salidas", "diagrama_dispersion.html")
htmlwidgets::saveWidget(p, file = ruta_salida_html)

cat("Gráfico guardado en:", ruta_salida_html, "\n")

