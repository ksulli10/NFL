# create individual dfs for rush td for each season
for (year in c(2009:2018)) {
  assign(paste("rush_td_vs_expected", year, sep = "_"),
         clean_rush_td_vs_expected(year))
}

# bind stats ungrouped
rush_td_vs_expected_overall_ungrouped <-
  rbind(
    rush_td_vs_expected_2009,
    rush_td_vs_expected_2010,
    rush_td_vs_expected_2011,
    rush_td_vs_expected_2012,
    rush_td_vs_expected_2013,
    rush_td_vs_expected_2014,
    rush_td_vs_expected_2015,
    rush_td_vs_expected_2016,
    rush_td_vs_expected_2017,
    rush_td_vs_expected_2018
  )

# bind stats grouped by player
rush_td_vs_expected_overall_grouped <-
  rbind(
    rush_td_vs_expected_2009,
    rush_td_vs_expected_2010,
    rush_td_vs_expected_2011,
    rush_td_vs_expected_2012,
    rush_td_vs_expected_2013,
    rush_td_vs_expected_2014,
    rush_td_vs_expected_2015,
    rush_td_vs_expected_2016,
    rush_td_vs_expected_2017,
    rush_td_vs_expected_2018
  ) %>%
  group_by(rusher_player_id, Player, Pos) %>%
  summarise(
    player_rush_att = sum(player_rush_att),
    actual_rush_tds = sum(actual_rush_tds),
    expected_rush_tds = sum(expected_rush_tds),
    tds_over_expectation = sum(actual_rush_tds - expected_rush_tds),
    tds_over_expectation_per_att = round(sum(actual_rush_tds - expected_rush_tds) / sum(player_rush_att), 4)
  ) %>%
  ungroup()