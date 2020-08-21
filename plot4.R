

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

#set up the four graphs
par(mfrow=c(2,2))

#draw graph 1
with(data,plot(dateTime,Global_active_power,type="line",xlab="", ylab='Global Active Power (kilowatts)'))

#draw graph 2
with(data,plot(dateTime,Voltage,type="line", xlab="datetime", ylab='voltage'))


#draw graph 3
with(data,plot(dateTime,Sub_metering_1,type="line",xlab="",ylab='Energy Sub Metering'))
with(data,lines(dateTime,Sub_metering_2,col="red"))
with(data,lines(dateTime,Sub_metering_3,col="blue"))
legend("topright",legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), col=c('black','red','blue'),lwd=1,cex=0.7)

#draw graph 4
with(data,plot(dateTime,Global_reactive_power,type="line",xlab="datetime", ylab='Global_Reactive_Power'))



dev.copy(png,"Plot4.png")
dev.off()
