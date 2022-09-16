library(tidyverse)
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url, destfile = "data//dataset.zip")

unzip(zipfile = "./data//dataset.zip", 
      exdir = "./data")

a = grep("1/2/2007", readLines("./data//household_power_consumption.txt"))



df <-read.table("./data//household_power_consumption.txt",skip=a[1]-1,nrows=1440*2,header = FALSE, sep=";",
                na.strings = "?",
               colClasses = c('character','character','numeric'
                              ,'numeric','numeric','numeric','numeric','numeric','numeric'),
                col.names = c("Date","Time","Global_active_power","Global_reactive_power",
                              "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                              "Sub_metering_3"))

df$Date <- as.Date(df$Date, "%d/%m/%Y")


df <- df %>% 
        mutate(dateTime = paste(Date,Time)) %>% 
        select(dateTime, "Global_active_power","Global_reactive_power",
               "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
               "Sub_metering_3") %>% 
        mutate(dateTime = as.POSIXct(dateTime))



#create plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(df, {
        plot(Global_active_power~dateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~dateTime, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~dateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~dateTime,col='Red')
        lines(Sub_metering_3~dateTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~dateTime, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
})
# save plot
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()



