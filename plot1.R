# First we load raw data from the directory.
# Source file is 127MB after unzipping so nothing really unusual
# Please keep in mind that loading might take a moment
sourceFile <- "./ExData_Plotting1/household_power_consumption.txt"
rawData <- read.csv(file = sourceFile, header = TRUE, sep = ";", stringsAsFactors=FALSE)

# Subsetting data to obtain only relevant measurements
workingDataSet <- rawData[rawData$Date == "1/2/2007" | rawData$Date == "2/2/2007",]
# Housekeeping
#rm(rawData)
#quartz()
hist(as.numeric(data$Global_active_power), col="red", main ="Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.print(png, "plot11.png", width = 480, height=480, units = "px")
dev.off