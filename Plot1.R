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

# HPFeb$Global nees to be numeric to plot
  HPFeb$Global_active_power<-as.numeric(HPFeb$Global_active_power)

#Plotting (I want to make sure it's the right plot)
  hist(HPFeb$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col="red", main= "Global Active Power")

#Creating the PNG file
  png(filename="Plot1.png", width=480, height=480, pointsize=12)
  hist(HPFeb$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col="red", main= "Global Active Power")
  dev.off()
