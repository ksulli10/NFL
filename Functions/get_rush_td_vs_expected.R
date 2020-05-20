####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####    2.  nflscrapR playerstats data frame
####        (named "playerstats_####" e.g. "playerstats_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define function
get_rush_td_vs_expected <- function(season) {
  # create data frame variable based on season input, e.g. "2018" -> "pbp_2018"
  pbp_input <- paste("pbp", season, sep = "_")
  # load data frame into local variable
  pbp_input <- get(pbp_input)
  
  # get overall yardline rush stats for all available pbp data
  # these are used for calculating the expectation
  source("Functions/get_yardline_rush_td_stats.R")
  yardline_rush_td_stats_overall <-
    get_yardline_rush_td_stats(season)
  
  # calculate rush tds per player by yard line
  all_rush_tds <-
    filter(pbp_input,
           rush_touchdown == 1,
           play_type == "run") %>%
    group_by(rusher_player_id, yardline_100, play_type) %>%
    dplyr::summarise(actual_rush_tds = n()) %>%
    ungroup(all_att_by_yardline)
  
  # calculate total attempts by yard line for player
  all_att_by_yardline <-
    filter(pbp_input,
           play_type == "run") %>%
    group_by(rusher_player_id, yardline_100, play_type) %>%
    dplyr::summarise(player_rush_att = n()) %>%
    ungroup(all_att_by_yardline)
  
  # merge to all_rec_tds
  all_rush_tds <-
    right_join(all_rush_tds,
               all_att_by_yardline,
               by = c("rusher_player_id", "yardline_100")) %>%
    select(rusher_player_id,
           yardline_100,
           actual_rush_tds,
           player_rush_att)
  
  # set NA to 0
  all_rush_tds <-
    mutate_all(all_rush_tds, ~ replace(., is.na(.), 0)) %>%
    filter(rusher_player_id != "1")
  
  # calculate expected tds by yard line for player
  all_expected_tds_by_yardline <-
    left_join(all_att_by_yardline,
              yardline_rush_td_stats_overall,
              by = c("yardline_100")) %>%
    select(rusher_player_id,
           yardline_100,
           player_rush_att,
           rush_td_rate) %>%
    mutate(expected_rush_tds = round(player_rush_att * rush_td_rate, 4))
  
  # change anything NA to a 0
  all_expected_tds_by_yardline <-
    mutate_all(all_expected_tds_by_yardline, ~ replace(., is.na(.), 0))
  
  # sum the expected TDs
  rush_td_sum <-
    group_by(all_expected_tds_by_yardline, rusher_player_id) %>%
    dplyr::summarise(expected_rush_tds = round(sum(expected_rush_tds), 2)) %>%
    ungroup(rush_td_sum)
  
  # sum the actual TDs
  all_rush_tds <-
    group_by(all_rush_tds, rusher_player_id) %>%
    dplyr::summarise(
      actual_rush_tds = sum(actual_rush_tds),
      player_rush_att = sum(player_rush_att)
    ) %>%
    ungroup(all_rush_tds)
  
  # join tables to format output
  output <-
    left_join(rush_td_sum, all_rush_tds, by = "rusher_player_id") %>%
    select(rusher_player_id,
           player_rush_att,
           expected_rush_tds,
           actual_rush_tds) %>%
    mutate(
      tds_over_expectation = actual_rush_tds - expected_rush_tds,
      tds_over_expectation_per_att = round(tds_over_expectation / player_rush_att, 4)
    ) %>%
    filter(rusher_player_id != "0")
  
  # add player names
  output <-
    left_join(output,
              filter(rosters_overall, team.season==season),
              by = c("rusher_player_id" = "teamPlayers.gsisId"))  %>%
    select(
      rusher_player_id,
      "season" = team.season,
      "team" = team.abbr,
      "pos" = teamPlayers.position,
      "name" = teamPlayers.displayName,
      "rush_att" = player_rush_att,
      "exp_tds" = expected_rush_tds,
      "tds" = actual_rush_tds,
      "tds_over_exp" = tds_over_expectation,
      "tdoe_per_att" = tds_over_expectation_per_att
    )
  
  # return completed data frame
  return(output)
}