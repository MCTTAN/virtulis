library(plotly)
library(rgl)

Sys.setenv("plotly_username"="mcttan")
Sys.setenv("plotly_api_key"="xjD4Vc2Ke9xINMYZSphf")

### DEMO 1

view(iris)
with(iris, plot3d(Sepal.Length, Sepal.Width, Petal.Length))

rgl.snapshot("plot.png")

rgl.postscript("plot.pdf",fmt="pdf")
# Saves the screenshot to a file in ps, eps, tex, pdf, svg or pgf format.

persp3d(volcano, col = "red")
rglwidget()


p <- plot_ly(z = ~volcano) %>% add_surface()

p <- plot_ly(midwest, x = ~percollege, color = ~state, type = "box")
p











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