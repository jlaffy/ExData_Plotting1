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
png(filename="plot2.png", width=480, height=480)
# plot
plot(x=feb$Datetime[order(feb$Datetime)],
	 y=feb$Global_active_power[order(feb$Datetime)],
	 type='l',
	 xlab='',
	 ylab="Global Active Power (kilowatts)")
# turn off graphics device
dev.off()
