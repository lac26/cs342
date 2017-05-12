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

        //load movies into store
        LoadDB.loadBooks(store, connection);

        //create an array list of books
        List<Book> books= new ArrayList<Book>();
        //get to get fields associated with book
        Key key = Key.createKey(Arrays.asList("book"));

        //vars to read in for book
        String bookId = "";
        String author = "";
        String title = "";
        String edition = "";
        String condition = "";

        Iterator<KeyValueVersion> iterator = store.storeIterator(Direction.UNORDERED, 0, key, null, null);
        String oldBook = "";

        while(iterator.hasNext()) {

            Key temp = iterator.next().getKey();
            bookId = new String(temp.getMajorPath().get(1));

            //if a new book ID
            if(!bookId.equals(oldBook)) {
                oldBook = bookId;

                Key title_key = Key.createKey(Arrays.asList("book", bookId), Arrays.asList("title"));
                title = new String(store.get(title_key).getValue().getValue());

                Key author_key = Key.createKey(Arrays.asList("book", bookId), Arrays.asList("author"));
                author = new String(store.get(author_key).getValue().getValue());

                Key edition_key = Key.createKey(Arrays.asList("book", bookId), Arrays.asList("edition"));
                edition = new String(store.get(edition_key).getValue().getValue());

                Key condition_key = Key.createKey(Arrays.asList("book", bookId), Arrays.asList("condition"));
                condition = new String(store.get(condition_key).getValue().getValue());

                Book b = new Book(bookId, author, title, edition, condition);
                books.add(b);
            }
        }

        //sort alphabetically by creating overwritting the compare function
        Collections.sort(books, new Comparator<Book>() {
            @Override
            public int compare(Book b1, Book b2) {
                return  (b1.getTitle()).compareToIgnoreCase(b2.getTitle());
            }
        });


        //print out all values correlated with the movie
        for(int i=0; i< books.size(); i++){
            System.out.print("\n -----------------"
                    + "\n Title: " + "\t" + books.get(i).getTitle()
                    + "\n Condition: " + "\t" +books.get(i).getCondition()
                    + "\n Auhor:" + "\t" + books.get(i).getAuthor()
                    + "\n Edition" + "\t" + books.get(i).getEdition()
            );
        }
    }
}
