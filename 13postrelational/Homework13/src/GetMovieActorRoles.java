import oracle.kv.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;


/**
 * Created by lac26 on 5/9/2017.
 * GetMovieActorRoles gets the roles, if any, for which a given actor is cast in a given movie.
 */
public class GetMovieActorRoles {
    /*
        Main establishes the JDBC connection and calls the methods that executes the query
    */
    public static void main(String[] args) throws SQLException {
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
        execute(jdbcConnection);
    }

    public static void execute(Connection connection) throws SQLException {
        //create store
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        //load the actors and the roles of those actors
        LoadDB.loadActors(store, connection);
        LoadDB.loadRoles(store, connection);

        //hardcode the movieId and the actorId
        String movieId = "92616";
        String actorId = "429719";

        //key all actors in movie with movieId and with id of actorId
        Key key = Key.createKey(Arrays.asList("movie", movieId), Arrays.asList("actorToMovie", actorId));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);

        //print intro statement
        System.out.println("Movie ID:" + "\t" + movieId + "\n" + "Actor ID" + "\t" + actorId);

        //for all actors with id actorId in the movie get the roles
        for (Map.Entry<Key, ValueVersion> field2 : fields.entrySet()) {
            String role = new String(field2.getValue().getValue().getValue());
            //cut of the [ and the ]
            String cleaned_role = role.substring(1, role.length() - 1);
            //convert the string to an array
            String[] array = cleaned_role.split(",");
            //print out each role for actor
            for (String actor_role : array) {
                System.out.println("\t" + actor_role);
            }
        }
    }
}
