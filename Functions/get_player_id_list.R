####
#### Requirements:
####    1.  nflscrapR playerstats data frame
####        (named "playerstats_####" e.g. "playerstats_2018")
####
####    *These files are automatically created by running "Master Project Setup.R"
####    *That script only needs to be run once.
####    *Local .rds files will be created to load from in the future (via "Local Load Setup.R")
####

# define function
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
  
  # return output data frame
  return(output)
}