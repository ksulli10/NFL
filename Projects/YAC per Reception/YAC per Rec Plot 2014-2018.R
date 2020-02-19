# create the data frame
yac_per_rec_WRTE_2014_to_2018_min_100 <-
  filter(distinct(get_rec_and_yac("2014_to_2018")),
         receptions > 100,
         Pos != "RB",
         Pos != "FB")



# overall plot
ggplot(data = yac_per_rec_WRTE_2014_to_2018_min_100) +
  geom_point(mapping = aes(x = receptions, y = total_yac)) +
  geom_text(
    data = filter(
      yac_per_rec_WRTE_2014_to_2018_min_100,
      receiver_player_id == "00-0030564" |
        receiver_player_id == "00-0030506" |
        receiver_player_id == "00-0027793" |
        receiver_player_id == "00-0027891" |
        receiver_player_id == "00-0027944" |
        receiver_player_id == "00-0031382" |
        receiver_player_id == "00-0031235" |
        receiver_player_id == "00-0027874" |
        receiver_player_id == "00-0029608" |
        receiver_player_id == "00-0028002" |
        receiver_player_id == "00-0026986" |
        receiver_player_id == "00-0027656" |
        receiver_player_id == "00-0030061" |
        receiver_player_id == "00-0022921" |
        receiver_player_id == "00-0031408"
    ),
    mapping = aes(x = receptions, y = total_yac, label = Player),
    nudge_y = 60
  ) +
  geom_smooth(
    mapping = aes(x = receptions, y = total_yac),
    method = lm,
    se = FALSE
  ) +
  theme_stata() +
  labs(
    title = "Receptions vs YAC",
    subtitle = "NFL, 2014-2018",
    x = "Receptions",
    y = "Total Yards After Catch"
  )



# highlight mike evans plot
ggplot(data = yac_per_rec_WRTE_2014_to_2018_min_100) +
  geom_point(mapping = aes(x = receptions, y = total_yac)) +
  geom_text(
    data = filter(
      yac_per_rec_WRTE_2014_to_2018_min_100,
      receiver_player_id == "00-0030564" |
      receiver_player_id == "00-0030506" |
      receiver_player_id == "00-0027793" |
      receiver_player_id == "00-0027891" |
      receiver_player_id == "00-0027656"
    ),
    mapping = aes(x = receptions, y = total_yac, label = Player),
    nudge_y = 100
    ) +
  geom_text(
    data = filter(
      yac_per_rec_WRTE_2014_to_2018_min_100,
      receiver_player_id == "00-0031408"
    ),
    mapping = aes(x = receptions, y = total_yac, label = Player),  color="red", 
    nudge_y = -100
  ) +
  geom_smooth(
    mapping = aes(x = receptions, y = total_yac),
    method = lm,
    se = FALSE
  ) +
  theme_stata() +
  labs(
    title = "Receptions vs YAC",
    subtitle = "NFL, 2014-2018",
    x = "Receptions",
    y = "Total Yards After Catch"
  ) +
  scale_x_continuous(limits=c(100,600), breaks=seq(100,600,50))