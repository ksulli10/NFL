####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####    2.  nflscrapR rosters data frame
####        (named "rosters_####" e.g. "rosters_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define plot function
# takes season as input (e.g. "2019")
net_ppd_vs_dropback_epa <- function(season = "overall") {
  library(ggrepel)
  
  # create data frame variables based on season input
  drivestats_input <- paste("fo_drivestats", season, sep = "_")
  pbp_input <- paste("pbp", season, sep = "_")
  # load data frames into local variables
  drivestats_input <- get(drivestats_input)
  pbp_input <- get(pbp_input)

  # create EPA per Dropback data
  epa_per_dropback <-
    select(filter(pbp_input, qb_dropback == 1),
           season, posteam, epa) %>%
    filter(!is.na(epa)) %>%
    group_by(season, posteam) %>%
    summarise(epa_per_dropback = sum(epa)/n())
  
  # specify team
  output <- select(drivestats_input, season, Team, NET_PPD) %>%
    inner_join(epa_per_dropback,
               by = c("season" = "season", "Team" = "posteam"))

  # plot
  ggplot() +
    geom_point(
      data = filter(output, Team != "NE"),
      mapping = aes(x = epa_per_dropback, y = NET_PPD),
      color = "Black"
    ) +
    geom_point(
      data = filter(output, Team == "NE"),
      mapping = aes(x = epa_per_dropback, y = NET_PPD),
      shape = 23,
      size = 3,
      fill = "Blue"
    ) +
    geom_text_repel(
      data = filter(output, Team == "NE"),
      mapping = aes(
        x = epa_per_dropback,
        y = NET_PPD,
        label = Season
      ),
      color = "Blue"
    ) +
    geom_smooth(
      data = output,
      mapping = aes(x = epa_per_dropback, y = NET_PPD),
      method = "lm",
      linetype = "dashed",
      color = "gray",
      se = FALSE
    ) +
    labs(
      title = "Net Points Per Drive vs EPA per Dropback",
      subtitle = "NFL, 2009-2019",
      x = "EPA per Dropback",
      y = "Net Points Per Drive"
    ) +
    theme_minimal()
}
