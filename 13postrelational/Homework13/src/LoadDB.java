import oracle.kv.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
/**
 * Created by lac26 on 5/9/2017.
 *  Pull data from the OracleXE IMDB Movie, Actor and Role tables and load it into Oracle KVLite using a key-value structure
 */


public class LoadDB {
    /* loadMovie loads the data from movie using JDBC and then puts the data into KVLite
    @param KVStore store, KVLite store to load data into
    @param Connection jdbcConnection, connection to use when pulling data using JDBC
     */
    public static void loadMovies(KVStore store, Connection jdbcConnection) throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        //store query results into movies
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

    /* loadActors loads the data from actors using JDBC and then puts the data into KVLite
    @param KVStore store, KVLite store to load data into
    @param Connection jdbcConnection, connection to use when pulling data using JDBC
     */
    public static void loadActors(KVStore store, Connection jdbcConnection) throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();

        //store results from query in actors
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


    /* loadRoles loads the data from role using JDBC and then puts the data into KVLite
    @param KVStore store, KVLite store to load data into
    @param Connection jdbcConnection, connection to use when pulling data using JDBC
     */
    public static void loadRoles(KVStore store, Connection jdbcConnection) throws SQLException {
        //get all of the actors for a specific movie
        Statement jdbcStatement = jdbcConnection.createStatement();
        //select data from Role
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT movieid, actorid, role FROM Role");

        //list of movie keys
        ArrayList<Key> movieKeys = new ArrayList<>();
        //list of movie values
        ArrayList<ArrayList<String>> actorRoles = new ArrayList<>();

        while(resultSet.next()){
            //make a key allowing it to be searchable by the movie id
            Key movieKey = Key.createKey(Arrays.asList("movie", resultSet.getString(1)), Arrays.asList("actorToMovie", resultSet.getString(2)));
            // get the role and append to list (originally had just appending value here but then could not get multiple roles)
            if(!movieKeys.contains(movieKey)){ //if actor associated does not have an array created yet, add the movie and create an array for roles
                movieKeys.add(movieKey); //add the movie
                actorRoles.add(new ArrayList<>());
            }
            String actorRole = new String(resultSet.getString(3).getBytes());
            //add the entry to the correct array list inside of movieKeys
            actorRoles.get(movieKeys.indexOf(movieKey)).add(actorRole);
        }

        //retrieve the key stored in movieKeys and the value
        for (int i =0; i<movieKeys.size(); i++){
            //get the correct array (stored at i at actorRoles).  Will store the whole array as the value but need to convert it to a string to do that.
            String role = actorRoles.get(i).toString();
            Value roleVal = Value.createValue(role.getBytes());
            store.put(movieKeys.get(i), roleVal);
        }
    }
}


