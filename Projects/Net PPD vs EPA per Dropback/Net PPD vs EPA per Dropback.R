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
