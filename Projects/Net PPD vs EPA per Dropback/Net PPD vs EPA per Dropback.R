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
# takes season as input (e.g. "2019")
net_ppd_vs_dropback_epa <- function(season = "overall") {
  # create data frame variables based on season input
  drivestats_input <- paste("fo_drivestats", season, sep = "_")
  pbp_input <- paste("pbp", season, sep = "_")
  # load data frames into local variables
  drivestats_input <- get(drivestats_input)
  pbp_input <- get(pbp_input)

  # create EPA per Dropback data
  epa_per_dropback <-
    select(filter(pbp_input, qb_dropback == 1),
           posteam, epa) %>%
    filter(!is.na(epa)) %>%
    group_by(posteam) %>%
    summarise(epa_per_dropback = sum(epa)/n())
  
  # specify team
  output <- select(drivestats_input, Team, NET_PPD) %>%
    inner_join(epa_per_dropback,
               by = c("Team" = "posteam"))

  view(output)
}














  # plot
  ggplot() +
    geom_point(
      data = filter(output, Team != "SEA"),
      mapping = aes(x = epa_per_dropback, y = NET_PPD),
      color = "grey"
    ) +
    geom_point(
      data = filter(output, Team == "SEA"),
      mapping = aes(x = epa_per_dropback, y = NET_PPD),
      shape = 23,
      size = 3,
      fill = "Red"
    ) +
    geom_text(
      data = filter(output, Team == "SEA"),
      mapping = aes(
        x = epa_per_dropback,
        y = NET_PPD,
        label = paste("'", substr(season, 3, 4), sep = '')
      ),
      color = "red",
      nudge_y = 0.1
    ) +
    geom_smooth(
      data = output,
      mapping = aes(x = epa_per_dropback, y = NET_PPD),
      method = "lm",
      linetype = "dashed",
      color = "black",
      se = FALSE
    ) +
    labs(
      title = "Net Points Per Drive vs EPA per Dropback",
      subtitle = "NFL, 2009-2019",
      x = "EPA per Dropback",
      y = "Net Points Per Drive"
    ) +
    annotate("text",
             x = 0.25,
             y = -0.85,
             label = "R^2 = 0.58") +
    theme_minimal()
}
