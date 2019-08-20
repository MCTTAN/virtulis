library(crimedata)
library(readxl)
library(xlsx)
library(data.table)
library(RCurl)
library(RSocrata)
library(sp)
library(rgdal)
library(downloader)
library(rjson)
library(RJSONIO)
library(jsonlite)
library(SparkR)
library(geojsonio)
if (!require("devtools")) install.packages("devtools")
devtools::install_github("ropensci/geojsonio")

# setwd("/cloud/project/data_extraction/NYPD/NYC_Open_Data/GeoJSON")
setwd("~/virtulis/data_extraction/NYPD/NYC_Open_Data/GeoJSON")

u <- "https://data.cityofnewyork.us/resource/h9gi-nx95.geojson"
downloader::download(url = u, destfile = "~/virtulis/data_extraction/NYPD/NYC_Open_Data/GeoJSON/motor_vehicle_collisions.GeoJSON")
# nyc_open_data <- read.table("https://data.cityofnewyork.us/resource/h9gi-nx95.geojson")
# nyc_open_data

u <- "https://data.cityofnewyork.us/resource/qgea-i56i.geojson"
downloader::download(url = u, destfile = "~/virtulis/data_extraction/NYPD/NYC_Open_Data/GeoJSON/complaint_data_historic.GeoJSON")

u <- "https://data.cityofnewyork.us/resource/5uac-w243.geojson"
downloader::download(url = u, destfile = "~/virtulis/data_extraction/NYPD/NYC_Open_Data/GeoJSON/complaint_data_current_year_to_date.GeoJSON")

u <- "https://data.cityofnewyork.us/resource/h9gi-nx95.geojson"
downloader::download(url = u, destfile = "~/virtulis/data_extraction/NYPD/NYC_Open_Data/GeoJSON/motor_vehicle_collisions_summary.GeoJSON")

