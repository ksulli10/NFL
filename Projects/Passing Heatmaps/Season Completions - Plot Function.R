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
  
  # # combine data by coordinates
  # tracking_input <-
  #   mutate(tracking_input, x_coord = round(x_coord, 0), y_coord = round(y_coord, 0))
  
  # filter data to player pass completions
  # combine data by coordinate blocks of 1 square yard
  tracking_input <-
    na.omit(filter(tracking_input, name == "Tom Brady", pass_type == "COMPLETE")) %>%
    mutate(x_coord = round(x_coord, 0),
           y_coord = round(y_coord, 0)) %>%
    group_by(x_coord, y_coord) %>%
    count(pass_type)
  
  # plot heatmap
  tracking_input %>%
    ggplot(aes(x_coord, y_coord)) +
    geom_raster(aes(fill = n))
}