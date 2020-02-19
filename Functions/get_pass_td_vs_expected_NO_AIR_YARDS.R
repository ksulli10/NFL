# takes play by play df as input, e.g. "pbp_2018"
get_pass_td_vs_expected_NO_AIR_YARDS <- function(season) {
  
  # create df name based on season input
  # requires existence of "pbp_20XX" named file
  pbp_input <- paste("pbp", season, sep = "_")
  pbp_input <- get(pbp_input)  
  
  # update unique player id list
  player_id_list_unique_overall <- get_player_id_list_unique(playerstats_overall)
  
  # update team player id list
  player_id_list_overall <- get_player_id_list(playerstats_overall)
  
  # calculate pass tds per player
  all_pass_tds <-
    filter(pbp_input,
           pass_touchdown == 1,
           play_type == "pass",) %>%
    select(passer_player_id, pass_touchdown, play_type) %>%
    group_by(passer_player_id) %>%
    summarise(actual_pass_tds = sum(pass_touchdown)) %>%
    ungroup(all_pass_tds)
  
  # add player names
  all_pass_tds <-
    right_join(
      all_pass_tds,
      player_id_list_unique_overall,
      by = c("passer_player_id" = "playerID")
    )
  
  # set NA to 0 and remove faulty player id
  all_pass_tds <-
    mutate_all(all_pass_tds, ~ replace(., is.na(.), 0)) %>%
    filter(passer_player_id != "1")
  
  # calculate total attempts by yard line for player
  all_att_by_yardline <-
    filter(pbp_input,
           play_type == "pass",) %>%
    group_by(passer_player_id, yardline_100, play_type) %>%
    summarise(player_pass_att = n()) %>%
    ungroup(all_att_by_yardline)
  
  # sum the total attempts
  pass_att_sum <-
    group_by(all_att_by_yardline, passer_player_id) %>%
    summarise(player_pass_att = sum(player_pass_att)) %>%
    ungroup(pass_att_sum)
  
  # merge to all_pass_tds
  all_pass_tds <-
    left_join(all_pass_tds, pass_att_sum, by = "passer_player_id")
  
  # calculate expected tds by yard line for player
  all_expected_tds_by_yardline <-
    left_join(all_att_by_yardline, yardline_stats_overall, by = "yardline_100") %>%
    select(passer_player_id,
           yardline_100,
           player_pass_att,
           pass_td_rate) %>%
    mutate(expected_pass_tds = round(player_pass_att * pass_td_rate, 4))
  
  # sum the expected TDs
  pass_td_sum <-
    group_by(all_expected_tds_by_yardline, passer_player_id) %>%
    summarise(expected_pass_tds = round(sum(expected_pass_tds), 2)) %>%
    ungroup(pass_td_sum)
  
  # join tables to format output
  output <-
    left_join(pass_td_sum, all_pass_tds, by = "passer_player_id") %>%
    select(passer_player_id, name, player_pass_att, expected_pass_tds, actual_pass_tds) %>%
    mutate(
      tds_over_expectation = actual_pass_tds - expected_pass_tds,
      pct_against_expectation = 100 * round(tds_over_expectation / expected_pass_tds, 2),
      tds_over_expectation_per_att = round(tds_over_expectation / player_pass_att, 4)
    ) %>% 
    filter(passer_player_id != "0")
  
  return(output)
}