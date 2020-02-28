####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####    2.  nflscrapR playerstats data frame
####        (named "playerstats_####" e.g. "playerstats_2018")
####    3.  nflscrapR rosters data frame
####        (named "rosters_####" e.g. "rosters_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define plot function
# takes season as input (e.g. "2019") and optional minimal number of attempts
plot_rush_td_vs_expected <- function(season, attempts = 20) {
  # instantiate the function
  source("Functions/get_rush_td_vs_expected.R")
  # get the data
  rush_td_data <- get_rush_td_vs_expected(season)
  # filter the data to min. attempts
  rush_td_data <- filter(rush_td_data, player_rush_att >= attempts)
  
  ggplot(
    data = rush_td_data,
    mapping = aes(x = expected_rush_tds, y = actual_rush_tds, label = name)
  ) +
    geom_point() +
    geom_text(size = 3, nudge_y = -0.5) +
    geom_abline(linetype = "dashed")
  # coord_fixed() +
  # scale_x_continuous(limit = c(0, NA)) +
  # scale_y_continuous(limit = c(0, NA))
}