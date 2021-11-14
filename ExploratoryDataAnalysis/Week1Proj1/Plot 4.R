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

dataset_long <- melt(data = df,
                     id.vars = c("Date", "Time", "Time2", "Global_active_power",
                                 "Global_reactive_power", "Voltage", "Global_intensity"),
                     variable.name = "Sub_metering",
                     value.name = "Reading")

p2 <- ggplot(aes(y=Global_active_power, x=Time2), 
             data = df) + 
  geom_line()

p3 <- ggplot(aes(y=Reading, x=Time2, colour=Sub_metering), 
             data = dataset_long) + 
  geom_line()

p4 <- ggplot(aes(y=Voltage, x=Time2), 
             data = df) + 
  geom_line()
p4 + scale_y_continuous(limit = c(233, 247)) # Change range of Y axis

ggsave("Plot 4.png", plot = p4)

p5 <- ggplot(aes(y=Global_reactive_power, x=Time2), 
             data = df) + 
  geom_line()

p5 + scale_y_continuous(limit = c(0.000, 0.500)) # Change range of Y axis

ggsave("Plot 4.png", plot = p2 + p4 + p3 + p5)