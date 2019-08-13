
Embedding googleVis in web sites dynamically



In this section, we provide examples how the googleVis functions can be embedded
into web pages dynamically.
The R packages R.rsp [Ben12] and brew [Hor11a] are two options to integrate
R snippets into HTML code. While the R.rsp package comes with its own internal
web server, brew requires the Apache HTTP server [Fou10a] with the RApache
[Hor11b] module installed. Please note that currently the RApache module only
runs on UNIX/Linux and Mac OS X.
Since version 2.11.0 R ships with its own internal web server and with Rook [Hor13]
and shiny [RI13] there are also two alternatives that use this facility. Both packages allow users to deploy web application locally with very little overhead. The
shiny framework is the newest and certainly easiest option to get started with web
apps using R and googleVis .




Using googleVis with R.rsp





The R.rsp package allows the user to integrate R code into html code. The R
code is parsed by the R.rsp web server and executed at run time.
As an example, we embed a motion chart into a rsp-page:
  <html>
  <body>
  <% library(googleVis)
M <- gvisMotionChart(Fruits, idvar="Fruit", timevar="Year") %>
  <%= M$html$chart %>
  </body>
  </html>
  The R code included in <%. . .%> is executed when read by the R.rsp HTTP server,
but no R output will be displayed. To embed the R output into the html code we
have to add an equal sign, <%=. . .%>, which acts as a cat statement.