
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

#create plot
hist(df$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

#save plot
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()



