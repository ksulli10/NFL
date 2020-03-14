#
# load local .rds files into rosters data frames
#
rosters_2019 <- readRDS("Data/rosters_2019.rds")
rosters_2018 <- readRDS("Data/rosters_2018.rds")
rosters_2017 <- readRDS("Data/rosters_2017.rds")
rosters_2016 <- readRDS("Data/rosters_2016.rds")
rosters_2015 <- readRDS("Data/rosters_2015.rds")
rosters_2014 <- readRDS("Data/rosters_2014.rds")
rosters_2013 <- readRDS("Data/rosters_2013.rds")
rosters_2012 <- readRDS("Data/rosters_2012.rds")
rosters_2011 <- readRDS("Data/rosters_2011.rds")
rosters_2010 <- readRDS("Data/rosters_2010.rds")
rosters_2009 <- readRDS("Data/rosters_2009.rds")

#
# create overall rosters data frame
#
library(plyr)
remove(rosters_overall)
rosters_overall <-
  rbind.fill(
    rosters_2009,
    rosters_2010,
    rosters_2011,
    rosters_2012,
    rosters_2013,
    rosters_2014,
    rosters_2015,
    rosters_2016,
    rosters_2017,
    rosters_2018,
    rosters_2019
  )
library(dplyr)