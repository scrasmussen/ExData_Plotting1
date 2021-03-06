# Read in the input
file <- "household_power_consumption.txt"
input <- read.table(file, header=TRUE, sep=';')

# Format the Dates for comparison
input$Date <- strptime(input$Date, "%d/%m/%Y")
day1 <- strptime("2007-02-01", "%Y-%m-%d")
day2 <- strptime("2007-02-02", "%Y-%m-%d")

d <- input[input$Date == day1 | input$Date == day2,]

d$Sub_metering_1 <- as.numeric(levels(d$Sub_metering_1))[d$Sub_metering_1]
d$Sub_metering_2 <- as.numeric(levels(d$Sub_metering_2))[d$Sub_metering_2]


png('plot3.png', width=480, height=480)
plot(d$Sub_metering_1, type='l', ylab='Energy sub metering', xlab='', axes=FALSE)
lines(d$Sub_metering_2, col='red')
lines(d$Sub_metering_3, col='blue')

len <- length(d$Global_active_power)
m <- max(d$Sub_metering_1)
axis(1, at=seq(0,len,len/2), labels=c('Thu','Fri', 'Sat'), las=2)
axis(2)
box()
legend_names <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend(len-975, m+2, legend_names, lty=c(1,1,1) , col=c("black","red","blue") )

dev.off()