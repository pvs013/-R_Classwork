## Exploratory Analysis
## Project #1
## ---------------------------------------
## File downloaded and unzipped in ./data directory
## - separated by ';'
## ---------------------------------------
file <- "./data/household_power_consumption.txt"
power_data <- read.table(file, header=TRUE, sep=";", na.strings="?")

## subset the data needed - in DD/MM/YYYY format
power_data <- power_data[power_data$Date %in% c("1/2/2007","2/2/2007"),]

## Merge Date and Time columns to an convert into Date classes
power_data$DateTime <- paste(power_data$Date, power_data$Time)
power_data$DateTime <- strptime(power_data$DateTime, format = "%d/%m/%Y %H:%M:%S")

# Open Graphics Device - png file 480x480
png(filename = "plot1.png", width = 480, height = 480)

## Draw histogram - Plot 1
## - use hist: Color Red, Title, X-axis title
hist(power_data$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

#Close Graphics Device
dev.off()

## Draw Plot 2
# Open Graphics Device - png file 480x480
png(filename = "plot2.png", width = 480, height = 480)

## Draw Plot 2
plot(power_data$DateTime, power_data$Global_active_power, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

#Close Graphics Device
dev.off()

## Draw Plot 3
# Open Graphics Device - png file 480x480
png(filename = "plot3.png", width = 480, height = 480)

## Draw Plot 3
plot(power_data$DateTime, power_data$Sub_metering_1, type="n",
     ylab="Energy sub metering", xlab="")
points(power_data$DateTime, power_data$Sub_metering_1, type="l", col="black")
points(power_data$DateTime, power_data$Sub_metering_2, type="l", col="red")
points(power_data$DateTime, power_data$Sub_metering_3, type="l", col="blue")
legend("topright", lwd = 2, col= c("black","red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Close Graphics Device
dev.off()



## Draw Plot 4
# Open Graphics Device - png file 480x480
png(filename = "plot4.png", width = 480, height = 480)


## Draw Plot 4
par(mfrow= c(2,2))
with(power_data, {
    ## Plot 1 - global active power
    plot(DateTime, Global_active_power, type="l",
         ylab="Global Active Power", xlab="")
    ## Plot 2 - voltage
    plot(DateTime, Voltage, type="l",
         ylab="Voltage", xlab="datetime")
    ## Plot 3 - Energy sub metering
    plot(DateTime, Sub_metering_1, type="n",
         ylab="Energy sub metering", xlab="")
    points(DateTime, Sub_metering_1, type="l", col="black")
    points(DateTime, Sub_metering_2, type="l", col="red")
    points(DateTime, Sub_metering_3, type="l", col="blue")
    legend("topright", lwd = 2, bty = "n", col= c("black","red","blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", 
                      "Sub_metering_3"), cex=0.95)
    ## Plot 4 - Global reactive power
    plot(DateTime, Global_reactive_power, type="l",
         ylab="Global_reactive_power", xlab="datetime")    
})

#Close Graphics Device
dev.off()


