####
#### Requirements:
####    1.  next-gen-scrapy tracking data frame
####        (named "tracking_####" e.g. "tracking_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define plot function
# takes season as input (e.g. "2019")
plot_passer_heatmap <- function(season) {
  # create data frame variable based on season input, e.g. "2018" -> "tracking_2018"
  tracking_input <- paste("tracking", season, sep = "_")
  # load data frame into local variable
  tracking_input <- get(tracking_input)

  # combine data by coordinates
  tracking_input <-
    mutate(tracking_input, x_coord = round(x_coord, 0), y_coord = round(y_coord, 0))

  tracking_input <-
    filter(
      tracking_input,
      name == "Tom Brady",
      pass_type != "INTERCEPTION",
      pass_type != "TOUCHDOWN"
    )
  
  tracking_input %>%
    ggplot(aes(x_coord, y_coord)) +
    geom_tile(aes(fill = pass_type))
}