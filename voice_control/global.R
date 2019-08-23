library(tidyverse)
library(lubridate)
library(tidyr)
library(base)
library(dplyr)

data <- read.csv("https://data.cityofnewyork.us/resource/uip8-fykc.csv", stringsAsFactors = FALSE)

arrest_dates <- format(as.Date(data$arrest_date), "%Y %d %b")

arrest_weekdays <- weekdays(as.Date(data$arrest_date))

law_cat_cd <- data$law_cat_cd # Level of offense: felony, misdemeanor, violation; string

data$arrest_boro <- ifelse(data$arrest_boro == 'B', 'Bronx', data$arrest_boro)
data$arrest_boro <- ifelse(data$arrest_boro == 'S', 'Staten Island', data$arrest_boro)
data$arrest_boro <- ifelse(data$arrest_boro == 'K', 'Brooklyn', data$arrest_boro)
data$arrest_boro <- ifelse(data$arrest_boro == 'M', 'Manhattan', data$arrest_boro)
data$arrest_boro <- ifelse(data$arrest_boro == 'Q', 'Queens', data$arrest_boro)
arrest_boro <- data$arrest_boro # Borough of arrest: B(Bronx), S(Staten Island), K(Brooklyn), M(Manhattan), Q(Queens); string

arrest_precinct <- data$arrest_precinct # Precinct where the arrest occurred; num

data$jurisdiction_code <- ifelse(data$jurisdiction_code == '0', 'Patrol', data$jurisdiction_code)
data$jurisdiction_code <- ifelse(data$jurisdiction_code == '1', 'Transit', data$jurisdiction_code)
data$jurisdiction_code <- ifelse(data$jurisdiction_code == '2', 'Housing', data$jurisdiction_code)
jurisdiction_code <- data$jurisdiction_code # Codes 0 - 2 represent NYPD whilst codes 3+ represent non-NYPD jurisdictions; num

age_group <- data$age_group # Perpetrator's age within a category; <18, 25-44, 18-24, 45-64; string

perp_sex <- data$perp_sex # Perpetrator's sex description; M/F; string

perp_race <- data$perp_race # Perpetrator's race description; string

x_coord_cd <- data$x_coord_cd # Midblock X-coordinate for New York State Plane Coordinate System, Long Island Zone, NAD 83, units feet (FIPS 3104); num

y_coord_cd <- data$y_coord_cd # Midblock Y-coordinate for New York State Plane Coordinate System, Long Island Zone, NAD 83, units feet (FIPS 3104); num

latitude <- data$latitude # Latitude coordinate for Global Coordinate System, WGS 1984, decimal degrees (EPSG 4326); num

longitude <- data$longitude # Longitude coordinate for Global Coordinate System, WGS 1984, decimal degrees (EPSG 4326); num

data_frame <- data.frame(arrest_dates, arrest_weekdays,
                         law_cat_cd,
                         arrest_boro,
                         arrest_precinct,
                         jurisdiction_code,
                         age_group,
                         perp_sex, perp_race,
                         x_coord_cd, y_coord_cd,
                         latitude, longitude)

colnames(data_frame)[which(names(data_frame) == "arrest_dates")] <- "Date of Arrest"
colnames(data_frame)[which(names(data_frame) == "arrest_weekdays")] <- "Day of Arrest"
colnames(data_frame)[which(names(data_frame) == "law_cat_cd")] <- "Level of Offense"
colnames(data_frame)[which(names(data_frame) == "arrest_boro")] <- "Borough"
colnames(data_frame)[which(names(data_frame) == "arrest_precinct")] <- "Precinct"
colnames(data_frame)[which(names(data_frame) == "jurisdiction_code")] <- "Jurisdiction Code"
colnames(data_frame)[which(names(data_frame) == "age_group")] <- "Age Group"
colnames(data_frame)[which(names(data_frame) == "perp_sex")] <- "Gender"
colnames(data_frame)[which(names(data_frame) == "perp_race")] <- "Race"
colnames(data_frame)[which(names(data_frame) == "x_coord_cd")] <- "X-Coordinate"
colnames(data_frame)[which(names(data_frame) == "y_coord_cd")] <- "Y-Coordinate"
colnames(data_frame)[which(names(data_frame) == "latitude")] <- "Latitude"
colnames(data_frame)[which(names(data_frame) == "longitude")] <- "Longitude"