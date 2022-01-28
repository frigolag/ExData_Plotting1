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
df<-read_delim("household_power_consumption.txt",delim=";",
               col_types = cols(col_date(format = "%d/%m/%Y"),
                                col_time(),col_double(),col_double(),
                                col_double(),col_double(),col_double(),col_double(),col_double()))

## extract data from 2007-02-01 & 2007-02-02
df1<-df%>% filter(Date=="2007-02-01"| Date=="2007-02-02")

## Plot1
## open device 
png(filename = "plot1.png")
## plot graphic
hist(df1$Global_active_power, main="Global Active Power",
     xlab = "Global Active Power (kilowatts)",col = "red")
## close device
dev.off()
