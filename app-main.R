
ui <- navbarPage("",
                 
                 tags$head(
                   tags$style(HTML("
      @import url('https://fonts.googleapis.com/css?family=Quicksand:300,400,500,600,700&display=swap');
      
      h1 {
        font-family: 'Quicksand', sans-serif;
        color: #1C24FF;
      }

    "))
                 ),
                 
                 h1("virtulis"),
                 
                 sidebarPanel(
                   sliderInput("obs", "Number of Trials:", min = 1, max = 1000, value = 500)
                 ),
                 
                 position = "fixed-bottom",
                 tabPanel("profile",
                          sidebarLayout(
                            sidebarPanel(
                              radioButtons("plotType", "Plot type",
                                           c("Scatter"="p", "Line"="l")
                              )
                            ),
                            mainPanel(
                              br(),
                              br(),
                              br(),
                              h1("This is h1"),
                              h2("This is h2"),
                              h3("This is h3"),
                              p("This is p1")
                            )
                          ),
                          icon = icon("")
                 ),
                 tabPanel("community",
                          verbatimTextOutput("summary")
                 ),
                 navbarMenu("events",
                            tabPanel("all",
                                     DT::dataTableOutput("table")
                            ),
                            tabPanel("upcoming",
                                     fluidRow(
                                       column(3,
                                              img(class="img-polaroid",
                                                  src=paste0("http://upload.wikimedia.org/",
                                                             "wikipedia/commons/9/92/",
                                                             "1919_Ford_Model_T_Highboy_Coupe.jpg")),
                                              tags$small(
                                                "Source: Photographed at the Bay State Antique ",
                                                "Automobile Club's July 10, 2005 show at the ",
                                                "Endicott Estate in Dedham, MA by ",
                                                a(href="http://commons.wikimedia.org/wiki/User:Sfoskett",
                                                  "User:Sfoskett")
                                              )
                                       )
                                     )
                            )
                 )
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    plot(cars, type=input$plotType)
  })
  
  output$summary <- renderPrint({
    summary(cars)
  })
  
  output$table <- DT::renderDataTable({
    DT::datatable(cars)
  })
}

shinyApp(ui, server)