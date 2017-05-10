import oracle.kv.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;

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
        while(movies.next()) {

            //create a key for the name.  Setup so can say /movie/movie_id/name
            Key name_key = Key.createKey(Arrays.asList("movie", movies.getString(1)), Arrays.asList("name"));
            //value that would come up at /movie/movie_id/name i.e. the name of the movie
            Value name_val = Value.createValue(movies.getString(2).getBytes());

            //similarly, create a key for the year.  /movie/movie_id/year
            Key year_key = Key.createKey(Arrays.asList("movie", movies.getString(1)), Arrays.asList("year"));
            //value corresponding to /movie/movie_id/year
            Value year_val = Value.createValue(movies.getString(3).getBytes());

            //create a key for rank /movie/movie_id/rank
            Key rank_key = Key.createKey(Arrays.asList("movie", movies.getString(1)), Arrays.asList("rank"));
            //value corresponding to /movie/movie_id/rank
            Value key_val;
            if(movies.getString(4) != null) {
                key_val = Value.createValue(movies.getString(4).getBytes());
            }
            else{
                key_val = Value.createValue("".getBytes());
            }

            //put all the keys and the vals in the store
            store.put(name_key, name_val);
            store.put(year_key, year_val);
            store.put(rank_key, key_val);
        }

            movies.close();
            jdbcStatement.close();
        }

    public static void loadActors(KVStore store, Connection jdbcConnection) throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet actors = jdbcStatement.executeQuery("SELECT id, firstname, lastname FROM Actor");

        while(actors.next()){
            //create a key for the name.  Setup so can say /actor/actor_id/firstname
            Key firstName_key = Key.createKey(Arrays.asList("actor", actors.getString(1)), Arrays.asList("firstname"));
            //value that would come up at /actor/actor_id/firstname i.e. the first name of the actor
            Value firstName_val = Value.createValue(actors.getString(2).getBytes());

            //create a key for the last name.  Setup so can say /actor/actor_id/lastname
            Key lastName_key = Key.createKey(Arrays.asList("actor", actors.getString(1)), Arrays.asList("lastname"));
            //value that would come up at /actor/actor_id/lastname i.e. the last name of the actor
            Value lastName_val = Value.createValue(actors.getString(3).getBytes());

            store.put(firstName_key, firstName_val);
            store.put(lastName_key, lastName_val);
        }

        actors.close();
        jdbcStatement.close();

    }

    public static void loadRoles(KVStore store, Connection jdbcConnection) throws SQLException {

    }

    }


