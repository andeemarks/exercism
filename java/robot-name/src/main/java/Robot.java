import java.util.HashSet;
import java.util.Random;
import java.util.Set;

class Robot {

    private String name;
    private Random r = new Random();

    private static Set<String> pastNames = new HashSet<String>();

    public Robot() {
        setName();
    }

    public String getName() {
        return this.name;
    }

    public void reset() {
        setName();
    }

    private void setName() {
        this.name = generateUniqueName();
        pastNames.add(this.name);
    }

    private String generateUniqueName() {
        String name = String.format("%s%03d", randomPrefix(), randomSuffix());
        while (pastNames.contains(name)) {
            name = String.format("%s%03d", randomPrefix(), randomSuffix());
        }
        pastNames.add(name);

        return name;
    }

    private int randomSuffix() {
        return r.nextInt(999);
    }

    private String randomPrefix() {
        return randomLetter() + randomLetter();
    }

    private String randomLetter() {
        return "" + (char) ('A' + r.nextInt(26));
    }

}