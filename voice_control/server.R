library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)
library (plotly)

function(input, output, session) {

  # Launch Map
  output$map <-  renderLeaflet({
    leaflet() %>%
      addTiles(
        urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png"
      ) %>%
      setView(lng = -96.76152, lat = 32.98648 , zoom = 4)
  })
  
  # Pop-Up Dialog Box At Current Location
  displayLocation <- function(latitude, longitude) {
    content <- as.character(tagList(
      tags$strong(HTML(sprintf("%s, %s, %s", "%s, %s, %s", "%s, %s, %s", "%s, %s, %s", "%s",
                               data_frame$"Date of Arrest",
                               data_frame$"Day of Arrest",
                               data_frame$"Level of Offense",
                               data_frame$"Borough",
                               data_frame$"Precinct",
                               data_frame$"Jurisdiction Code",
                               data_frame$"Age Group",
                               data$frame$"Gender",
                               data$frame$"Race",
                               data$frame$"X-Coordinate",
                               data$frame$"Y-Coordinate",
                               data$frame$"Latitude",
                               data$frame$"Longitude"
      ))), tags$br(),
      sprintf("Date of arrest: %s"), tags$br(),
      sprintf("Day of arrest: %s"), tags$br(),
      sprintf("Level of offense: %s"), tags$br(),
      sprintf("Borough: %s"), tags$br(),
      sprintf("Precinct: %s"), tags$br(),
      sprintf("Jurisdiction Code: %s"), tags$br(),
      sprintf("Age Group: %s"), tags$br(),
      sprintf("Gender: %s"), tags$br(),
      sprintf("Race: %s"), tags$br(),
      sprintf("X-Coordinate: %s"), tags$br(),
      sprintf("Y-Coordinate: %s"), tags$br(),
      sprintf("Latitude: %s"), tags$br(),
      sprintf("Longitude: %s")
    ))
    leafletProxy("map") %>% addPopups(longitude, latitude, content, layerId = location)
  }
  
  # A reactive expression that returns the set of zips that are
  # in bounds right now
  # zipsInBounds <- reactive({
  #   if (is.null(input$map_bounds))
  #     return(zipdata[FALSE,])
  #   bounds <- input$map_bounds
  #   latRng <- range(bounds$north, bounds$south)
  #   lngRng <- range(bounds$east, bounds$west)
  # 
  #   subset(zipdata,
  #     latitude >= latRng[1] & latitude <= latRng[2] &
  #       longitude >= lngRng[1] & longitude <= lngRng[2])
  # })

  # Identify any changes in color
    color <- eventReactive(input$color, {
    output$default <- renderText({ paste("Color by", input$color) })
    
    input$color 
    })

  # Identify changes in size
  size <- eventReactive(input$size, {
  output$default <- renderText({ paste("Size by",input$size) }) 
    
    input$size
    })
  
  # Scatter plot
  output$scatterPlot <- renderPlotly({
  
    # Y versus X
    
    # if(input$ploty == "Date of Arrest" && input$plotx == "Level of Offense")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", mode = 'markers', x = ~"Date of Arrest", y = ~"Level of Offense") %>% layout(title = "Graph 'Date of Arrest' by 'Level of Offense'")
    # }
    
    # else if(input$ploty == "Date of Arrest" && input$plotx == "Borough")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", mode = 'markers', x = ~"Date of Arrest", y = ~"Borough") %>% layout(title = "Graph 'Date of Arrest' by 'Borough'")
    # }
    # else if (input$ploty == "Date of Arrest" && input$plotx == "Precinct")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", mode = 'markers', x = ~"Date of Arrest", y = ~"Precinct") %>% layout(title = "Graph 'Date of Arrest' by 'Precinct'")
    # }
    # else if (input$ploty == "Date of Arrest" && input$plotx == "Jurisdiction Code")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", mode = 'markers', x = ~"Date of Arrest", y = ~"Jurisdiction Code") %>% layout(title = "Graph 'Date of Arrest' by 'Jurisdiction Code'")
    # }
    # else if (input$ploty == "Date of Arrest" && input$plotx == "Age Group")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", mode = 'markers', x = ~"Date of Arrest", y = ~"Age Group") %>% layout(title = "Graph 'Date of Arrest' by 'Age Group'")
    # }
    # else if (input$ploty == "Date of Arrest" && input$plotx == "Gender")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", mode = 'markers', x = ~"Date of Arrest", y = ~"Gender") %>% layout(title = "Graph 'Date of Arrest' by 'Gender'")
    # }
    # else if (input$ploty == "Date of Arrest" && input$ploty == "Race")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Date of Arrest", y = ~"Race") %>% layout(title = "Graph 'Date of Arrest' by 'Race'")
    # }
    # 
    # else if (input$ploty == "Day of Arrest" && input$plotx == "Level of Offense")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Day of Arrest", y = ~"Level of Offense") %>% layout(title = "Graph 'Day of Arrest' by 'Level of Offense'")
    # }
    # else if (input$ploty == "Day of Arrest" && input$plotx == "Borough")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Day of Arrest", y = ~"Borough") %>% layout(title = "Graph 'Day of Arrest' by 'Borough'")
    # }
    # else if (input$ploty == "Day of Arrest" && input$plotx == "Precinct")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Day of Arrest", y = ~"Precinct") %>% layout(title = "Graph 'Day of Arrest' by 'Precinct'")
    # }
    # else if (input$ploty == "Day of Arrest" && input$plotx == "Jurisdiction Code")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Day of Arrest", y = ~"Jurisdiction Code") %>% layout(title = "Graph 'Day of Arrest' by 'Jurisdiction Code'")
    # }
    # else if (input$ploty == "Day of Arrest" && input$plotx == "Age Group")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Day of Arrest", y = "Age Group") %>% layout(title = "Graph 'Day of Arrest' by 'Age Group'")
    # }
    # else if (input$ploty == "Day of Arrest" && input$plotx == "Gender")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Day of Arrest", y = ~"Gender") %>% layout(title = "Graph 'Day of Arrest' by 'Gender'")
    # }
    # else if (input$ploty == "Day of Arrest" && input$plotx == "Race")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Day of Arrest", y = ~"Race") %>% layout(title = "Graph 'Day of Arrest' by 'Race'")
    # }
    # 
    # else if (input$ploty == "Level of Offense" && input$plotx == "Borough")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Level of Offense", y = ~"Borough") %>% layout(title = "Graph 'Level of Offense' by 'Borough'")
    # }
    # else if (input$ploty == "Level of Offense" && input$plotx == "Precinct")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Level of Offense", y = ~"Precinct") %>% layout(title = "Graph 'Level of Offense' by 'Precinct'")
    # }
    # else if (input$ploty == "Level of Offense" && input$plotx == "Jurisdiction Code")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Level of Offense", y = ~"Jurisdiction Code") %>% layout(title = "Graph 'Level of Offense' by 'Jurisdiction Code'")
    # }
    # else if (input$ploty == "Level of Offense" && input$plotx == "Age Group")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Level of Offense", y = ~"Age Group") %>% layout(title = "Graph 'Level of Offense' by 'Age Group'")
    # }
    # else if (input$ploty == "Level of Offense" && input$plotx == "Gender")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Level of Offense", y = ~"Gender") %>% layout(title = "Graph 'Level of Offense' by 'Gender'")
    # }
    # else if (input$ploty == "Level of Offense" && input$plotx == "Race")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Level of Offense", y = ~"Race") %>% layout(title = "Graph 'Level of Offense' by 'Race'")
    # }
    # 
    # else if (input$ploty == "Borough" && input$plotx == "Level of Offense")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Borough", y = ~"Level of Offense") %>% layout(title = "Graph 'Borough' by 'Level of Offense'")
    # }
    # else if (input$ploty == "Borough" && input$plotx == "Precinct")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Borough", y = ~"Precinct") %>% layout(title = "Graph 'Borough' by 'Precinct'")
    # }
    # else if (input$ploty == "Borough" && input$plotx == "Jurisdiction Code")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Borough", y = ~"Jurisdiction Code") %>% layout(title = "Graph 'Borough' by 'Jurisdiction Code'")
    # }
    # else if (input$ploty == "Borough" && input$plotx == "Age Group")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Borough", y = ~"Age Group") %>% layout(title = "Graph 'Borough' by 'Age Group'")
    # }
    # else if (input$ploty == "Borough" && input$plotx == "Gender")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Borough", y = ~"Gender") %>% layout(title = "Graph 'Borough' by 'Gender'")
    # }
    # else if (input$ploty == "Borough" && input$plotx == "Race")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Borough", y = ~"Race") %>% layout(title = "Graph 'Borough' by 'Race'")
    # }
    # 
    # else if (input$ploty == "Precinct" && input$plotx == "Level of Offense")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Precinct", y = ~"Level of Offense") %>% layout(title = "Graph 'Precinct' by 'Level of Offense'")
    # }
    # else if (input$ploty == "Precinct" && input$plotx == "Borough")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Precinct", y = ~"Borough") %>% layout(title = "Graph 'Precinct' by 'Borough'")
    # }
    # else if (input$ploty == "Precinct" && input$plotx == "Jurisdiction Code")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Precinct", y = ~"Jurisdiction Code") %>% layout(title = "Graph 'Precinct' by 'Jurisdiction Code'")
    # }
    # else if (input$ploty == "Precinct" && input$plotx == "Age Group")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Precinct", y = ~"Age Group") %>% layout(title = "Graph 'Precinct' by 'Age Group'")
    # }
    # else if (input$ploty == "Precinct" && input$plotx == "Gender")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Precinct", y = ~"Gender") %>% layout(title = "Graph 'Precinct' by 'Gender'")
    # }
    # else if (input$ploty == "Precinct" && input$ploty == "Race")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Precinct", y = ~"Race") %>% layout(title = "Graph 'Precinct' by 'Race'")
    # }
    # 
    # else if (input$ploty == "Jurisdiction Code" && input$plotx == "Level of Offense")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Jurisdiction Code", y = "Level of Offense") %>% layout(title = "Graph 'Jurisdiction Code' by 'Level of Offense'")
    # }
    # else if (input$ploty == "Jurisdiction Code" && input$plotx == "Borough")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Borough") %>% layout(title = "Graph 'Jurisdiction Code' by 'Borough'")
    # }
    # else if (input$ploty == "Jurisdiction Code" && input$plotx == "Precinct")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Jurisdiction Code", y = ~"Precinct") %>% layout(title = "Graph 'Jurisdiction Code' by 'Precinct'")
    # }
    # else if (input$ploty == "Jurisdiction Code" && input$plotx == "Age Group")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Jurisdiction Code", y = ~"Age Group") %>% layout(title = "Graph 'Jurisdiction Code' by 'Age Group'")
    # }
    # else if (input$ploty == "Jurisdiction Code" && input$plotx == "Gender")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Jurisdiction Code", y = ~"Gender") %>% layout(title = "Graph 'Jurisdiction Code' by 'Gender'")
    # }
    # else if (input$ploty == "Jurisdiction Code" && input$plotx == "Race")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Jurisdiction Code", y = ~"Race") %>% layout(title = "Graph 'Jurisdiction Code' by 'Race'")
    # }
    # 
    # else if (input$ploty == "Age Group" && input$plotx == "Level of Offense")
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", model = 'markers', x = ~"Age Group", y = ~"Level of Offense") %>% layout(title = "Graph 'Age Group' by 'Level of Offense'")
    # }

    # else
    # {
    #   plot_ly(data = zipsInBounds(), type = "scatter", mode = 'markers', x = ~"Date of Arrest", y = ~"Level of Offense") %>% layout(title = "Graph 'Date of Arrest' by 'Level of Offense'")
    # }
  })

  #change the longitude based on Zip dynamically
#   longi<-eventReactive(input$zip,{
# 
#   if(length(allzips[allzips$zipcode == input$zip,]$longitude)!=0)
#   {
#     a<-allzips[allzips$zipcode == input$zip,]$longitude
#   }
#   else
#   {
#     #default to Dallas
#     a<--96.76152
#   }
#   
#   return(a)
# })
  

  #change the latitude based on Zip dynamically
  # lati<-eventReactive(input$zip,{
  # 
  # if(length(allzips[allzips$zipcode == input$zip,]$latitude)!=0)
  # {
  #   a<-allzips[allzips$zipcode == input$zip,]$latitude
  # }
  # else
  # {
  #   #Default to Dallas
  #   a<-32.98648
  # }
  # 
  # return(a)
  # })

# To cater to goto zip command
# GoToPlace<-eventReactive(input$zip,{
#   
#   output$default <- renderText({ paste("Go to Zipcode",input$zip) })
#   
#   if(length(allzips[allzips$zipcode == input$zip,]$latitude)!=0) 
#   {
#     a<-cbind(allzips[allzips$zipcode == input$zip,]$city.y,allzips[allzips$zipcode == input$zip,]$zipcode)
#     
#   }
#   else 
#   {
#     a<-cbind("WRONG","ZIPCODE :)")
#   }
#   colnames(a)<- c("City","Zipcode")
#   return(a)
#   
#   
# })

#to identify changes in zoom
# zoom<-eventReactive(input$zoom,{
#   
# output$default <- renderText({ paste("Zoom") })
#   input$zoom
# })

#to identify changes in feature for top N 
# feature<-eventReactive(input$feature,{
#   input$feature
# })

#to fetch data points for top N feature
# points <- eventReactive(c(input$feature,input$top), {
# 
#   if(is.numeric(input$top))
# {
#   if(feature()=='education'){
#   output$default <- renderText({ paste("Top",input$top,"places by Education") })
#   
#   a<-cbind(top_n(allzips,input$top,education)$city.y,top_n(allzips,input$top,education)$zipcode)
#   
#   }
#   else if(feature()=='income'){
#   output$default <- renderText({ paste("Top",input$top,"places by Income") })
#     a<-cbind(top_n(allzips,input$top,education)$city.y,top_n(allzips,input$top,education)$zipcode)
#     
#   }
#   else if (feature() =='population')
#   {
#    output$default <- renderText({ paste("Top",input$top,"places by Population") })
#     a<-cbind(top_n(allzips,input$top,education)$city.y,top_n(allzips,input$top,education)$zipcode)
#    
#   }
# 
#   else {
#   output$default <- renderText({ paste("Try agian, Default :'Top N places by Education'") })
#   a<-cbind(top_n(allzips,input$top,education)$city.y,top_n(allzips,input$top,education)$zipcode)
#    
#   }
#   
# }
#   
#   
#   else{
#     output$default <- renderText({ paste("Try agian, Default :'Top N places by Education'") })
#     a<-cbind(top_n(allzips,input$top,education)$city.y,top_n(allzips,input$top,education)$zipcode)
#     
#   }
#   colnames(a)<- c("City","Zipcode")
#   
#   returnValue(a)
#   
#   }
# )

#to change viewing area based on lat,long and zoom
# observe({
#   mapa<-leafletProxy("map")
#   mapa %>%setView(lat = lati(),lng = longi(),zoom = zoom()) 
#   })


#to change view to for 'go to zipcode ' command
# observe({
#   mapa<-leafletProxy("map")
#   mapa %>%clearMarkers()
#   mapa%>% addMarkers(lat=lati(),lng =longi())
#   GoToPlaceData<- GoToPlace()
#   output$TopN_output <- renderDataTable(GoToPlaceData,
#                                         options = list(
#                                           pageLength = 7,
#                                           iDisplayLength=5,                    # initial number of records
#                                           aLengthMenu=c(5,10),    # records/page options
#                                           bLengthChange=0,        # show/hide records per page dropdown
#                                           bFilter=0,              # global search box on/off
#                                           bInfo=0                # information on/off (how many records filtered, etc)
#                                           #bAutoWidth=0           # automatic column width calculation, disable if passing column width via aoColumnDefs
#                                         )) 
#   })


# to render 'top N values'
# observe({
#  
# a<- points()
# output$TopN_output <- renderDataTable(a,
# options = list(
#   
#               # pageLength = 7,
#                iDisplayLength=5,                    # initial number of records
#                aLengthMenu=c(5,10),    # records/page options
#                bLengthChange=0,        # show/hide records per page dropdown
#                bFilter=0,              # global search box on/off
#                bInfo=0,                # information on/off (how many records filtered, etc)
#                bAutoWidth=0           # automatic column width calculation, disable if passing column width via aoColumnDefs
# ))
# 
# 
# 
# })




#This observer is responsible for maintaining the circles and legend,
# according to the variables the user has chosen to map to color and size.

# observe({
#   
#   if( color()=='education')
#   {
#     colorBy<-'education'
#    
#     
#   }
#   else if ( color()=='population')
#   {
#     
#     
#     colorBy<-'population'
#   }  
#   else if(color()=='population') 
#   {
#   
#     colorBy<-'income'
#   }
#   
#   else 
#   {
#     output$default <- renderText({ paste("Try Again,Default: 'Color by income'")})
#     colorBy<-'income'
#     
#   }
#   
#   
#   if(size()=='education')
#   {
#     
#     sizeBy<-'education'
#   }
#   else if (size()=='population')
#   {
#    
#     sizeBy<-'population'
#   }  
#   else if(size()=='income')
#   {
#     
#     sizeBy<-'income'
#   }
#   else
#   {
#     output$default <- renderText({ paste("Try Again,Default: 'Size by income'",input$size) })
#     sizeBy<-'income'
#   }
#   
#     output$color1 <- renderText({ input$color })
#     output$size1 <- renderText({ input$size })
#  
#     colorData <- zipdata[[colorBy]]
#     pal <- colorBin("Spectral", colorData, 7, pretty = FALSE)
#   
# 
#  
#     radius <- zipdata[[sizeBy]] / max(zipdata[[sizeBy]]) * 30000
#  
#   
# 
#   leafletProxy("map", data = zipdata) %>%
#     clearShapes() %>%
#     addCircles(~longitude, ~latitude, radius=radius, layerId=~zipcode,
#       stroke=FALSE, fillOpacity=0.4, fillColor=pal(colorData)) %>%
#     addLegend("bottomleft", pal=pal, values=colorData, title=colorBy,
#       layerId="colorLegend")
# })

  # When map is clicked, show a popup with city info
  
#   observe({
#     leafletProxy("map") %>% clearPopups()
#     event <- input$map_shape_click
#     if (is.null(event))
#       return()
# 
#     isolate({
#       displayLocation(event$id, event$lat, event$lng)
#     })
#   })
# 
# 
#   ## Data Explorer  tab to display data##
# 
#   observe({
#     cities <- if (is.null(input$states)) character(0) else {
#       filter(cleantable, State %in% input$states) %>%
#         `$`('City') %>%
#         unique() %>%
#         sort()
#     }
#     stillSelected <- isolate(input$cities[input$cities %in% cities])
#     updateSelectInput(session, "cities", choices = cities,
#       selected = stillSelected)
#   })
# 
#   observe({
#     zipcodes <- if (is.null(input$states)) character(0) else {
#       cleantable %>%
#         filter(State %in% input$states,
#           is.null(input$cities) | City %in% input$cities) %>%
#         `$`('Zipcode') %>%
#         unique() %>%
#         sort()
#     }
#     stillSelected <- isolate(input$zipcodes[input$zipcodes %in% zipcodes])
#     updateSelectInput(session, "zipcodes", choices = zipcodes,
#       selected = stillSelected)
#   })
# 
#   observe({
#     if (is.null(input$goto))
#       return()
#     isolate({
#       map <- leafletProxy("map")
#       map %>% clearPopups()
#       dist <- 0.5
#       zip <- input$goto$zip
#       lat <- input$goto$lat
#       lng <- input$goto$lng
#       displayLocation(zip, lat, lng)
#       map %>% fitBounds(lng - dist, lat - dist, lng + dist, lat + dist)
#     })
#   })
# 
#   output$ziptable <- DT::renderDataTable({
#     df <- cleantable %>%
#       filter(
#         Score >= input$minScore,
#         Score <= input$maxScore,
#         is.null(input$states) | State %in% input$states,
#         is.null(input$cities) | City %in% input$cities,
#         is.null(input$zipcodes) | Zipcode %in% input$zipcodes
#       ) %>%
#       mutate(Action = paste('<a class="go-map" href="" data-lat="', Lat, '" data-long="', Long, '" data-zip="', Zipcode, '"><i class="fa fa-crosshairs"></i></a>', sep=""))
#     action <- DT::dataTableAjax(session, df)
# 
#     DT::datatable(df, options = list(ajax = list(url = action)), escape = FALSE)
#   })
}