# load libraries
source("Workspace/Load Libraries.R")

# set up ryurko PBP data since 2009
source("Workspace/Generate PBP Data Frames.R")

# create add_series_success function
source("Functions/add_series_success.R")

# add series success to data frames
source("Workspace/Add Series Success to PBP Data.R")

# create overall pbp data frame
source("Workspace/Create Overall PBP Data Frame.R")

# save pbp data frames into local RDS files
source("Workspace/Save PBP as RDS.R")

# create player stats data frames
source("Workspace/Generate Player Stats Data Frames.R")

# save player stats data frames into local RDS files
source("Workspace/Save Player Stats as RDS.R")