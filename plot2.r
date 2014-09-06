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
n.col <-1
n.row <-1
par(mfrow = c(n.col, n.row))

# Plotting
d1 <- strptime(paste0(workingDataSet$Date, " ", workingDataSet$Time), "%d/%m/%Y %H:%M:%S")
plot(d1, as.double(workingDataSet$Global_active_power),
     type="l", col="black", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.print(png, "plot2.png", width = 480, height=480, units = "px")
dev.off