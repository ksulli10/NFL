# create individual dfs for rush, pass, and rec for each season
for (year in c(2009:2018)) {
  assign(paste("yardline_rush_stats", year, sep = "_"),
         get_yardline_rush_stats(year))
  assign(paste("yardline_pass_stats", year, sep = "_"),
         get_yardline_pass_stats(year))
  assign(paste("yardline_rec_stats", year, sep = "_"),
         get_yardline_rec_stats(year))
}


# create overall rush stats df
yardline_rush_stats_overall <- rbind(
  yardline_rush_stats_2009,
  yardline_rush_stats_2010,
  yardline_rush_stats_2011,
  yardline_rush_stats_2012,
  yardline_rush_stats_2013,
  yardline_rush_stats_2014,
  yardline_rush_stats_2015,
  yardline_rush_stats_2016,
  yardline_rush_stats_2017,
  yardline_rush_stats_2018
) %>%
  group_by(yardline_100) %>%
  summarise(
    rush_tds = sum(rush_tds),
    rush_att = sum(rush_att),
    rush_td_rate = round(sum(rush_tds) / sum(rush_att), 4)
  )


# create overall pass stats df
yardline_pass_stats_overall <- rbind(
  yardline_pass_stats_2009,
  yardline_pass_stats_2010,
  yardline_pass_stats_2011,
  yardline_pass_stats_2012,
  yardline_pass_stats_2013,
  yardline_pass_stats_2014,
  yardline_pass_stats_2015,
  yardline_pass_stats_2016,
  yardline_pass_stats_2017,
  yardline_pass_stats_2018
) %>%
  group_by(yardline_100, air_yards) %>%
  summarise(
    pass_tds = sum(pass_tds),
    pass_att = sum(pass_att),
    pass_td_rate = round(sum(pass_tds) / sum(pass_att), 4)
  )


# create overall rec stats df
yardline_rec_stats_overall <- rbind(
  yardline_rec_stats_2009,
  yardline_rec_stats_2010,
  yardline_rec_stats_2011,
  yardline_rec_stats_2012,
  yardline_rec_stats_2013,
  yardline_rec_stats_2014,
  yardline_rec_stats_2015,
  yardline_rec_stats_2016,
  yardline_rec_stats_2017,
  yardline_rec_stats_2018
) %>%
  group_by(yardline_100, air_yards) %>%
  summarise(
    rec_tds = sum(rec_tds),
    rec_att = sum(rec_att),
    rec_td_rate = round(sum(rec_tds) / sum(rec_att), 4)
  )