# takes player stats df as input, e.g. playerstats_2009
get_player_id_list_unique <- function(playerstats_input) {
  
  # create list of player ids and their teams
  output <-
    group_by(playerstats_input, playerID, name) %>%
    summarise() %>%
    ungroup(playerstats_input) %>%
    na.omit()
  
  return(output)
}