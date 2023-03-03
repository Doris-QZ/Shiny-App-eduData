# Load packages
library(tidyverse)
library(readxl)


# Load data
url <- "https://nces.ed.gov/programs/digest/d19/tables/xls/tabn311.70.xls"
download.file(url, destfile = "/Users/Doris/Desktop/Shiny-App-eduData/course-enrollments.xls", method="curl")
enrollments <- read_excel("course-enrollments.xls", skip=1)


# Clean data
enrollments <- enrollments[-c(1:4, 6:11, 27:48), -c(14:18)]
enrollments$language <- c("All", "American Sign Language", "Arabic", "Chinese", "French", "German", "Greek, Ancient",
                          "Hebrew", "Italian", "Japanese", "Korean", "Latin", "Portuguese", "Russian", "Spanish", "Other languages")
enrollments <- enrollments[,-1]
enrollments <- gather(enrollments, "year", "enrollment", -"language")
enrollments$language <- replace(enrollments$language, enrollments$language=="Greek, Ancient", "Greek")
enrollments$enrollment <- replace(enrollments$enrollment, enrollments$enrollment=="---", NA)
enrollments <- enrollments[complete.cases(enrollments),]

enrollments$enrollment <- as.numeric(enrollments$enrollment)
enrollments$year <- as.factor(enrollments$year)

# Export data
write.csv(enrollments, file="/Users/Doris/Desktop/Shiny-App-eduData/enrollments.csv")



