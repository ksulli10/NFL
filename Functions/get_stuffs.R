####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define function
get_stuffs <- function(season) {
  # create data frame variable based on season input, e.g. "2018" -> "pbp_2018"
  pbp_input <- paste("pbp", season, sep = "_")
  # load data frame into local variable
  pbp_input <- get(pbp_input)
  
  # grab all plays fitting the specified conditions
  stuffed_plays <- filter(
    pbp_input,
    .1 < wp,
    wp < .9,
    yardline_100 > 10,
    game_seconds_remaining > 300,
    yards_gained < 3
  )
  
  output <-
    stuffed_plays %>% dplyr::count(play_type, sort=TRUE)
  
  # return output dataframe
  return(output)
}