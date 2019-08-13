library(googleVis)

Geo <- gvisGeoChart(CityPopularity, locationvar='City',
                    colorvar='Popularity',
                    options=list(region='US', height=350,
                                 displayMode='markers',
                                 colorAxis="{values:[200,400,600,800],
                                 colors:[\'red', \'pink\', \'orange',\'green']}"))

Editor <- gvisLineChart(CityPopularity, options=list(gvis.editor='Edit me!'))

#plot(Editor)

#plot(Geo)

plot(Editor)

print(Editor, tag='header')
print(Editor, tag='chart')


# Google Charts API