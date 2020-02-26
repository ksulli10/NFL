# load libraries
source("Workspace/Load Libraries.R")

# load local PBP RDS into data frames
source("Workspace/Load RDS into PBP DF.R")

# load local Player Stats RDS into data frames
source("Workspace/Load RDS into Player Stats DF.R")

# load local Rosters RDS into data frames
source("Workspace/Load RDS into Rosters DF.R")

# load NFL Teams data frame
nflteams <- read.csv("Data/nflteams.csv", header = TRUE)