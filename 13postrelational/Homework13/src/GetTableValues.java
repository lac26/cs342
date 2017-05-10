import oracle.kv.*;
import java.sql.*;
import java.util.Arrays;


/**
 * Created by lac26 on 5/9/2017.
 * GetTableValues gets the basic fields from the Movie table
 */
public class GetTableValues {

    /*
    Main establishes the JDBC connection and calls the methods that executes the query
     */
    public static void main(String[] args) throws SQLException{
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
        execute(jdbcConnection);
    }



    public static void execute(Connection connection) throws SQLException {

          //not using KVlite:
        /*
        Statement jdbcStatement = connection.createStatement();
        ResultSet resultSet2 = jdbcStatement.executeQuery("SELECT name, year, TO_CHAR(rank)  FROM Movie WHERE id = 92616");
        if(resultSet2.next()) {
        System.out.println(resultSet2.getString(1) + "\n"
                + resultSet2.getInt(2) + "\n"
                + resultSet2.getString(3));

        }
        resultSet2.close();
        */

        // using KVLite
        //create store
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        //pass store and jdbcConnection to LoadDB, loads data into store
        LoadDB.loadMovies(store, connection);

        //create keys to get the name, year, and rank
        Key name_key = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("name"));
        Key year_key = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("year"));
        Key rank_key = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("rank"));

        //the intro statement
        System.out.println("Table:" + "\t" + "movie" + "\n" + "ID:" + "\t" + "92616");

        //get and print out the corresponding value for each key

        if (store.get(name_key) != null) {
            String nameResult = new String(store.get(name_key).getValue().getValue());
            System.out.println(nameResult);
        }

        if(store.get(year_key) != null ){
            String yearResult = new String (store.get(year_key).getValue().getValue());
            System.out.println(yearResult);
        }

        if(store.get(rank_key) !=null){
            String rankResult = new String (store.get(rank_key).getValue().getValue());
            System.out.println(rankResult);
        }


        store.close();

    }
}
