####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####    2.  nflscrapR playerstats data frame
####        (named "playerstats##" e.g. "playerstats18")
####

clean_pass_td_vs_expected <- function(season) {

  # create player_id_list file
  source("Functions/get_player_id_list.R")
  player_id_list <- get_player_id_list(season)
  
  # run get_pass_td_vs_expected function
  source("Functions/get_pass_td_vs_expected.R")
  output <- get_pass_td_vs_expected(season)
  
  # add full names, positions, teams
  output <-
    left_join(output,
              player_id_list,
              by = c("passer_player_id" = "playerID"))
  
  # rearrange and extract certain columns
  output <- select(
    output,
    passer_player_id,
    name,
    # Team,
    # Pos,
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
    filter(output, name != 0)
  
  # remove duplicates
  output <- output[!duplicated(output$passer_player_id), ]
  
  # add year column and rename
  output <- as.data.frame(append(output, season, after = 1))
  names(output)[2]<-"Year"
  
  # return completed df  
  return(output)
}
