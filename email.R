
library(mailR)
library(rJava)

sender <- "mtan1@umbc.edu"
recipient <- "mariechantaltan@gmail.com"
send.mail(from = sender,
          to = recipient,
          subject = "testing",
          body = "testing",
          authenticate = TRUE,
          send = TRUE,
          debug = TRUE,
          smtp = list(host.name = "smtp.gmail.com",
                      port = 587,
                      user.name = "mtan1@umbc.edu",
                      passwd = "Hunting247!",
                      tls = TRUE),
          # attach.files = c("/cloud/project/Resume.pdf"),
          # file.names = c("resume.pdf")
          # file.descriptions = c("")
)