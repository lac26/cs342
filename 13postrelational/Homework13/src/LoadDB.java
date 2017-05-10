import oracle.kv.*;

import java.sql.*;
import java.util.Arrays;

/**
 * Created by lac26 on 5/9/2017.
 * Pulls data using JDBC and puts the data into KVLite
 */
public class LoadDB {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
    }

    //load the data from movie using JDBC and then read the data into Kvstore
    public static void loadMovies(KVStore store, Connection jdbcConnection) throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet movies = jdbcStatement.executeQuery("SELECT id, name, year, rank  FROM Movie");
        while(movies.next()){

            //create a key for the name.  Setup so can say /movie/movie_id/name
            Key name_key = Key.createKey(Arrays.asList(), Arrays.asList(movies.getString(1), "name"));
            //value that would come up at /movie/movie_id/name i.e. the name of the movie
            Value name_val = Value.createValue(movies.getString(2).getBytes());

            //similarly, create a key for the year.  /movie/movie_id/year
            Key year_key = Key.createKey(Arrays.asList(), Arrays.asList(movies.getString(1), "year"));
            //value corresponding to /movie/movie_id/year
            Value year_val = Value.createValue(movies.getString(3).getBytes());

            //create a key for rank /movie/movie_id/rank
            Key rank_key = Key.createKey(Arrays.asList(), Arrays.asList(movies.getString(1), "rank"));
            //value corresponding to /movie/movie_id/rank
            Value key_val = Value.createValue(movies.getString(4).getBytes());
        }
    }
}
