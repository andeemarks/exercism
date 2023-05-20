public class ElonsToyCar {

    private int distance = 0;
    private int batteryCharge = 100;

    public static ElonsToyCar buy() {
        return new ElonsToyCar();
    }

    public String distanceDisplay() {
        return String.format("Driven %d meters", distance);
    }

    public String batteryDisplay() {
        if (batteryCharge <= 0) {
            return "Battery empty";
        } else {
            return "Battery at " + batteryCharge + "%";
        }
    }

    public void drive() {
        this.batteryCharge -= 1;
        if (this.batteryCharge >= 0) {
            this.distance += 20;
        }
    }
}
