theme_538 <- function(base_size = 10, font = "Lato") {
  
  # Text setting
  txt <- element_text(size = base_size + 1, colour = "black", face = "plain")
  bold_txt <- element_text(
    size = base_size + 1, colour = "black"
    #,
    #family = "Montserrat", face = "bold"
  )
  large_txt <- element_text(size = base_size + 2, color = "black", face = "bold")
  
  
  theme_minimal(base_size = base_size, base_family = font) +
    theme(
      # Legend Settings
      legend.key = element_blank(),
      legend.background = element_blank(),
      legend.position = "bottom",
      legend.direction = "horizontal",
      legend.box = "vertical",
      
      # Backgrounds
      strip.background = element_blank(),
      strip.text = large_txt,
      plot.background = element_blank(),
      plot.margin = unit(c(1, 1, 1, 1), "lines"),
      
      # Axis & Titles
      text = txt,
      axis.text = txt,
      axis.ticks = element_blank(),
      axis.line = element_blank(),
      axis.title = bold_txt,
      plot.title = large_txt,
      
      # Panel
      panel.grid = element_line(colour = NULL),
      panel.grid.major = element_line(colour = "#D2D2D2"),
      panel.grid.minor = element_blank(),
      panel.background = element_blank(),
      panel.border = element_blank()
    )
}