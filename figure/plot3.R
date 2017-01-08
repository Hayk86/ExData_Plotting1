library(dplyr)
library(tidyr)
library(lubridate)
x <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE,
                na.strings = "?", colClasses = "character")

df <- tbl_df(x)
rm(x)

Ending_Date <- ymd_hms("2007-02-02 23:59:59")
Starting_Date <- ymd_hms("2007-02-01 00:00:00")
df$Date <- dmy_hms(paste(df$Date,df$Time, sep = " "))
#df$Date <- dmy(df$Date)
#df$Time <- hms(df$Time)
df <- df[df$Date >= Starting_Date & df$Date <= Ending_Date,]

df[,3:9] <- lapply(df[,3:9], as.numeric)

png(filename = "plot3.png")
plot(df$Date, df$Sub_metering_1, type = "l", ylab = "Energy Sub Metering", xlab = "")
lines(df$Date, df$Sub_metering_2, col = "red")
lines(df$Date, df$Sub_metering_3, col = "blue")
legend("topright", col = c("black","red", "blue"), lty = 1,
       legend = c("Sub_Metering_1", "Sub_Metering_2","Sub_Metering_3"))
dev.off()

