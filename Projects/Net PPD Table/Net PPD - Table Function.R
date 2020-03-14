####
#### Requirements:
####    1.  nflscrapR rosters data frame
####        (named "rosters_####" e.g. "rosters_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define plot function
# takes season as input (e.g. "2019")
net_ppd_table <- function(season = "overall") {
  # create data frame variables based on season input
  drivestats_input <- paste("fo_drivestats", season, sep = "_")
  # load data frames into local variables
  drivestats_input <- get(drivestats_input)
  
  # select relevant data
  output <-
    select(
      drivestats_input,
      Season,
      Team,
      NET_PPD,
      NET_PPD_RK,
      OFF_PPD,
      OFF_PPD_RK,
      DEF_PPD,
      DEF_PPD_RK
    ) %>%
    arrange(desc(NET_PPD))
  
  # rename columns
  output <-
    summarise(
      output,
      Season,
      Team,
      "Net PPD (Rank)" = paste(NET_PPD, "(", NET_PPD_RK, ")"),
      "Offense PPD (Rank)" = paste(OFF_PPD, "(", OFF_PPD_RK, ")"),
      "Defense PPD (Rank)" = paste(DEF_PPD, "(", DEF_PPD_RK, ")")
    )
  
  # limit to first 16 rows
  output <- head(output, 16)
  
  # generate table
  output %>%
    gt() %>%
    tab_header(title = "Points Per Drive Statistics (2000-2019)",
               subtitle = "2007 Patriots - The Most Complete Team Ever?") %>%
    opt_align_table_header(align = "left") %>%
    tab_source_note(source_note = "Table: @thePatsStats | Data: Football Outsiders") %>%
    cols_align(align = "right")
}