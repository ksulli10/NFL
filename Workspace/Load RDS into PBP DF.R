#
# load local .rds files into pbp data frames
#
pbp_2019 <- readRDS("Data/pbp_2019.rds")
pbp_2018 <- readRDS("Data/pbp_2018.rds")
pbp_2017 <- readRDS("Data/pbp_2017.rds")
pbp_2016 <- readRDS("Data/pbp_2016.rds")
pbp_2015 <- readRDS("Data/pbp_2015.rds")
pbp_2014 <- readRDS("Data/pbp_2014.rds")
pbp_2013 <- readRDS("Data/pbp_2013.rds")
pbp_2012 <- readRDS("Data/pbp_2012.rds")
pbp_2011 <- readRDS("Data/pbp_2011.rds")
pbp_2010 <- readRDS("Data/pbp_2010.rds")
pbp_2009 <- readRDS("Data/pbp_2009.rds")

#
# create overall pbp data frame
#
library(plyr)
remove(pbp_overall)
pbp_overall <-
  rbind.fill(
    pbp_2009,
    pbp_2010,
    pbp_2011,
    pbp_2012,
    pbp_2013,
    pbp_2014,
    pbp_2015,
    pbp_2016,
    pbp_2017,
    pbp_2018,
    pbp_2019
  )
detach(package:plyr)