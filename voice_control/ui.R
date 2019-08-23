library(leaflet)
library(plotly)


characteristics <- c(
  # "age" = "Age"
  "education" = "education",
  "income" = "income",
  "Population" = "population"
)


navbarPage("virtulis", id = "nav",
           
           
           tabPanel("Map",
                    div(class = "outer",
                        
                        tags$head(
                          tags$link(rel = "stylesheet", type = "text/css", href = "https://fonts.googleapis.com/css?family=Poppins:200,300,400,600,700,800"),
                          includeCSS("styles.css"),
                          includeScript("gomap.js")
                        ),
                       
                        singleton(tags$head(
                          tags$script(src = "//cdnjs.cloudflare.com/ajax/libs/annyang/1.4.0/annyang.min.js"),
                          includeScript('init.js')
                        )),
                        
                        h5("Try these voice commands: 'Top 10 places by income','Go to zip code 21117','Zoom in','Color by population','Size by income' , 'Graph population by income'"),
                        
                        leafletOutput("map", width = "100%", height = "100%"),
                        
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = 100, left =20 , right = "auto", bottom = "auto",
                                      width = 400, height = "auto",
                                      
                                      # h5('Listening...'),verbatimTextOutput("default"),
                                      h5(''), verbatimTextOutput("default"),
                                      dataTableOutput("TopN_output")
                        ),
                        
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = 100, left = "auto", right = 20, bottom = "auto",
                                      width = 400, height = "auto",
                                      #tags$a(href="https://www.linkedin.com/in/abhishekmshivalingaiah", "LinkedIn    "),
                                      tags$a(href="https://www.mcttan.github.io/virtulis/pages/history.html", "GitHub    "),
                                      
                                      h6("Color By"),verbatimTextOutput("color1"),
                                      h6("Size By"),verbatimTextOutput("size1"),
                                      plotlyOutput("scatterPlot")
                        )
                        
                        # tags$div(id="cite",
                        #          'Sources: ', tags$em('NYC Open Source'), ' NYPD'
                        # )
                        
                    )
           ),
           
           tabPanel("Tabular Data",
                    fluidRow(
                      column(3,
                             selectInput("states", "States", c("All states"="", structure(state.abb, names=state.name), "Washington, DC"="DC"), multiple=TRUE)
                      ),
                      column(3,
                             conditionalPanel("input.states",
                                              selectInput("cities", "Cities", c("All cities"=""), multiple=TRUE)
                             )
                      ),
                      column(3,
                             conditionalPanel("input.states",
                                              selectInput("zipcodes", "Zipcodes", c("All zipcodes"=""), multiple=TRUE)
                             )
                      )
                    ),
                    fluidRow(
                      column(1,
                             numericInput("minScore", "Min score", min=0, max=100, value=0)
                      ),
                      column(1,
                             numericInput("maxScore", "Max score", min=0, max=100, value=100)
                      )
                    ),
                    hr(),
                    DT::dataTableOutput("ziptable")
           ),
           
           # conditionalPanel("false", icon("heartbeat"))
           conditionalPanel("false", icon("crosshair"))
)