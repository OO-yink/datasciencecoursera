library("pacman") # Load pacman package
p_load(ggplot2, ggthemes, dplyr, readr, datasets, grid, RColorBrewer, data.table, pacman, patchwork, lubridate)

dataset <- read.table('/household_power_consumption.txt', 
                      header = TRUE,
                      na="?",
                      sep = ";",
                      colClasses = c("character",
                                     "character",
                                     "numeric",
                                     "numeric",
                                     "numeric",
                                     "numeric",
                                     "numeric",
                                     "numeric",
                                     "numeric"))

dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y")
df <- dataset[dataset$Date >= "2007-02-01" & dataset$Date < "2007-02-03", ]
df$Time <- as.POSIXct(df$Time, format="%H:%M:%S")
df$Time <- format(df$Time, format = "%H:%M:%S") # Extract Time from a Column in a Dataframe
df$datetime <- paste(df$Date,df$Time)
df$datetime <- ymd_hms(df$datetime)

# Open the file
png("Plot 3.png", 480, 480)

# Make the figure
plot(data.frame(df$datetime, df$Sub_metering_1), type = "l", xlab = "Datetime", ylab = "Energy sub metering")
lines(data.frame(df$datetime, df$Sub_metering_2), type = "l", col = "red")
lines(data.frame(df$datetime, df$Sub_metering_3), type = "l", col = "blue")

# Add a legend
legend("topright",
       legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"),
       col = c("black", "red", "blue"),
       lty = 1)

# Close the file
dev.off()
