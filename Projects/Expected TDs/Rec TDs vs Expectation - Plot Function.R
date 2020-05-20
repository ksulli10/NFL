####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####    2.  nflscrapR rosters data frame
####        (named "rosters_####" e.g. "rosters_overall")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define plot function
# takes season as input (e.g. "2019") and optional minimal number of attempts
plot_rec_td_vs_expected <- function(season, attempts = 100) {
  # instantiate the function
  source("Functions/get_rec_td_vs_expected.R")
    # instantiate the theme
  source("Functions/theme_538.R")
  # get the data
  rec_td_data <- get_rec_td_vs_expected(season)
  # filter the data to min. attempts
  rec_td_data <- filter(rec_td_data, rec_att >= attempts)
  # remove NA player names (keeps only players that made roster)
  rec_td_data <- filter(rec_td_data,!is.na(name))
  
  
  ggplot(data = rec_td_data,
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
      subtitle = paste("Min.", attempts, "Targets"),
      caption = "Figure: @thePatsStats | Data: @nflscrapR"
    )
  # coord_fixed() +
  # scale_x_continuous(limit = c(0, NA)) +
  # scale_y_continuous(limit = c(0, NA))
}