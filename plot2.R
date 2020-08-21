

#Get the file from coursera
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")

# Load the data from the zip file
dataraw <- read.table(unz('household_power_consumption.zip', "household_power_consumption.txt"),
                      sep=";",
                      header=TRUE,
                      na.strings="?")
#convert the text Date to a date and subset based on that
dataraw$Date<-as.Date(dataraw$Date,'%d/%m/%Y')
data= subset(dataraw, Date == '2007-02-01' | Date == '2007-02-02') 

#convert time to a time format
data$Time<-strptime(data$Time,'%H:%M:%S')

data$dateTime <- paste(data$Date, data$Time)
data$dateTime <- as.POSIXct(data$dateTime)


#draw the graph locally and then copy to the png file
with(data,plot(dateTime,Global_active_power,type="line",
               ylab='Global Active Power (kilowatts)'))
dev.copy(png,"Plot2.png")
dev.off()
