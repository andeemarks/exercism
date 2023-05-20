public class CarsAssemble {

    public double productionRatePerHour(int speed) {
        int fullEfficiencyProductionRate = 221 * speed;
        switch (speed) {
            case 10: {
                return fullEfficiencyProductionRate * 0.77;
            }
            case 9: {
                return fullEfficiencyProductionRate * 0.8;
            }
            case 8:
            case 7:
            case 6:
            case 5: {
                return fullEfficiencyProductionRate * 0.9;
            }
            case 4:
            case 3:
            case 2:
            case 1: {
                return fullEfficiencyProductionRate;
            }
            default: {
                return 0;
            }
        }
    }

    public int workingItemsPerMinute(int speed) {
        return (int) (productionRatePerHour(speed) / 60);
    }
}
