patriots_rush_td_vs_expected <-
  filter(rush_td_vs_expected_overall_ungrouped, Team == "NE") %>% 
  group_by(rusher_player_id, Player, Pos) %>%
  summarise(
    player_rush_att = sum(player_rush_att),
    actual_rush_tds = sum(actual_rush_tds),
    expected_rush_tds = sum(expected_rush_tds),
    tds_over_expectation = sum(actual_rush_tds - expected_rush_tds),
    tds_over_expectation_per_att = round(
      sum(actual_rush_tds - expected_rush_tds) / sum(player_rush_att),
      4
    )
  ) %>%
  ungroup() %>% 
  filter(player_rush_att > 200)






ggplot(data = patriots_rush_td_vs_expected,
       mapping = aes(
         x = reorder(Player, tds_over_expectation_per_att),
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
    label = Player,
    angle = 60,
    hjust = "inward",
  )) +
  labs(
    title = "Patriots Rushing Touchdown Efficiency",
    subtitle = "2009-2018, Min 200 Attempts",
    y = "Rush TDs Against Expectation Per Att."
  ) +
  theme_stata() +
  theme(
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = "none"
  ) +
  scale_y_continuous(breaks = seq(-.03, .03, by = .01), limit=c(-.03,.03)) + 
  ylim(-.03, .03)