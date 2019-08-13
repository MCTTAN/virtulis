library(googleVis)

G <- gvisGeoChart(Exports, "Country", "Profit", options=list(width=200, height=100))

T <- gvisTable(Exports, options=list(width=200, height=270))

M <- gvisMotionChart(Fruits, "Fruit", "Year", options=list(width=400, height=370))

GT <- gvisMerge(G,T, horizontal=FALSE)

GTM <- gvisMerge(GT, M, horizontal = TRUE, tableOptions = "bgcolor=\"#CCCCCC\" cellspacing=10")

plot(GTM)