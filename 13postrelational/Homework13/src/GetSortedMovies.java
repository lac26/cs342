import oracle.kv.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.*;

/**
 * Created by lac26 on 5/10/2017.
 */
public class GetSortedMovies {

    public static void main(String[] args) throws SQLException {
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
        execute(jdbcConnection);
    }

    public static void execute(Connection connection) throws SQLException {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        //pass store and jdbcConnection to LoadDB, loads data into store
        LoadDB.loadMovies(store, connection);

        //first param is title, 2nd param is date
        Map<String, Movie> movies = new Hashtable<>();
        Key key = Key.createKey(Arrays.asList("movie"));


        String name = "";
        String year = "";


        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            if(field.getKey().getMinorPath().get(1).equals("name")) {
                name = new String(field.getValue().getValue().getValue());
            }
            if(field.getKey().getMinorPath().get(1).equals("year")) {
                year = new String(field.getValue().getValue().getValue());
            }
            Movie movie = new Movie(name, year);
            movies.put(name, movie);
        }



        //not yet sorted years
        List<Movie> yearsToSort = new ArrayList<Movie>(movies.values());

        System.out.print(yearsToSort.get(0).getYear());
        //sort the years

        Collections.sort(yearsToSort, new Comparator<Movie>() {
            @Override
            public int compare(Movie o1, Movie o2) {
                return  Integer.parseInt(o1.getYear()) - Integer.parseInt(o2.getYear());
            }
        });


        for(int i=0; i< yearsToSort.size(); i++){
            System.out.println(movies.get(i).getTitle());
        }

    }
}
