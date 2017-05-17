import oracle.kv.KVStore;
import oracle.kv.Key;
import oracle.kv.Value;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;

/**
 * Created by lac26 on 5/12/2017.
 * LoadDB pulls data from the OracleXE Book, Person, and PersonBook tables and load it into the Oracle KVLite using a key-value structure
 * Key structure:
 * book/[id]/author/[author name]
 * book/[id]/title/[title name]
 * book/[id]/edition[edition]
 * book/[id]/condition/[condition]
 * book/[title]/[author]/[edition]/[condition] *to make sorting by title easier
 * owner/[id]/[firstname]
 * owner/[id]/[lastname]
 * book/[bookid]/ownerToBook/[ownerID]/[quantity]
 */
public class LoadDB {

    /* loadBooks loads the data from Book using JDBC and then puts the data into KVLite
    @param KVStore store, KVLite store to load data into
    @param Connection jdbcConnection, connection to use when pulling data using JDBC
     */
    public static void loadBooks(KVStore store, Connection jdbcConnection) throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        //store query results into books
        ResultSet books = jdbcStatement.executeQuery("SELECT id, author, title, edition, condition  FROM Book");

        while(books.next()) {
            //create key for author /book/book_id/author
            Key author_key = Key.createKey(Arrays.asList("book", books.getString(1)), Arrays.asList("author"));
            //value for author
            Value author_val = Value.createValue("".getBytes());
            if (books.getString(2) != null) {
                author_val = Value.createValue(books.getString(2).getBytes());
            }

            //create key for author /book/book_id/title
            Key title_key = Key.createKey(Arrays.asList("book", books.getString(1)), Arrays.asList("title"));
            //value for author
            Value title_val = Value.createValue("".getBytes());
            if (books.getString(3) != null) {
                title_val = Value.createValue(books.getString(3).getBytes());
            }

            //create key for author /book/book_id/edition
            Key edition_key = Key.createKey(Arrays.asList("book", books.getString(1)), Arrays.asList("edition"));
            //value for author
            Value edition_val = Value.createValue("".getBytes());
            if (books.getString(4) != null) {
                edition_val = Value.createValue(books.getString(4).getBytes());
            }

            //create key for author /book/book_id/author
            Key condition_key = Key.createKey(Arrays.asList("book", books.getString(1)), Arrays.asList("condition"));
            //value for author
            Value condition_val = Value.createValue("".getBytes());
            if (books.getString(5) != null) {
                condition_val = Value.createValue(books.getString(5).getBytes());
            }

            store.put(author_key, author_val);
            store.put(title_key, title_val);
            store.put(edition_key, edition_val);
            store.put(condition_key, condition_val);
        }

        books.close();
        jdbcStatement.close();
    }


    /* loadSortedBooks loads the data from Book using JDBC and then puts the data into KVLite.
    * creates a key/value structure like book/[title]/[author]/[edition]/[condition] to make sorting by title easier
    @param KVStore store, KVLite store to load data into
    @param Connection jdbcConnection, connection to use when pulling data using JDBC
     */
    public static void loadSortedBooks(KVStore store, Connection jdbcConnection) throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        //store query results into books
        ResultSet booksResultSet = jdbcStatement.executeQuery("SELECT id, author, title, edition, condition  FROM Book");
        while(booksResultSet.next()){
            String title = booksResultSet.getString(3);
            String author = "";
            if(booksResultSet.getString(2) != null){
                author = booksResultSet.getString(2);
            }
            String edition = "";
            if(booksResultSet.getString(4) !=null){
                edition = booksResultSet.getString(4);
            }
            String condition = "";
            if(booksResultSet.getString(5) != null){
                condition = booksResultSet.getString(5);
            }
            Key bookKey = Key.createKey(Arrays.asList("book"),
                    Arrays.asList(title, author, edition, condition));
            Value bookValue = Value.createValue(new byte[0]);
            store.put(bookKey, bookValue);
           // System.out.println(bookKey.toString());
        }
    }



    /* loadOwners loads the data from Person using JDBC and then puts the data into KVLite
        @param KVStore store, KVLite store to load data into
        @param Connection jdbcConnection, connection to use when pulling data using JDBC
      */
    public static void loadOwners(KVStore store, Connection jdbcConnection) throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        //store results from query in groups
        ResultSet owners = jdbcStatement.executeQuery("SELECT ID, firstName, lastName FROM Person");

        while(owners.next()){
            //create key for name /book/owner/owner_id/firstname
            Key name_key = Key.createKey(Arrays.asList("owner", owners.getString(1)), Arrays.asList("firstname"));
            //value for author
            Value name_val = Value.createValue("".getBytes());
            if (owners.getString(2) != null) {
                name_val = Value.createValue(owners.getString(2).getBytes());
            }

            store.put(name_key, name_val);

            //create key for name /book/owner/owner_id/lastname
            Key last_key = Key.createKey(Arrays.asList("owner", owners.getString(1)), Arrays.asList("lastname"));
            //value for author
            Value last_val = Value.createValue("".getBytes());
            if (owners.getString(3) != null) {
                last_val = Value.createValue(owners.getString(3).getBytes());
            }
            store.put(last_key, last_val);
        }
        owners.close();
        jdbcStatement.close();
    }



    /* loadBookOwners loads the data from PersonBook using JDBC and then puts the data into KVLite
        @param KVStore store, KVLite store to load data into
        @param Connection jdbcConnection, connection to use when pulling data using JDBC
    */
    public static void loadBookOwners(KVStore store, Connection jdbcConnection) throws SQLException{
        Statement jdbcStatement = jdbcConnection.createStatement();
        //select books in a group
        ResultSet book_group = jdbcStatement.executeQuery("SELECT bookID, ownerID, quant FROM PersonBook");

        /* there should just be one entry for bookID, ownerID, and quant but in the case of multiple entries storing in a list */
        //list of book keys
        ArrayList<Key> bookKeys = new ArrayList<>();
        //list of book values
        ArrayList<ArrayList<String>> quants = new ArrayList<>();

        while(book_group.next()){
            //make a key allowing it to be searchable by the book id
            Key bookKey = Key.createKey(Arrays.asList("book", book_group.getString(1)), Arrays.asList("ownerToBook", book_group.getString(2)));
            // get the quantity and append to list
            if(!bookKeys.contains(bookKey)){ //if owner associated does not have an array created yet, add the owner and create an array for quantities
                bookKeys.add(bookKey); //add the book
                quants.add(new ArrayList<>());
            }
            String quant = new String(book_group.getString(3).getBytes());
            //add the entry to the correct array list inside of bookKeys
            quants.get(bookKeys.indexOf(bookKey)).add(quant);
        }

        //retrieve the key stored in bookKeys and the value
        for (int i =0; i<bookKeys.size(); i++){
            //get the correct array (stored at i at quants).  Will store the whole array as the value but need to convert it to a string to do that.
            String role = quants.get(i).toString();
            Value roleVal = Value.createValue(role.getBytes());
            store.put(bookKeys.get(i), roleVal);
        }
    }
}
