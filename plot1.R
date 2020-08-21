

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

#draw the graph locally and then copy to the png file
hist(data$Global_active_power,col='red',xlab='Global Active Power (kilowatts)', ylab='Frequency',main='Global Active Power')
dev.copy(png,"Plot1.png")
dev.off()
