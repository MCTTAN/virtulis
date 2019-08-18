library(crimedata)

data-crime <- get_crime_data()

list_crime_data()

subtable <- subset(data_crime, city_name == "Austin")

write.csv(MyData, file = "data-crime-austin.csv")
# write.csv(MyData, file = "MyData.csv",row.names=FALSE)
# write.csv(MyData, file = "MyData.csv",row.names=FALSE, na="")
# write.table(MyData, file = "MyData.csv",row.names=FALSE, na="",col.names=FALSE, sep=",")