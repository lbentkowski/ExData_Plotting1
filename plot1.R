# 1. Loading and cleaning data ----
# Load required packages
library(dplyr)
library(lubridate)
# read data from file - standalone file was required so direct link to web is privided (Works under Windows for MAC check slashes \ and /)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
df <- read.table(unz(temp, "household_power_consumption.txt"),header = TRUE, sep = ";", colClasses = "character")
unlink(temp)
# subseting only desirable dates using dplyr
df_sub <- df %>%  
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>% # filter two days defined in task
  transform(Date = (dmy(Date))) %>%                   # change date format do yyy-mm-dd
  mutate(Date_time = as.POSIXct(paste(Date,Time)))    # add column with date-time format as time series.
# check if classes are properly defined for Date and Date_time
df_sub[ , 3:9] <- sapply(df_sub[ , 3:9], as.numeric)
lapply(df_sub, class)

# 2. Creating a plot ----
# Plot1 a histogram
png(file="plot1.png",width=480,height=480)
hist(df_sub$Global_active_power,
     main ="Global Active Power",
     xlab ="Global Active Power (kilowatts)",
     col = "red")
dev.off()
