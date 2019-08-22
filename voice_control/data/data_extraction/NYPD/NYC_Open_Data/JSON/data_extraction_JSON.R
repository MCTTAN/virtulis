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

# setwd("/cloud/project/data_extraction/NYPD/NYC_Open_Data/JSON")
setwd("~/virtulis/data_extraction/NYPD/NYC_Open_Data/JSON")

### JSON

nyc_open_data <- fromJSON("https://data.cityofnewyork.us/resource/h9gi-nx95.json" )
write.table(nyc_open_data, "motor_vehicle_collisions.json")

nyc_open_data <- fromJSON("https://data.cityofnewyork.us/resource/qgea-i56i.json")
write.table(nyc_open_data, "complaint_data_historic.json")

nyc_open_data <- fromJSON("https://data.cityofnewyork.us/resource/5uac-w243.json")
write.table(nyc_open_data, "complaint_data_current_year_to_date.json")

nyc_open_data <- fromJSON("https://data.cityofnewyork.us/resource/h9gi-nx95.json")
write.table(nyc_open_data, "motor_vehicle_collisions_summary.json")

nyc_open_data <- fromJSON("https://data.cityofnewyork.us/resource/uip8-fykc.json")
write.table(nyc_open_data, "arrest_data_year_to_date.json")

nyc_open_data <- fromJSON("https://data.cityofnewyork.us/resource/8h9b-rp9u.json")
write.table(nyc_open_data, "arrests_data_historic.json")

nyc_open_data <- fromJSON("https://data.cityofnewyork.us/resource/2fra-mtpn.json")
write.table(nyc_open_data, "complaint_map_year_to_date.json")

nyc_open_data <- fromJSON("https://data.cityofnewyork.us/resource/57mv-nv28.json")
write.table(nyc_open_data, "complaint_map_historic.json")

nyc_open_data <- fromJSON("https://data.cityofnewyork.us/resource/833y-fsy8.json")
write.table(nyc_open_data, "shooting_incident_data_historic.json")

nyc_open_data <- fromJSON("https://data.cityofnewyork.us/resource/5ucz-vwe8.json")
write.table(nyc_open_data, "shooting_incident_data_year_to_date.json")

nyc_open_data <- fromJSON("https://data.cityofnewyork.us/resource/sv2w-rv3k.json")
write.table(nyc_open_data, "criminal_court_summons_historic.json")

nyc_open_data <- fromJSON("https://data.cityofnewyork.us/resource/mv4k-y93f.json")
write.table(nyc_open_data, "criminal_court_summons_incident_level_data_year_to_date.json")
