
class BirdWatcher {
    private static final int BUSY_DAY_THRESHOLD = 5;
    private final int[] birdsPerDay;
    private int daysCounted;

    public BirdWatcher(int[] birdsPerDay) {
        this.birdsPerDay = birdsPerDay.clone();
        this.daysCounted = birdsPerDay.length;
    }

    public int[] getLastWeek() {
        return this.birdsPerDay;
    }

    public int getToday() {
        return this.birdsPerDay[this.daysCounted - 1];
    }

    public void incrementTodaysCount() {
        this.birdsPerDay[this.daysCounted - 1] = getToday() + 1;
    }

    public boolean hasDayWithoutBirds() {
        for (int count : this.birdsPerDay) {
            if (count == 0) {
                return true;
            }
        }

        return false;
    }

    public int getCountForFirstDays(int days) {
        int count = 0;
        for (int i = 0; i < Math.min(days, this.daysCounted); i++) {
            count += this.birdsPerDay[i];
        }

        return count;
    }

    public int getBusyDays() {
        int numberOfBusyDays = 0;
        for (int count : this.birdsPerDay) {
            if (count >= BUSY_DAY_THRESHOLD) {
                numberOfBusyDays++;
            }
        }

        return numberOfBusyDays;
    }
}
