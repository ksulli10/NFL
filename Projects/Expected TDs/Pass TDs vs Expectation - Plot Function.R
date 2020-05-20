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
plot_pass_td_vs_expected <- function(season, attempts = 20) {
  # instantiate the function
  source("Functions/get_pass_td_vs_expected.R")
  # get the data
  pass_td_data <- get_pass_td_vs_expected(season)
  # filter the data to min. attempts
  pass_td_data <- filter(pass_td_data, pass_att >= attempts)
  # remove NA player names (keeps only players that made roster)
  pass_td_data <- filter(pass_td_data,!is.na(name))
  
  ggplot(data = pass_td_data,
         mapping = aes(x = exp_tds, y = tds, label = name)) +
    theme_538() +
    geom_point(aes(color = if_else(tds_over_exp >= 0, "#2c7bb6", "#d7181c")),
               size = 3) +
    geom_text_repel(aes(
      label = name,
      color = if_else(tds_over_exp >= 0, "#2c7bb6", "#d7181c")
    )) +
    scale_fill_identity(aesthetics = c("fill", "colour")) +
    geom_abline(linetype = "dashed") +
    labs(
      x = "Expected Touchdowns",
      y = "Actual Touchdowns",
      title = paste("Touchdowns over Expectation (",
                    season,
                    ")",
                    sep = ""),
      subtitle = paste("Min.", attempts, "Pass Attempts"),
      caption = "Figure: @thePatsStats | Data: @nflscrapR"
    )
  # coord_fixed() +
  # scale_x_continuous(limit = c(0, NA)) +
  # scale_y_continuous(limit = c(0, NA))
}