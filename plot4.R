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
png(filename="plot4.png", width=480, height=480)

# set mfcol to show 4 plots, added by column
par(mfcol=c(2,2))

# SUBPLOT 1
plot(x=feb$Datetime[order(feb$Datetime)],
	 y=feb$Global_active_power[order(feb$Datetime)],
	 type='l',
	 xlab='',
	 ylab="Global Active Power (kilowatts)")

# SUBPLOT 2
plot(feb$Datetime, feb$'Sub_metering_1',
	 type='l', xlab='', ylab="Energy sub metering")
lines(feb$Datetime, feb$'Sub_metering_2', col='red')
lines(feb$Datetime, feb$'Sub_metering_3', col='blue')
legend('topright', legend=colnames(feb)[7:9],
	   col=c('black', 'red', 'blue'), lty=1, bty='n')

# SUBPLOT 3
with(feb, plot(Datetime, Voltage, type='l'))

# SUBPLOT 4
with(feb, plot(Datetime, Global_reactive_power, type='l'))

# turn off graphics device
dev.off()
