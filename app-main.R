
ui <- navbarPage("",
                 
                 tags$head(
                   tags$style(HTML("
      @import url('https://fonts.googleapis.com/css?family=Quicksand:300,400,500,600,700&display=swap');
      
      h1 {
        font-family: 'Quicksand', sans-serif;
        font-size: 60px;
        line-height: 40px;
        color: #1C24FF;
      }
      
      h2 {
        font-family: 'Quicksand', sans-serif;
        font-size: 40px;
        line-height: 40px;
        color: #1C24FF;
      }
      
      h3 {
        font-family: 'Quicksand', sans-serif;
        font-size: 20px;
        line-height: 40px;
        color: #1C24FF;
      }
      
      p {
        font-family: 'Quicksand', sans-serif;
        color: #336380;
      }

    "))
                 ),
                 
                 h1("virtulis"),
                 
                 # sidebarPanel(
                 #   sliderInput("obs", "Number of Trials:", min = 1, max = 1000, value = 500)
                 # ),
                 
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
                              br(),
                              
                              img(src='https://github.com/MCTTAN/virtulis/blob/master/media/police-1.jpg?raw=true',
                                  height = "50%",
                                  width = "50%",
                                  align = "center"),
                              
                              
                              
                              
                              br(),
                              br(),
                              br(),
                              
                              h1("Bio"),
                              
                              br(),
                  
                              p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
                              
                              h1("Skills"),
                              
                              
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