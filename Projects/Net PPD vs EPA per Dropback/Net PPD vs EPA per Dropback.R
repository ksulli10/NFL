####
####
#### WARNING: Will have issues with team names (e.g. "LV" vs "OAK").
####
####


#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####    2.  Football Outsiders drive stats data frame
####        (named "fo_drivestats_####" e.g. "fo_drivestats_2019")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define plot function
# takes season (e.g. "2019") and team abbreviation (e.g. "NE") as input
net_ppd_vs_dropback_epa <- function(season, team = "NE") {
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
    dplyr::summarise(epa_per_dropback = mean(epa))
  
  # specify team
  output <- select(mutate(drivestats_input, Season = as.numeric(Season)), Season, Team, NET_PPD) %>%
    inner_join(epa_per_dropback,
               by = c("Season" = "season", "Team" = "posteam"))

  # plot
  ggplot() +
    geom_point(
      data = filter(output, Team != team),
      mapping = aes(x = epa_per_dropback, y = NET_PPD),
      color = "Black"
    ) +
    geom_point(
      data = filter(output, Team == team),
      mapping = aes(x = epa_per_dropback, y = NET_PPD),
      shape = 23,
      size = 3,
      fill = "Blue"
    ) +
    geom_text_repel(
      data = filter(output, Team == team),
      mapping = aes(
        x = epa_per_dropback,
        y = NET_PPD,
        label = paste(team, Season)
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
      subtitle = paste(team, season),
      caption = "Figure: @thePatsStats | Data: @nflscrapR",
      x = "EPA per Dropback",
      y = "Net Points Per Drive"
    ) +
    theme_minimal()
}
