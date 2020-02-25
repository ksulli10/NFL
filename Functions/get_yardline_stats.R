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
get_yardline_stats <- function(season) {
  # create data frame variable based on season input, e.g. "2018" -> "pbp_2018"
  pbp_input <- paste("pbp", season, sep = "_")
  # load data frame into local variable
  pbp_input <- get(pbp_input)
  
  # create empty set
  yardline_stats <-
    data.frame(yardline_100 = c(1:99))
  
  # get rush TDs by yard line
  yardline_stats <-
    full_join(
      yardline_stats,
      filter(pbp_input, rush_touchdown == 1, play_type == "run") %>%
        select(yardline_100, play_type, rush_touchdown) %>%
        group_by(yardline_100) %>%
        count(rush_touchdown) %>%
        mutate(rush_tds = n) %>%
        select(yardline_100, rush_tds),
      by = "yardline_100"
    )
  
  # add pass TDs by yard line
  yardline_stats <-
    full_join(
      yardline_stats,
      filter(pbp_input, pass_touchdown == 1, play_type == "pass") %>%
        select(yardline_100, play_type, pass_touchdown) %>%
        group_by(yardline_100) %>%
        count(pass_touchdown) %>%
        mutate(pass_tds = n) %>%
        select(yardline_100, pass_tds),
      by = "yardline_100"
    )
  
  # add rush attempts by yard line
  yardline_stats <-
    full_join(
      yardline_stats,
      filter(pbp_input, play_type == "run") %>%
        select(yardline_100, play_type) %>%
        group_by(yardline_100) %>%
        count(play_type) %>%
        mutate(rush_att = n) %>%
        select(yardline_100, rush_att),
      by = "yardline_100"
    )
  
  # add pass attempts by yard line
  yardline_stats <-
    full_join(
      yardline_stats,
      filter(pbp_input, play_type == "pass") %>%
        select(yardline_100, play_type) %>%
        group_by(yardline_100) %>%
        count(play_type) %>%
        mutate(pass_att = n) %>%
        select(yardline_100, pass_att),
      by = "yardline_100"
    )
  
  # calculate rate stats and order columns
  yardline_stats <-
    mutate(
      yardline_stats,
      rush_td_rate = round(rush_tds / rush_att, 4),
      pass_td_rate = round(pass_tds / pass_att, 4)
    ) %>%
    select(yardline_100,
           rush_tds,
           rush_att,
           rush_td_rate,
           pass_tds,
           pass_att,
           pass_td_rate)
  
  # change anything NA to a 0
  yardline_stats <-
    mutate_all(yardline_stats, ~ replace(., is.na(.), 0))
  
  # calculate pass favorability
  yardline_stats <-
    mutate(yardline_stats,
           pass_favorability = round(pass_tds / pass_att - rush_tds / rush_att, 4))
  
  # return output data frame
  return(yardline_stats)
}