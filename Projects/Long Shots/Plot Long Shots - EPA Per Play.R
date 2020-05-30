####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define plot function
# takes season as input (e.g. "2018")
plot_long_shots_epa <-
  function(season) {
    # instantiate the theme
    source("Functions/theme_538.R")
    # instantiate the function
    source("Functions/get_long_shots.R")
    
    # create long shots data frame
    long_shots_overall <- get_long_shots(season)
    
    # EPA Per Play
    long_shots_overall %>%
      ggplot(aes(x = reorder(play_type, total_plays, desc), y = epa_per_play)) +
      geom_col(fill = "gold", width = 0.8) +
      # scale_y_continuous(limits = c(-0.18, 0.1), breaks = seq(-0.2, 0.1, 0.05)) +
      labs(
        x = element_blank(),
        y = "EPA Per Play",
        title = "EPA per Play by Play Type",
        subtitle = paste("2nd & Short, NFL", season),
        caption = "Figure: @thePatsStats | Data: @nflscrapR"
      ) +
      geom_text(
        aes(label = format(round(
          epa_per_play, digits = 2
        ), nsmall = 2)),
        color = "black",
        vjust = ifelse(long_shots_overall$epa_per_play > 0,-0.4, 1)
      ) +
      geom_hline(yintercept = 0,
                 color = "black",
                 size = 1) +
      theme_538() +
      theme(panel.grid.major.x = element_blank())
    
  }