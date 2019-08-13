# Suppose you have an existing web page and would like to integrate the output of
# a googleVis function, such as gvisMotionChart. In this case you only need the
# chart output from gvisMotionChart. So you can either copy and paste the output
# from the R console

# R> print(M, 'chart') ## or cat(M$html$chart)

# into your existing html page, or write the content directly into a file

# R> print(M, 'chart', file='myfilename')
# and process it from there.