fluidPage(
  shiny::singleton(
    shiny::tags$head(
      tags$link(rel = "stylesheet", href = "style.css"),
      tags$link(rel = "stylesheet", href = "snackbar.css"),
      tags$script(src="snackbar.js"),
      tags$script(src="https://www.gstatic.com/firebasejs/5.7.0/firebase-app.js"),
      tags$script(src="https://www.gstatic.com/firebasejs/5.7.0/firebase-auth.js"),
      shiny::tags$script(src="sof-auth.js")
    )
  ),
  
  # load shinyjs on
  shinyjs::useShinyjs(),
  
  source("sign-in.R", local = TRUE)$value,
  source("register.R", local = TRUE)$value,
  source("verify-email.R", local = TRUE)$value,
  
  source("main.R", local = TRUE)$value
)
