
function(input, output, session) {
  
  # If the user clicks on the Register link, then go to the Register page
  
  observeEvent(input$go_to_register, {
    shinyjs::show("register_panel", anim = TRUE, animType = "fade")
    shinyjd::hide("sign_in_panel")
  }, ignoreInit = TRUE)
  
  observeEvent(input$go_to_sign_in, {
    shinyjs::hide("register_panel")
    shinyjs::show("sign_in_panel", anim = TRUE, animType = "fade")
  }, ignoreInit = TRUE)
  
  # Switch between auth sign in / registration and app for signed-in user
  
  observeEvent(session$userData$current_user(), {
    current_user <- session$userData$current_user()
    
    if(is.null(current_user)) {
      shinyjs::show("sign_in_panel")
      shinyjs::hide("main")
      shinyjs::hide("verify_email_view")
    } else {
      shinyjs::hide("sign_in_panel")
      shinyjs::hide("register_panel")
      
      if(current_user$emailVerified == TRUE) {
        shinyjs::show("main")
      } else {
        shinyjs::show("verify_email_view")
      }
    }
  }, ignoreNULL = FALSE)
  
  # Hold information about the user that signed in through Firebase.
  # A value of NULL will be used if the user is not signed in.
  
  session$userData$current_user <- reactiveVal(NULL)
  
  observeEvent(input$sof_auth_user, {
    session$userData$current_user(input$sof_auth_user)
  }, ignoreNULL = FALSE)
  
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