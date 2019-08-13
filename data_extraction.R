library(crimedata)

data_crime <- get_crime_data()

list_crime_data()

subtable <- subset(data_crime, city_name == "Austin")

# data_crime
# Exporting data to a tabl-delimited text file
write.table(subtable, "/cloud/project/data_exported/data_crime_exported.txt", sep="\t")