#### Some notes:
####
#### a) This assumes you have all of the data from nflscrapR in a tibble/df called plays
####     (If you use a different name, you can change my code or copy yours to plays)
#### b) There are two broken games because for whatever reason yards_gained is always NA
####     - These two games are from 2013, Week 12 PIT @ CLE and Week 13 JAX @ CLE
#### c) This adds two columns to plays
####     1: series
####           - this counts starting at 1 for the first series in a game
####           - the id is shared across both teams being on offense
####           - value is NA for kickoffs, extra points, and two point conversions
####           - play_type == "no_play" still recorded as part of its series
####           - for the two broken games, this is always NA
####     2: series_success
####           - this is 1 if the series later succeeds, 0 if the series does not
####           - success = touchdown or new 1st down (through yardage or def penalty)
####           - failure = punt, fg attempt, interception, fumble lost, turnover on downs
####           - for the two broken games, this is always 0
#### c) See code comments hopefully you can understand the logic, feel free to DM me
#### d) It's not perfect, but it's very good
####     (If you have fixes for anything or spot specific bugs, LMK!)
#### e) Have fun, tag me in anything cool you do with it :)

add_series_success <- function(season) {
  
  # create df name based on season input
  # requires existence of "pbp_20XX" named file
  pbp_input <- paste("pbp", season, sep = "_")
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
    } else if ((is.na(pbp_input$down[r]) || pbp_input$down[r] == 1) &&
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
  pbp_input$series_success[(nrow(pbp_input) - 1):nrow(pbp_input)] <- NA
  
  return(pbp_input)
}



#
# add to pbp data frames
#
pbp_2019 <- add_series_success(2019)
pbp_2018 <- add_series_success(2018)
pbp_2017 <- add_series_success(2017)
pbp_2016 <- add_series_success(2016)
pbp_2015 <- add_series_success(2015)
pbp_2014 <- add_series_success(2014)
pbp_2013 <- add_series_success(2013)
pbp_2012 <- add_series_success(2012)
pbp_2011 <- add_series_success(2011)
pbp_2010 <- add_series_success(2010)
pbp_2009 <- add_series_success(2009)

#
# create overall ryurko PBP data frame
#
library(plyr)
remove(pbp_data_overall)
pbp_data_overall <-
  rbind.fill(
    pbp_2009,
    pbp_2010,
    pbp_2011,
    pbp_2012,
    pbp_2013,
    pbp_2014,
    pbp_2015,
    pbp_2016,
    pbp_2017,
    pbp_2018,
    pbp_2019
  )
detach(package:plyr)