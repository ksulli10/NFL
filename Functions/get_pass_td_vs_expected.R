####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####

get_pass_td_vs_expected <- function(season) {
  
  # create df name based on season input
  # requires existence of "pbp_20XX" named file
  pbp_input <- paste("pbp", season, sep = "_")
  pbp_input <- get(pbp_input)
  
  # get yardline pass stats
  source("Functions/get_yardline_pass_stats.R")
  yardline_pass_stats_overall <- get_yardline_pass_stats("data_overall")
  
  # get player id list
  source("Functions/get_player_id_list.R")
    player_id_list_unique_overall <-
    get_player_id_list("overall")
  
  
  # remove duplicates
  player_id_list_unique_overall <-
    distinct(player_id_list_unique_overall, playerID, .keep_all = TRUE)
  
  
  # calculate pass tds per player by yard line and air yards
  all_pass_tds <-
    filter(pbp_input,
           pass_touchdown == 1,
           play_type == "pass",
           !is.na(air_yards)) %>%
    group_by(passer_player_id, yardline_100, air_yards, play_type) %>%
    summarise(actual_pass_tds = n()) %>%
    ungroup(all_att_by_yardline)
  
  
  # add player names
  all_pass_tds <-
    left_join(
      all_pass_tds,
      player_id_list_unique_overall,
      by = c("passer_player_id" = "playerID")
    )
  
  
  # calculate total attempts by yard line and air yards for player
  all_att_by_yardline <-
    filter(pbp_input,
           play_type == "pass", !is.na(air_yards)) %>%
    group_by(passer_player_id, yardline_100, air_yards, play_type) %>%
    summarise(player_pass_att = n()) %>%
    ungroup(all_att_by_yardline)
  
  
  # merge to all_pass_tds
  all_pass_tds <-
    right_join(
      all_pass_tds,
      all_att_by_yardline,
      by = c("passer_player_id", "yardline_100", "air_yards")
    ) %>%
    select(passer_player_id,
           yardline_100,
           air_yards,
           actual_pass_tds,
           player_pass_att)
  
  
  # set NA to 0
  all_pass_tds <-
    mutate_all(all_pass_tds, ~ replace(., is.na(.), 0)) %>%
    filter(passer_player_id != "1")
  
  
  # calculate expected tds by yard line for player
  all_expected_tds_by_yardline <-
    left_join(
      all_att_by_yardline,
      yardline_pass_stats_overall,
      by = c("yardline_100", "air_yards")
    ) %>%
    select(passer_player_id,
           yardline_100,
           air_yards,
           player_pass_att,
           pass_td_rate) %>%
    mutate(expected_pass_tds = round(player_pass_att * pass_td_rate, 4))
  
  
  # sum the expected TDs
  pass_td_sum <-
    group_by(all_expected_tds_by_yardline, passer_player_id) %>%
    summarise(expected_pass_tds = round(sum(expected_pass_tds), 2)) %>%
    ungroup(pass_td_sum)
  
  
  # sum the actual TDs
  all_pass_tds <-
    group_by(all_pass_tds, passer_player_id) %>%
    summarise(
      actual_pass_tds = sum(actual_pass_tds),
      player_pass_att = sum(player_pass_att)
    ) %>%
    ungroup(all_pass_tds)
  
  
  # join tables to format output
  output <-
    left_join(pass_td_sum, all_pass_tds, by = "passer_player_id") %>%
    select(passer_player_id,
           player_pass_att,
           expected_pass_tds,
           actual_pass_tds) %>%
    mutate(
      tds_over_expectation = actual_pass_tds - expected_pass_tds,
      tds_over_expectation_per_att = round(tds_over_expectation / player_pass_att, 4)
    ) %>%
    filter(passer_player_id != "0")
  
  
  return(output)
}