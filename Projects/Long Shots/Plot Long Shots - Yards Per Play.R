####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define plot function
# takes season as input (e.g. "2018")
plot_long_shots_yp <-
  function(season) {
    # instantiate the theme
    source("Functions/theme_538.R")
    # instantiate the function
    source("Functions/get_long_shots.R")
    
    # create long shots data frame
    long_shots_overall <- get_long_shots(season)
    
    # Yards Per Play
    long_shots_overall %>%
      ggplot(aes(x = reorder(play_type, total_plays, desc), y = yards_gained_per_play)) +
      geom_col(fill = "dark red", width = 0.8) +
      # scale_y_continuous(limits = c(0, 12), breaks = seq(0, 12, 2)) +
      labs(
        x = element_blank(),
        y = "Yards Per Play",
        title = "Yards Gained by Play Type",
        subtitle = paste("2nd & Short, NFL", season),
        caption = "Figure: @thePatsStats | Data: @nflscrapR"
      ) +
      geom_text(aes(label = format(
        round(yards_gained_per_play, digits = 2), nsmall = 2
      )),
      color = "black",
      vjust = -0.3) +
      geom_hline(yintercept = 0,
                 color = "black",
                 size = 1) +
      theme_538() +
      theme(panel.grid.major.x = element_blank())
  }
