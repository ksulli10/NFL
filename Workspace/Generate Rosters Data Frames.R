# #
# # set up data frames for rosters by season
# #
# rosters_2019 <- season_rosters(
#   2019,
#   as.vector(nflteams[, 'abbr']),
#   c(
#     "QUARTERBACK",
#     "RUNNING_BACK",
#     "WIDE_RECEIVER",
#     "TIGHT_END",
#     "DEFENSIVE_LINEMAN",
#     "LINEBACKER",
#     "DEFENSIVE_BACK",
#     "KICKOFF_KICKER",
#     "KICK_RETURNER",
#     "PUNTER",
#     "PUNT_RETURNER",
#     "FIELD_GOAL_KICKER"
#   )
# )
# rosters_2018 <- season_rosters(
#   2018,
#   as.vector(nflteams[, 'abbr']),
#   c(
#     "QUARTERBACK",
#     "RUNNING_BACK",
#     "WIDE_RECEIVER",
#     "TIGHT_END",
#     "DEFENSIVE_LINEMAN",
#     "LINEBACKER",
#     "DEFENSIVE_BACK",
#     "KICKOFF_KICKER",
#     "KICK_RETURNER",
#     "PUNTER",
#     "PUNT_RETURNER",
#     "FIELD_GOAL_KICKER"
#   )
# )
# rosters_2017 <- season_rosters(
#   2017,
#   as.vector(nflteams[, 'abbr']),
#   c(
#     "QUARTERBACK",
#     "RUNNING_BACK",
#     "WIDE_RECEIVER",
#     "TIGHT_END",
#     "DEFENSIVE_LINEMAN",
#     "LINEBACKER",
#     "DEFENSIVE_BACK",
#     "KICKOFF_KICKER",
#     "KICK_RETURNER",
#     "PUNTER",
#     "PUNT_RETURNER",
#     "FIELD_GOAL_KICKER"
#   )
# )
# rosters_2016 <- season_rosters(
#   2016,
#   as.vector(nflteams[, 'abbr']),
#   c(
#     "QUARTERBACK",
#     "RUNNING_BACK",
#     "WIDE_RECEIVER",
#     "TIGHT_END",
#     "DEFENSIVE_LINEMAN",
#     "LINEBACKER",
#     "DEFENSIVE_BACK",
#     "KICKOFF_KICKER",
#     "KICK_RETURNER",
#     "PUNTER",
#     "PUNT_RETURNER",
#     "FIELD_GOAL_KICKER"
#   )
# )
# rosters_2015 <- season_rosters(
#   2015,
#   as.vector(nflteams[, 'abbr']),
#   c(
#     "QUARTERBACK",
#     "RUNNING_BACK",
#     "WIDE_RECEIVER",
#     "TIGHT_END",
#     "DEFENSIVE_LINEMAN",
#     "LINEBACKER",
#     "DEFENSIVE_BACK",
#     "KICKOFF_KICKER",
#     "KICK_RETURNER",
#     "PUNTER",
#     "PUNT_RETURNER",
#     "FIELD_GOAL_KICKER"
#   )
# )
# rosters_2014 <- season_rosters(
#   2014,
#   as.vector(nflteams[, 'abbr']),
#   c(
#     "QUARTERBACK",
#     "RUNNING_BACK",
#     "WIDE_RECEIVER",
#     "TIGHT_END",
#     "DEFENSIVE_LINEMAN",
#     "LINEBACKER",
#     "DEFENSIVE_BACK",
#     "KICKOFF_KICKER",
#     "KICK_RETURNER",
#     "PUNTER",
#     "PUNT_RETURNER",
#     "FIELD_GOAL_KICKER"
#   )
# )
# rosters_2013 <- season_rosters(
#   2013,
#   as.vector(nflteams[, 'abbr']),
#   c(
#     "QUARTERBACK",
#     "RUNNING_BACK",
#     "WIDE_RECEIVER",
#     "TIGHT_END",
#     "DEFENSIVE_LINEMAN",
#     "LINEBACKER",
#     "DEFENSIVE_BACK",
#     "KICKOFF_KICKER",
#     "KICK_RETURNER",
#     "PUNTER",
#     "PUNT_RETURNER",
#     "FIELD_GOAL_KICKER"
#   )
# )
# rosters_2012 <- season_rosters(
#   2012,
#   as.vector(nflteams[, 'abbr']),
#   c(
#     "QUARTERBACK",
#     "RUNNING_BACK",
#     "WIDE_RECEIVER",
#     "TIGHT_END",
#     "DEFENSIVE_LINEMAN",
#     "LINEBACKER",
#     "DEFENSIVE_BACK",
#     "KICKOFF_KICKER",
#     "KICK_RETURNER",
#     "PUNTER",
#     "PUNT_RETURNER",
#     "FIELD_GOAL_KICKER"
#   )
# )
# rosters_2011 <- season_rosters(
#   2011,
#   as.vector(nflteams[, 'abbr']),
#   c(
#     "QUARTERBACK",
#     "RUNNING_BACK",
#     "WIDE_RECEIVER",
#     "TIGHT_END",
#     "DEFENSIVE_LINEMAN",
#     "LINEBACKER",
#     "DEFENSIVE_BACK",
#     "KICKOFF_KICKER",
#     "KICK_RETURNER",
#     "PUNTER",
#     "PUNT_RETURNER",
#     "FIELD_GOAL_KICKER"
#   )
# )
# rosters_2010 <- season_rosters(
#   2010,
#   as.vector(nflteams[, 'abbr']),
#   c(
#     "QUARTERBACK",
#     "RUNNING_BACK",
#     "WIDE_RECEIVER",
#     "TIGHT_END",
#     "DEFENSIVE_LINEMAN",
#     "LINEBACKER",
#     "DEFENSIVE_BACK",
#     "KICKOFF_KICKER",
#     "KICK_RETURNER",
#     "PUNTER",
#     "PUNT_RETURNER",
#     "FIELD_GOAL_KICKER"
#   )
# )
# rosters_2009 <-
#   season_rosters(
#     2009,
#     as.vector(nflteams[, 'abbr']),
#     c(
#       "QUARTERBACK",
#       "RUNNING_BACK",
#       "WIDE_RECEIVER",
#       "TIGHT_END",
#       "DEFENSIVE_LINEMAN",
#       "LINEBACKER",
#       "DEFENSIVE_BACK",
#       "KICKOFF_KICKER",
#       "KICK_RETURNER",
#       "PUNTER",
#       "PUNT_RETURNER",
#       "FIELD_GOAL_KICKER"
#     )
#   )
# rosters_2008 <-
#   season_rosters(
#     2008,
#     as.vector(nflteams[, 'abbr']),
#     c(
#       "QUARTERBACK",
#       "RUNNING_BACK",
#       "WIDE_RECEIVER",
#       "TIGHT_END",
#       "DEFENSIVE_LINEMAN",
#       "LINEBACKER",
#       "DEFENSIVE_BACK",
#       "KICKOFF_KICKER",
#       "KICK_RETURNER",
#       "PUNTER",
#       "PUNT_RETURNER",
#       "FIELD_GOAL_KICKER"
#     )
#   )
# rosters_2007 <-
#   season_rosters(
#     2007,
#     as.vector(nflteams[, 'abbr']),
#     c(
#       "QUARTERBACK",
#       "RUNNING_BACK",
#       "WIDE_RECEIVER",
#       "TIGHT_END",
#       "DEFENSIVE_LINEMAN",
#       "LINEBACKER",
#       "DEFENSIVE_BACK",
#       "KICKOFF_KICKER",
#       "KICK_RETURNER",
#       "PUNTER",
#       "PUNT_RETURNER",
#       "FIELD_GOAL_KICKER"
#     )
#   )
# rosters_2006 <-
#   season_rosters(
#     2006,
#     as.vector(nflteams[, 'abbr']),
#     c(
#       "QUARTERBACK",
#       "RUNNING_BACK",
#       "WIDE_RECEIVER",
#       "TIGHT_END",
#       "DEFENSIVE_LINEMAN",
#       "LINEBACKER",
#       "DEFENSIVE_BACK",
#       "KICKOFF_KICKER",
#       "KICK_RETURNER",
#       "PUNTER",
#       "PUNT_RETURNER",
#       "FIELD_GOAL_KICKER"
#     )
#   )
# rosters_2005 <-
#   season_rosters(
#     2005,
#     as.vector(nflteams[, 'abbr']),
#     c(
#       "QUARTERBACK",
#       "RUNNING_BACK",
#       "WIDE_RECEIVER",
#       "TIGHT_END",
#       "DEFENSIVE_LINEMAN",
#       "LINEBACKER",
#       "DEFENSIVE_BACK",
#       "KICKOFF_KICKER",
#       "KICK_RETURNER",
#       "PUNTER",
#       "PUNT_RETURNER",
#       "FIELD_GOAL_KICKER"
#     )
#   )
# rosters_2004 <-
#   season_rosters(
#     2004,
#     as.vector(nflteams[, 'abbr']),
#     c(
#       "QUARTERBACK",
#       "RUNNING_BACK",
#       "WIDE_RECEIVER",
#       "TIGHT_END",
#       "DEFENSIVE_LINEMAN",
#       "LINEBACKER",
#       "DEFENSIVE_BACK",
#       "KICKOFF_KICKER",
#       "KICK_RETURNER",
#       "PUNTER",
#       "PUNT_RETURNER",
#       "FIELD_GOAL_KICKER"
#     )
#   )
# rosters_2003 <-
#   season_rosters(
#     2003,
#     as.vector(nflteams[, 'abbr']),
#     c(
#       "QUARTERBACK",
#       "RUNNING_BACK",
#       "WIDE_RECEIVER",
#       "TIGHT_END",
#       "DEFENSIVE_LINEMAN",
#       "LINEBACKER",
#       "DEFENSIVE_BACK",
#       "KICKOFF_KICKER",
#       "KICK_RETURNER",
#       "PUNTER",
#       "PUNT_RETURNER",
#       "FIELD_GOAL_KICKER"
#     )
#   )
# rosters_2002 <-
#   season_rosters(
#     2002,
#     as.vector(nflteams[, 'abbr']),
#     c(
#       "QUARTERBACK",
#       "RUNNING_BACK",
#       "WIDE_RECEIVER",
#       "TIGHT_END",
#       "DEFENSIVE_LINEMAN",
#       "LINEBACKER",
#       "DEFENSIVE_BACK",
#       "KICKOFF_KICKER",
#       "KICK_RETURNER",
#       "PUNTER",
#       "PUNT_RETURNER",
#       "FIELD_GOAL_KICKER"
#     )
#   )
# rosters_2001 <-
#   season_rosters(
#     2001,
#     as.vector(nflteams[, 'abbr']),
#     c(
#       "QUARTERBACK",
#       "RUNNING_BACK",
#       "WIDE_RECEIVER",
#       "TIGHT_END",
#       "DEFENSIVE_LINEMAN",
#       "LINEBACKER",
#       "DEFENSIVE_BACK",
#       "KICKOFF_KICKER",
#       "KICK_RETURNER",
#       "PUNTER",
#       "PUNT_RETURNER",
#       "FIELD_GOAL_KICKER"
#     )
#   )
# # rosters_2000 <-
# #   season_rosters(
# #     2000,
# #     as.vector(nflteams[, 'abbr']),
# #     c(
# #       "QUARTERBACK",
# #       "RUNNING_BACK",
# #       "WIDE_RECEIVER",
# #       "TIGHT_END",
# #       "DEFENSIVE_LINEMAN",
# #       "LINEBACKER",
# #       "DEFENSIVE_BACK",
# #       "KICKOFF_KICKER",
# #       "KICK_RETURNER",
# #       "PUNTER",
# #       "PUNT_RETURNER",
# #       "FIELD_GOAL_KICKER"
# #     )
# #   )
# 
# #
# # create overall rosters data frame
# #
# remove(rosters_overall)
# rosters_overall <-
#   rbind.fill(
#     # rosters_2000,
#     rosters_2001,
#     rosters_2002,
#     rosters_2003,
#     rosters_2004,
#     rosters_2005,
#     rosters_2006,
#     rosters_2007,
#     rosters_2008,
#     rosters_2009,
#     rosters_2010,
#     rosters_2011,
#     rosters_2012,
#     rosters_2013,
#     rosters_2014,
#     rosters_2015,
#     rosters_2016,
#     rosters_2017,
#     rosters_2018,
#     rosters_2019
#   )







#
# create rosters data frame
#
rosters_overall <-
  readRDS(
    url(
      'https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/roster-data/roster.rds'
    )
  )