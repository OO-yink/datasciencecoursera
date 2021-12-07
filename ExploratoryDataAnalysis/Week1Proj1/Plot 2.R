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
png("Plot 2.png", 480, 480)

# Make the figure
plot(data.frame(df$datetime, df$Global_active_power), type = "l", 
     xlab = "Datetime", ylab = "Global Active Power (kilowatts)")

# Close the file
dev.off()