####
#### Requirements:
####    1.  next-gen-scrapy tracking data frame
####        (named "tracking_####" e.g. "tracking_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define plot function
# takes season as input (e.g. "2019")
plot_passer_heatmap_3 <- function(season = "overall") {
  # create data frame variable based on season input, e.g. "2018" -> "tracking_2018"
  tracking_input <- paste("tracking", season, sep = "_")
  # load data frame into local variable
  tracking_input <- get(tracking_input)
  
  # filter data to player pass completions
  completions <-
    na.omit(filter(tracking_input, name=="Tom Brady", pass_type=="COMPLETE"))
  
  incompletions <-
    na.omit(filter(tracking_input, name=="Tom Brady", pass_type=="INCOMPLETE"))
  
  # source theme
  source("Functions/theme_heatmap.R")
  
  # plot heatmap
  ggplot()+
    # geom_bin2d(data=completions, mapping=aes(x_coord, y_coord), bins=100) +
    geom_bin2d(data=incompletions, mapping=aes(x_coord, y_coord), bins=100) +
    scale_fill_gradient(low="brown", high="red") +
    theme_heatmap() +
    labs(
      y = "Yards Downfield",
      title = "Completed Passes",
      subtitle = "Tom Brady (2017-2019)",
      caption = "Figure: @thePatsStats | Data: next-gen-scrapy-2.0"
    )
}