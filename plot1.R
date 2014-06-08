## script creates plot1
# historgram of Global active power data

## read data
datao <- read.table("household_power_consumption.txt", sep= ";", as.is = "Date", header=TRUE)
datao$Date <- as.Date(datao$Date, format = "%d/%m/%Y")
datao$Time <- strptime(datao$Time, format = "%H:%M:%S")
datao$Global_active_power <- as.numeric(as.character(datao$Global_active_power))

## new data with just 2007-02-01 and 2007-02-02
date1 <- grep("2007-02-01", datao$Date)
feb1 <- datao[date1,]
date2 <- grep("2007-02-02", datao$Date)
feb2 <- datao[date2,]
datac <- rbind(feb1, feb2)

## create histogram to png file
png(file = "plot1.png")
hist(datac$Global_active_power, 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red")
dev.off()