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

select(FO_drive_stats, Season, Team, NET_PPD) %>%
  inner_join(offense_epa_overall,
             by = c("Team" = "posteam", "Season" = "Season"))





ggplot() +
  geom_point(
    data = filter(baldwin_update, Team != "SEA"),
    mapping = aes(x = off_epa_per_dropback, y = NET_PPD),
    color = "grey"
  ) +
  geom_point(
    data = filter(baldwin_update, Team == "SEA"),
    mapping = aes(x = off_epa_per_dropback, y = NET_PPD),
    shape = 23,
    size = 3,
    fill = "Red"
  ) +
  geom_text(
    data = filter(baldwin_update, Team == "SEA"),
    mapping = aes(
      x = off_epa_per_dropback,
      y = NET_PPD,
      label = paste("'", substr(Season, 3, 4), sep = '')
    ),
    color = "red",
    nudge_y = 0.1
  ) +
  geom_smooth(
    data = baldwin_update,
    mapping = aes(x = off_epa_per_dropback, y = NET_PPD),
    method = "lm",
    linetype = "dashed",
    color = "black",
    se = FALSE
  ) +
  labs(
    title = "Net Points Per Drive vs EPA per Dropback",
    subtitle = "NFL, 2009-2018",
    x = "EPA per Dropback",
    y = "Net Points Per Drive"
  ) +
  annotate("text",
           x = 0.25,
           y = -0.85,
           label = "R^2 = 0.58") +
  theme_minimal()
