import java.util.HashSet;
import java.util.List;
import java.util.stream.Collectors;

class Triangle {
    private double side1, side2, side3;
    private List<Double> allSides;

    Triangle(double side1, double side2, double side3) throws TriangleException {
        allSides = List.of(side1, side2, side3);
        validatePositiveSides(allSides);
        validateTriangleDescription(allSides);

        this.side1 = side1;
        this.side2 = side2;
        this.side3 = side3;
    }

    boolean isEquilateral() {
        return side1 == side2 && side2 == side3;
    }

    boolean isIsosceles() {
        return new HashSet<Double>(allSides).size() <= 2;
    }

    boolean isScalene() {
        return !isEquilateral() && !isIsosceles();
    }

    private void validatePositiveSides(List<Double> allSides) throws TriangleException {
        if (allSides
                .stream()
                .min(Double::compare)
                .get() == 0) {
            throw new TriangleException();
        }
    }

    private void validateTriangleDescription(List<Double> allSides) throws TriangleException {
        List<Double> sortedSides = allSides
                .stream()
                .sorted()
                .collect(Collectors.toList());
        if (sortedSides.get(2) > sortedSides.get(1) + sortedSides.get(0)) {
            throw new TriangleException();
        }
    }

}
