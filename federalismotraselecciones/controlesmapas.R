# Librerias ----
library(tidyverse)
library(rebus)
library(curl)
library(sf)
library(leaflet)
library(htmlwidgets)
library(htmltools)
library(ggtext)
library(readxl)


juve <- st_read("https://github.com/JuveCampos/MexicoSinIslas/raw/master/Sin_islas.geojson")

juve <- juve %>% 
  mutate(entidad = ENTIDAD)
  
mapachido <- read_excel("gubernaturas.xlsx")


gen_map <- function(anio_sel) {
  
  bd <- mapachido %>% 
    filter(anio == anio_sel)
  
  bd <- merge(juve, bd, by = "entidad")
  
colores <- c(bd$pintar)

etiquetas <- lapply(str_c("Estado: ", bd$entidad, "<br>",
                          "Partido: ", bd$partido, "<br>"), htmltools::HTML)

leaflet() %>% 
  addProviderTiles(provider = providers$CartoDB.Positron) %>% 
  addPolygons(data = bd,
              stroke = FALSE, 
              smoothFactor = 0.5, 
              fillOpacity = 1,
              label = etiquetas,
              weight = 0.1,
              color = colores,
              opacity = 5)
 
}



