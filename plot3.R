#!/usr/bin/env Rscript

## Load the data
dat <- read.table("household_power_consumption.txt",
				  sep=";", header=TRUE,
				  stringsAsFactors=FALSE)

# replace "?" with NaN
dat[dat=="?"] <- NaN
dat[is.na(dat)] <- NaN

# subset dataframe for the two days in february
feb <- subset(dat, subset = Date %in% c("1/2/2007", "2/2/2007"))
# combine Date and Time variables as Datetime
feb$Datetime <- as.POSIXct(paste(feb$Date, feb$Time), format="%d/%m/%Y %H:%M:%S")

## Plot
# open file
png(filename="plot3.png", width=480, height=480)

plot(feb$Datetime, feb$'Sub_metering_1',
	 type='l', xlab='', ylab="Energy sub metering")
lines(feb$Datetime, feb$'Sub_metering_2', col='red')
lines(feb$Datetime, feb$'Sub_metering_3', col='blue')
legend('topright', legend=colnames(feb)[7:9],
	   col=c('black', 'red', 'blue'), lty=1)

# turn off graphics device
dev.off()
