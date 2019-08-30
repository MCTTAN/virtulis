library(dplyr)
library(scales)
library(tweenr)
library(animation)
library(dplyr)
library(ggplot2)
library(ggthemes)
# an example of a time series data frame
plot_data <- data.frame(Date =seq(as.Date("2010/1/1"), as.Date("2019/1/1"), "years"), Value=runif(10,0,1000)) 
# prepare  data for tween by creating columns for the time between points
df.all<-plot_data %>% 
  mutate(day=as.numeric(Date-min(Date)+1),ease="linear")
# add rows to fill in the gaps
plot_data_tween<-tween_elements(df.all, time = "day",  group="ease", ease="ease", nframes = nrow(df.all)*20)
df_tween_appear <- tween_appear(plot_data_tween, time='day', nframes = nrow(df.all)*10)

make_plot <- function(i){
  plot_data <-  df_tween_appear %>% filter(.frame==i, .age> -3.5) 
  p<- plot_data %>%
    ggplot()+
    geom_line(aes(x=Date, y=Value),color="darkgray", size=0.7)+
    geom_point(data=. %>% 
                 filter(Date==max(Date)),
               mapping=aes(x=Date, y=Value),
               size=3,color="pink",stroke=4)+
    geom_point(data=. %>% 
                 filter(Date==max(Date)),
               mapping=aes(x=Date, y=Value), color="white", size=2)+
    geom_text(data=. %>% filter(Date==max(Date)),
              mapping=aes(x=Date,
                          y=Value,label=round(Value,0)),
              color="black",
              nudge_x=7,hjust=1.5, size=6)+
    geom_line(data=df.all, aes(x=Date,y=Value),alpha=0.1)+
    theme_minimal(base_family = "sans")+
    scale_y_continuous(sec.axis=dup_axis())+
    theme(plot.subtitle=element_text(face="italic",size=14),
          plot.title=element_text(color="darkcyan",size=19),
          plot.caption=element_text(hjust=0),
          panel.grid.major.x = element_line(color="lightgray"),
          panel.grid.minor.x = element_line(color="lightgray"),
          panel.grid.major.y = element_line(color="lightgray"),
          panel.grid.minor.y = element_line(color="lightgray"),
          axis.text.x = element_text(angle = 90, hjust = 1, size=12))+
    labs(x="",y="Total Value",
         caption="All values- 2010-2019.")+
    ggtitle(("Yearly Trends of Values"))
  return(p)
}

ani_settings<-ani.options(interval=1/10)  # Number to set the time interval of the animation (unit in seconds); adjust for speed of ani
saveGIF({for (i in 1:max(df_tween_appear$.frame)){
  g<-make_plot(i)
  print(g)
  print(paste(i,"out of",max(df_tween_appear$.frame)))
  ani.pause() # adds a pause the end of animation
}
},movie.name="gifs/yearlytrends.gif",ani.width = 500, ani.height = 350)