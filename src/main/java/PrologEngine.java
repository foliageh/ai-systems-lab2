import org.jpl7.Query;
import org.jpl7.Term;

import java.util.Map;

/**
 * Class responsible for interacting with the Prolog engine and executing queries.
 */
public class PrologEngine {
    // Initializes the Prolog knowledge base from the specified file.
    public void initialize(String knowledgeBaseFilePath) {
        Query q = new Query("consult('" + knowledgeBaseFilePath + "')");
        if (!q.hasSolution())
            throw new RuntimeException("Failed to load the knowledge base from " + knowledgeBaseFilePath + ".");
    }

    // Executes a Prolog query and returns all results.
    public Map<String, Term>[] executeQuery(String query) {
        Query q = new Query(query);
        return q.allSolutions();
    }
}
