####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define plot function
# takes season as input (e.g. "2019")
thomasmock_plot <- function(season) {
  # source cleaning function
  source("Functions/thomasmock_pbp_clean.R")
  
  # define filtered data frame
  rb_trio <- thomasmock_pbp_clean(2019) %>%
    filter(
      posteam == "NE",
      receiver %in% c("S.Michel", "R.Burkhead", "J.White") |
        rusher %in% c("S.Michel", "R.Burkhead", "J.White"),
      play_type != "no_play"
    ) %>%
    mutate(
      # Assign a single player name for filtering regardless of play_type
      player = if_else(is.na(receiver), rusher, receiver),
      # Add nice labels to play_type
      play_type = factor(play_type, labels = c("Reception", "Rush"))
    ) %>%
    group_by(player, play_type) %>%
    summarize(
      n = n(),
      mean_yards = sum(yards_gained, na.rm = TRUE) / n,
      mean_success = sum(success, na.rm = TRUE) / n
    )
  
  # create basic faceted plot
  rb_trio_plot <- rb_trio %>%
    ggplot(aes(x = player, y = mean_yards, fill = player, position = "dodge", group = play_type)) +
    geom_col() +
    facet_grid(~play_type)
  
  # source theme function
  source("Functions/theme_538.R")
  
  # fancify and label the plot
  rb_trio_plot +
    geom_hline(yintercept = 0.03, color = "black", size = 2) +
    theme_538() +
    scale_fill_manual(values = c("#002244", "#c60c30", "#b0b7bc")) +
    labs(
      x = "",
      y = "Avg Yards per Play",
      title = "Patriots Running Backs in 2019",
      subtitle = "Sony Michel was the least efficient Patriots running back.",
      caption = "Data: @nflscrapR"
    ) +
    theme(
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(color = "white", size = 1),
      panel.ontop = TRUE,
      legend.position = "none"
    )  +
    scale_y_continuous(
      breaks = seq(0, 6, 1)
    )
}