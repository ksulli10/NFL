#
# set up tracking data since 2017
#
tracking_overall <- read_csv("https://raw.githubusercontent.com/ArrowheadAnalytics/next-gen-scrapy-2.0/master/pass_and_game_data.csv")
tracking_overall <- rename(tracking_overall, id = X1)

#
# split tracking data into seasons
#
tracking_2017 <- filter(tracking_overall, season==2017)
tracking_2018 <- filter(tracking_overall, season==2018)
tracking_2019 <- filter(tracking_overall, season==2019)
tracking_2020 <- filter(tracking_overall, season==2020)