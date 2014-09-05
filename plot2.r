# First we load raw data from the directory.
# Source file is 127MB after unzipping so nothing really unusual
# Please keep in mind that loading might take a moment
sourceFile <- "./ExData_Plotting1/household_power_consumption.txt"
rawData <- read.csv(file = sourceFile, header = TRUE, sep = ";", stringsAsFactors=FALSE)

# Subsetting data to obtain only relevant measurements
workingDataSet <- rawData[rawData$Date == "1/2/2007" | rawData$Date == "2/2/2007",]
# Housekeeping
rm(rawData)
d1 <- strptime(paste0(workingDataSet$Date, " ", workingDataSet$Time), "%d/%m/%Y %H:%M:%S")
plot(d1, as.double(workingDataSet$Global_active_power),
     type="l", col="black", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.print(png, "plot2.png", width = 480, height=480, units = "px")
dev.off