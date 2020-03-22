#
# load local .rds files into pbp data frames
#
pbp_2019 <- readRDS("Data/pbp_2019.rds")
pbp_2018 <- readRDS("Data/pbp_2018.rds")
pbp_2017 <- readRDS("Data/pbp_2017.rds")
pbp_2016 <- readRDS("Data/pbp_2016.rds")
pbp_2015 <- readRDS("Data/pbp_2015.rds")
pbp_2014 <- readRDS("Data/pbp_2014.rds")
pbp_2013 <- readRDS("Data/pbp_2013.rds")
pbp_2012 <- readRDS("Data/pbp_2012.rds")
pbp_2011 <- readRDS("Data/pbp_2011.rds")
pbp_2010 <- readRDS("Data/pbp_2010.rds")
pbp_2009 <- readRDS("Data/pbp_2009.rds")

#
# add season column to FO drive stats data frames
#
pbp_2009 <-
  mutate(pbp_2009, Season = "2009") %>%
  select(Season, everything())
pbp_2010 <-
  mutate(pbp_2010, Season = "2010") %>%
  select(Season, everything())
pbp_2011 <-
  mutate(pbp_2011, Season = "2011") %>%
  select(Season, everything())
pbp_2012 <-
  mutate(pbp_2012, Season = "2012") %>%
  select(Season, everything())
pbp_2013 <-
  mutate(pbp_2013, Season = "2013") %>%
  select(Season, everything())
pbp_2014 <-
  mutate(pbp_2014, Season = "2014") %>%
  select(Season, everything())
pbp_2015 <-
  mutate(pbp_2015, Season = "2015") %>%
  select(Season, everything())
pbp_2016 <-
  mutate(pbp_2016, Season = "2016") %>%
  select(Season, everything())
pbp_2017 <-
  mutate(pbp_2017, Season = "2017") %>%
  select(Season, everything())
pbp_2018 <-
  mutate(pbp_2018, Season = "2018") %>%
  select(Season, everything())
pbp_2019 <-
  mutate(pbp_2019, Season = "2019") %>%
  select(Season, everything())

#
# create overall pbp data frame
#
remove(pbp_overall)
pbp_overall <-
  rbind.fill(
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