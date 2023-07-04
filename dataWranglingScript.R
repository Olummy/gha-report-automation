# Wed Sep 15 22:44:05 2021 ------------------------------

library(readr)

all_data <- read_csv("all_data.csv")

coord <- regmatches(all_data$File, gregexpr("(?<=\\().*?(?=\\))", all_data$File, perl=T))
  
coord <- unlist(coord)

all_data$coordinate <- coord[seq(from = 2, to = length(coord), by = 2)]

# replace the hyphen with a comma

all_data$coordinate <- gsub("-", ", ", all_data$coordinate)

View(all_data)
