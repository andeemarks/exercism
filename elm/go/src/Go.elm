module Go exposing (..)

import GoSupport exposing (..)


applyRules : Game -> Rule -> NonValidatingRule -> Rule -> Rule -> Game
applyRules game oneStonePerPointRule captureRule libertyRule koRule =
    case
        game
            |> oneStonePerPointRule
            |> Result.andThen libertyRule
            |> Result.andThen koRule
    of
        Ok updatedGame ->
            updatedGame
                |> captureRule
                |> changePlayer

        Err msg ->
            { game | error = msg }
