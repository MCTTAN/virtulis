library(tidyverse)
library(leaflet)
library(geojsonio)
library(htmlwidgets)
library(htmltools)

# boston <- read.csv("bostonbrews.csv", stringsAsFactors=F)
# bostoneight <- geojsonio::geojson_read("mass-8ft.json", what = "sp")
# 
# bostonmap <- leaflet(boston) %>% 
#   addProviderTiles("CartoDB.Positron") %>%
#   setView(-71.061229, 42.357379, zoom = 13) %>% 
#   addPolygons(data=bostoneight,
#               col = 'dodgerblue',
#               stroke = FALSE, 
#               fillOpacity = 0.3, 
#               smoothFactor = 0.5) %>%
#   addCircleMarkers(label=~string,
#                    weight = 3, 
#                    radius=10, 
#                    color="#ffa500")
# bostonmap