# NFL
NFL analytics projects.

# Set-up
The function/plot scripts in this repository require the existence of the following nflscrapR data frames:
1.  Play-by-play data for each NFL season (e.g. "pbp_2018")
2.  Player statistics data for each NFL season (e.g. "playerstats_2018")
3.  Full roster data for each NFL season (e.g. "rosters_2018")

To generate the required data frames during a first-time set-up, run the script titled "Master Project Setup.R".  It will gather the required information and create local .rds files to expedite future data import.  It will likely take 30-60 minutes to run.  Any subsequent sessions can simply run "Local Load Setup.R" after opening the project, which should take less than a minute.