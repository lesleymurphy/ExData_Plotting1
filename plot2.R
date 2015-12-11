###############################################################################################
##Exploratory Data Analysis, Course Project #1, plot2
##Lesley Murphy, December 2015
################################################################################################
##Purpose is to download dataset and recreate graphs as seen in GitHub repo: https://github.com/rdpeng/ExData_Plotting1
##This script will recreate Plot 2

##set working directory
setwd("./ExData_Plotting1")

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

##data cleaning done#################################################################################################

##Plot 2 is a line drawing of Global Active Power (kilowatts) (y-axis) by day (x-axis)
plot2<-plot(data$DateTime, data$Global_active_power, type="l", xlab=" ", ylab="Global Active Power (kilowatts)")

##Export/save as .png file with width of 480 pixels and a height of 480 pixels
dev.copy(png,filename="plot2.png",
        width=480, height=480, units="px")
dev.off()








