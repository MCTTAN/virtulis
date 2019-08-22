library(plotly)
library(rgl)
library(crimedata)

data_crime <- get_crime_data()
head(data_crime)
#data_crime
list_crime_data()
subtable <- subset(data_crime, city_name == "Austin")
write.table(subtable, "/cloud/project/data_exported/data_crime_exported.txt", sep="\t")

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

z <- c(
  c(8.83,8.89,8.81,8.87,8.9,8.87),
  c(8.89,8.94,8.85,8.94,8.96,8.92),
  c(8.84,8.9,8.82,8.92,8.93,8.91),
  c(8.79,8.85,8.79,8.9,8.94,8.92),
  c(8.79,8.88,8.81,8.9,8.95,8.92),
  c(8.8,8.82,8.78,8.91,8.94,8.92),
  c(8.75,8.78,8.77,8.91,8.95,8.92),
  c(8.8,8.8,8.77,8.91,8.95,8.94),
  c(8.74,8.81,8.76,8.93,8.98,8.99),
  c(8.89,8.99,8.92,9.1,9.13,9.11),
  c(8.97,8.97,8.91,9.09,9.11,9.11),
  c(9.04,9.08,9.05,9.25,9.28,9.27),
  c(9,9.01,9,9.2,9.23,9.2),
  c(8.99,8.99,8.98,9.18,9.2,9.19),
  c(8.93,8.97,8.97,9.18,9.2,9.18)
)
dim(z) <- c(15,6)
z2 <- z + 1
z3 <- z - 1

p <- plot_ly(showscale = FALSE) %>%
  add_surface(z = ~z) %>%
  add_surface(z = ~z2, opacity = 0.98) %>%
  add_surface(z = ~z3, opacity = 0.98)

######

Sys.setenv("plotly_username"="mcttan")
Sys.setenv("plotly_api_key"="hIxMHTtHqnM2TRhzSlxz")

chart_link = api_create(p, filename="surface-1")
chart_link












# Sys.setenv("plotly_username"="mcttan")
# Sys.setenv("plotly_api_key"="xjD4Vc2Ke9xINMYZSphf")

### DEMO 1

# view(iris)
# with(iris, plot3d(Sepal.Length, Sepal.Width, Petal.Length))
# 
# rgl.snapshot("plot.png")
# 
# rgl.postscript("plot.pdf",fmt="pdf")
# # Saves the screenshot to a file in ps, eps, tex, pdf, svg or pgf format.
# 
# persp3d(volcano, col = "red")
# rglwidget()
# 
# 
# p <- plot_ly(z = ~volcano) %>% add_surface()
# 
# p <- plot_ly(midwest, x = ~percollege, color = ~state, type = "box")
# p











# identify3d(x, y = NULL, z = NULL, labels, n)
# 
# x, y, z : Numeric vector specifying the coordinates of points. The arguments y and z are optional when:
#   x is a matrix or a data frame containing at least 3 columns which will be used as the x, y and z coordinates.
# x is a formula of form zvar ~ xvar + yvar (see ?xyz.coords).
# labels an optional character vector giving labels for points
# n the maximum number of points to be identified
# 
# 
# The function identify3d(), works similarly to the identify function in base graphics.
# 
# The R code below, allow the user to identify 5 points :
#   
#   rgl_init()
# rgl.spheres(x, y, z, r = 0.2, color = "#D95F02") 
# rgl_add_axes(x, y, z, show.bbox = F)
# aspect3d(1,1,1)
# rgl.material(color = "blue")
# identify3d(x, y, z, labels = rownames(iris), n = 5)