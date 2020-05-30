####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define function
get_long_shots <- function(season) {
  # create data frame variable based on season input, e.g. "2018" -> "pbp_2018"
  pbp_input <- paste("pbp", season, sep = "_")
  # load data frame into local variable
  pbp_input <- get(pbp_input)
  
  # grab all plays fitting the specified conditions
  all_plays <- filter(
    pbp_input,
    .1 < wp,
    wp < .9,
    yardline_100 > 20,
    game_seconds_remaining > 300,
    down == 2,
    play_type == "pass" | play_type == "run",
    ydstogo < 3
  )
  
  # grab all long pass plays fitting the specified conditions
  long_pass_plays <- filter(
    pbp_input,
    .1 < wp,
    wp < .9,
    yardline_100 > 20,
    game_seconds_remaining > 300,
    down == 2,
    ydstogo < 3,
    play_type == "pass",
    air_yards > 14
  )
  
  # grab all medium pass plays fitting the specified conditions
  medium_pass_plays <- filter(
    pbp_input,
    .1 < wp,
    wp < .9,
    yardline_100 > 20,
    game_seconds_remaining > 300,
    down == 2,
    ydstogo < 3,
    play_type == "pass",
    air_yards < 15,
    air_yards > 4
  )
  
  # grab all short pass plays fitting the specified conditions
  short_pass_plays <- filter(
    pbp_input,
    .1 < wp,
    wp < .9,
    yardline_100 > 20,
    game_seconds_remaining > 300,
    down == 2,
    ydstogo < 3,
    play_type == "pass",
    air_yards < 5
  )
  
  # grab all run plays fitting the specified conditions
  run_plays <- filter(
    pbp_input,
    .1 < wp,
    wp < .9,
    yardline_100 > 20,
    game_seconds_remaining > 300,
    down == 2,
    ydstogo < 3,
    play_type == "run"
  )
  
  # create vector for play_type categories
  play_type <-
    c("All Plays",
      "Runs",
      "Short Passes",
      "Medium Passes",
      "Long Passes")
  
  # create vector for total_plays
  total_plays <- c(
    nrow(all_plays),
    nrow(run_plays),
    nrow(short_pass_plays),
    nrow(medium_pass_plays),
    nrow(long_pass_plays)
  )
  
  # create vector for epa per play
  epa_per_play <- c(
    mean(all_plays$epa, na.rm = TRUE),
    mean(run_plays$epa, na.rm = TRUE),
    mean(short_pass_plays$epa, na.rm = TRUE),
    mean(medium_pass_plays$epa, na.rm = TRUE),
    mean(long_pass_plays$epa, na.rm = TRUE)
  )
  
  # create vector for yards gained on average
  yards_gained_per_play <- c(
    mean(all_plays$yards_gained, na.rm = TRUE),
    mean(run_plays$yards_gained, na.rm = TRUE),
    mean(short_pass_plays$yards_gained, na.rm = TRUE),
    mean(medium_pass_plays$yards_gained, na.rm = TRUE),
    mean(long_pass_plays$yards_gained, na.rm = TRUE)
  )
  
  # create vector for first down rates
  first_down_pct <- c(
    mean(
      all_plays$first_down_pass + all_plays$first_down_rush,
      na.rm = TRUE
    ),
    mean(run_plays$first_down_rush,
         na.rm = TRUE),
    mean(short_pass_plays$first_down_pass,
         na.rm = TRUE),
    mean(medium_pass_plays$first_down_pass,
         na.rm = TRUE),
    mean(long_pass_plays$first_down_pass,
         na.rm = TRUE)
  )
  
  # create vector for series success rates
  series_success_rate <- c(
    mean(all_plays$series_success, na.rm = TRUE),
    mean(run_plays$series_success, na.rm = TRUE),
    mean(short_pass_plays$series_success, na.rm = TRUE),
    mean(medium_pass_plays$series_success, na.rm = TRUE),
    mean(long_pass_plays$series_success, na.rm = TRUE)
  )
  
  # put vectors into output dataframe
  output <-
    data.frame(
      play_type,
      total_plays,
      epa_per_play,
      yards_gained_per_play,
      first_down_pct,
      series_success_rate
    )
  
  # return output dataframe
  return(output)
}