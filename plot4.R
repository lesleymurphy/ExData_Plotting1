###############################################################################################
##Exploratory Data Analysis, Course Project #1, plot4
##Lesley Murphy, December 2015
################################################################################################
##Purpose is to download dataset and recreate graphs as seen in GitHub repo: https://github.com/rdpeng/ExData_Plotting1
##This script will recreate Plot 4

##set working directory
setwd("./ExplorDataAnalysisProject1")

##create folder
if(!file.exists("data")) {
        dir.create("data")
}

##download data
temp <- tempfile()
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), header = FALSE, skip = 66637, sep=";", nrows = 2880, na.strings = "?")
unlink(temp)

##Because of skipping rows, have to add back in the column names
colnames(data)<-c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

##Combine Date and Time into a single column and Identify DateTime column as date and time, rather than factors
data$DateTime<-as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

###Add in Weekdays
data$DayOfWeek<-weekdays(data$DateTime)

##data cleaning is done##################################################################

##Plot 4 is tiles (2,2) with upper left corner=plot2, bottom left corner=plot 3
##graphs on right side are the same as plot 2 except in upper right is voltage on y-axis and lower right is with
##y-axis of global_reactive_power and both have xlab of "datetime"

##Export/save as .png file with width of 480 pixels and a height of 480 pixels
##switched to png rather than dev because  it was cutting off the right side of legend
png(filename="plot4.png", width=480, height=480, units="px")

##setup plotting area for tiles
par(mfrow=c(2,2))

##upper left
plot(data$DateTime, data$Global_active_power, type="l", xlab=" ", ylab="Global Active Power")

##upper right
plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

##lower left
plot(data$DateTime, data$Sub_metering_1, col="black", type="l", xlab=" ", ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col="red", type="l")
lines(data$DateTime, data$Sub_metering_3, col="blue", type="l")

leg.txt<-c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

legend('topright',legend=leg.txt,
       cex=0.8,
       bty="n",
       lty=c(1,1, 1),
       lwd=c(2.5,2.5),
       col=c("black", "red", "blue"))

##lower right
plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()