####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define plot function
# takes season as input (e.g. "2019")
calc_agg_wp_stats <-
  function(season) {
    # create data frame variable based on season input, e.g. "2018" -> "pbp_2018"
    pbp_input <- paste("pbp", season, sep = "_")
    # load data frame into local variable
    pbp_input <- get(pbp_input)
    
    # filter to remove NA and non-plays
    filtered_pbp <- filter(pbp_input, play_type != "no_play", !is.na(play_type), !is.na(wp))
    
    # calculate plays and TDs per criteria
    view(dplyr::summarize(
      filtered_pbp,
      season = max(season),
      total_plays = n(),
      plays_above_90_q1 = sum(wp >= .9 & qtr==1 & season_type=="REG"),
      plays_above_80_q1 = sum(wp >= .8 & qtr==1 & season_type=="REG"),
      total_tds = sum(qtr==1 & touchdown==1 & season_type=="REG"),
      tds_above_90_q1 = sum(wp >= .9 & qtr==1 & touchdown==1 & season_type=="REG"),
      tds_above_80_q1 = sum(wp >= .8 & qtr==1 & touchdown==1 & season_type=="REG"),
    ))
  }