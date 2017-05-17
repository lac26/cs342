import oracle.kv.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;
/**
 * Created by lac26 on 5/12/2017.
 * GetBookOwners gets the owner information associated with a book as well as the number of copies of the book the owner has (joining Person, Book, and PersonBook tables)
 */
public class GetBookOwners {

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

        //get the owners and the books the owners own
        LoadDB.loadOwners(store,connection);
        LoadDB.loadBookOwners(store,connection);

        String bookId = "2";

        //get all owners with book id 2
        Key key = Key.createKey(Arrays.asList("book", bookId), Arrays.asList("ownerToBook"));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);

        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            //to get id of the owner
            System.out.println(field.getKey().getMajorPath().toString() + "    " + field.getKey().getMinorPath().toString());
            String owner_id = field.getKey().getMinorPath().get(1);


            String first = "";
            String last = "";
            String title ="";
            String author="";

            Map<Key, ValueVersion> owner = store.multiGet(Key.createKey(Arrays.asList("owner", owner_id)), null, null);
            for (Map.Entry<Key, ValueVersion> field2 : owner.entrySet()) {
                if (field2.getKey().getMinorPath().get(0).equals("firstname")) {
                    first = new String(field2.getValue().getValue().getValue());
                }if (field2.getKey().getMinorPath().get(0).equals("lastname")) {
                    last = new String(field2.getValue().getValue().getValue());
                }
            }

            Map<Key, ValueVersion> book = store.multiGet(Key.createKey(Arrays.asList("book", bookId)), null, null);
            for (Map.Entry<Key, ValueVersion> field2 : book.entrySet()) {
                if (field2.getKey().getMinorPath().get(0).equals("title")) {
                    title = new String(field2.getValue().getValue().getValue());
                }if (field2.getKey().getMinorPath().get(0).equals("author")) {
                    author = new String(field2.getValue().getValue().getValue());
                }
            }

            //get the quanity of the book
            String quant = new String(field.getValue().getValue().getValue());
            String cleaned_quant = quant.substring(1, quant.length()-1);

            //convert the string to an array
            String[] array = cleaned_quant.split(",");

            //print out values in the array
            for(String q: array) {
                System.out.print("Book ID: " + "\t" + bookId +
                        "\nBook title: " + "\t" + title +
                        "\nBook author: " + "\t" + author +
                        "\nOwner ID" + "\t" + owner_id +
                        "\nOwner first name " + "\t" + first + "\t" +
                        "\nOwner last name: " + "\t" +  last +
                        "\nNumber of copies owner has:" + "\t" + q);
            }
        }
    }
}
