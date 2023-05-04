module ValentinesDay exposing (..)


type Activity
    = BoardGame
    | Chill
    | Movie MovieGenre
    | Restaurant Cuisine


type MovieGenre
    = Crime
    | Horror
    | Romance
    | Thriller


type Cuisine
    = Korean
    | Turkish


type Rating
    = No
    | Yes
    | Maybe


rateActivity : Activity -> Rating
rateActivity activity =
    case activity of
        Movie Romance ->
            Yes

        Restaurant Korean ->
            Yes

        Restaurant Turkish ->
            Maybe

        _ ->
            No
