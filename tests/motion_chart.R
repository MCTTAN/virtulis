library(googleVis)

data(Fruits)

M <- gvisMotionChart(Fruits, idvar="Fruit", timevar="Year")

str(M)

M$type

M$chartid

print(M, tag='header')

names(M$html$chart)

print(M, tag='chart')

plot(M)

print(M, file="/cloud/project/data_exported/myGoogleVisChart.html")


