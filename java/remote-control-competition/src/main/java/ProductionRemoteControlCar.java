class ProductionRemoteControlCar implements RemoteControlCar, Comparable {
    private int distance = 0;
    private int numberOfVictories;

    public void drive() {
        this.distance += 10;
    }

    public int getDistanceTravelled() {
        return this.distance;
    }

    public int getNumberOfVictories() {
        return this.numberOfVictories;
    }

    public void setNumberOfVictories(int numberOfVictories) {
        this.numberOfVictories = numberOfVictories;
    }

    @Override
    public int compareTo(Object o) {
        ProductionRemoteControlCar otherCar = ((ProductionRemoteControlCar) o);

        return otherCar.getNumberOfVictories() - this.getNumberOfVictories();
    }
}
