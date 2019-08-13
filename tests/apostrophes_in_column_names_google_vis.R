# The googleVis package converts data frames into JSON objects. The column
# names of the resulting JSON tables are encapsulated with single speech marks, see
# lines 12 – 16 of the code example on page 5.
# Hence apostrophes in column names of your input data frame have to be encapsulated by a double backslash.
# Here is a little example, see the output in Figure 8.
# R> df <- data.frame("Year"=c(2009,2010), "Lloyd\\'s"=c(86.1, 93.3),
#                     + "Munich Re\\'s R/I"=c(95.3, 100.5),
#                     + check.names=FALSE)
# R> df
# 
# Year Lloyd\\'s Munich Re\\'s R/I
# 1 2009 86.1 95.3
# 2 2010 93.3 100.5
# R> CR <- gvisColumnChart(df, options=list(vAxis='{baseline:0}',
#                                           + title="Combined Ratio %",
#                                           + legend="{position:'bottom'}"))
# R> plot(CR)