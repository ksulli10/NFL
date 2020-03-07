theme_heatmap <- function(base_size = 10, font = "Lato") {
  
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
      legend.position = "none",
      
      # Backgrounds
      strip.background = element_blank(),
      strip.text = large_txt,
      plot.background = element_blank(),
      plot.margin = unit(c(1, 1, 1, 1), "lines"),
      
      # Axis & Titles
      text = txt,
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      axis.line = element_blank(),
      axis.title.x = element_blank(),
      axis.title.y = bold_txt,
      plot.title = large_txt,
      
      # Panel
      panel.grid = element_line(colour = NULL),
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(colour = "#000000"),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill="#567d46"),
      panel.border = element_blank()
    )
}