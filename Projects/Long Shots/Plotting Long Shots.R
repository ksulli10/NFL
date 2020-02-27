source("Functions/theme_538.R")
source("Functions/get_long_shots.R")
long_shots_overall <- get_long_shots("data_overall")

# First Down Rate
long_shots_overall %>%
  ggplot(aes(x = reorder(play_type, total_plays, desc), y = first_down_pct)) +
  geom_col(fill = "dark green", width = 0.8) +
  scale_y_continuous(limits = c(0, 1.0), breaks = seq(0, 1.0, 0.1)) +
  labs(x = element_blank(),
       y = "First Down Rate",
       title = "First Down Rate by Play Type",
       subtitle = "2nd & Short (NFL 2009-2018)",
       caption = "Data from nflscrapR") +
  geom_text(aes(
    label = paste((100*round(first_down_pct, 3)),"%", sep="")),
    color = "black",
    vjust = -0.3
  ) +
  geom_hline(yintercept = 0, color = "black", size = 1) +
  theme_538() +
  theme(
    panel.grid.major.x = element_blank()
  )



# Series Success Rate
long_shots_overall %>%
  ggplot(aes(x = reorder(play_type, total_plays, desc), y = series_success_rate)) +
  geom_col(fill = "royal blue", width = 0.8) +
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, 0.1)) +
  labs(x = element_blank(),
       y = "Series Success Rate",
       title = "Series Success Rate by Play Type",
       subtitle = "Series Includes 2nd & Short (NFL 2009-2018)",
       caption = "Data from nflscrapR") +
  geom_text(aes(
    label = paste((100*round(series_success_rate, 3)),"%", sep="")),
    color = "black",
    vjust = -0.3
  ) +
  geom_hline(yintercept = 0, color = "black", size = 1) +
  theme_538() +
  theme(
    panel.grid.major.x = element_blank()
  )


# Yards Per Play
long_shots_overall %>%
  ggplot(aes(x = reorder(play_type, total_plays, desc), y = yards_gained_per_play)) +
  geom_col(fill = "dark red", width = 0.8) +
  scale_y_continuous(limits = c(0, 12), breaks = seq(0, 12, 2)) +
  labs(x = element_blank(),
       y = "Yards Per Play",
       title = "Yards Gained by Play Type",
       subtitle = "2nd & Short (NFL 2009-2018)",
       caption = "Data from nflscrapR") +
  geom_text(aes(
    label = format(round(yards_gained_per_play, digits=2), nsmall=2)),
    color = "black",
    vjust = -0.3
  ) +
  geom_hline(yintercept = 0, color = "black", size = 1) +
  theme_538() +
  theme(
    panel.grid.major.x = element_blank()
  )



# EPA Per Play
long_shots_overall %>%
  ggplot(aes(x = reorder(play_type, total_plays, desc), y = epa_per_play)) +
  geom_col(fill = "gold", width = 0.8) +
  scale_y_continuous(limits = c(-0.18, 0.1), breaks = seq(-0.2, 0.1, 0.05)) +
  labs(x = element_blank(),
       y = "EPA Per Play",
       title = "EPA per Play by Play Type",
       subtitle = "2nd & Short (NFL 2009-2018)",
       caption = "Data from nflscrapR") +
  geom_text(aes(
    label = format(round(epa_per_play, digits=2), nsmall=2)),
    color = "black",
    vjust = ifelse(long_shots_overall$epa_per_play > 0, -0.4, 1)
  ) +
  geom_hline(yintercept = 0, color = "black", size = 1) + 
  theme_538() +
  theme(
    panel.grid.major.x = element_blank()
  )


