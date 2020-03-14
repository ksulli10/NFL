#
# load local .rds files into Football Outsiders drive stats data frames
#
fo_drivestats_2000 <- readRDS("Data/fo_drivestats_2000.rds")
fo_drivestats_2001 <- readRDS("Data/fo_drivestats_2001.rds")
fo_drivestats_2002 <- readRDS("Data/fo_drivestats_2002.rds")
fo_drivestats_2003 <- readRDS("Data/fo_drivestats_2003.rds")
fo_drivestats_2004 <- readRDS("Data/fo_drivestats_2004.rds")
fo_drivestats_2005 <- readRDS("Data/fo_drivestats_2005.rds")
fo_drivestats_2006 <- readRDS("Data/fo_drivestats_2006.rds")
fo_drivestats_2007 <- readRDS("Data/fo_drivestats_2007.rds")
fo_drivestats_2008 <- readRDS("Data/fo_drivestats_2008.rds")
fo_drivestats_2009 <- readRDS("Data/fo_drivestats_2009.rds")
fo_drivestats_2010 <- readRDS("Data/fo_drivestats_2010.rds")
fo_drivestats_2011 <- readRDS("Data/fo_drivestats_2011.rds")
fo_drivestats_2012 <- readRDS("Data/fo_drivestats_2012.rds")
fo_drivestats_2013 <- readRDS("Data/fo_drivestats_2013.rds")
fo_drivestats_2014 <- readRDS("Data/fo_drivestats_2014.rds")
fo_drivestats_2015 <- readRDS("Data/fo_drivestats_2015.rds")
fo_drivestats_2016 <- readRDS("Data/fo_drivestats_2016.rds")
fo_drivestats_2017 <- readRDS("Data/fo_drivestats_2017.rds")
fo_drivestats_2018 <- readRDS("Data/fo_drivestats_2018.rds")
fo_drivestats_2019 <- readRDS("Data/fo_drivestats_2019.rds")

#
# add season column to FO drive stats data frames
#
fo_drivestats_2000 <-
  mutate(fo_drivestats_2000, Season = "2000") %>%
  select(Season, everything())
fo_drivestats_2001 <-
  mutate(fo_drivestats_2001, Season = "2001") %>%
  select(Season, everything())
fo_drivestats_2002 <-
  mutate(fo_drivestats_2002, Season = "2002") %>%
  select(Season, everything())
fo_drivestats_2003 <-
  mutate(fo_drivestats_2003, Season = "2003") %>%
  select(Season, everything())
fo_drivestats_2004 <-
  mutate(fo_drivestats_2004, Season = "2004") %>%
  select(Season, everything())
fo_drivestats_2005 <-
  mutate(fo_drivestats_2005, Season = "2005") %>%
  select(Season, everything())
fo_drivestats_2006 <-
  mutate(fo_drivestats_2006, Season = "2006") %>%
  select(Season, everything())
fo_drivestats_2007 <-
  mutate(fo_drivestats_2007, Season = "2007") %>%
  select(Season, everything())
fo_drivestats_2008 <-
  mutate(fo_drivestats_2008, Season = "2008") %>%
  select(Season, everything())
fo_drivestats_2009 <-
  mutate(fo_drivestats_2009, Season = "2009") %>%
  select(Season, everything())
fo_drivestats_2010 <-
  mutate(fo_drivestats_2010, Season = "2010") %>%
  select(Season, everything())
fo_drivestats_2011 <-
  mutate(fo_drivestats_2011, Season = "2011") %>%
  select(Season, everything())
fo_drivestats_2012 <-
  mutate(fo_drivestats_2012, Season = "2012") %>%
  select(Season, everything())
fo_drivestats_2013 <-
  mutate(fo_drivestats_2013, Season = "2013") %>%
  select(Season, everything())
fo_drivestats_2014 <-
  mutate(fo_drivestats_2014, Season = "2014") %>%
  select(Season, everything())
fo_drivestats_2015 <-
  mutate(fo_drivestats_2015, Season = "2015") %>%
  select(Season, everything())
fo_drivestats_2016 <-
  mutate(fo_drivestats_2016, Season = "2016") %>%
  select(Season, everything())
fo_drivestats_2017 <-
  mutate(fo_drivestats_2017, Season = "2017") %>%
  select(Season, everything())
fo_drivestats_2018 <-
  mutate(fo_drivestats_2018, Season = "2018") %>%
  select(Season, everything())
fo_drivestats_2019 <-
  mutate(fo_drivestats_2019, Season = "2019") %>%
  select(Season, everything())

#
# create overall FO drive stat data frame
#
library(plyr)
remove(fo_drivestats_overall)
fo_drivestats_overall <-
  rbind(
    fo_drivestats_2000,
    fo_drivestats_2001,
    fo_drivestats_2002,
    fo_drivestats_2003,
    fo_drivestats_2004,
    fo_drivestats_2005,
    fo_drivestats_2006,
    fo_drivestats_2007,
    fo_drivestats_2008,
    fo_drivestats_2009,
    fo_drivestats_2010,
    fo_drivestats_2011,
    fo_drivestats_2012,
    fo_drivestats_2013,
    fo_drivestats_2014,
    fo_drivestats_2015,
    fo_drivestats_2016,
    fo_drivestats_2017,
    fo_drivestats_2018,
    fo_drivestats_2019
  )
library(dplyr)