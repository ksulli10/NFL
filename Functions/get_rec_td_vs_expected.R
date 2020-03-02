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
get_rec_td_vs_expected <- function(season) {
  # create data frame variable based on season input, e.g. "2018" -> "pbp_2018"
  pbp_input <- paste("pbp", season, sep = "_")
  # load data frame into local variable
  pbp_input <- get(pbp_input)
  
  # get overall yardline rec stats for all available pbp data
  # these are used for calculating the expectation
  source("Functions/get_yardline_rec_td_stats.R")
  yardline_rec_td_stats_overall <-
    get_yardline_rec_td_stats("overall")
  
  # calculate rec tds per player by yard line and air yards
  all_rec_tds <-
    filter(pbp_input,
           pass_touchdown == 1,
           play_type == "pass",!is.na(air_yards)) %>%
    group_by(receiver_player_id, yardline_100, air_yards, play_type) %>%
    summarise(actual_rec_tds = n()) %>%
    ungroup(all_att_by_yardline)
  
  # calculate total attempts by yard line and air yards for player
  all_att_by_yardline <-
    filter(pbp_input,
           play_type == "pass",!is.na(air_yards)) %>%
    group_by(receiver_player_id, yardline_100, air_yards, play_type) %>%
    summarise(player_rec_att = n()) %>%
    ungroup(all_att_by_yardline) %>%
    na.omit
  
  # merge to all_rec_tds
  all_rec_tds <-
    right_join(
      all_rec_tds,
      all_att_by_yardline,
      by = c("receiver_player_id", "yardline_100", "air_yards")
    ) %>%
    select(receiver_player_id,
           yardline_100,
           air_yards,
           actual_rec_tds,
           player_rec_att)
  
  # set NA to 0 (most target profiles did not result in a TD at all)
  all_rec_tds <-
    mutate_all(all_rec_tds, ~ replace(., is.na(.), 0)) %>%
    filter(receiver_player_id != "1")
  
  # calculate expected tds by yard line for player
  all_expected_tds_by_yardline <-
    left_join(
      all_att_by_yardline,
      yardline_rec_td_stats_overall,
      by = c("yardline_100", "air_yards")
    ) %>%
    select(receiver_player_id,
           yardline_100,
           air_yards,
           player_rec_att,
           rec_td_rate) %>%
    mutate(expected_rec_tds = round(player_rec_att * rec_td_rate, 4))
  
  # change anything NA to a 0
  all_expected_tds_by_yardline <-
    mutate_all(all_expected_tds_by_yardline, ~ replace(., is.na(.), 0))
  
  # sum the expected TDs
  rec_td_sum <-
    group_by(all_expected_tds_by_yardline, receiver_player_id) %>%
    summarise(expected_rec_tds = round(sum(expected_rec_tds), 2)) %>%
    ungroup(rec_td_sum)
  
  # sum the actual TDs
  all_rec_tds <-
    group_by(all_rec_tds, receiver_player_id) %>%
    summarise(
      actual_rec_tds = sum(actual_rec_tds),
      player_rec_att = sum(player_rec_att)
    ) %>%
    ungroup(all_rec_tds)
  
  # join tables to format output
  output <-
    left_join(rec_td_sum, all_rec_tds, by = "receiver_player_id") %>%
    select(receiver_player_id,
           player_rec_att,
           expected_rec_tds,
           actual_rec_tds) %>%
    mutate(
      tds_over_expectation = actual_rec_tds - expected_rec_tds,
      tds_over_expectation_per_att = round(tds_over_expectation / player_rec_att, 4)
    ) %>%
    filter(receiver_player_id != "0")
  
  # create data frame containing all player IDs for the given season
  source("Functions/get_player_id_list.R")
  player_id_list <- get_player_id_list(season)
  
  # remove duplicates
  player_id_list <-
    distinct(player_id_list, playerID, .keep_all = TRUE)
  
  # add player names
  output <-
    left_join(output,
              player_id_list,
              by = c("receiver_player_id" = "playerID"))  %>%
    select(
      receiver_player_id,
      # Season,
      Team,
      # Pos,
      name,
      player_rec_att,
      expected_rec_tds,
      actual_rec_tds,
      tds_over_expectation,
      tds_over_expectation_per_att
    )
  
  # # filter NAs
  # output <- filter(output, !is.na(Season))
  
  # return completed data frame
  return(output)
}