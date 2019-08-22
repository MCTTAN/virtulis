library(tidyverse)
library(lubridate)
library(tidyr)
library(base)

### ARREST DATA (YEAR TO DATE)

# length(data) == 18
# lengths(data) == 1000

# data <- read.csv("~/virtulis/data_extraction/NYPD/NYC_Open_Data/CSV/arrest_data_year_to_date.csv")
data <- read.csv("https://data.cityofnewyork.us/resource/uip8-fykc.csv", stringsAsFactors = FALSE)
# str(data)

### Save columns into variables

# data$ARREST_KEY
arrest_dates <- format(as.Date(data$arrest_date), "%Y %d %b") # Exact date of arrest for the reported event; calendar
arrest_weekdays <- weekdays(as.Date(data$arrest_date))
# arrest_months <- months(as.Date(data$arrest_date))
# data$arrest_date
# arrest_date <- data$arrest_date

# data$PD_CD

# data$PD_DESC

# data$KY_CD

# data$OFNS_DESC

# data$LAW_CODE

law_cat_cd <- data$law_cat_cd # Level of offense: felony, misdemeanor, violation; string

### Rename items
data$arrest_boro <- ifelse(data$arrest_boro == 'B', 'Bronx', data$arrest_boro)
data$arrest_boro <- ifelse(data$arrest_boro == 'S', 'Staten Island', data$arrest_boro)
data$arrest_boro <- ifelse(data$arrest_boro == 'K', 'Brooklyn', data$arrest_boro)
data$arrest_boro <- ifelse(data$arrest_boro == 'M', 'Manhattan', data$arrest_boro)
data$arrest_boro <- ifelse(data$arrest_boro == 'Q', 'Queens', data$arrest_boro)
arrest_boro <- data$arrest_boro # Borough of arrest: B(Bronx), S(Staten Island), K(Brooklyn), M(Manhattan), Q(Queens); string
# arrest_boro

arrest_precinct <- data$arrest_precinct # Precinct where the arrest occurred; num

### Rename items
# data <- subset(data, data$jurisdiction_code == 0 & data$jurisdiction_code == 1 & data$jurisdiction_code == 2)
# data$jurisdiction_code <- subset(data$jurisdiction_code, data$jurisdiction_code <= 2)
data$jurisdiction_code <- ifelse(data$jurisdiction_code == '0', 'Patrol', data$jurisdiction_code)
data$jurisdiction_code <- ifelse(data$jurisdiction_code == '1', 'Transit', data$jurisdiction_code)
data$jurisdiction_code <- ifelse(data$jurisdiction_code == '2', 'Housing', data$jurisdiction_code)
jurisdiction_code <- data$jurisdiction_code # Codes 0 - 2 represent NYPD whilst codes 3+ represent non-NYPD jurisdictions; num
# jurisdiction_code

age_group <- data$age_group # Perpetrator's age within a category; <18, 25-44, 18-24, 45-64; string

perp_sex <- data$perp_sex # Perpetrator's sex description; M/F; string

perp_race <- data$perp_race # Perpetrator's race description; string

x_coord_cd <- data$x_coord_cd # Midblock X-coordinate for New York State Plane Coordinate System, Long Island Zone, NAD 83, units feet (FIPS 3104); num

y_coord_cd <- data$y_coord_cd # Midblock Y-coordinate for New York State Plane Coordinate System, Long Island Zone, NAD 83, units feet (FIPS 3104); num

latitude <- data$latitude # Latitude coordinate for Global Coordinate System, WGS 1984, decimal degrees (EPSG 4326); num

longitude <- data$longitude # Longitude coordinate for Global Coordinate System, WGS 1984, decimal degrees (EPSG 4326); num

# In R, matrices are homogeneous while dataframes are heterogeneous.
data_frame <- data.frame(arrest_dates, arrest_weekdays,
                         law_cat_cd,
                         arrest_boro,
                         arrest_precinct,
                         jurisdiction_code,
                         age_group,
                         perp_sex, perp_race,
                         x_coord_cd, y_coord_cd,
                         latitude, longitude)
# data_frame[c("Patrol", "Transit", "Housing"), ]
# data_frame[c('Patrol', 'Transit', 'Housing'), ]

# data_frame <- subset(data_frame, (data_frame$jurisdiction_code == 'Patrol' & data_frame$jurisdiction_code == 'Transit' & data_frame$jurisdiction_code == 'Housing') )
# data_frame
# data_frame <- data_frame[(data_frame$jurisdiction_code == 'Patrol' & data_frame$jurisdiction_code == 'Transit' & data_frame$jurisdiction_code == 'Housing'), ]
# data_frame <- data_frame[(data_frame$jurisdiction_code == 'Patrol' & data_frame$jurisdiction_code == 'Transit' & data_frame$jurisdiction_code == 'Housing')]
# data_frame <- data_frame[-c(data_frame$jurisdiction_code != 'Patrol' & data_frame$jurisdiction_code != 'Transit' & data_frame$jurisdiction_code != 'Housing'), ]
# print(data_frame)