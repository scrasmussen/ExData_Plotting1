# Read in the input
file <- "household_power_consumption.txt"
input <- read.table(file, header=TRUE, sep=';')

# Format the Dates for comparison
input$Date <- strptime(input$Date, "%d/%m/%Y")
day1 <- strptime("2007-02-01", "%Y-%m-%d")
day2 <- strptime("2007-02-02", "%Y-%m-%d")

d <- input[input$Date == day1 | input$Date == day2,]

d$Global_active_power <- as.numeric(levels(d$Global_active_power))[d$Global_active_power]
png('plot1.png', width=480, height=480)
hist(d$Global_active_power, col='red', main='Global Active Power', xlab='Global Active Power (kilowatts)')
dev.off()