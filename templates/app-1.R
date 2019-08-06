library(shiny)

ui <- basicPage(
  sliderInput("n", "Number of points:", min = 10, max = 500, value = 100), plotOutput("distPlot")
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    plot(rnorm(input$n), rnorm(input$n))
  })
}

shinyApp(ui, server)