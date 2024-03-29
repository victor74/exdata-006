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

# Finding ymin and ymax
ymin <- min(as.numeric(workingDataSet$Sub_metering_1),
            as.numeric(workingDataSet$Sub_metering_2),
            as.numeric(workingDataSet$Sub_metering_3))
ymax <- max(as.numeric(workingDataSet$Sub_metering_1),
            as.numeric(workingDataSet$Sub_metering_2),
            as.numeric(workingDataSet$Sub_metering_3))
yrange <- range(c(ymin, ymax))

# Resetting graphical parameters
n.col <-1
n.row <-1
par(mfrow = c(n.col, n.row))

# Plotting
d1 <- strptime(paste0(workingDataSet$Date, " ", workingDataSet$Time), "%d/%m/%Y %H:%M:%S")
plot(d1, as.double(workingDataSet$Sub_metering_1), 
     type="l", ylim=yrange, col="black", ylab = "Energy sub metering", xlab = "")
lines(d1, as.double(workingDataSet$Sub_metering_2), type="l", col="red")
lines(d1, as.double(workingDataSet$Sub_metering_3), type="l", col="blue")
legend("topright",c("Sub_metering_1    ","Sub_metering_2    ","Sub_metering_3    "),
     lwd = 2, col = c("black","red","blue"))
dev.print(png, "plot3.png", width = 480, height=480, units = "px")
dev.off