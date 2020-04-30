ss_2019 <-
  data.frame(
    season = "2019",
    series_success_1_15 = series_success_aggregate(2019, yds = 15),
    series_success_2_10 = series_success_aggregate(2019, dwn = 2)
  )
ss_2018 <-
  data.frame(
    season = "2018",
    series_success_1_15 = series_success_aggregate(2018, yds = 15),
    series_success_2_10 = series_success_aggregate(2018, dwn = 2)
  )
ss_2017 <-
  data.frame(
    season = "2017",
    series_success_1_15 = series_success_aggregate(2017, yds = 15),
    series_success_2_10 = series_success_aggregate(2017, dwn = 2)
  )
ss_2016 <-
  data.frame(
    season = "2016",
    series_success_1_15 = series_success_aggregate(2016, yds = 15),
    series_success_2_10 = series_success_aggregate(2016, dwn = 2)
  )
ss_2015 <-
  data.frame(
    season = "2015",
    series_success_1_15 = series_success_aggregate(2015, yds = 15),
    series_success_2_10 = series_success_aggregate(2015, dwn = 2)
  )
ss_2014 <-
  data.frame(
    season = "2014",
    series_success_1_15 = series_success_aggregate(2014, yds = 15),
    series_success_2_10 = series_success_aggregate(2014, dwn = 2)
  )
ss_2013 <-
  data.frame(
    season = "2013",
    series_success_1_15 = series_success_aggregate(2013, yds = 15),
    series_success_2_10 = series_success_aggregate(2013, dwn = 2)
  )
ss_2012 <-
  data.frame(
    season = "2012",
    series_success_1_15 = series_success_aggregate(2012, yds = 15),
    series_success_2_10 = series_success_aggregate(2012, dwn = 2)
  )
ss_2011 <-
  data.frame(
    season = "2011",
    series_success_1_15 = series_success_aggregate(2011, yds = 15),
    series_success_2_10 = series_success_aggregate(2011, dwn = 2)
  )
ss_2010 <-
  data.frame(
    season = "2010",
    series_success_1_15 = series_success_aggregate(2010, yds = 15),
    series_success_2_10 = series_success_aggregate(2010, dwn = 2)
  )
ss_2009 <-
  data.frame(
    season = "2009",
    series_success_1_15 = series_success_aggregate(2009, yds = 15),
    series_success_2_10 = series_success_aggregate(2009, dwn = 2)
  )


#
# create overall ss data frame
#
ss_overall <-
  rbind.fill(
    ss_2009,
    ss_2010,
    ss_2011,
    ss_2012,
    ss_2013,
    ss_2014,
    ss_2015,
    ss_2016,
    ss_2017,
    ss_2018,
    ss_2019
  )

remove(ss_2009)
remove(ss_2010)
remove(ss_2011)
remove(ss_2012)
remove(ss_2013)
remove(ss_2014)
remove(ss_2015)
remove(ss_2016)
remove(ss_2017)
remove(ss_2018)
remove(ss_2019)