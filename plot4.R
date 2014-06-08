## script creates plot4
# 4 plots: plot2, voltage, plot3, Global_reactive_power

## read data
datao <- read.table("household_power_consumption.txt", sep= ";", as.is = "Date", header=TRUE)
datao$Date <- as.Date(datao$Date, format = "%d/%m/%Y")
datao$Global_active_power <- as.numeric(as.character(datao$Global_active_power))

## new data with just 2007-02-01 and 2007-02-02
date1 <- grep("2007-02-01", datao$Date)
feb1 <- datao[date1,]
date2 <- grep("2007-02-02", datao$Date)
feb2 <- datao[date2,]
datac <- rbind(feb1, feb2)

## combine date and time to one variable 'dt'
datac$datetime <- paste(as.character(datac$Date), as.character(datac$Time))
datac$datetime <- strptime(datac$datetime, format = "%Y-%m-%d %H:%M:%S")

## variables to numeric
datac$Sub_metering_1 <- as.numeric(as.character(datac$Sub_metering_1))
datac$Sub_metering_2 <- as.numeric(as.character(datac$Sub_metering_2))
datac$Sub_metering_3 <- as.integer(as.character(datac$Sub_metering_3))
datac$Global_reactive_power <- as.numeric(as.character(datac$Global_reactive_power))
datac$Voltage <- as.numeric(as.character(datac$Voltage))


## create plot to png file
png(file = "plot4.png")
par(mfrow = c(2,2))
with(datac, {
  ## plot 1,1
  plot(datetime, Global_active_power, type="l",
       xlab = "", 
       ylab = "Global Active Power")
  ## plot 1,2
  plot(datetime, Voltage, type ="l")
  ## plot 2,1
  plot(datetime, Sub_metering_1, type="l",
                 xlab = "", 
                 ylab = "Energy sub metering")
  lines(datetime, Sub_metering_2, col = "red")
  lines(datetime, Sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), bty = "n",
       lty = c(1,1,1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  ## plot 2,2
  plot(datetime, Global_reactive_power, type ="l")
})
dev.off()