twitbeef <- select(filter(pbp_2018, yrdline100 <= 10, Touchdown==1, PlayType=="Run" | PlayType=="Pass"), GameID, posteam, Touchdown, PlayType) %>%
  group_by(posteam) %>%
  count(PlayType)



ggplot(twitbeef) +
  geom_bar(mapping=aes(x=reorder(posteam, n), n, fill=PlayType), stat="identity") +
  labs(title="TDs Inside the 10", subtitle="2018 Season", x="Team", y="TDs")




ggplot(twitbeef) +
  geom_bar(mapping=aes(x=reorder(posteam, n), n, fill=PlayType), stat="identity") +
  labs(title="TDs Inside the 10", subtitle="2018 Season", x="Team", y="TDs") + 
  geom_point(data=team_summary_2018, mapping=aes(x=Abbr, y=W))