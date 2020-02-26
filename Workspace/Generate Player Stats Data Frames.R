#
# create player stats data frames
#
playerstats_2019 <- season_player_game(2019)
playerstats_2018 <- season_player_game(2018)
playerstats_2017 <- season_player_game(2017)
playerstats_2016 <- season_player_game(2016)
playerstats_2015 <- season_player_game(2015)
playerstats_2014 <- season_player_game(2014)
playerstats_2013 <- season_player_game(2013)
playerstats_2012 <- season_player_game(2012)
playerstats_2011 <- season_player_game(2011)
playerstats_2010 <- season_player_game(2010)
playerstats_2009 <- season_player_game(2009)

#
# create overall player stats data frame
#
library(plyr)
remove(playerstats_overall)
playerstats_overall <-
  rbind.fill(
    playerstats_2009,
    playerstats_2010,
    playerstats_2011,
    playerstats_2012,
    playerstats_2013,
    playerstats_2014,
    playerstats_2015,
    playerstats_2016,
    playerstats_2017,
    playerstats_2018,
    playerstats_2019
  )
detach(package:plyr)