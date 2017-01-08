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


png(filename = "plot1.png")
hist(df$Global_active_power, xlab = "Global Active Power (kilowats)",
     col = "red", main = "Global Active Power")
dev.off()

