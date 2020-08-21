

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
with(data,plot(dateTime,Sub_metering_1,type="line",ylab='Energy Sub Metering'))
with(data,lines(dateTime,Sub_metering_2,col="red"))
with(data,lines(dateTime,Sub_metering_3,col="blue"))

legend("topright",legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), col=c('black','red','blue'),lwd=3)

dev.copy(png,"Plot3.png")
dev.off()
