####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define function
get_yardline_rush_td_stats <- function(season = "overall") {
  # create data frame variable based on season input, e.g. "2018" -> "pbp_2018"
  pbp_input <- paste("pbp", season, sep = "_")
  # load data frame into local variable
  pbp_input <- get(pbp_input)
  
  # create empty set
  output <-
    data.frame(yardline_100 = c(1:99))
  
  # get rush TDs by yard line
  output <-
    full_join(
      output,
      filter(
        pbp_input,
        rush_touchdown == 1,
        play_type == "run",
        half_seconds_remaining >= 60
      ) %>%
        select(yardline_100, play_type, rush_touchdown) %>%
        group_by(yardline_100) %>%
        dplyr::count(rush_touchdown) %>%
        mutate(rush_tds = n) %>%
        select(yardline_100, rush_tds),
      by = "yardline_100"
    )
  
  # add rush attempts by yard line
  output <-
    full_join(
      output,
      filter(
        pbp_input,
        play_type == "run",
        half_seconds_remaining >= 60
      ) %>%
        select(yardline_100, play_type) %>%
        group_by(yardline_100) %>%
        dplyr::count(play_type) %>%
        mutate(rush_att = n) %>%
        select(yardline_100, rush_att),
      by = "yardline_100"
    )
  
  # calculate rate stats and order columns
  output <-
    mutate(output,
           rush_td_rate = round(rush_tds / rush_att, 4),) %>%
    select(yardline_100,
           rush_tds,
           rush_att,
           rush_td_rate)
  
  # change anything NA to a 0
  output <-
    mutate_all(output, ~ replace(., is.na(.), 0))
  
  # return output data frame
  return(output)
}
