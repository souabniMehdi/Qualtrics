install.packages("darksky")
library("darksky")
library("tidyverse")

darksky_api_key(force = FALSE) #46ee8c7983fb33d00ddae73f778f88e7

now <- get_current_forecast(43.2672, -70.8617)

tmp <- get_forecast_for(-33.86659241, 151.2081909, "2014-10-01T02:00:00", add_headers=TRUE)
var <- c("hourly.apparentTemperature",)
tmp.data <- tmp[tmp$hourly.time=="2014-10-01 02:00:00",var]



library("rjson")
freegeoip <- function(ip, format = ifelse(length(ip)==1,'list','dataframe')){
  if (1 == length(ip))
  {
    # a single IP address
    require(rjson)
    url <- paste(c("http://freegeoip.net/json/", ip), collapse='')
    ret <- fromJSON(readLines(url, warn=FALSE))
    if (format == 'dataframe')
      ret <- data.frame(t(unlist(ret)))
    return(ret)
  } else {
    ret <- data.frame()
    for (i in 1:length(ip))
    {
      r <- freegeoip(ip[i], format="dataframe")
      ret <- rbind(ret, r)
    }
    return(ret)
  }
} 

a=freegeoip('184.26.100.110')




setwd(file.path("C:/Users/Soubeiga Armel/Desktop/Mes COURS/SSD_UGA/M1/Stage/Data/study1/"))
load("final_study1.RData")

df <- read.csv("~/Machine Learning/Darksky.csv", header=T,sep=",", fill = TRUE)
for(i in 1:length(df$DarkSky)){
  fdf <- get_forecast_for(df$LocationLatitude[i], df$LocationLongitude[i], df$DarkSky[i], add_headers=TRUE)
  fdf <- as.data.frame(fdf)
  fdf <- fdf[1:2,]
  fd <- rbind(fd,fdf)
}
