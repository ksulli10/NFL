# create individual dfs for pass td for each season
for (year in c(2009:2018)) {
  assign(paste("pass_td_vs_expected", year, sep = "_"),
         clean_pass_td_vs_expected(year))
  assign(paste("rush_td_vs_expected", year, sep = "_"),
         clean_rush_td_vs_expected(year))
  assign(paste("rec_td_vs_expected", year, sep = "_"),
         clean_rec_td_vs_expected(year))
}




# bind pass stats ungrouped
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

# bind pass stats grouped by player
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
    expected_pass_tds = sum(expected_pass_tds),
    actual_pass_tds = sum(actual_pass_tds),
    tds_over_expectation = sum(actual_pass_tds - expected_pass_tds),
    tds_over_expectation_per_att = round(sum(actual_pass_tds - expected_pass_tds) / sum(player_pass_att), 4)
  ) %>%
  ungroup()




# bind rush stats ungrouped
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

# bind rush stats grouped by player
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
    expected_rush_tds = sum(expected_rush_tds),
    actual_rush_tds = sum(actual_rush_tds),
    tds_over_expectation = sum(actual_rush_tds - expected_rush_tds),
    tds_over_expectation_per_att = round(sum(actual_rush_tds - expected_rush_tds) / sum(player_rush_att), 4)
  ) %>%
  ungroup()




# bind receiving stats ungrouped
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

# bind receiving stats grouped by player
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
    expected_rec_tds = sum(expected_rec_tds),
    actual_rec_tds = sum(actual_rec_tds),
    tds_over_expectation = sum(actual_rec_tds - expected_rec_tds),
    tds_over_expectation_per_att = round(sum(actual_rec_tds - expected_rec_tds) / sum(player_rec_att), 4)
  ) %>%
  ungroup()




# combine rec and rush for skill stats, ungrouped
skill_td_vs_expected_overall_ungrouped <-
  full_join(
    rush_td_vs_expected_overall_ungrouped,
    rec_td_vs_expected_overall_ungrouped,
    by = c("rusher_player_id" = "receiver_player_id", "Player", "Year", "Team", "Pos")
  ) %>%
  mutate_all(~ replace(., is.na(.), 0)) %>%
  mutate(
    "player_id" = rusher_player_id,
    "rushes_and_targets" = player_rush_att + player_rec_att,
    "expected_tds" = expected_rush_tds + expected_rec_tds,
    "actual_tds" = actual_rush_tds + actual_rec_tds,
    "tds_over_expectation" = actual_tds - expected_tds,
    "tds_over_expectation_per_att" = round(tds_over_expectation / rushes_and_targets, 4)
  ) %>%
  select(
    player_id,
    Year,
    Player,
    Team,
    Pos,
    rushes_and_targets,
    expected_tds,
    actual_tds,
    tds_over_expectation,
    tds_over_expectation_per_att
  )

# combine rec and rush for skill stats, grouped
skill_td_vs_expected_overall_grouped <-
  full_join(
    rush_td_vs_expected_overall_ungrouped,
    rec_td_vs_expected_overall_ungrouped,
    by = c("rusher_player_id" = "receiver_player_id", "Player", "Year", "Team", "Pos")
  ) %>%
  mutate_all(~ replace(., is.na(.), 0)) %>%
  mutate(
    "player_id" = rusher_player_id,
    "rushes_and_targets" = player_rush_att + player_rec_att,
    "expected_tds" = expected_rush_tds + expected_rec_tds,
    "actual_tds" = actual_rush_tds + actual_rec_tds,
    "tds_over_expectation" = actual_tds - expected_tds,
    "tds_over_expectation_per_att" = round(tds_over_expectation / rushes_and_targets, 4)
  ) %>%
  select(
    player_id,
    Year,
    Player,
    Team,
    Pos,
    rushes_and_targets,
    expected_tds,
    actual_tds,
    tds_over_expectation,
    tds_over_expectation_per_att
  ) %>%
  group_by(player_id, Player, Pos) %>%
  summarise(
    rushes_and_targets = sum(rushes_and_targets),
    expected_tds = sum(expected_tds),
    actual_tds = sum(actual_tds),
    tds_over_expectation = sum(actual_tds - expected_tds),
    tds_over_expectation_per_att = round(sum(actual_tds - expected_tds) / sum(rushes_and_targets), 4)
  ) %>%
  ungroup()
  