ui <- fluidPage(
  shiny::singleton(
    shiny::tags$head(
      tags$link(rel = "stylesheet", href = "styles.css"),
      tags$link(rel = "stylesheet", href = "snackbar.css"),
      tags$script(src="snackbar.js"),
      tags$script(src="https://www.gstatic.com/firebasejs/5.7.0/firebase-app.js"),
      tags$script(src="https://www.gstatic.com/firebasejs/5.7.0/firebase-auth.js"),
      shiny::tags$script(src="sof-auth.js")
    )
  ),
  
  # load shinyjs on
  shinyjs::useShinyjs(),
  
  source("sof-auth/sign-in.R", local = TRUE)$value,
  source("sof-auth/register.R", local = TRUE)$value,
  source("sof-auth/verify-email.R", local = TRUE)$value,
  
  source("ui/main.R", local = TRUE)$value
)

server <- function(input, output, session) {
  
  ##### Switch Views ------------------
  # if user click link to register, go to register view
  observeEvent(input$go_to_register, {
    shinyjs::show("register_panel", anim = TRUE, animType = "fade")
    shinyjs::hide("sign_in_panel")
  }, ignoreInit = TRUE)
  
  observeEvent(input$go_to_sign_in, {
    shinyjs::hide("register_panel")
    shinyjs::show("sign_in_panel", anim = TRUE, animType = "fade")
  }, ignoreInit = TRUE)
  
  # switch between auth sign in/registration and app for signed in user
  observeEvent(session$userData$current_user(), {
    current_user <- session$userData$current_user()
    
    if (is.null(current_user)) {
      shinyjs::show("sign_in_panel")
      shinyjs::hide("main")
      shinyjs::hide("verify_email_view")
    } else {
      shinyjs::hide("sign_in_panel")
      shinyjs::hide("register_panel")
      
      if (current_user$emailVerified == TRUE) {
        shinyjs::show("main")
      } else {
        shinyjs::show("verify_email_view")
      }
      
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
  
  
  
  ##### App for signed in user
  signed_in_user_df <- reactive({
    req(session$userData$current_user())
    
    out <- session$userData$current_user()
    out <- unlist(out)
    
    data.frame(
      name = names(out),
      value = unname(out)
    )
  })
  
  
  output$user_out <- DT::renderDT({
    datatable(
      signed_in_user_df(),
      rownames = FALSE,
      options = list(
        dom = "tp",
        scrollX = TRUE
      )
    )
  })
  
}

shinyApp(ui, server)
