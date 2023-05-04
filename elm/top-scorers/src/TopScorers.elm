module TopScorers exposing (..)

import Dict exposing (Dict)
import TopScorersSupport exposing (PlayerName)


updateGoalCountForPlayer : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
updateGoalCountForPlayer playerName playerGoalCounts =
    let
        playerGoals =
            Dict.get playerName playerGoalCounts
    in
    case playerGoals of
        Just goals ->
            Dict.update playerName (\_ -> Just (goals + 1)) playerGoalCounts

        Nothing ->
            Dict.insert playerName 1 playerGoalCounts


aggregateScorers : List PlayerName -> Dict PlayerName Int
aggregateScorers playerNames =
    List.foldl updateGoalCountForPlayer Dict.empty playerNames


removeInsignificantPlayers : Int -> Dict PlayerName Int -> Dict PlayerName Int
removeInsignificantPlayers goalThreshold playerGoalCounts =
    Dict.filter (\_ -> \goalCount -> goalCount >= goalThreshold)
        playerGoalCounts

resetPlayerGoalCount : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
resetPlayerGoalCount playerName playerGoalCounts =
    Dict.insert playerName 0 playerGoalCounts

formatPlayer : PlayerName -> Dict PlayerName Int -> String
formatPlayer playerName playerGoalCounts =
    let
        playerGoals =
            Dict.get playerName playerGoalCounts
    in
    playerName ++ ": " ++ String.fromInt (Maybe.withDefault 0 playerGoals)


formatPlayers : Dict PlayerName Int -> String
formatPlayers players =
    players
        |> Dict.map (\name -> \_ -> formatPlayer name players)
        |> Dict.values
        |> String.join ", "


combineGames : Dict PlayerName Int -> Dict PlayerName Int -> Dict PlayerName Int
combineGames game1 game2 =
    Dict.merge
        (\name game1Goals mergedGames -> Dict.insert name game1Goals mergedGames)
        (\name game1Goals game2Goals mergedGames -> Dict.insert name (game1Goals + game2Goals) mergedGames)
        (\name game2Goals mergedGames -> Dict.insert name game2Goals mergedGames)
        game1 
        game2
        Dict.empty
