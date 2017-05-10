import oracle.kv.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;

/**
 * Created by lac26 on 5/10/2017.
 * GetMovieActors gets the roles, if any, for a given actor cast in a given movie
 */
public class GetMovieActors {

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

        //get the actors and the roles of the actors
        LoadDB.loadActors(store, connection);
        LoadDB.loadRoles(store,connection);

        //create key that gets all of the actors in movie with id 92616
        Key actorMajorKey = Key.createKey(Arrays.asList("actor", "92616"));

        //intro statement
        System.out.println("Movie: 92616");

        //key to get roles of actors in movie 92616
        Key key = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("actorToMovie"));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);

        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            //to get id of the actor
            String actor_id = field.getKey().getMinorPath().get(1);
            //get the information for the actor
            String first = "";
            String last = "";
            Map<Key, ValueVersion> actor = store.multiGet(Key.createKey(Arrays.asList("actor", actor_id)), null, null);
            for (Map.Entry<Key, ValueVersion> field2 : actor.entrySet()) {
                if (field2.getKey().getMinorPath().get(0).equals("firstname")) {
                    first = new String(field2.getValue().getValue().getValue());
                }if (field2.getKey().getMinorPath().get(0).equals("lastname")) {
                    last = new String(field2.getValue().getValue().getValue());
                }
            }

            //get the role of the actor
            String role = new String(field.getValue().getValue().getValue());
            String cleaned_role = role.substring(1, role.length()-1);

            //convert the string to an array
            String[] array = cleaned_role.split(",");

            //print out values in the array (originally had not array but string but then only got one role from actor)
            for(String actor_role: array) {
                System.out.print("\n" + actor_id + "\t" + first + "\t" + last + "\t" + actor_role);
            }

        }
    }
}
