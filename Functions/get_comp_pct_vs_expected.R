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
get_comp_pct_vs_expected <- function(season) {
  # create data frame variable based on season input, e.g. "2018" -> "pbp_2018"
  pbp_input <- paste("pbp", season, sep = "_")
  # load data frame into local variable
  pbp_input <- get(pbp_input)
  
  # get overall completion percentage stats for all available pbp data
  # these are used for calculating the expectation
  source("Functions/get_comp_pct_stats.R")
  comp_pct_stats_overall <-
    get_comp_pct_stats(season)
  
  # calculate completions by air yards for player
  all_pass_completions <-
    filter(pbp_input,
           complete_pass == 1,
           play_type == "pass",
           !is.na(air_yards)) %>%
    group_by(passer_player_id, air_yards, play_type) %>%
    dplyr::summarise(actual_pass_completions = n()) %>%
    ungroup()
  
  # calculate total attempts by air yards for player
  all_pass_att <-
    filter(
      pbp_input,
      play_type == "pass",
      !grepl("thrown away", desc),
      !grepl("Thrown away", desc),
      !grepl("throws ball away", desc),
      !is.na(air_yards)
    ) %>%
    group_by(passer_player_id, air_yards, play_type) %>%
    dplyr::summarise(player_pass_att = n()) %>%
    ungroup()
  
  # merge attempts to all_pass_completions
  all_pass_completions <-
    right_join(all_pass_completions,
               all_pass_att,
               by = c("passer_player_id", "air_yards")) %>%
    select(passer_player_id,
           air_yards,
           actual_pass_completions,
           player_pass_att)
  
  # set NA to 0 and remove player_id 1
  all_pass_completions <-
    mutate_all(all_pass_completions, ~ replace(., is.na(.), 0)) %>%
    filter(passer_player_id != "1")
  
  # calculate expected completions for player
  all_expected_comp <-
    left_join(all_pass_att,
              comp_pct_stats_overall,
              by = c("air_yards")) %>%
    select(passer_player_id,
           air_yards,
           player_pass_att,
           pass_comp_rate) %>%
    mutate(expected_completions = round(player_pass_att * pass_comp_rate, 4))
  
  # change anything NA to a 0
  all_expected_comp <-
    mutate_all(all_expected_comp, ~ replace(., is.na(.), 0))
  
  # sum the expected completions
  pass_comp_sum <-
    group_by(all_expected_comp, passer_player_id) %>%
    dplyr::summarise(expected_completions = round(sum(expected_completions), 2)) %>%
    ungroup()
  
  # sum the actual completions
  all_pass_completions <-
    group_by(all_pass_completions, passer_player_id) %>%
    dplyr::summarise(
      actual_pass_completions = sum(actual_pass_completions),
      player_pass_att = sum(player_pass_att)
    ) %>%
    ungroup()
  
  # join tables to format output
  # calculate actual and expected values
  output <-
    left_join(pass_comp_sum, all_pass_completions, by = "passer_player_id") %>%
    select(
      passer_player_id,
      player_pass_att,
      expected_completions,
      actual_pass_completions
    ) %>%
    mutate(
      actual_comp_pct = round(100 * actual_pass_completions / player_pass_att, 2),
      expected_comp_pct = round(100 * expected_completions / player_pass_att, 2),
      cpoe = actual_comp_pct - expected_comp_pct
    ) %>%
    filter(passer_player_id != "0")
  
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
              by = c("passer_player_id" = "playerID"))  %>%
    select(
      passer_player_id,
      # Season,
      Team,
      # Pos,
      name,
      player_pass_att,
      actual_completions = actual_pass_completions,
      actual_comp_pct,
      expected_completions,
      expected_comp_pct,
      cpoe
    )
  
  # # filter NAs
  # output <- filter(output, !is.na(Season))
  
  # return completed data frame
  return(output)
}