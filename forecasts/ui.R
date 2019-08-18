if(!require(leaflet)){
  install.packages("leaflet")
  library(leaflet)
}
library(leaflet)


navbarPage(

  title = div(img(src="dsx1.png"),"IBM"), 

  tabPanel(
    div(class="outer",

      tags$head(
        # Include our custom CSS
        includeCSS("styles.css"),
        includeScript("gomap.js")
      ),

      leafletOutput("map", width="100%", height="100%"),

      absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
        draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
        width = 330, height = "auto", 

        h2("Choose date & time"),

        sliderInput("month", "Month", min = 1, max = 12, value = 1),
        sliderInput("day", "Day", min = 1, max = 28, value = 20),
        sliderInput("time", "Time", min = 7, max = 23, value = 17)
        
      ),

      tags$div(id="cite",'Please send your questions to Jorge Castañón: jorgecasta@us.ibm.com',fontsize=20)
      
    )
  )
)
