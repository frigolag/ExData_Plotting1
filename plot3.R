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
                                               Sub_metering_1=col_double(),
                                               Sub_metering_2=col_double(),
                                               Sub_metering_3=col_double()))
## extract data from 2007-02-01 & 2007-02-02
df3<-df%>% filter(Date=="1/2/2007"| Date=="2/2/2007")%>%
  unite(Date_Time,Date,Time,sep = " ")
df3$Date_Time<-as.POSIXct(df3$Date_Time,tz="",format= "%d/%m/%Y %H:%M:%S")

## Plot
## open device 
png(filename = "plot3.png")
## plot graphic
matplot(df3$Date_Time,df3[,2:4],ylab = "Energy sub metering",
        lty = c(1,1,1),type=c("S","S","S"),col = c("black","red","blue"),xlab="")

text =  c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright",legend = text,col=c("black","red","blue"),
       lty=1)
## close device
dev.off()
