####
#### Requirements:
####    1.  nflscrapR play-by-play data frame
####        (named "pbp_####" e.g. "pbp_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define function
thomasmock_pbp_clean <- function(season) {
  # create data frame variable based on season input, e.g. "2018" -> "pbp_2018"
  pbp_input <- paste("pbp", season, sep = "_")
  # load data frame into local variable
  pbp_input <- get(pbp_input)
  
  pbp_rp <- pbp_input %>%
    # grab only penalties, pass, and run plays
    filter(!is.na(epa),
           play_type == "no_play" |
             play_type == "pass" | play_type == "run") %>%
    # create pass, rush and success columns
    mutate(
      pass = if_else(str_detect(desc, "(pass)|(sacked)|(scramble)"), 1, 0),
      rush = if_else(
        str_detect(
          desc,
          "(left end)|(left tackle)|(left guard)|(up the middle)|(right guard)|(right tackle)|(right end)"
        ) & pass == 0,
        1,
        0
      ),
      success = ifelse(epa > 0, 1, 0)
    ) %>%
    # filter to only pass or rush plays
    filter(pass == 1 | rush == 1) %>%
    mutate(
      passer_player_name = ifelse(
        play_type == "no_play" & pass == 1,
        str_extract(
          desc,
          "(?<=\\s)[A-Z][a-z]*\\.\\s?[A-Z][A-z]+(\\s(I{2,3})|(IV))?(?=\\s((pass)|(sack)|(scramble)))"
        ),
        passer_player_name
      ),
      receiver_player_name = ifelse(
        play_type == "no_play" & str_detect(desc, "pass"),
        str_extract(
          desc,
          "(?<=to\\s)[A-Z][a-z]*\\.\\s?[A-Z][A-z]+(\\s(I{2,3})|(IV))?"
        ),
        receiver_player_name
      ),
      rusher_player_name = ifelse(
        play_type == "no_play" & rush == 1,
        str_extract(
          desc,
          "(?<=\\s)[A-Z][a-z]*\\.\\s?[A-Z][A-z]+(\\s(I{2,3})|(IV))?(?=\\s((left end)|(left tackle)|(left guard)|      (up the middle)|(right guard)|(right tackle)|(right end)))"
        ),
        rusher_player_name
      )
    ) %>%
    mutate(
      name = if_else(
        !is.na(passer_player_name),
        passer_player_name,
        rusher_player_name
      ),
      rusher = rusher_player_name,
      receiver = receiver_player_name,
      play = 1
    )
  
  # return cleaned pbp data frame
  return(pbp_rp)
}