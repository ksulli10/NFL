# get all series IDs that start in red zone
run_vs_pass_success <- function(season) {
  
  
  # create df name based on season input
  # requires existence of "player_id_list_20XX" named file
  pbp_input <- paste("pbp", season, sep = "_")
  pbp_input <- get(pbp_input)
  
  
  # find series that...
  # ... started inside the opposing 25
  # ... had WP between 10% and 90%
  # ... were not "and goal"
  # ... had more than 5 mins remaining in the game
  output <- filter(
    pbp_input,
    wp >= .1,
    wp <= .9,
    down == 1,
    yardline_100 <= 25,
    goal_to_go == 0,
    game_seconds_remaining >= 300,!is.na(series),!is.na(series_success)
  ) %>%
    select(game_id, series, series_success)
  
  
  # get total number of plays in each of the above series
  play_count_per_series <- 
    inner_join(pbp_input, output, by = c("game_id", "series", "series_success")) %>%
    filter(play_type == "pass" | play_type == "run") %>% 
    group_by(game_id, series) %>% 
    dplyr::summarise("total_count"=n())
  
  
  # remove >= 4 plays
  play_count_per_series <- filter(play_count_per_series, total_count <= 4)
  
  
  # append to first output
  output <-
    left_join(output,
              play_count_per_series,
              by = c("game_id", "series")) %>%
    na.omit()
  
  
  # get number of runs vs passes in each series
  play_sample <-
    inner_join(pbp_input, output, by = c("game_id", "series", "series_success")) %>%
    group_by(game_id, series, play_type) %>% 
    dplyr::summarise("sub_count"=n()) %>% 
    filter(play_type == "pass" | play_type == "run")
  
  
  # append play types to output
  output <- left_join(
    output, play_sample, by = c("game_id", "series"))
  
  
  # calculate percentages
  output <- mutate(output, percentage = round(sub_count/total_count,2))
  
  
  # group by percentages
  output <- group_by(output, play_type, percentage) %>% 
    summarise(series_success_rate = mean(series_success))
  
  # return output
  return(output)
}