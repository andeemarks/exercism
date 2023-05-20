public class Lasagna {
    public int expectedMinutesInOven() {
        return 40;
    }

    public int remainingMinutesInOven(int elapsedCookingTimeInMinutes) {
        return expectedMinutesInOven() - elapsedCookingTimeInMinutes;
    }

    public int preparationTimeInMinutes(int numberOfLayers) {
        return numberOfLayers * 2;
    }

    public int totalTimeInMinutes(int numberOfLayers, int elapsedCookingTimeInMinutes) {
        return preparationTimeInMinutes(numberOfLayers) + elapsedCookingTimeInMinutes;
    }
}
