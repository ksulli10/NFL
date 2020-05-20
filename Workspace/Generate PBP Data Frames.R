#
# set up guga PBP data since 2000
#
pbp_2019 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2019.rds'))
pbp_2018 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2018.rds'))
pbp_2017 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2017.rds'))
pbp_2016 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2016.rds'))
pbp_2015 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2015.rds'))
pbp_2014 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2014.rds'))
pbp_2013 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2013.rds'))
pbp_2012 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2012.rds'))
pbp_2011 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2011.rds'))
pbp_2010 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2010.rds'))
pbp_2009 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2009.rds'))
pbp_2008 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2008.rds'))
pbp_2007 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2007.rds'))
pbp_2006 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2006.rds'))
pbp_2005 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2005.rds'))
pbp_2004 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2004.rds'))
pbp_2003 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2003.rds'))
pbp_2002 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2002.rds'))
pbp_2001 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2001.rds'))
pbp_2000 <- readRDS(url('https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_2000.rds'))

#
# create overall pbp data frame
#
remove(pbp_overall)
pbp_overall <-
  rbind.fill(
    pbp_2000,
    pbp_2001,
    pbp_2002,
    pbp_2003,
    pbp_2004,
    pbp_2005,
    pbp_2006,
    pbp_2007,
    pbp_2008,
    pbp_2009,
    pbp_2010,
    pbp_2011,
    pbp_2012,
    pbp_2013,
    pbp_2014,
    pbp_2015,
    pbp_2016,
    pbp_2017,
    pbp_2018,
    pbp_2019
  )