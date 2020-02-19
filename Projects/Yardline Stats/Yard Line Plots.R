ggplot(yardline_stats_overall) +
  geom_point(mapping = aes(x = yardline_100, y = pass_td_rate, color = "salmon")) +
  geom_point(mapping = aes(x = yardline_100, y = rush_td_rate, color = "darkslategray3")) +
  theme_minimal() +
  # theme(
  #   plot.background = element_rect(fill = "#ededed"),
  #   legend.background = element_rect(fill = "#ededed"),
  # ) +
  # theme_stata() +
  labs(
    title = "TD Rates by Yard Line",
    subtitle = "NFL, 2009-2018",
    x = "Distance from Opp. Endzone",
    y = "TD Rate",
    color = "Pass vs Rush"
  ) +
  scale_color_discrete(
    name = "",
    labels = c("Rush", "Pass"),
    guide = guide_legend(reverse = TRUE)
  ) +
  scale_x_continuous(breaks = seq(0, 100, by = 10)) +
  scale_y_continuous(limits = c(0.0, 0.6))





ggplot(yardline_stats_overall) +
  geom_point(mapping = aes(x = yardline_100, y = pass_favorability * 100, color =
                             pass_favorability > 0)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  theme_minimal() +
  # theme_stata() +
  labs(
    title = "TD Rates, Passing vs Rushing",
    subtitle = "NFL, 2009-2018",
    x = "Distance from Opp. Endzone",
    y = "Percentage Points",
    color = "Passing Favored?"
  )	+
  scale_color_discrete(
    name = "Favorability",
    labels = c("Rush/Even", "Pass"),
    guide = guide_legend(reverse = TRUE)
  ) +
  scale_x_continuous(breaks = seq(0, 100, by = 10)) +
  scale_y_continuous(
    breaks = seq(-10, 20, by = 5),
    limit = c(-10, 20),
    labels = abs(seq(-10, 20, by = 5)))