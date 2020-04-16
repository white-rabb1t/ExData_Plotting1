##Checks if directory "Data" exists. If it doesn't, the directory will be created
if(!file.exists("./data")){
  dir.create("./data")
}

##Downloads data set
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./data/exdata%2Fdata%2Fhousehold_power_consumption.zip")){
  download.file(fileUrl, destfile = "./data/exdata%2Fdata%2Fhousehold_power_consumption.zip")
}

##Unzip data set
if(!file.exists("./data/household_power_consumption.txt")){
  unzip("./data/exdata%2Fdata%2Fhousehold_power_consumption.zip", exdir = "./data")
  dateDownloaded <- date()
}

##Reads in the data set
householdPower <- read.table("./data/household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE, header = TRUE)

##Subsets the data from 1/2/2007 and 2/2/2007
twoDays <- subset(householdPower, householdPower$Date == "1/2/2007" | householdPower$Date == "2/2/2007")

##Combines the Date and Time columns into one column
twoDays$Datetime <- paste(twoDays$Date,twoDays$Time)

##Removes the Date and Time column and reorders the columns so Datetime comes first
twoDays$Date <- NULL
twoDays$Time <- NULL
col_order <- c("Datetime", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
twoDays <- twoDays[, col_order]

##Converting the Datetime column from character classes
twoDays$Datetime <- strptime(twoDays$Datetime, format = "%d/%m/%Y %H:%M:%S")

##Creating a PNG canvas of 480px x 480px
png("plot2.png", width = 480, height = 480)

##Drawing the plot
plot(twoDays$Datetime, twoDays$Global_active_power, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)")

##Closing the file
dev.off()