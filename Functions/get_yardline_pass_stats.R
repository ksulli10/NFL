####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####
####    *These files are automatically created by running "Master Project Setup.R"
####    *That script only needs to be run once.
####    *Local .rds files will be created to load from in the future (via "Local Load Setup.R")
####

# define function
get_yardline_pass_stats <- function(season) {
  # create data frame variable based on season input, e.g. "2018" -> "pbp_2018"
  pbp_input <- paste("pbp", season, sep = "_")
  # load data frame into local variable
  pbp_input <- get(pbp_input)
  
  # create empty set
  output <-
    data.frame(yardline_100 = c(1:99))
  
  # get pass TDs by yard line and air yards
  output <-
    full_join(
      output,
      filter(pbp_input, pass_touchdown == 1, play_type == "pass") %>%
        select(yardline_100, play_type, pass_touchdown, air_yards) %>%
        group_by(yardline_100, air_yards) %>%
        count(pass_touchdown) %>%
        mutate(pass_tds = n) %>%
        select(yardline_100, touchdown_air_yards = air_yards, pass_tds),
      by = "yardline_100"
    )
  
  # add pass attempts by yardline and air yards
  output <-
    right_join(
      output,
      filter(pbp_input, play_type == "pass", !is.na(air_yards)) %>%
        select(yardline_100, play_type, air_yards) %>%
        group_by(yardline_100, air_yards) %>%
        count(play_type) %>%
        mutate(pass_att = n) %>%
        select(yardline_100, attempt_air_yards = air_yards, pass_att),
      by = c("yardline_100", "touchdown_air_yards" = "attempt_air_yards")
    ) %>%
    mutate("air_yards" = touchdown_air_yards)
  
  # calculate rate stats and order columns
  output <-
    mutate(output,
           pass_td_rate = round(pass_tds / pass_att, 4)) %>%
    select(yardline_100,
           air_yards,
           pass_tds,
           pass_att,
           pass_td_rate)
  
  # change anything NA to a 0
  output <-
    mutate_all(output, ~ replace(., is.na(.), 0))
  
  # return output data frame
  return(output)
}
