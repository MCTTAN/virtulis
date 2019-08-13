library(plotGoogleMaps)
library(spatstat)
library(crimedata)
library(stats)
library(googleVis)

data_crime <- get_crime_data()
head(data_crime)
# data_crime
# crime = mydataframe[, "crime"]
write.table(subtable, "/cloud/project/data_exported/data_crime_exported.txt", sep="\t")
# list_crime_data()
subtable <- data_crime$city_name

data_crime$latlong <- paste(data_crime$latitude, data_crime$longitude, sep = ":")
print(gvisGeoChart(quakes, locationvar = "latlong", colorvar = "", sizevar = "", options = list(displayMode = "", region = "", colorAxis = "{colors:['red', 'grey']}", backgroundColor = "lightblue")), "chart")

obj <- gvisGeoChart(quakes, locationvar = "latlong", colorvar = "", sizevar = "", options = list(displayMode = "", region = "", colorAxis = "{colors:['red', 'grey']}", backgroundColor = "lightblue"))


plot(obj, browser=rstudioapi::viewer)


# gvisGeoChart(data, locationvar = "", numvar = "", options = list(), chartid)


# plotGoogleMaps(subtable, zcol="data_crime$city_name", filename="/cloud/project/data_exported/data_crime_exported.txt", layerName="Number of Crimes", fillOpacity=0.4, strokeWeight=0, mapTypeId="ROADMAP")

# plotGoogleMaps(Borough,zcol="Intensity",filename="Crimes_Boroughs.html",layerName="Number of Crimes", fillOpacity=0.4,strokeWeight=0,mapTypeId="ROADMAP")


# uid
# city_name
# offense_code
# offense_type
# offense_group
# offense_against
# date_single
# longitude
# latitude
# location_type
# location_category
# census_block
# date_start
# date_end