#####################################################################################
## Step 1: Load Libraries ##
#####################################################################################
library(tidyverse)
library(tidyquant)
library(geofacet)
library(viridis)
library(scales)
library(tweenr)
library(animation)
library(dplyr)

#####################################################################################
## Step 2: go get data ##
## FHFA's ALL-Transactions House Price Index for US and states (NSA) **
#####################################################################################
df <- tq_get(c("USSTHPI",paste0(us_state_grid3$code,      # get state abbreviations
                                "STHPI")),                    # append STHPI
             get="economic.data",             # use FRED
             from="2000-01-01")               # go from 1990 forward

df %>% mutate(state=substr(symbol,1,2)        # create a state variable
) -> df


df %>% group_by(state) %>% 
  mutate(hpi=100*price/price[date=="2000-01-01"]) %>% # rebenchmark index to 100 in Q1 2000
  ungroup() %>% 
  map_if(is.character,as.factor) %>%   # tweenr will try to interpolate characters, but will ignore factors
  as.tibble() -> df
knitr::kable(head(df))

dplyr::filter(df,state=="CA") %>% 
  ggplot(aes(x=date, y=hpi))+
  geom_line(data=df, aes(group=state),color="lightgray",alpha=0.5)+
  geom_line(size=1.1,color="royalblue") + 
  geom_line(data=dplyr::filter(df,state=="US"),color="black",linetype=2, alpha=0.85)+
  geom_text(data=dplyr::filter(df,state=="US" & date==max(df$date)), aes(label=state), nudge_y=0.01,fontface="bold",color="black",label="US")+
  geom_text(data=df %>% filter(state=="CA" & date==max(df$date)), aes(label=state), nudge_y=0.01,fontface="bold",color="royalblue")+
  # set axis labels
  scale_y_log10(breaks=c(100,150,200,250,300),limits=c(85,300),sec.axis=dup_axis())+
  labs(x="",y="House Price Index (2000 Q1=100, log scale NSA)",
       title="House price trends by state",
       subtitle=paste("Each gray line a state, highlighted state CA"),
       caption="@lenkiefer Source: U.S. Federal Housing Finance Agency, All-Transactions House Price Index for the United States [USSTHPI],\nretrieved from FRED, Federal Reserve Bank of St. Louis; https://fred.stlouisfed.org/series/USSTHPI, March 18, 2018.")+
  theme(plot.subtitle=element_text(face="italic",size=14),
        plot.title=element_text(color="royalblue",face="bold",size=18),
        plot.caption=element_text(hjust=0))


# tween states
# use keep_state to pause the animation for 10/15 frames

data <- dplyr::filter(df, state=="US") %>%
  keep_state(10) %>%
  tween_state(dplyr::filter(df, state=="CA"), 'linear', 10) %>%
  keep_state(15) %>%
  tween_state(dplyr::filter(df, state=="TX"), 'linear', 10) %>%
  keep_state(15) %>%
  tween_state(dplyr::filter(df, state=="FL"), 'linear', 10) %>%
  keep_state(15) %>%
  tween_state(dplyr::filter(df, state=="NY"), 'linear', 10) %>%
  keep_state(15) %>%
  tween_state(dplyr::filter(df, state=="OH"), 'linear', 10) %>%
  keep_state(15) %>%
  tween_state(filter(df, state=="US"), 'linear',10) %>%
  keep_state(10)

oopt = ani.options(interval = 1/10)
saveGIF({for (i in 1:max(data$.frame)) {
  df.plot<-dplyr::filter(data,.frame==i)
  p<-df.plot %>% 
    ggplot(aes(x=date, y=hpi))+
    geom_line(data=df, aes(group=state),color="lightgray",alpha=0.5)+
    geom_line(size=1.1,color="royalblue") + 
    geom_line(data=dplyr::filter(df,state=="US"),color="black",linetype=2, alpha=0.85)+
    geom_text(data=dplyr::filter(df,state=="US" & date==max(df.plot$date)), aes(label=state), nudge_y=0.01,fontface="bold",color="black",label="US")+
    geom_text(data=df.plot %>% filter(date==max(df.plot$date)), aes(label=state), nudge_y=0.01,fontface="bold",color="royalblue")+
    # set axis labels
    scale_y_log10(breaks=c(100,150,200,250,300),limits=c(85,300),sec.axis=dup_axis())+
    labs(x="",y="House Price Index (2000 Q1=100, log scale NSA)",
         title="House price trends by state",
         subtitle=paste("Each gray line a state, highlighted state",head(df.plot,1)$state),
         caption="@lenkiefer Source: U.S. Federal Housing Finance Agency, All-Transactions House Price Index for the United States [USSTHPI],\nretrieved from FRED, Federal Reserve Bank of St. Louis; https://fred.stlouisfed.org/series/USSTHPI, March 18, 2018.")+
    theme(plot.subtitle=element_text(face="italic",size=14),
          plot.title=element_text(color="royalblue",face="bold",size=18),
          plot.caption=element_text(hjust=0))
  print(p)
  
  print(paste0(i, " out of ",max(data$.frame)))
  
  ani.pause()}
},movie.name="C:/Users/14438/Documents/virtulis/txHousing.gif",ani.width = 700, ani.height = 540) #replace YOURDIRECTORY with a place where you want to save the gif

anim_save("C:/Users/14438/Documents/virtulis/txHousing.gif", df.plot)






# modified from: https://www.kaggle.com/dmi3kno/leaderboard-shakeup-storyline-chart/code
df.us<-dplyr::filter(df,state=="US") %>%  select(date,hpi) %>% 
  mutate(day=as.numeric(date-min(date)+1),ease="linear")

plot_data_tween<-tween_elements(df.us, time = "day",  group="ease", ease="ease", nframes = nrow(df.us)*5)
df_tween_appear <- tween_appear(plot_data_tween, time='day', nframes = nrow(df.us)*5)

# add pause at end of animation
df_tween_appear<- df_tween_appear %>% keep_state(20)

make_plot_appear <- function(i){
  plot_data <- 
    df_tween_appear %>% filter(.frame==i, .age> -3.5) 
  p<- plot_data %>% 
    ggplot()+
    geom_line(aes(x=date, y=hpi),color="royalblue", size=1.3)+
    geom_point(data=. %>% filter(date==max(date)), mapping=aes(x=date, y=hpi), size=3,color="red",stroke=1.5)+
    geom_point(data=. %>% filter(date==max(date)), mapping=aes(x=date, y=hpi), color="white", size=2)+
    geom_text(data=. %>% filter(date==max(date)), mapping=aes(x=date, y=hpi,label=round(hpi,0)),color="red",nudge_x=7,hjust=-0.4,fontface="bold")+
    geom_line(data=df.us, aes(x=date,y=hpi),alpha=0.1)+
    theme_minimal(base_family = "sans")+
    scale_x_date(limits = c(as.Date("2000-01-01"),as.Date("2018-04-30")),
                 date_breaks = "1 year",date_labels="%Y")  +
    scale_y_continuous(sec.axis=dup_axis())+
    theme(plot.subtitle=element_text(face="italic",size=14),
          plot.title=element_text(color="royalblue",face="bold",size=18),
          plot.caption=element_text(hjust=0),
          panel.grid.major.x = element_line(color="lightgray"),
          panel.grid.minor.x = element_line(color="lightgray"),
          panel.grid.major.y = element_line(color="lightgray"),
          panel.grid.minor.y = element_line(color="lightgray"))+
    labs(x="",y="House Price Index (2000 Q1=100, log scale NSA)",
         title="U.S. house price index",
         subtitle="(2000 Q1 =1 100)",
         caption="@lenkiefer Source: U.S. Federal Housing Finance Agency, All-Transactions House Price Index for the United States [USSTHPI],\nretrieved from FRED, Federal Reserve Bank of St. Louis; https://fred.stlouisfed.org/series/USSTHPI, March 18, 2018.")
  return(p)
}

oopt<-ani.options(interval=1/20)
saveGIF({for (i in 1:max(df_tween_appear$.frame)){
  g<-make_plot_appear(i)
  print(g)
  print(paste(i,"out of",max(df_tween_appear$.frame)))
  ani.pause()
}
},movie.name="C:/Users/14438/Documents/virtulis/hpi2.gif",ani.width = 700, ani.height = 540)








# now compare US, CA and TX
df.us2<-dplyr::filter(df,state %in% c("TX","CA","US")) %>%  select(date,state,hpi) %>% 
  mutate(day=as.numeric(date-min(date)+1),ease="linear")


plot_data_tween2<-tween_elements(df.us2, time = "day",  group="state", ease="ease", nframes = nrow(df.us2))
df_tween_appear2 <- tween_appear(plot_data_tween2, time='day', nframes = nrow(df.us2))
#df_tween_appear$date <- as.POSIXct(as.Date("2000-01-01")+df_tween_appear$day)

# add pause at end of animation
df_tween_appear2<- df_tween_appear2 %>% keep_state(20)
summary(df_tween_appear2)
#filter(df_tween_appear, .frame==334 & date>"2018-03-01")

make_plot_appear2 <- function(i){
  plot_data <- 
    df_tween_appear2 %>% filter(.frame==i, .age> -3.5) 
  p<- plot_data %>% 
    ggplot()+
    geom_line(aes(x=date, y=hpi, color=.group), size=1.3)+
    geom_point(data=. %>% filter(date==max(date)), mapping=aes(x=date, y=hpi,color=.group), size=3,stroke=1.5)+
    geom_point(data=. %>% filter(date==max(date)), mapping=aes(x=date, y=hpi,color=.group),  size=2)+
    geom_text(data=. %>% filter(date==max(date)), mapping=aes(x=date, y=hpi,label=.group, color=.group),nudge_x=7,hjust=-0.4,fontface="bold")+
    geom_line(data=df.us2, aes(x=date,y=hpi, group=state),alpha=0.25,color="darkgray")+
    theme_minimal(base_family = "sans")+
    scale_x_date(limits = c(as.Date("2000-01-01"),as.Date("2018-04-30")),
                 date_breaks = "1 year",date_labels="%Y")  +
    scale_y_continuous(sec.axis=dup_axis())+
    theme(plot.subtitle=element_text(face="italic",size=14),
          legend.position="none",
          plot.title=element_text(color="royalblue",face="bold",size=18),
          plot.caption=element_text(hjust=0),
          panel.grid.major.x = element_line(color="lightgray"),
          panel.grid.minor.x = element_line(color="lightgray"),
          panel.grid.major.y = element_line(color="lightgray"),
          panel.grid.minor.y = element_line(color="lightgray"))+
    labs(x="",y="House Price Index (2000 Q1=100, log scale NSA)",
         title="House price index",
         subtitle="(2000 Q1 =1 100)",
         caption="@lenkiefer Source: U.S. Federal Housing Finance Agency, All-Transactions House Price Index ,\nretrieved from FRED, Federal Reserve Bank of St. Louis; https://fred.stlouisfed.org/series/XXSTHPI, March 18, 2018. [XX= state code or US]")
  return(p)
}

oopt<-ani.options(interval=1/20)
saveGIF({for (i in 1:max(df_tween_appear2$.frame)){
  g<-make_plot_appear2(i)
  print(g)
  print(paste(i,"out of",max(df_tween_appear2$.frame)))
  ani.pause()
}
},movie.name="C:/Users/14438/Documents/virtulis/hpi3.gif",ani.width = 700, ani.height = 540)
