# takes season as input, e.g. "2018"
get_rec_and_yac <- function(season) {
  
  # create df name based on season input
  # requires existence of "pbp_20XX" named file
  pbp_input <- paste("pbp", season, sep = "_")
  pbp_input <- get(pbp_input)
  
  # create df name based on season input
  # requires existence of "player_id_list_20XX" named file
  player_id_list <- paste("player_id_list", season, sep = "_")
  
  
  # filter to completed pass plays
  # sum the receptions and yac
  output <-
    filter(pbp_input, play_type == "pass",!is.na(yards_after_catch)) %>%
    group_by(receiver_player_id) %>%
    summarise(receptions = n(),
              total_yac = sum(yards_after_catch),
              yac_per_reception = round(total_yac/receptions, 3)) %>%
    ungroup()
  
  # add full names, positions, teams
  output <-
    left_join(output,
              get(player_id_list),
              by = c("receiver_player_id" = "GSIS_ID"))
  
  # reorganize columns
  output <- select(output, receiver_player_id, Player, Pos, receptions, total_yac, yac_per_reception)
  
  # remove NA
  output <- na.omit(output)
  
  return(output)
}
