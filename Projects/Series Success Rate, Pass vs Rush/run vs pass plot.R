ggplot(temp_df,
       mapping = aes(x = percentage, y = series_success_rate, color = play_type)) +
  geom_point() +
  geom_smooth() +
  scale_x_continuous(breaks = seq(0, 1, by = .25))