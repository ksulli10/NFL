#
# create overall ryurko PBP data frame
#
library(plyr)
remove(pbp_data_overall)
pbp_data_overall <-
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