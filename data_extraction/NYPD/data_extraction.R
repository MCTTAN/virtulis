library(crimedata)
library(readxl)
library(xlsx)

# setwd("/cloud/project/data_extraction")
setwd("../virtulis/data_extraction")

data_crime <- get_crime_data()
list_crime_data()
subtable <- subset(data_crime, city_name == "New York")
write.csv(subtable, file = "crimedata_new_york.csv")

motor_vehicle_collisions <- read.csv("https://data.cityofnewyork.us/resource/h9gi-nx95.csv")
write.csv(motor_vehicle_collisions, file = "motor_vehicle_collisions.csv")



# Does not work:
# motor_vehicle_collisions <- read_excel("https://data.cityofnewyork.us/api/views/h9gi-nx95/files/b5fd8e71-ca48-4e96-bf63-1b8a7c4cc47b?download=true&filename=Collision_DataDictionary.xlsx")
# write.csv(motor_vehicle_collisons, file = "motor_vehicle_collisions.csv")

# convert("mtcars.dta", "mtcars.sav")

# write.table(subtable, "/cloud/project/data_exported/data_crime_exported.txt", sep="\t")

# data <-read.csv("http://www.calvin.edu/~lk24/courses/Data/grandrapidsweather.csv")

# IMPORT, EXPORT, CONVERT
# https://cran.r-project.org/web/packages/rio/vignettes/rio.html

# https://developer.ibm.com/clouddataservices/2016/11/03/open-crime-data/

# https://www.r-bloggers.com/getting-data-from-an-online-source/
# https://theodi.org/article/how-to-use-r-to-access-data-on-the-web/
# https://www.dezyre.com/data-science-in-r-programming-tutorial/r-tutorial-importing-data-from-web

# write.csv(MyData, file = "MyData.csv",row.names=FALSE)
# write.csv(MyData, file = "MyData.csv",row.names=FALSE, na="")
# write.table(MyData, file = "MyData.csv",row.names=FALSE, na="",col.names=FALSE, sep=",")