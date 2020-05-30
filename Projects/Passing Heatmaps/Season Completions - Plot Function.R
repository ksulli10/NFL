####
#### WARNING: This is an experimental file and is currently non-functional.
####

####
#### Requirements:
####    1.  next-gen-scrapy tracking data frame
####        (named "tracking_####" e.g. "tracking_2018")
####
####    * Run "Local Load Setup.R" to load the necessary files from "Data/" into data frames
####

# define plot function
# takes season as input (e.g. "2019")
plot_passer_heatmap <- function(season = "overall") {
  # create data frame variable based on season input, e.g. "2018" -> "tracking_2018"
  tracking_input <- paste("tracking", season, sep = "_")
  # load data frame into local variable
  tracking_input <- get(tracking_input)
  
  # create empty field data frame
  empty_field_x <- c(-27:27)
  empty_field_y <- c(-9:60)
  empty_field <- expand.grid(empty_field_x, empty_field_y) %>%
    arrange(Var1) %>%
    select(x_coord = Var1, y_coord = Var2)
  
  # group empty field by 3x3 yard intervals
  empty_field <-
    group_by(
      empty_field,
      x_gr = cut(x_coord, breaks = seq(-27, 27, by = 3)),
      y_gr = cut(y_coord, breaks = seq(-9, 60, 3))
    ) %>%
    summarise() %>%
    ungroup()
  
  # remove NA
  empty_field <- na.omit(empty_field)
  
  # filter data to player pass completions
  tracking_input <-
    na.omit(filter(tracking_input, name == "Tom Brady", pass_type == "COMPLETE"))
  
  # group by 3x3 yard intervals
  tracking_input <-
    group_by(
      tracking_input,
      x_gr = cut(x_coord, breaks = seq(-27, 27, by = 3)),
      y_gr = cut(y_coord, breaks = seq(-9, 60, 3))
    ) %>%
    summarise(n = n()) %>%
    na.omit() %>%
    ungroup()
  
  # join dfs
  output <-
    left_join(empty_field,
              tracking_input,
              by = c("x_gr" = "x_gr", "y_gr" = "y_gr")) %>%
    mutate_all( ~ replace(., is.na(.), 0))
  
  # source theme
  source("Functions/theme_heatmap.R")
  
  # plot heatmap
  output %>%
    ggplot(aes(x_gr, y_gr)) +
    geom_raster(aes(fill = n), interpolate = TRUE) +
    theme_heatmap() +
    scale_fill_gradient(low = "#567d46",
                        high = "#cf350e",
                        na.value = "#ffffff") +
    # scale_y_discrete()
    labs(
      y = "Yards Downfield",
      title = "Completed Passes - Heatmap",
      subtitle = paste("Tom Brady (", season, ")", sep = ""),
      caption = "Figure: @thePatsStats | Data: next-gen-scrapy-2.0"
    )
}