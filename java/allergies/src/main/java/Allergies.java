import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

class Allergies {

    private int allergyScore;

    public Allergies(int allergyScore) {
        this.allergyScore = allergyScore;
    }

    public boolean isAllergicTo(Allergen allergen) {
        return ((allergyScore & allergen.getScore()) != 0);
    }

    public List<Allergen> getList() {
        Stream<Allergen> allergens = Stream.of(Allergen.values());

        return allergens.filter(this::isAllergicTo).collect(Collectors.toList());
    }

}