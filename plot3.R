## script creates plot3
# line graph of Global Active Power data

## read data
datao <- read.table("household_power_consumption.txt", sep= ";", as.is = "Date", header=TRUE)
datao$Date <- as.Date(datao$Date, format = "%d/%m/%Y")
#datao$Time <- strptime(datao$Time, format = "%H:%M:%S")
datao$Global_active_power <- as.numeric(as.character(datao$Global_active_power))

## new data with just 2007-02-01 and 2007-02-02
date1 <- grep("2007-02-01", datao$Date)
feb1 <- datao[date1,]
date2 <- grep("2007-02-02", datao$Date)
feb2 <- datao[date2,]
datac <- rbind(feb1, feb2)

## combine date and time to one variable 'dt'
datac$dt <- paste(as.character(datac$Date), as.character(datac$Time))
datac$dt <- strptime(datac$dt, format = "%Y-%m-%d %H:%M:%S")

## sub metering variables to numeric
datac$Sub_metering_1 <- as.numeric(as.character(datac$Sub_metering_1))
datac$Sub_metering_2 <- as.numeric(as.character(datac$Sub_metering_2))
datac$Sub_metering_3 <- as.integer(as.character(datac$Sub_metering_3))

## create plot to png file
png(file = "plot3.png")
with(datac, plot(dt, Sub_metering_1, type="l",
                 xlab = "", 
                 ylab = "Energy sub metering"))
with(datac, lines(dt, Sub_metering_2, col = "red"))
with(datac, lines(dt, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"), 
       lty = c(1,1,1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()