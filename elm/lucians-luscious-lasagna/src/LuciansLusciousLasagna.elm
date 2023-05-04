module LuciansLusciousLasagna exposing (elapsedTimeInMinutes, expectedMinutesInOven, preparationTimeInMinutes)


elapsedTimeInMinutes : number -> number -> number
elapsedTimeInMinutes layers timeInOven =
    preparationTimeInMinutes layers + timeInOven


preparationTimeInMinutes : number -> number
preparationTimeInMinutes layers =
    2 * layers


expectedMinutesInOven : number
expectedMinutesInOven =
    40
