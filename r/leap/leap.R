leap <- function(year) {
  if (!divisible_by(year, 4)) {
    return(FALSE)
  }

  if (divisible_by(year, 100)) {
    divisible_by(year, 400)
  } else {
    TRUE
  }
}

divisible_by <- function(number, divisor) {
  number %% divisor == 0
}