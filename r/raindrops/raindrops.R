raindrops <- function(number) {
  not_divisible <- !divisible_by(number, 3) &&
    !divisible_by(number, 5) &&
    !divisible_by(number, 7)

  paste0(sound_for(number, 3, "Pling"),
         sound_for(number, 5, "Plang"),
         sound_for(number, 7, "Plong"),
         if (not_divisible) number, "")
}

divisible_by <- function(number, divisor) {
  number %% divisor == 0
}

sound_for <- function(number, divisor, sound) {
  if (divisible_by(number, divisor)) {
    sound
  } else {
    ""
  }
}