source("Projects/Expected TDs/Create Expected TD Stats.R")
rush_td_vs_expected_1000_carries <-
  filter(rush_td_vs_expected_overall_grouped, player_rush_att >= 1000)

ggplot(data = rush_td_vs_expected_1000_carries,
       mapping = aes(
         x = reorder(name, tds_over_expectation_per_att),
         y = tds_over_expectation_per_att
       )) +
  geom_bar(stat = "identity",
           mapping = aes(fill = tds_over_expectation_per_att)) +
  geom_hline(yintercept = 0,
             color = "red",
             linetype = "dashed") +
  geom_text(mapping = aes(
    y = -0.0005 * (
      abs(tds_over_expectation_per_att) / tds_over_expectation_per_att
    ),
    label = name,
    angle = 90,
    hjust = "inward",
  )) +
  labs(title = "Rushing Touchdown Efficiency",
       subtitle = "2009-2018, Min 1000 Attempts",
       y = "Rush TDs Against Expectation Per Att.") +
  theme_stata() +
  theme(
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = "none"
  )