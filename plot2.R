# Read in the input
file <- "household_power_consumption.txt"
input <- read.table(file, header=TRUE, sep=';')

# Format the Dates for comparison
input$Date <- strptime(input$Date, "%d/%m/%Y")
day1 <- strptime("2007-02-01", "%Y-%m-%d")
day2 <- strptime("2007-02-02", "%Y-%m-%d")

d <- input[input$Date == day1 | input$Date == day2,]

d$Global_active_power <- as.numeric(levels(d$Global_active_power))[d$Global_active_power]


png('plot2.png', width=480, height=480)
plot(d$Global_active_power, type='l', ylab='Global Active Power (kilowatts)', xlab='', axes=FALSE)

len <- length(d$Global_active_power)
axis(1, at=seq(0,len,len/2), labels=c('Thu','Fri', 'Sat'), las=2)
axis(2)
box()

dev.off()