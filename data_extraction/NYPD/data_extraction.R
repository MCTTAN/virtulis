library(crimedata)
library(readxl)
library(xlsx)
library(data.table)
library(RCurl)
library(RSocrata)
library(rgdal)
library(downloader)
library(rjson)

# setwd("/cloud/project/data_extraction/NYPD")
setwd("~/virtulis/data_extraction/NYPD")

### CSV

data_crime <- get_crime_data()
list_crime_data()
subtable <- subset(data_crime, city_name == "New York")
write.csv(subtable, file = "crimedata_new_york.csv")

nyc_open_data <- read.csv("https://data.cityofnewyork.us/resource/h9gi-nx95.csv")
write.csv(nyc_open_data, file = "motor_vehicle_collisions.csv")

nyc_open_data <- read.csv("https://data.cityofnewyork.us/resource/qgea-i56i.csv")
write.csv(nyc_open_data, file = "complaint_data_historic.csv")

nyc_open_data <- read.csv("https://data.cityofnewyork.us/resource/5uac-w243.csv")
write.csv(nyc_open_data, file = "complaint_data_current_year_to_date.csv")

nyc_open_data <- read.csv("https://data.cityofnewyork.us/resource/uip8-fykc.csv")
write.csv(nyc_open_data, file = "arrest_data_year_to_date.csv")

nyc_open_data <- read.csv("https://data.cityofnewyork.us/resource/8h9b-rp9u.csv")
write.csv(nyc_open_data, file = "arrests_data_historic.csv")

nyc_open_data <- read.csv("https://data.cityofnewyork.us/resource/833y-fsy8.csv")
write.csv(nyc_open_data, file = "shooting_incident_data_historic.csv")

nyc_open_data <- read.csv("https://data.cityofnewyork.us/resource/5ucz-vwe8.csv")
write.csv(nyc_open_data, file = "shooting_incident_data_year_to_date.csv")

nyc_open_data <- read.csv("https://data.cityofnewyork.us/resource/sv2w-rv3k.csv")
write.csv(nyc_open_data, file = "criminal_court_summons_historic.csv")

nyc_open_data <- read.csv("https://data.cityofnewyork.us/resource/mv4k-y93f.csv")
write.csv(nyc_open_data, file = "criminal_court_summons_incident_level_data_year_to_date.csv")

### GeoJSON

### JSON

