# NFL
NFL analytics projects.

# Set-up
The function/plot scripts in this repository require the existence of the following nflscrapR data frames:

1.  Play-by-play data for each NFL season (e.g. "pbp_2018") including series success
2.  Player statistics data for each NFL season (e.g. "playerstats_2018")
3.  Full roster data for each NFL season (e.g. "rosters_2018")

To create these, run the "Local Load Setup.R" script after opening the project.  It should take less than a minute.

If for any reason there are no .rds files in the "Data/" directory, they can be re-generated using the "Master Project Setup.R" script.  This will take several hours.