abstract class Fighter {

    boolean isVulnerable() {
        return false;
    }

    abstract int damagePoints(Fighter fighter);

}

class Warrior extends Fighter {

    @Override
    public String toString() {
        return "Fighter is a Warrior";
    }

    @Override
    int damagePoints(Fighter wizard) {
        return wizard.isVulnerable() ? 10 : 6;
    }
}

class Wizard extends Fighter {
    private boolean hasSpellPrepared = false;

    @Override
    public String toString() {
        return "Fighter is a Wizard";
    }

    @Override
    boolean isVulnerable() {
        return !this.hasSpellPrepared;
    }

    @Override
    int damagePoints(Fighter warrior) {
        return this.hasSpellPrepared ? 12 : 3;
    }

    void prepareSpell() {
        this.hasSpellPrepared = true;
    }

}