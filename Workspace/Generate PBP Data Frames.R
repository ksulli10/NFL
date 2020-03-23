#
# set up ryurko PBP data since 2009
#
pbp_2019 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2019.csv")
pbp_2018 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2018.csv")
pbp_2017 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2017.csv")
pbp_2016 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2016.csv")
pbp_2015 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2015.csv")
pbp_2014 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2014.csv")
pbp_2013 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2013.csv")
pbp_2012 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2012.csv")
pbp_2011 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2011.csv")
pbp_2010 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2010.csv")
pbp_2009 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2009.csv")
pbp_2019_pre <- scrape_season_play_by_play(2019, type="pre")

# create add_series_success function
source("Functions/add_series_success.R")

#
# add series success to pbp data frames
#
pbp_2019 <- add_series_success(2019)
pbp_2018 <- add_series_success(2018)
pbp_2017 <- add_series_success(2017)
pbp_2016 <- add_series_success(2016)
pbp_2015 <- add_series_success(2015)
pbp_2014 <- add_series_success(2014)
pbp_2013 <- add_series_success(2013)
pbp_2012 <- add_series_success(2012)
pbp_2011 <- add_series_success(2011)
pbp_2010 <- add_series_success(2010)
pbp_2009 <- add_series_success(2009)
pbp_2019_pre <- add_series_success("2019_pre")

#
# create overall pbp data frame
#
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