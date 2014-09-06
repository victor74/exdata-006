# First we load raw data from the directory.
# Source file is 127MB after unzipping so nothing really unusual
# Please keep in mind that loading might take a moment

sourceFile <- "./household_power_consumption.txt"

if(!file.exists(sourceFile)){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    destfile <- "household_power_consumption.zip"
    download.file(fileUrl, destfile, method="curl")
    unzip(destfile)
}

rawData <- read.csv(file = sourceFile, header = TRUE, sep = ";", stringsAsFactors=FALSE)

# Subsetting data to obtain only relevant measurements
workingDataSet <- rawData[rawData$Date == "1/2/2007" | rawData$Date == "2/2/2007",]
# Housekeeping
rm(rawData)

# Resetting graphical parameters
n.col <-2
n.row <-2
par(mfrow = c(n.col, n.row))

# Plotting
d1 <- strptime(paste0(workingDataSet$Date, " ", workingDataSet$Time), "%d/%m/%Y %H:%M:%S")
plot(d1, as.double(workingDataSet$Global_active_power),
     type="l", col="black", xlab = "", ylab = "Global Active Power")

plot(d1, as.double(workingDataSet$Voltage),
     type="l", col="black", xlab = "", ylab = "Voltage", sub = "datetime")

Sub_metering_1_colour = "black"
Sub_metering_2_colour = "red"
Sub_metering_3_colour = "blue"

plot(d1, as.double(workingDataSet$Sub_metering_1), 
     type="l", ylim=yrange, col=Sub_metering_1_colour, ylab = "Energy sub metering", xlab = "")
lines(d1, as.double(workingDataSet$Sub_metering_2), type="l", col=Sub_metering_2_colour)
lines(d1, as.double(workingDataSet$Sub_metering_3), type="l", col=Sub_metering_3_colour)
legend("topright",c("Sub_metering_1    ","Sub_metering_2    ","Sub_metering_3    "),
       lwd = 2, col = c("black","red","blue"), bty="n", cex=0.5)

plot(d1, as.double(workingDataSet$Global_reactive_power),
     type="l", col="black", xlab = "", ylab = "Global_reactive_power", sub = "datetime")
dev.print(png, "plot4.png", width = 480, height=480, units = "px")
dev.off