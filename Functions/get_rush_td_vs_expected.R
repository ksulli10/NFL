# takes play by play df as input, e.g. "pbp_2018"
get_rush_td_vs_expected <- function(season) {

  # create df name based on season input
  # requires existence of "pbp_20XX" named file
  pbp_input <- paste("pbp", season, sep = "_")
  pbp_input <- get(pbp_input)  
  
  # update unique player id list
  player_id_list_unique_overall <- get_player_id_list_unique(playerstats_overall)
  
  # update team player id list (not used in function)
  player_id_list_overall <- get_player_id_list(playerstats_overall)
  
  # calculate rush tds per player
  all_rush_tds <-
    filter(pbp_input,
           rush_touchdown == 1,
           play_type == "run",) %>%
    select(rusher_player_id, rush_touchdown, play_type) %>%
    group_by(rusher_player_id) %>%
    summarise(actual_rush_tds = sum(rush_touchdown)) %>%
    ungroup(all_rush_tds)
  
  # add player names
  all_rush_tds <-
    right_join(
      all_rush_tds,
      player_id_list_unique_overall,
      by = c("rusher_player_id" = "playerID")
    )
  
  # set NA to 0 and remove faulty player id
  all_rush_tds <-
    mutate_all(all_rush_tds, ~ replace(., is.na(.), 0)) %>%
    filter(rusher_player_id != "1")
  
  # calculate total attempts by yard line for player
  all_att_by_yardline <-
    filter(pbp_input,
           play_type == "run",) %>%
    group_by(rusher_player_id, yardline_100, play_type) %>%
    summarise(player_rush_att = n()) %>%
    ungroup(all_att_by_yardline)
  
  # sum the total attempts
  rush_att_sum <-
    group_by(all_att_by_yardline, rusher_player_id) %>%
    summarise(player_rush_att = sum(player_rush_att)) %>%
    ungroup(rush_att_sum)
  
  # merge to all_rush_tds
  all_rush_tds <-
    left_join(all_rush_tds, rush_att_sum, by = "rusher_player_id")
  
  # calculate expected tds by yard line for player
  all_expected_tds_by_yardline <-
    left_join(all_att_by_yardline, yardline_stats_overall, by = "yardline_100") %>%
    select(rusher_player_id,
           yardline_100,
           player_rush_att,
           rush_td_rate) %>%
    mutate(expected_rush_tds = round(player_rush_att * rush_td_rate, 4))
  
  # sum the expected TDs
  rush_td_sum <-
    group_by(all_expected_tds_by_yardline, rusher_player_id) %>%
    summarise(expected_rush_tds = round(sum(expected_rush_tds), 2)) %>%
    ungroup(rush_td_sum)
  
  # join tables to format output
  output <-
    left_join(rush_td_sum, all_rush_tds, by = "rusher_player_id") %>%
    select(rusher_player_id, name, player_rush_att, expected_rush_tds, actual_rush_tds) %>%
    mutate(
      tds_over_expectation = actual_rush_tds - expected_rush_tds,
      pct_against_expectation = 100 * round(tds_over_expectation / expected_rush_tds, 2),
      tds_over_expectation_per_att = round(tds_over_expectation / player_rush_att, 4)
    ) %>% 
    filter(rusher_player_id != "0")
  
  return(output)
}