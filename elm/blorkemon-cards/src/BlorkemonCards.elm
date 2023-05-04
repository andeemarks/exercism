module BlorkemonCards exposing
    ( Card
    , compareShinyPower
    , expectedWinner
    , isMorePowerful
    , maxPower
    , sortByCoolness
    , sortByMonsterName
    )


type alias Card =
    { monster : String, power : Int, shiny : Bool }


isMorePowerful : Card -> Card -> Bool
isMorePowerful card1 card2 =
    card1.power > card2.power


maxPower : Card -> Card -> Int
maxPower card1 card2 =
    max card1.power card2.power


sortByMonsterName : List Card -> List Card
sortByMonsterName cards =
    cards
        |> List.sortBy .monster


sortByCoolness : List Card -> List Card
sortByCoolness cards =
    cards
        |> List.sortWith compareCoolness


compareCoolness : Card -> Card -> Order
compareCoolness card1 card2 =
    if card1.shiny == card2.shiny then
        compare card2.power card1.power

    else if card1.shiny && not card2.shiny then
        Basics.LT

    else
        Basics.GT


compareShinyPower : Card -> Card -> Order
compareShinyPower card1 card2 =
    if card1.power == card2.power then
        if card1.shiny == card2.shiny then
            Basics.EQ

        else if card1.shiny && not card2.shiny then
            Basics.GT

        else
            Basics.LT

    else
        compare card1.power card2.power


expectedWinner : Card -> Card -> String
expectedWinner card1 card2 =
    case compareShinyPower card1 card2 of
        Basics.EQ ->
            "too close to call"

        Basics.GT ->
            card1.monster

        Basics.LT ->
            card2.monster
