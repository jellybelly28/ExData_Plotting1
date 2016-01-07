#Plot 2: Global Active Power Over Days

#Plot 1: A histogram of the Global Active Power

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
Date_Time_format<-strptime(Date_Time, format ="%Y-%m-%d %H:%M:%S")

#Adding the Date_Time_format to HPFeb
HPFeb2<-cbind(HPFeb, Date_Time_format)

# HPFeb2$Global nees to be numeric to plot
HPFeb2$Global_active_power<-as.numeric(HPFeb2$Global_active_power)

#Plotting (make sure I have the right plot)
with(HPFeb2, plot(HPFeb2$Date_Time_format, HPFeb2$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=" "))
#Creating the PNG file
png(filename="Plot2.png", width=480, height=480, pointsize=12)
with(HPFeb2, plot(HPFeb2$Date_Time_format, HPFeb2$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab= " "))
dev.off()