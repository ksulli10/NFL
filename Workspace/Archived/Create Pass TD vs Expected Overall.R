# create individual dfs for pass td for each season
for (year in c(2009:2018)) {
  assign(paste("pass_td_vs_expected", year, sep = "_"),
         clean_pass_td_vs_expected(year))
}

# bind stats ungrouped
pass_td_vs_expected_overall_ungrouped <-
  rbind(
    pass_td_vs_expected_2009,
    pass_td_vs_expected_2010,
    pass_td_vs_expected_2011,
    pass_td_vs_expected_2012,
    pass_td_vs_expected_2013,
    pass_td_vs_expected_2014,
    pass_td_vs_expected_2015,
    pass_td_vs_expected_2016,
    pass_td_vs_expected_2017,
    pass_td_vs_expected_2018
  )

# bind stats grouped by player
pass_td_vs_expected_overall_grouped <-
  rbind(
    pass_td_vs_expected_2009,
    pass_td_vs_expected_2010,
    pass_td_vs_expected_2011,
    pass_td_vs_expected_2012,
    pass_td_vs_expected_2013,
    pass_td_vs_expected_2014,
    pass_td_vs_expected_2015,
    pass_td_vs_expected_2016,
    pass_td_vs_expected_2017,
    pass_td_vs_expected_2018
  ) %>%
  group_by(passer_player_id, Player, Pos) %>%
  summarise(
    player_pass_att = sum(player_pass_att),
    actual_pass_tds = sum(actual_pass_tds),
    expected_pass_tds = sum(expected_pass_tds),
    tds_over_expectation = sum(actual_pass_tds - expected_pass_tds),
    tds_over_expectation_per_att = round(sum(actual_pass_tds - expected_pass_tds) / sum(player_pass_att), 4)
  ) %>%
  ungroup()