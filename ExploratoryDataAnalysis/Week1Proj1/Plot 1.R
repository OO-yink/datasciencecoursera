#library("pacman") # Load pacman package
#library('data.table')
#library(patchwork)
p_load(ggplot2, ggthemes, dplyr, readr, datasets, grid, RColorBrewer, data.table, pacman, patchwork)

dataset <- read.table('./Data/household_power_consumption.txt', header = TRUE, sep = ";")
setDT(dataset)
dataset$Date <- as.POSIXct(dataset$Date, format="%d/%m/%Y")
dataset$Date <- as.Date(dataset$Date)
df <- dataset[dataset$Date >= "2007-02-01" & dataset$Date < "2007-02-03", ]
df$Time <- as.POSIXct(df$Time, format="%H:%M:%S")
df$Time2 <- format(df$Time, format = "%H:%M:%S") # Extract Time from a Column in a Dataframe 
df$Global_active_power <- as.numeric(df$Global_active_power)

df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
df$Voltage <- as.numeric(df$Voltage)
df$Global_intensity <- as.numeric(df$Global_intensity)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)

p1 <- ggplot(df, aes(x=Global_active_power)) + geom_histogram(bins = 30)
p1

ggsave("Plot 1.png", plot = p1)