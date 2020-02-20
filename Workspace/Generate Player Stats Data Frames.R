#
# create player stats data frames
#
playerstats19 <- season_player_game(2019)
playerstats18 <- season_player_game(2018)
playerstats17 <- season_player_game(2017)
playerstats16 <- season_player_game(2016)
playerstats15 <- season_player_game(2015)
playerstats14 <- season_player_game(2014)
playerstats13 <- season_player_game(2013)
playerstats12 <- season_player_game(2012)
playerstats11 <- season_player_game(2011)
playerstats10 <- season_player_game(2010)
playerstats09 <- season_player_game(2009)

#
# create overall player stats data frame
#
library(plyr)
remove(playerstats_overall)
playerstats_overall <-
  rbind.fill(
    playerstats09,
    playerstats10,
    playerstats11,
    playerstats12,
    playerstats13,
    playerstats14,
    playerstats15,
    playerstats16,
    playerstats17,
    playerstats18,
    playerstats19
  )
detach(package:plyr)