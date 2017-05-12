import oracle.kv.KVStore;
import oracle.kv.KVStoreConfig;
import oracle.kv.KVStoreFactory;
import oracle.kv.Key;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Arrays;

/**
 * Created by lac26 on 5/12/2017.
 * GetBookValues gets the basic values from the book table
 */

public class GetBookValues {

    /*
Main establishes the JDBC connection and calls the methods that executes the query
 */
    public static void main(String[] args) throws SQLException {
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "lydia", "pass");
        execute(jdbcConnection);
    }

    public static void execute(Connection connection) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        //load the books
        LoadDB.loadBooks(store, connection);

        String bookId = "2";

        Key author_key = Key.createKey(Arrays.asList("book", bookId), Arrays.asList("author"));
        Key title_key = Key.createKey(Arrays.asList("book", bookId), Arrays.asList("title"));
        Key edition_key = Key.createKey(Arrays.asList("book", bookId), Arrays.asList("edition"));
        Key condition_key = Key.createKey(Arrays.asList("book", bookId), Arrays.asList("condition"));

        //the intro statement
        System.out.println("Table:" + "\t" + "book" + "\n" + "ID:" + "\t" + bookId);


        if (store.get(author_key) != null) {
            String authorResult = new String(store.get(author_key).getValue().getValue());
            System.out.println("Author: " + "\t" + authorResult);
        }

        if(store.get(title_key) != null ){
            String titleResult = new String (store.get(title_key).getValue().getValue());
            System.out.println("Title: "+ "\t" +  titleResult);
        }

        if(store.get(edition_key) !=null){
            String editionResult = new String (store.get(edition_key).getValue().getValue());
            System.out.println("Edition: " + "\t" + editionResult);
        }

        if(store.get(condition_key) !=null){
            String condResult = new String (store.get(condition_key).getValue().getValue());
            System.out.println("Condition: " + "\t" + condResult);
        }
        store.close();
    }
}
