import oracle.kv.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;


/**
 * Created by lac26 on 5/9/2017.
 */
public class GetMovieActorRoles {

    public static void main(String[] args) throws SQLException {
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
        execute(jdbcConnection);
    }

    public static void execute(Connection connection) throws SQLException {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        //pass store and jdbcConnection to LoadDB, loads data into store
        LoadDB.loadActors(store, connection);
        LoadDB.loadRoles(store, connection);


        String movieId = "92616";
        String actorId = "429719";


        Key key = Key.createKey(Arrays.asList("movie", movieId), Arrays.asList("actorToMovie", actorId));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);

        System.out.println("Movie ID:" + "\t" + movieId + "\n" + "Actor ID" + "\t" + actorId);
        for (Map.Entry<Key, ValueVersion> field2 : fields.entrySet()) {
            String role = new String(field2.getValue().getValue().getValue());
            String cleaned_role = role.substring(1, role.length() - 1);
            //convert the string to an array
            String[] array = cleaned_role.split(",");
            //problem, getting one role instead of multiple roles
            for (String actor_role : array) {
                System.out.println("\t" + actor_role);

            }


        }
    }
}
