import org.jpl7.Term;

import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Scanner;

/**
 * Main class for the GTA Recommendation System.
 */
public class GTARecommendationSystem {
    private final PrologEngine prologEngine;
    private final GTAQueryProcessor queryProcessor;

    public GTARecommendationSystem() {
        this.prologEngine = new PrologEngine();
        this.queryProcessor = new GTAQueryProcessor();
    }

    // Main method for running the recommendation system.
    public void run() {
        // Initialize knowledge base
        prologEngine.initialize("gta_sa_knowledge_base.pl");

        // Welcome messages
        System.out.println("Welcome to GTA San Andreas recommendation system!");
        System.out.println("Query format:");
        System.out.println("\t(I'm character_name and) I need to find people (in location_name) who are <members of my gang|my friends|my allies|my enemies> (and who has a vehicle).");

        // Main loop for user queries
        Scanner console = new Scanner(System.in);
        while (true) {
            System.out.print("\nEnter your query: ");
            try {
                String query = console.nextLine();
                parseAndExecuteQuery(query);
            } catch (NoSuchElementException e) {
                System.out.println("Exiting...");
                break;
            }
        }
    }

    // Processes the user input, executes query and displays results
    private void parseAndExecuteQuery(String query) {
        // Process and validate user input query
        GTACharacterQuery queryData = queryProcessor.processInputQuery(query);
        if (queryData == null) {
            System.out.println("Invalid input format. Please try again.");
            return;
        }

        // Build Prolog query based on user query data
        String prologQuery = queryProcessor.buildPrologQuery(queryData);
        System.out.println("Query: " + prologQuery);

        // Execute query and display results
        Map<String, Term>[] results = prologEngine.executeQuery(prologQuery);
        displayResults(results);
    }

    // Displays the results of a Prolog query
    private void displayResults(Map<String, Term>[] results) {
        if (results.length == 0) {
            System.out.println("No results found.");
        } else {
            System.out.println("Found characters:");
            for (Map<String, Term> result : results)
                System.out.println(result.get("ResultList").toString());
        }
    }
}
