#
# load local .rds files into player stats data frames
#
playerstats_2019 <- readRDS("Data/playerstats_2019.rds")
playerstats_2018 <- readRDS("Data/playerstats_2018.rds")
playerstats_2017 <- readRDS("Data/playerstats_2017.rds")
playerstats_2016 <- readRDS("Data/playerstats_2016.rds")
playerstats_2015 <- readRDS("Data/playerstats_2015.rds")
playerstats_2014 <- readRDS("Data/playerstats_2014.rds")
playerstats_2013 <- readRDS("Data/playerstats_2013.rds")
playerstats_2012 <- readRDS("Data/playerstats_2012.rds")
playerstats_2011 <- readRDS("Data/playerstats_2011.rds")
playerstats_2010 <- readRDS("Data/playerstats_2010.rds")
playerstats_2009 <- readRDS("Data/playerstats_2009.rds")

#
# create overall player stats data frame
#
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