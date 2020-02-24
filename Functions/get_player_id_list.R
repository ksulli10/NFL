####
#### Requirements:
####    1.  nflscrapR player stats data frame
####        (created from nflscrapR season_player_game function.)
####        (named "playerstats##" e.g. "playerstats18")
####


get_player_id_list <- function(season) {
  
  # create playerstats variable
  playerstats_file <- paste("playerstats", season, sep = "_")
  # import the data frame
  playerstats_file <- get(playerstats_file)
  
  # create list of player ids and their teams
  output <-
    group_by(playerstats_file, Team, playerID, name) %>%
    summarise() %>%
    ungroup(playerstats_file) %>%
    na.omit()
  
  return(output)
}