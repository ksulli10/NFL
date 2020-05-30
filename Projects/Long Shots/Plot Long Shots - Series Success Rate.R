####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define plot function
# takes season as input (e.g. "2018")
plot_long_shots_ss <-
  function(season) {
    # instantiate the theme
    source("Functions/theme_538.R")
    # instantiate the function
    source("Functions/get_long_shots.R")
    
    # create long shots data frame
    long_shots_overall <- get_long_shots(season)
    
    # Series Success Rate
    long_shots_overall %>%
      ggplot(aes(x = reorder(play_type, total_plays, desc), y = series_success_rate)) +
      geom_col(fill = "royal blue", width = 0.8) +
      # scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, 0.1)) +
      labs(
        x = element_blank(),
        y = "Series Success Rate",
        title = "Series Success Rate by Play Type",
        subtitle = paste("2nd & Short, NFL", season),
        caption = "Figure: @thePatsStats | Data: @nflscrapR"
      ) +
      geom_text(aes(label = paste((
        100 * round(series_success_rate, 3)
      ), "%", sep = "")),
      color = "black",
      vjust = -0.3) +
      geom_hline(yintercept = 0,
                 color = "black",
                 size = 1) +
      theme_538() +
      theme(panel.grid.major.x = element_blank())
  }