####
#### Requirements:
####    1.  nflscrapR rosters data frame
####        (named "rosters_####" e.g. "rosters_2018")
####    2.  nflscrapR playerstats data frame
####        (named "playerstats_####" e.g. "playerstats_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define function
get_player_id_list <- function(season) {
  # create playerstats variable
  playerstats_file <- paste("playerstats", season, sep = "_")
  # import the playerstats data frame
  playerstats_file <- get(playerstats_file)
  # remove playerID == 1
  playerstats_file <- filter(playerstats_file, playerID != 1)
  # create rosters variable
  rosters_file <- paste("rosters", season, sep = "_")
  # import the rosters data frame
  rosters_file <- get(rosters_file)
  
  # create list of player ids and their teams
  output <-
    group_by(playerstats_file, playerID) %>%
    select(Season, playerID, Team, name)
  
  # add positions
  output <-
    left_join(output,
              rosters_file,
              by = c("playerID" = "GSIS_ID", "Season", "Team", "name")) %>%
    select(Season, playerID, Team, Pos, Player, name)
  
  # remove duplicates
  output <-
    distinct(output, playerID, .keep_all = TRUE)
  
  # return output data frame
  return(output)
}