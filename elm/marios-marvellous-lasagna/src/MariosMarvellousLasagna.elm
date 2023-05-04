module MariosMarvellousLasagna exposing (remainingTimeInMinutes)


remainingTimeInMinutes : number -> number -> number
remainingTimeInMinutes layers timeInOven =
    let
        expectedMinutesInOven =
            40

        preparationTimeInMinutes =
            2
    in
    layers * preparationTimeInMinutes + expectedMinutesInOven - timeInOven
