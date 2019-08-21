library(shiny)
ui = fluidPage(
  singleton(
    tags$head(
      tags$script(src = "//cdnjs.cloudflare.com/ajax/libs/annyang/2.6.0/annyang.min.js"),
      includeScript("voice.js")
    )
  )
)
server = function(input, output, session) {}
shinyApp(ui, server)