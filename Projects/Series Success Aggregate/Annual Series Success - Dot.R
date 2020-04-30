####
#### Requirements:
####    1.  nflscrapR play-by-play data frames
####        (named "pbp_####" e.g. "pbp_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define plot function
plot_all_series_success <-
  function() {
    # instantiate the function
    source("Functions/series_success_aggregate.R")
    # instantiate the theme
    source("Functions/theme_538.R")
    # get the data
    source("Projects/Series Success Aggregate/Create Annual Series Success DF.R")
    plot_data <- ss_overall

    # plot the data
    plot_data %>%
      ggplot(aes(x = season, y = value)) + 
      geom_line(aes(y = series_success_1_15, col="1st and 15", group="1st and 15"), size=1) +
      geom_point(aes(y = series_success_1_15, col="1st and 15"), size=3) +
      geom_line(aes(y = series_success_2_10, col="2nd and 10", group="1st and 15"), size=1) +
      geom_point(aes(y = series_success_2_10, col="2nd and 10"), size=3) +
      theme_538() +
      theme(
        # Legend Settings
        legend.key = element_blank(),
        legend.title = element_blank(),
        legend.background = element_blank(),
        legend.position = "right",
        legend.direction = "vertical",
        # Caption Settings
        plot.caption.position = "plot") +
      scale_y_continuous(breaks = seq(0, 1, by = 0.01)) +
      labs(
        x = "",
        y = "Series Success Rate",
        title = "Annual Series Success Rates",
        subtitle = "NFL, 2009-2019",
        caption = "(Win prob. < 95%, Between 20 yard lines, Over 5min. remaining)\nFigure: @thePatsStats | Data: @nflscrapR and @LeeSharpeNFL"
      )
  }