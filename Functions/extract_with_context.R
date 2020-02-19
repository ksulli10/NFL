# extract rows on either side
# takes dataframe and row arguments as input
extract_with_context <- function(x, rows, after = 0, before = 0) {
  
  match.idx  <- which(rownames(x) %in% rows)
  span       <- seq(from = -before, to = after)
  extend.idx <- c(outer(match.idx, span, `+`))
  extend.idx <- Filter(function(i) i > 0 & i <= nrow(x), extend.idx)
  extend.idx <- sort(unique(extend.idx))
  
  return(x[extend.idx, , drop = FALSE])
}