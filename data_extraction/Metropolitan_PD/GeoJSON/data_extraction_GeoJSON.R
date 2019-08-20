library(crimedata)
library(readxl)
library(xlsx)
library(data.table)
library(RCurl)
library(RSocrata)
library(sp)
library(rgdal)
library(downloader)
library(geojsonio)
library(rjson)
library(RJSONIO)
library(jsonlite)
library(SparkR)

# setwd("/cloud/project/data_extraction/Metropolitan_PD")
setwd("~/virtulis/data_extraction/Metropolitan_PD")

### CSV

# nyc_open_data <- read.csv("https://data.cityofnewyork.us/resource/h9gi-nx95.csv")
# write.csv(nyc_open_data, file = "motor_vehicle_collisions.csv")

### GeoJSON

u <- "https://opendata.arcgis.com/datasets/6af5cb8dc38e4bcbac8168b27ee104aa_38.geojson"
downloader::download(url = u, destfile = "~/virtulis/data_extraction/Metropolitan_PD/crime_incidents_in_2017.GeoJSON")
crime_incidents_in_2017 <- read.table("https://opendata.arcgis.com/datasets/6af5cb8dc38e4bcbac8168b27ee104aa_38.geojson")
crime_incidents_in_2017
# geojsonio::geojson_write(gas, file = "/tmp/gas2.geojson")

### JSON

# crime_incidents_in_2017 <- fromJSON(file= "<filename.json>" )