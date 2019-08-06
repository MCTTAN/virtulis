library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  
  skin = "black",
  
  dashboardHeader(title = "virtulis"),

  
  dashboardSidebar(
    sidebarMenu(
      menuItem("First", tabName = "first", icon = icon("dashboard")),
      menuItem("Second", tabName = "second", icon = icon("th"))
    )
  ),
  
  dashboardBody(
    
    tabItems(
      tabItem(tabName = "first",
              h2("First tab content")
              ),
      
      tabItem(tabName = "second",
              h2("Second tab content")
              )
    ),
    
    fluidRow(
      h2("This text is in a row, without a column")
    ),
    
    fluidRow(
      column(width = 12,
             h2("This text is in a column in a row")
      )
    )
  )
)

server <- function(input, output) {}

shinyApp(ui, server)