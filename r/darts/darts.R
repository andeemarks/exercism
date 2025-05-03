score <- function(x, y) {
  if (is_outside_target(x, y)) return(0)
  if (is_outer_circle(x, y)) return(1)
  if (is_middle_circle(x, y)) return(5)

  10
}

is_outside_target <- function(x, y) {
  distance_from_centre(x, y) > 10
}

is_middle_circle <- function(x, y) {
  distance_from_centre(x, y) <= 5 && distance_from_centre(x, y) > 1
}

is_outer_circle <- function(x, y) {
  distance_from_centre(x, y) <= 10 && distance_from_centre(x, y) > 5
}

distance_from_centre <- function(x, y) {
  sqrt(x ^ 2 + y ^ 2)
}