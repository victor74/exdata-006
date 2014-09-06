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

# Resetting graphical parameters
n.col <-1
n.row <-1
par(mfrow = c(n.col, n.row))

# Constructing histogram
hist(as.numeric(workingDataSet$Global_active_power), col="red", main ="Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# Writing to a file
dev.print(png, "plot1.png", width = 480, height=480, units = "px")
dev.off