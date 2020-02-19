# calculate annual series success rate from 1st and 10
# win probability < 80% and > 20%
# more than 5 minutes left in game
# outside the red zone
# takes season as input, e.g. "2018"
accept_or_nah_1st_10 <- function(season) {
  
  # create df name based on season input
  # requires existence of "pbp_20XX" named file
  pbp_input <- paste("pbp", season, sep = "_")
  pbp_input <- get(pbp_input)
  
  output <- filter(
    pbp_input,
    .2 < wp,
    wp < .8,
    yardline_100 > 20,
    game_seconds_remaining > 300,
    down == 1,
    ydstogo == 10,
    !is.na(series_success)
  )
  
  mean <- mean(output$series_success)
  
  return (mean)
}





# calculate annual series success rate from 1st and 15
# win probability < 80% and > 20%
# more than 5 minutes left in game
# outside the red zone
# takes season as input, e.g. "2018"
accept_or_nah_1st_15 <- function(season) {

  # create df name based on season input
  # requires existence of "pbp_20XX" named file
  pbp_input <- paste("pbp", season, sep = "_")
  pbp_input <- get(pbp_input)
  
  output <- filter(
    pbp_input,
    .2 < wp,
    wp < .8,
    yardline_100 > 20,
    game_seconds_remaining > 300,
    down == 1,
    ydstogo == 15,
    !is.na(series_success)
    )
  
  mean <- mean(output$series_success)
  
  return (mean)
}







# calculate annual series success rate from 2nd and 10
# win probability < 80% and > 20%
# more than 5 minutes left in game
# outside the red zone
# takes season as input, e.g. "2018"
accept_or_nah_2nd_10 <- function(season) {
  
  # create df name based on season input
  # requires existence of "pbp_20XX" named file
  pbp_input <- paste("pbp", season, sep = "_")
  pbp_input <- get(pbp_input)
  
  output <- filter(
    pbp_input,
    .2 < wp,
    wp < .8,
    yardline_100 > 20,
    game_seconds_remaining > 300,
    down == 2,
    ydstogo == 10,
    !is.na(series_success)
  )
  
  mean <- mean(output$series_success)
  
  return (mean)
}