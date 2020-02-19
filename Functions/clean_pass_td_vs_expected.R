# takes a year as input, e.g. "2017"
clean_pass_td_vs_expected <- function(season) {
  

  # create df name based on season input
  # requires existence of "player_id_list_20XX" named file
  player_id_list <- paste("player_id_list", season, sep = "_")
  
  # run get_pass_td_vs_expected function on pbp_input string formed above
  output <- get_pass_td_vs_expected(season)
  
  # add full names, positions, teams
  output <-
    left_join(output,
              get(player_id_list),
              by = c("passer_player_id" = "GSIS_ID"))
  
  # rearrange and extract certain columns
  output <- select(
    output,
    passer_player_id,
    Player,
    Team,
    Pos,
    player_pass_att,
    expected_pass_tds,
    actual_pass_tds,
    tds_over_expectation,
    tds_over_expectation_per_att
  )
  
  # remove NA
  output <-
    mutate_all(output, ~ replace(., is.na(.), 0))
  output <-
    filter(output, Player != 0)
  
  # remove duplicates
  output <- output[!duplicated(output$passer_player_id), ]
  
  # add year column and rename
  output <- as.data.frame(append(output, season, after = 1))
  names(output)[2]<-"Year"
  
  # return completed df  
  return(output)
}
