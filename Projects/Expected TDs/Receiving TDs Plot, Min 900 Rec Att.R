source("Projects/Expected TDs/Create Expected TD Stats.R")
rec_td_vs_expected_900_rec_att <-
  filter(rec_td_vs_expected_overall_grouped, player_rec_att >= 900)

ggplot(data = rec_td_vs_expected_900_rec_att,
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
    angle = 60,
    hjust = "inward",
  )) +
  labs(title = "Receiving Touchdown Efficiency",
       subtitle = "2009-2018, Min 900 Attempts",
       y = "Receiving TDs Against Expectation Per Att.") +
  theme_stata() +
  theme(
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = "none"
  ) +
  scale_y_continuous(breaks = seq(-.010, .03, by = .01),
                     limit = c(-.01, .03))