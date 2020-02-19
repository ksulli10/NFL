#
# import Football Outsiders drive stats since 2002
#
FO_drive_stats_2019 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2019.csv")
FO_drive_stats_2018 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2018.csv")
FO_drive_stats_2017 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2017.csv")
FO_drive_stats_2016 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2016.csv")
FO_drive_stats_2015 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2015.csv")
FO_drive_stats_2014 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2014.csv")
FO_drive_stats_2013 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2013.csv")
FO_drive_stats_2012 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2012.csv")
FO_drive_stats_2011 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2011.csv")
FO_drive_stats_2010 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2010.csv")
FO_drive_stats_2009 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2009.csv")
FO_drive_stats_2008 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2008.csv")
FO_drive_stats_2007 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2007.csv")
FO_drive_stats_2006 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2006.csv")
FO_drive_stats_2005 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2005.csv")
FO_drive_stats_2004 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2004.csv")
FO_drive_stats_2003 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2003.csv")
FO_drive_stats_2002 <- read.csv("C:/Users/ksull/Desktop/R Work/Net PPD vs EPA per Dropback/football outsiders drive stats 2002.csv")

# add season column to FO drive stats data frames
FO_drive_stats_2002 <- mutate(FO_drive_stats_2002, Season = "2002") %>%
  select(Season, everything())
FO_drive_stats_2003 <-
  mutate(FO_drive_stats_2003, Season = "2003") %>%
  select(Season, everything())
FO_drive_stats_2004 <-
  mutate(FO_drive_stats_2004, Season = "2004") %>%
  select(Season, everything())
FO_drive_stats_2005 <-
  mutate(FO_drive_stats_2005, Season = "2005") %>%
  select(Season, everything())
FO_drive_stats_2006 <-
  mutate(FO_drive_stats_2006, Season = "2006") %>%
  select(Season, everything())
FO_drive_stats_2007 <-
  mutate(FO_drive_stats_2007, Season = "2007") %>%
  select(Season, everything())
FO_drive_stats_2008 <-
  mutate(FO_drive_stats_2008, Season = "2008") %>%
  select(Season, everything())
FO_drive_stats_2009 <-
  mutate(FO_drive_stats_2009, Season = "2009") %>%
  select(Season, everything())
FO_drive_stats_2010 <-
  mutate(FO_drive_stats_2010, Season = "2010") %>%
  select(Season, everything())
FO_drive_stats_2011 <-
  mutate(FO_drive_stats_2011, Season = "2011") %>%
  select(Season, everything())
FO_drive_stats_2012 <-
  mutate(FO_drive_stats_2012, Season = "2012") %>%
  select(Season, everything())
FO_drive_stats_2013 <-
  mutate(FO_drive_stats_2013, Season = "2013") %>%
  select(Season, everything())
FO_drive_stats_2014 <-
  mutate(FO_drive_stats_2014, Season = "2014") %>%
  select(Season, everything())
FO_drive_stats_2015 <-
  mutate(FO_drive_stats_2015, Season = "2015") %>%
  select(Season, everything())
FO_drive_stats_2016 <-
  mutate(FO_drive_stats_2016, Season = "2016") %>%
  select(Season, everything())
FO_drive_stats_2017 <-
  mutate(FO_drive_stats_2017, Season = "2017") %>%
  select(Season, everything())
FO_drive_stats_2018 <-
  mutate(FO_drive_stats_2018, Season = "2018") %>%
  select(Season, everything())
FO_drive_stats_2018 <-
  mutate(FO_drive_stats_2019, Season = "2019") %>%
  select(Season, everything())

# create overall FO drive stat data frame
FO_drive_stats <-
  rbind(
    FO_drive_stats_2002,
    FO_drive_stats_2003,
    FO_drive_stats_2004,
    FO_drive_stats_2005,
    FO_drive_stats_2006,
    FO_drive_stats_2007,
    FO_drive_stats_2008,
    FO_drive_stats_2009,
    FO_drive_stats_2010,
    FO_drive_stats_2011,
    FO_drive_stats_2012,
    FO_drive_stats_2013,
    FO_drive_stats_2014,
    FO_drive_stats_2015,
    FO_drive_stats_2016,
    FO_drive_stats_2017,
    FO_drive_stats_2018,
    FO_drive_stats_2019
  )

