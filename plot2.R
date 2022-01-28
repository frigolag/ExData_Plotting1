## Install & load tidyverse package
install.packages("tidyverse")
library(tidyverse)

## Check if zip file exists in directory
zipfile<- "exdata_data_household_power_consumption.zip"
if (file.exists(!zipfile)){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                zipfile,mode= "wb")
}

## Check if file exists in directory
file<- "household_power_consumption.txt"
if (file.exists(!file)){
  unzip(zipfile)
}

## read data from file
df<-read_delim("household_power_consumption.txt",
               delim=";",col_types = cols_only(Date =col_character(),
                                               Time=col_character(), 
                                               Global_active_power=col_double()))
## extract data from 2007-02-01 & 2007-02-02
df2<-df%>% filter(Date=="1/2/2007"| Date=="2/2/2007")%>%
  unite(Date_Time,Date,Time,sep = " ")
df2$Date_Time<-as.POSIXct(df2$Date_Time,tz="",format= "%d/%m/%Y %H:%M:%S")

## Plot
## open device 
png(filename = "plot2.png")
## plot graphic
with(df2,plot(Date_Time,Global_active_power,ylab = "Global Active Power (kilowatts)",
              type="l",xlab=""))
## close device
dev.off()
