library(googleVis)

## Please note that by default the googleVis plot command
## will open a browser window and requires Internet
## connection to display the visualisation.


G1 <- gvisGeoChart(Exports, locationvar='Country', numvar='Profit') 

plot(G1)

## Plot only Europe
G2 <- gvisGeoChart(Exports, "Country", "Profit",
                   options=list(region="150"))

# plot(G2)

G <- gvisGeoChart(Exports, "Country", "Profit", options = list(width = 250, 
                                                               height = 120))

B <- gvisBarChart(Exports[, 1:2], yvar = "Profit", xvar = "Country", 
                  options = list(width = 250, height = 260, legend = "none"))
M <- gvisMotionChart(Fruits, "Fruit", "Year", options = list(width = 400, 
                                                             height = 380))
GBM <- gvisMerge(gvisMerge(G, B, horizontal = FALSE), M, horizontal = TRUE, 
                 tableOptions = "cellspacing=5")

plot(GBM)
# print(GBM, "chart")

