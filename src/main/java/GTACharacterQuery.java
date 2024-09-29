/**
 * Class stores parsed data from the user's input query.
 */
public class GTACharacterQuery {
    private final String character;
    private final String location;
    private final String relation;
    private final boolean needsVehicle;

    public GTACharacterQuery(String character, String location, String relation, boolean needsVehicle) {
        this.character = character;
        this.location = location;
        this.relation = relation;
        this.needsVehicle = needsVehicle;
    }

    public String getCharacter() {
        return character;
    }

    public String getLocation() {
        return location;
    }

    public String getRelation() {
        return relation;
    }

    public boolean needsVehicle() {
        return needsVehicle;
    }
}
