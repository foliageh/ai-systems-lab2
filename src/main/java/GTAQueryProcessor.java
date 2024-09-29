import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Class responsible for constructing Prolog queries from user input.
 */
public class GTAQueryProcessor {
    private static final String QUERY_REGEX =
            "(?:I'm (?<character>[a-z_]+) and )?" +
                    "I need to find people(?: in (?<location>[a-z_]+))?" +
                    " who are (?<relation>members of my gang|my friends|my allies|my enemies)" +
                    "(?<vehicle> and who has a vehicle)?.";

    private final Pattern queryPattern;

    public GTAQueryProcessor() {
        this.queryPattern = Pattern.compile(QUERY_REGEX);
    }

    // Processes the user input query and returns query data if input is valid, null otherwise.
    public GTACharacterQuery processInputQuery(String inputQuery) {
        Matcher matcher = queryPattern.matcher(inputQuery);
        if (!matcher.matches())
            return null;

        String character = matcher.group("character");
        String location = matcher.group("location");
        String relation = matcher.group("relation");
        boolean needsVehicle = matcher.group("vehicle") != null;

        // If no character is specified, default to "cj"
        if (character == null)
            character = "cj";

        return new GTACharacterQuery(character, location, relation, needsVehicle);
    }

    // Builds a Prolog query string based on the user query data.
    public String buildPrologQuery(GTACharacterQuery queryData) {
        StringBuilder query = new StringBuilder();
        query.append("findall(Character, (");

        switch (queryData.getRelation()) {
            case "members of my gang":
                query.append("gang_member(Character, Gang), gang_member(").append(queryData.getCharacter()).append(", Gang)");
                break;
            case "my friends":
                query.append("are_friends(Character, ").append(queryData.getCharacter()).append(")");
                break;
            case "my allies":
                query.append("are_allies(Character, ").append(queryData.getCharacter()).append(")");
                break;
            case "my enemies":
                query.append("is_enemy(Character, ").append(queryData.getCharacter()).append(")");
                break;
        }
        if (queryData.getLocation() != null)
            query.append(", located_in(Character, ").append(queryData.getLocation()).append(")");
        if (queryData.needsVehicle())
            query.append(", vehicle(Character, _)");

        query.append(", Character \\= ").append(queryData.getCharacter());
        query.append("), CharacterList), maplist(term_string, CharacterList, ResultList)");
        return query.toString();
    }
}
