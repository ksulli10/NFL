####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define function
get_comp_pct_stats <- function(season = "overall") {
  # create data frame variable based on season input, e.g. "2018" -> "pbp_2018"
  pbp_input <- paste("pbp", season, sep = "_")
  # load data frame into local variable
  pbp_input <- get(pbp_input)
  
  # get pass completions by air yards
  output <-
    filter(pbp_input,
           complete_pass == 1,
           play_type == "pass",
           half_seconds_remaining >= 60) %>%
    select(play_type, complete_pass, air_yards) %>%
    group_by(air_yards) %>%
    count(complete_pass) %>%
    ungroup() %>%
    mutate(pass_completions = n) %>%
    select(air_yards, pass_completions)
  
  # get pass attempts by air yards
  output <-
    right_join(
      output,
      filter(
        pbp_input,
        play_type == "pass",
        half_seconds_remaining >= 60,!is.na(air_yards)
      ) %>%
        select(play_type, air_yards) %>%
        group_by(air_yards) %>%
        count(play_type) %>%
        ungroup() %>%
        mutate(pass_att = n) %>%
        select(air_yards, pass_att),
      by = "air_yards"
    )
  
  # change anything NA to a 0
  output <-
    mutate_all(output, ~ replace(., is.na(.), 0))
  
  # calculate rate stats and order columns
  output <-
    mutate(output,
           pass_comp_rate = round(pass_completions / pass_att, 4)) %>%
    select(air_yards,
           pass_completions,
           pass_att,
           pass_comp_rate)
  
  # return output data frame
  return (output)
}