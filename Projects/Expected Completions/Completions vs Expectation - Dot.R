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
plot_comp_pct_vs_expected_dot <-
  function(season, attempts = 200) {
    # instantiate the function
    source("Functions/get_comp_pct_vs_expected.R")
    # instantiate the theme
    source("Functions/theme_538.R")
    # get the data
    comp_pct_data <- get_comp_pct_vs_expected(season)
    # filter the data to min. attempts
    comp_pct_data <-
      filter(comp_pct_data, pass_att >= attempts)
    # remove NA player names (keeps only players that made roster)
    comp_pct_data <- filter(comp_pct_data,!is.na(name))
    
    # plot the data
    comp_pct_data %>%
      ggplot(aes(x = exp_comp_pct, y = comp_pct)) +
      geom_point(aes(color = if_else(cpoe >= 0, "#2c7bb6", "#d7181c")),
                 size = 3) +
      geom_text_repel(aes(
        label = name,
        color = if_else(cpoe >= 0, "#2c7bb6", "#d7181c")
        #, hjust = if_else(cpoe > 0,-0.2, 1.2)
      )) +
      scale_fill_identity(aesthetics = c("fill", "colour")) +
      theme_538() +
      # scale_y_continuous(limits=c(58,77), breaks=seq(58, 77, by=1)) +
      # scale_x_continuous(limits=c(61,68), breaks=seq(61, 68, by=1)) +
      scale_y_continuous(breaks = seq(1, 100, by = 1)) +
      scale_x_continuous(breaks = seq(1, 100, by = 1)) +
      geom_abline(linetype = "dashed", color = "grey") +
      labs(
        x = "Expected Completion Pct. (%)",
        y = "Actual Completion Pct. (%)",
        title = paste(
          "Depth-Adjusted Completion Percentage over Expectation (",
          season,
          ")",
          sep = ""
        ),
        subtitle = paste("Min.", attempts, "Pass Attempts"),
        caption = "Figure: @thePatsStats | Data: @nflscrapR"
      )
  }