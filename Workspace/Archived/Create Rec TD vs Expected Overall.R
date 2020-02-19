# create individual dfs for rec td for each season
for (year in c(2009:2018)) {
  assign(paste("rec_td_vs_expected", year, sep = "_"),
         clean_rec_td_vs_expected(year))
}

# bind stats ungrouped
rec_td_vs_expected_overall_ungrouped <-
  rbind(
    rec_td_vs_expected_2009,
    rec_td_vs_expected_2010,
    rec_td_vs_expected_2011,
    rec_td_vs_expected_2012,
    rec_td_vs_expected_2013,
    rec_td_vs_expected_2014,
    rec_td_vs_expected_2015,
    rec_td_vs_expected_2016,
    rec_td_vs_expected_2017,
    rec_td_vs_expected_2018
  )

# bind stats grouped by player
rec_td_vs_expected_overall_grouped <-
  rbind(
    rec_td_vs_expected_2009,
    rec_td_vs_expected_2010,
    rec_td_vs_expected_2011,
    rec_td_vs_expected_2012,
    rec_td_vs_expected_2013,
    rec_td_vs_expected_2014,
    rec_td_vs_expected_2015,
    rec_td_vs_expected_2016,
    rec_td_vs_expected_2017,
    rec_td_vs_expected_2018
  ) %>%
  group_by(receiver_player_id, Player, Pos) %>%
  summarise(
    player_rec_att = sum(player_rec_att),
    actual_rec_tds = sum(actual_rec_tds),
    expected_rec_tds = sum(expected_rec_tds),
    tds_over_expectation = sum(actual_rec_tds - expected_rec_tds),
    tds_over_expectation_per_att = round(sum(actual_rec_tds - expected_rec_tds) / sum(player_rec_att), 4)
  ) %>%
  ungroup()