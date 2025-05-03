hamming <- function(strand1, strand2) {
  stopifnot(nchar(strand1) == nchar(strand2))

  distance <- 0
  for (i in 1:nchar(strand1)) {
    if (substring(strand1, i, i) != substring(strand2, i, i)) {
      distance <- distance + 1
    }
  }
  distance
}
