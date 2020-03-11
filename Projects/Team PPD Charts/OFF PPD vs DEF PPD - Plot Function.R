ggplot(fo_drivestats_overall, aes(x = DEF_PPD, y = OFF_PPD)) + geom_point() +
  geom_abline(linetype = "dashed") + geom_text(aes(label = paste(Team, Season)), check_overlap = TRUE)