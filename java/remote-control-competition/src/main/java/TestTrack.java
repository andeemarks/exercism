import java.util.Collections;
import java.util.List;

public class TestTrack {

    public static void race(RemoteControlCar car) {
        car.drive();
    }

    public static List<ProductionRemoteControlCar> getRankedCars(ProductionRemoteControlCar prc1,
            ProductionRemoteControlCar prc2) {
        throw new UnsupportedOperationException("Please implement the (static) TestTrack.getRankedCars() method");
    }

    public static List<ProductionRemoteControlCar> getRankedCars(List<ProductionRemoteControlCar> unsortedCars) {
        Collections.sort(unsortedCars);

        return unsortedCars;
    }
}
