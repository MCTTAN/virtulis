library(crimedata)

data-crime <- get_crime_data()

list_crime_data()

subtable <- subset(data_crime, city_name == "Austin")

write.csv(MyData, file = "data-crime-austin.csv")
# data <-read.csv("http://www.calvin.edu/~lk24/courses/Data/grandrapidsweather.csv")

# https://www.r-bloggers.com/getting-data-from-an-online-source/
# https://theodi.org/article/how-to-use-r-to-access-data-on-the-web/
# https://www.dezyre.com/data-science-in-r-programming-tutorial/r-tutorial-importing-data-from-web

# write.csv(MyData, file = "MyData.csv",row.names=FALSE)
# write.csv(MyData, file = "MyData.csv",row.names=FALSE, na="")
# write.table(MyData, file = "MyData.csv",row.names=FALSE, na="",col.names=FALSE, sep=",")