#### [[[CREDIT:  LEE SHARPE]]]
####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####
####    *These files are automatically created by running "Master Project Setup.R"
####    *That script only needs to be run once.
####    *Local .rds files will be created to load from in the future (via "Local Load Setup.R")
####
#### Some notes:
####    a) There are two broken games because for whatever reason yards_gained is always NA
####        - These two games are from 2013, Week 12 PIT @ CLE and Week 13 JAX @ CLE
####    b) This adds two columns to plays:
####        1: series
####           - this counts starting at 1 for the first series in a game
####           - the id is shared across both teams being on offense
####           - value is NA for kickoffs, extra points, and two point conversions
####           - play_type == "no_play" still recorded as part of its series
####           - for the two broken games, this is always NA
####        2: series_success
####           - this is 1 if the series later succeeds, 0 if the series does not
####           - success = touchdown or new 1st down (through yardage or def penalty)
####           - failure = punt, fg attempt, interception, fumble lost, turnover on downs
####           - for the two broken games, this is always 0
####

# define function
add_series_success <- function(season) {
  # create data frame variable based on season input, e.g. "2018" -> "pbp_2018"
  pbp_input <- paste("pbp", season, sep = "_")
  # load data frame into local variable
  pbp_input <- get(pbp_input)
  
  # series data
  broken_games <-
    unique(pbp_input$game_id[is.na(pbp_input$yards_gained)])
  pbp_input$series <- c(NA, 1, rep(NA, nrow(pbp_input) - 2))
  pbp_input$series_success <- 0
  series <- 1
  lb <- 1
  
  for (r in 3:nrow(pbp_input))
  {
    # skip broken games
    if (pbp_input$game_id[r] %in% broken_games)
    {
      lb <- lb + 1
      next
    }
    
    # game has changed
    if (pbp_input$game_id[r] != pbp_input$game_id[r - 1])
    {
      if (pbp_input$yards_gained[r - 1] >= pbp_input$ydstogo[r - 1])
      {
        pbp_input$series_success[pbp_input$game_id == pbp_input$game_id[r - 1]
                                 & pbp_input$series == series] <- 1
      } else {
        pbp_input$series_success[pbp_input$game_id == pbp_input$game_id[r - 1]
                                 & pbp_input$series == series] <- NA
      }
      series <- 1
      # beginning of 2nd half or overtime
    } else if (pbp_input$qtr[r] != pbp_input$qtr[r - lb] &&
               (pbp_input$qtr[r] == 3 || pbp_input$qtr[r] >= 5)) {
      if (pbp_input$yards_gained[r - lb] >= pbp_input$ydstogo[r - lb])
      {
        pbp_input$series_success[pbp_input$game_id == pbp_input$game_id[r]
                                 & pbp_input$series == series] <- 1
      } else {
        pbp_input$series_success[pbp_input$game_id == pbp_input$game_id[r]
                                 & pbp_input$series == series] <- NA
      }
      series <- series + 1
      # or drive has changed
    } else if (pbp_input$drive[r] != pbp_input$drive[r - lb]) {
      if (pbp_input$yards_gained[r - lb] >= pbp_input$ydstogo[r - lb])
      {
        pbp_input$series_success[pbp_input$game_id == pbp_input$game_id[r]
                                 & pbp_input$series == series] <- 1
      }
      series <- series + 1
      # first down or NA down with last play having enough yards or defensive penalty
    } else if ((is.na(pbp_input$down[r]) ||
                pbp_input$down[r] == 1) &&
               (
                 pbp_input$yards_gained[r - lb] >= pbp_input$ydstogo[r - lb] ||
                 any(pbp_input$first_down_penalty[(r - lb):(r - 1)] == 1, na.rm =
                     TRUE)
               )) {
      if (pbp_input$play_type[r - lb] != "kickoff" ||
          any(pbp_input$first_down_penalty[(r - lb):(r - 1)] == 1, na.rm =
              TRUE))
      {
        pbp_input$series_success[pbp_input$game_id == pbp_input$game_id[r]
                                 & pbp_input$series == series] <- 1
      }
      series <- series + 1
    }
    
    # mark series
    if (!is.na(pbp_input$play_type[r]) &&
        pbp_input$play_type[r] == "kickoff")
    {
      # kickoffs
      pbp_input$series_success[r] <- NA
      series <- series - 1
    } else if ((!is.na(pbp_input$play_type[r]) &&
                pbp_input$play_type[r] == "extra_point") ||
               (!is.na(pbp_input$two_point_attempt[r]) &&
                pbp_input$two_point_attempt[r] == 1)) {
      # extra point or two point conversion
      pbp_input$series_success[r] <- NA
      series <- series - 1
    } else {
      # all other plays
      pbp_input$series[r] <- series
    }
    
    # lookback
    if (is.na(pbp_input$play_type[r]) ||
        pbp_input$play_type[r] == "no_play" ||
        pbp_input$play_type[r] == "extra_point" ||
        (!is.na(pbp_input$two_point_attempt[r]) &&
         pbp_input$two_point_attempt[r] == 1))
    {
      lb <- lb + 1
    } else {
      lb <- 1
    }
    
  }
  
  # make last two NA
  pbp_input$series_success[(nrow(pbp_input) - 1):nrow(pbp_input)] <-
    NA
  
  # return output data frame
  return(pbp_input)
}