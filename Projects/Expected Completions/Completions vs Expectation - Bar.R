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
plot_comp_pct_vs_expected_bar <- function(season = "overall", attempts = 20) {
  # instantiate the function
  source("Functions/get_comp_pct_vs_expected.R")
  # instantiate the theme
  source("Functions/theme_538.R")
  # get the data
  comp_pct_data <- get_comp_pct_vs_expected(season)
  # filter the data to min. attempts
  comp_pct_data <-
    filter(comp_pct_data, player_pass_att >= attempts)
  
  # plot the data
  comp_pct_data %>%
    ggplot(aes(x = reorder(name, cpoe), y = cpoe)) +
    geom_col(aes(fill = if_else(cpoe >= 0, "#2c7bb6", "#d7181c"))) +
    geom_text(aes(
      label = name,
      color = if_else(cpoe >= 0, "#2c7bb6", "#d7181c"),
      hjust = if_else(cpoe > 0, -0.1, 1.1)
    )) +
    coord_flip() +
    scale_fill_identity(aesthetics = c("fill", "colour")) +
    theme_538() +
    theme(
      panel.grid.major.y = element_blank(),
      axis.text.y = element_blank()
    ) +
    geom_hline(yintercept = 0) +
    # scale_y_continuous(limits=c(-8,10), breaks=seq(-8, 10, by=1)) +
    scale_y_continuous(breaks=seq(-8, 10, by=1)) +
    labs(
      x = "",
      y = "Depth-Adjusted CPOE (%)",
      title = paste("Depth-Adjusted Completion Percentage over Expectation (",season,")",sep=""),
      subtitle = paste("Min.",attempts,"Pass Attempts"),
      caption = "Figure: @thePatsStats | Data: @nflscrapR"
    )
}