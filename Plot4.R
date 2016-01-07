#Plot 3: Energy sub metering over days

#Part 1: Downloading the file and extracting the data
setwd("~/Documents/")
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="household.zip")
dateDownloaded<-date()
unzip("./household.zip")

#Part 2: Reading the CSV
household_power_consumption <- read.csv("~/Documents/household_power_consumption.txt", header= TRUE, sep=";", na.strings= TRUE, stringsAsFactors = FALSE)


#change the date's class
household_power_consumption$Date<-as.Date(household_power_consumption$Date, format="%d/%m/%Y")

#subset Feb data
HPFeb<-household_power_consumption[household_power_consumption$Date=="2007-02-01" | household_power_consumption$Date=="2007-02-02",]

#Need to combine the date with the time
Date_Time<-paste(HPFeb$Date, HPFeb$Time, sep = "")

#Changing format of the date and time
datetime<-strptime(Date_Time, format ="%Y-%m-%d %H:%M:%S")

#Adding the Date_Time_format to HPFeb
HPFeb2<-cbind(HPFeb, datetime)

# HPFeb2$Global nees to be numeric to plot
HPFeb2$Global_active_power<-as.numeric(HPFeb2$Global_active_power)

#Creating the plot
png(filename="Plot4.png", width=480, height=480, pointsize=12)
par(mfrow=c(2,2))
par(mar=c(4,4,2,2))
#plot upper left
plot(HPFeb2$datetime, HPFeb2$Global_active_power, type="l", ylab="Global Active Power", xlab = " ")
#plot upper right
plot( HPFeb2$datetime, HPFeb2$Voltage, type="l",ylab="Voltage", xlab="datetime")
#plot lower left
plot(HPFeb2$datetime, HPFeb2$Sub_metering_1, type="n", xlab= " ", ylab= "Energy sub metering")
lines(HPFeb2$datetime, HPFeb2$Sub_metering_1, col="black")
lines(HPFeb2$datetime, HPFeb2$Sub_metering_3, col="blue")
lines(HPFeb2$datetime, HPFeb2$Sub_metering_2, col="red")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= c(1,1,1), col = c("black", "red", "blue"))

#plot lower right
plot(HPFeb2$datetime, HPFeb2$Global_reactive_power, type= "l", xlab="datetime", ylab="Global_reactive_power")


dev.off()