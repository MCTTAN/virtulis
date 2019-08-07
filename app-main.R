
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
                              
                              h2("Partners"),
                              
                              textInput("text", label = h3("Text input"), value = "Enter text..."),
                              
                              hr(),
                              fluidRow(column(3, verbatimTextOutput("value"))),
                              
                              h2("Bio"),
                              
                              br(),
                  
                              p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
                              
                              br(),
                              br(),
                              br(),
                              
                              h2("Skills"),
                              
                              br(),
                              
                              textInput("text", label = h3("Text input"), value = "Enter text..."),
                              
                              hr(),
                              fluidRow(column(3, verbatimTextOutput("value"))),
                              
                              br(),
                              br(),
                              br(),
                              
                              h2("Skills Visualization"),
                              br(),
                              p("(can switch between yours and your team's)"),
                              
                              br(),
                              br(),
                              br(),
                              br(),
                              br()
                              
                              
                            )
                          )
                 ),
                 
                 tabPanel("bulletin board",
                          mainPanel()
                          # verbatimTextOutput("summary")
                 ),
                 
                 tabPanel("crime & community data",
                          mainPanel(
                          textInput("text", label = h3("Text input"), value = "Enter text..."),
                          
                          hr(),
                          fluidRow(column(3, verbatimTextOutput("value")))
                            
                          )
                 ),
                 
                 tabPanel("messages",
                          mainPanel()
                 ),
                 
                 #navbarMenu("")
                 
                 tabPanel("events",
                            mainPanel()
                            # tabPanel("all",
                            #          DT::dataTableOutput("table")
                            # ),
                            # tabPanel("upcoming",
                            #          fluidRow(
                            #            column(3,
                            #                   img(class="img-polaroid",
                            #                       src=paste0("http://upload.wikimedia.org/",
                            #                                  "wikipedia/commons/9/92/",
                            #                                  "1919_Ford_Model_T_Highboy_Coupe.jpg")),
                            #                   tags$small(
                            #                     "Source: Photographed at the Bay State Antique ",
                            #                     "Automobile Club's July 10, 2005 show at the ",
                            #                     "Endicott Estate in Dedham, MA by ",
                            #                     a(href="http://commons.wikimedia.org/wiki/User:Sfoskett",
                            #                       "User:Sfoskett")
                            #                   )
                            #            )
                            #          )
                            # )
                 )
)

server <- function(input, output, session) {
  
  output$value <- renderPrint({ input$text })
  
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