#
# load local .rds files into tracking data frames
#
tracking_2019 <- readRDS("Data/tracking_2019.rds")
tracking_2018 <- readRDS("Data/tracking_2018.rds")
tracking_2017 <- readRDS("Data/tracking_2017.rds")

#
# create overall tracking data frame
#
library(plyr)
remove(tracking_overall)
tracking_overall <-
  rbind.fill(
    tracking_2017,
    tracking_2018,
    tracking_2019
  )
library(dplyr)