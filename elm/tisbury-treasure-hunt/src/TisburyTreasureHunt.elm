module TisburyTreasureHunt exposing (..)


type alias PlaceLocation =
    ( Char, Int )


type alias TreasureLocation =
    ( Int, Char )


type alias Place =
    String


placeLocationToTreasureLocation : PlaceLocation -> TreasureLocation
placeLocationToTreasureLocation ( mapX, mapY ) =
    ( mapY, mapX )


treasureLocationMatchesPlaceLocation : PlaceLocation -> TreasureLocation -> Bool
treasureLocationMatchesPlaceLocation placeLocation treasureLocation =
    treasureLocation == placeLocationToTreasureLocation placeLocation


countPlaceTreasures : ( Place, PlaceLocation ) -> List ( Place, TreasureLocation ) -> Int
countPlaceTreasures ( _, placeLocation ) treasures =
    List.map Tuple.second treasures
        |> List.filter (treasureLocationMatchesPlaceLocation placeLocation)
        |> List.length


specialCaseSwapPossible : ( Place, TreasureLocation ) -> ( Place, PlaceLocation ) -> ( Place, TreasureLocation ) -> Bool
specialCaseSwapPossible ( foundTreasure, _ ) ( place, _ ) ( desiredTreasure, _ ) =
    case ( foundTreasure, place, desiredTreasure ) of
        ( _, "Abandoned Lighthouse", _ ) ->
            True

        ( "Amethyst Octopus", "Stormy Breakwater", "Crystal Crab" ) ->
            True

        ( "Amethyst Octopus", "Stormy Breakwater", "Glass Starfish" ) ->
            True

        ( "Vintage Pirate Hat", "Harbor Managers Office", "Model Ship in Large Bottle" ) ->
            True

        ( "Vintage Pirate Hat", "Harbor Managers Office", "Antique Glass Fishnet Float" ) ->
            True

        _ ->
            False
