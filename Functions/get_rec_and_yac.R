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
get_rec_and_yac <- function(season) {
  # create data frame variable based on season input, e.g. "2018" -> "pbp_2018"
  pbp_input <- paste("pbp", season, sep = "_")
  # load data frame into local variable
  pbp_input <- get(pbp_input)
  
  # create data frame containing all player IDs for the given season
  source("Functions/get_player_id_list.R")
  player_id_list <- get_player_id_list(season)
  
  # filter to completed pass plays
  # sum the receptions and yac
  output <-
    filter(pbp_input, play_type == "pass", !is.na(yards_after_catch)) %>%
    group_by(receiver_player_id) %>%
    dplyr::summarise(
      receptions = n(),
      total_yac = sum(yards_after_catch),
      yac_per_reception = round(total_yac / receptions, 3)
    ) %>%
    ungroup()
  
  # add full names, positions, teams
  output <-
    left_join(output,
              player_id_list,
              by = c("receiver_player_id" = "playerID"))
  
  # reorganize columns
  output <-
    select(output,
           receiver_player_id,
           Season,
           Team,
           name,
           # Pos,
           receptions,
           total_yac,
           yac_per_reception)
  
  # remove NA
  output <- na.omit(output)
  
  # remove duplicates
  output <-
    distinct(output, receiver_player_id, .keep_all = TRUE)
  
  # return output data frame
  return(output)
}
