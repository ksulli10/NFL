####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define function
# Inputs:
#     1. season = season to indicate play-by-play data frame (e.g. "2019"), default "overall"
#     2. wp_low = minimum win probability at start of play, value 0 to 1, default 5%
#     3. wp_high = maximum win probability at start of play, value 0 to 1, default 95%
#     4. yardline_min = minimum yards from target end zone, default 20
#     5. yardline_max = maximum yards from target end zone, default 80
#     6. seconds_left = minimum seconds left in the game, default 5 minutes
#     7. down = down, default 1st down
#     8. yds = distance remaining in set of downs, default 10
series_success_aggregate <-
  function(season = "overall",
           wp_low = 0.05,
           wp_high = 0.95,
           yardline_min = 20,
           yardline_max = 80,
           seconds_left = 300,
           dwn = 1,
           yds = 10) {
    # create df name based on season input
    # requires existence of "pbp_20XX" named file
    pbp_input <- paste("pbp", season, sep = "_")
    pbp_input <- get(pbp_input)
    
    # filter data
    output <- filter(
      pbp_input,
      wp > wp_low,
      wp < wp_high,
      yardline_100 >= yardline_min,
      yardline_100 <= yardline_max,
      game_seconds_remaining > seconds_left,
      down == dwn,
      ydstogo == yds,
      play_type != "no_play",
      play_type != "qb_kneel",
      !is.na(series_success)
    )
    
    # calculate series success
    mean <- mean(output$series_success)
    
    # return output
    return (mean)
  }





#### examples:
####       series_success_aggregate(season=2018, dwn=1, yds=15)
####
####       series_success_aggregate(season=2018, dwn=2, yds=10)
####
####       series_success_aggregate(season="overall", dwn=1, yds=10)
####
####       series_success_aggregate(
####         season = 2016,
####         wp_low = .2,
####         wp_high = .8,
####         yardline = 10,
####         seconds_left = 60,
####         dwn = 1,
####         yds = 10
####       )
