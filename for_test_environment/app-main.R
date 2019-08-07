ui <- fluidPage(
  
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
      
      h4 {
        font-family: 'Quicksand', sans-serif;
        font-size: 10px;
        line-height: 40px;
        color: #1C24FF;
      }
      
      p {
        font-family: 'Quicksand', sans-serif;
        color: #336380;
      }
                    "))
  ),
  
  shiny::singleton(
    shiny::tags$head(
      tags$link(rel = "stylesheet", href = "styles.css"),
      tags$link(rel = "stylesheet", href = "snackbar.css"),
      tags$script(src="snackbar.js"),
      tags$script(src="https://www.gstatic.com/firebasejs/6.3.4/firebase-app.js"),
      tags$script(src="https://www.gstatic.com/firebasejs/6.3.4/firebase-auth.js"),
      shiny::tags$script(src="sof-auth.js")
    )
  ),
  
  # load shinyjs on
  shinyjs::useShinyjs(),
  
  source("sof-auth/dataviz.R", local = TRUE)$value,
  source("sof-auth/department.R", local = TRUE)$value,
  source("sof-auth/messages.R", local = TRUE)$value,
  source("sof-auth/profile.R", local = TRUE)$value,
  source("sof-auth/tasks_and_events.R", local = TRUE)$value,
  
  source("ui/main.R", local = TRUE)$value
)

server <- function(input, output, session) {
  
  output$out1 <- renderPrint(input$in1)
  output$out2 <- renderPrint(input$in2)
  output$out3 <- renderPrint(input$in3)
  output$out4 <- renderPrint(input$in4)
  output$out5 <- renderPrint(input$in5)
  output$out6 <- renderPrint(input$in6)
  
  ##### Switch Views ------------------
  
  observeEvent(input$go_to_profile, {
    shinyjs::show("profile_tab", anim = TRUE, animType = "fade")
    shinyjs::hide("department_tab")
    shinyjs::hide("dataviz_tab")
    shinyjs::hide("tasks_and_events_tab")
    shinyjs::hide("messages_tab")
  }, ignoreInit = TRUE)
  
  observeEvent(input$go_to_department, {
    shinyjs::hide("profile_tab")
    shinyjs::show("department_tab", anim = TRUE, animType = "fade")
    shinyjs::hide("dataviz_tab")
    shinyjs::hide("tasks_and_events_tab")
    shinyjs::hide("messages_tab")
  }, ignoreInit = TRUE)
  
  observeEvent(input$go_to_dataviz, {
    shinyjs::hide("profile_tab")
    shinyjs::hide("department_tab")
    shinyjs::show("dataviz_tab", anim = TRUE, animType = "fade")
    shinyjs::hide("tasks_and_events_tab")
    shinyjs::hide("messages_tab")
  }, ignoreInit = TRUE)
  
  observeEvent(input$go_to_tasks_and_events, {
    shinyjs::hide("profile_tab")
    shinyjs::hide("department_tab")
    shinyjs::hide("dataviz_tab")
    shinyjs::show("tasks_and_events_tab", anim = TRUE, animType = "fade")
    shinyjs::hide("messages_tab")
  }, ignoreInit = TRUE)
  
  observeEvent(input$go_to_messages, {
    shinyjs::hide("profile_tab")
    shinyjs::hide("department_tab")
    shinyjs::hide("dataviz_tab")
    shinyjs::hide("tasks_and_events_tab")
    shinyjs::show("messages_tab", anim = TRUE, animType = "fade")
  }, ignoreInit = TRUE)
  
  # switch between auth sign in/registration and app for signed in user
  observeEvent(session$userData$current_user(), {
    current_user <- session$userData$current_user()
    
    if (is.null(current_user)) {
      shinyjs::show("profile_tab")
      shinyjs::hide("department_tab")
      shinyjs::hide("dataviz_tab")
      shinyjs::hide("tasks_and_events_tab")
      shinyjs::hide("messages_tab")
    } else {
      shinyjs::hide("profile_tab")
      shinyjs::hide("department_tab")
      shinyjs::hide("dataviz_tab")
      shinyjs::hide("tasks_and_events_tab")
      shinyjs::hide("messages_tab")
    }
    
  }, ignoreNULL = FALSE)
  
  
  
  
  # Signed in user --------------------
  # the `session$userData$current_user()` reactiveVal will hold information about the user
  # that has signed in through Firebase.  A value of NULL will be used if the user is not
  # signed in
  session$userData$current_user <- reactiveVal(NULL)
  
  # input$sof_auth_user comes from front end js in "www/sof-auth.js"
  observeEvent(input$sof_auth_user, {
    
    # set the signed in user
    session$userData$current_user(input$sof_auth_user)
    
  }, ignoreNULL = FALSE)
  
}

shinyApp(ui, server)
