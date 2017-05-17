import oracle.kv.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.*;

/**
 * Created by lac26 on 5/12/2017.
 * Lists all of the books for the year alphabetically (along with corresponding information such as condition, author, edition)
 */
public class GetSortedBooks {

    /*
Main establishes the JDBC connection and calls the methods that executes the query
*/
    public static void main(String[] args) throws SQLException {
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "lydia", "pass");
        execute(jdbcConnection);
    }

    public static void execute(Connection connection) throws SQLException {
        //create store
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        LoadDB db = new LoadDB();
        db.loadSortedBooks(store, connection);

        Key bookKey = Key.createKey("book");
        KeyRange subRange = null;
        Iterator<Key> iterator = store.multiGetKeysIterator(Direction.FORWARD, 0, bookKey, subRange, null);
        while(iterator.hasNext()){
            Key temp = iterator.next();
            String title = temp.getMinorPath().get(0);
            String author = temp.getMinorPath().get(1);
            System.out.println("\n" + title + "\n Author:" + "\t" +  author);
        }
    }
}
