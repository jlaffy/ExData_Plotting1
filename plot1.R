#!/usr/bin/env Rscript

## Load the data
dat <- read.table("household_power_consumption.txt",
				  sep=";", header=TRUE,
				  stringsAsFactors=FALSE)

# replace "?" with NaN
dat[dat=="?"] <- NaN

## Subset
# subset dataframe for the two days in february
feb <- subset(dat, subset = Date %in% c("1/2/2007", "2/2/2007"))

## Plot
# open file
png(filename="plot1.png", width=480, height=480)
# plot histogram and save to file
hist(as.numeric(feb$Global_active_power),
	 col="red",
	 main="Global Active Power",
	 xlab="Global Active Power (kilowatts)")
# turn off graphics device
dev.off()

