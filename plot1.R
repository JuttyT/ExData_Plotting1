#R_Explore_Week_1_Project
library(stringr)
library(dplyr)

my_folder <- "/Users/thejt/Downloads/"
my_file   <- "household_power_consumption.txt"
my_data   <- read.delim2(paste(my_folder,my_file, sep = ""), header = FALSE)

my_col_data <- as.data.frame(str_split_fixed(my_data$V1,";",str_count(my_data[1,1], ";")+1))
  colnames(my_col_data) <- c("date", "time", "global_active_power", "global_reactive_power","voltage", "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")

my_col_data <- my_col_data[2:nrow(my_col_data),]
my_col_data <- mutate(my_col_data, date = as.Date(date, format="%d/%m/%Y"))
  
  top_date      <- "2007-02-01"
  bottom_date   <- "2007-02-02"
  
two_days_df   <- filter(my_col_data,(date == top_date | date == bottom_date))  #60mins*48hrs = 2880

two_days_df   <- mutate(two_days_df, global_active_power = as.numeric(global_active_power))
two_days_df   <- mutate(two_days_df, voltage = as.numeric(voltage))
two_days_df   <- mutate(two_days_df, sub_metering_1 = as.numeric(sub_metering_1))
two_days_df   <- mutate(two_days_df, sub_metering_2 = as.numeric(sub_metering_2))
two_days_df   <- mutate(two_days_df, sub_metering_3 = as.numeric(sub_metering_3))
two_days_df   <- mutate(two_days_df, global_reactive_power = as.numeric(global_reactive_power))

#Plot 1
hist((two_days_df$global_active_power)/500, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, file= "plot1.png", width = 480, height = 480)
dev.off()
