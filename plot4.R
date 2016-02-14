# Read in the input
file <- "household_power_consumption.txt"
input <- read.table(file, header=TRUE, sep=';')

# Format the Dates for comparison
input$Date <- strptime(input$Date, "%d/%m/%Y")
day1 <- strptime("2007-02-01", "%Y-%m-%d")
day2 <- strptime("2007-02-02", "%Y-%m-%d")

d <- input[input$Date == day1 | input$Date == day2,]

d$Global_active_power <- as.numeric(levels(d$Global_active_power))[d$Global_active_power]
d$Sub_metering_1 <- as.numeric(levels(d$Sub_metering_1))[d$Sub_metering_1]
d$Sub_metering_2 <- as.numeric(levels(d$Sub_metering_2))[d$Sub_metering_2]
d$Voltage <- as.numeric(levels(d$Voltage))[d$Voltage]
d$Global_reactive_power <- as.numeric(levels(d$Global_reactive_power))[d$Global_reactive_power]

png('plot4.png', width=480, height=480)
par(mfrow=c(2,2))

plot(d$Global_active_power, type='l', ylab='Global Active Power', xlab='', axes=FALSE)
len <- length(d$Global_active_power)
axis(1, at=seq(0,len,len/2), labels=c('Thu','Fri', 'Sat'), las=2)
axis(2)
box()

# plot 3
dmin <- min(d$Voltage)
dmax <- max(d$Voltage)
plot(d$Voltage, ylim=c(dmin,dmax), type='l', xlab='datetime', ylab='Voltage', axes=FALSE)
axis(1, at=seq(0,len,len/2), labels=c('Thu','Fri', 'Sat'), las=2)
axis(2)
box()

# plot 3
plot(d$Sub_metering_1, type='l', ylab='Energy sub metering', xlab='', axes=FALSE)
lines(d$Sub_metering_2, col='red')
lines(d$Sub_metering_3, col='blue')

len <- length(d$Global_active_power)
m <- max(d$Sub_metering_1)
axis(1, at=seq(0,len,len/2), labels=c('Thu','Fri', 'Sat'), las=2)
axis(2)
box()
legend_names <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend(len-2000, m+2, legend_names, lty=c(1,1,1) , col=c("black","red","blue") ,bty="n")

# plot 4
plot(d$Global_reactive_power, type='l', xlab='datetime', ylab='Global_reactive_power', axes=FALSE)
axis(1, at=seq(0,len,len/2), labels=c('Thu','Fri', 'Sat'), las=2)
axis(2)
box()

dev.off()