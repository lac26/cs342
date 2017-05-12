/**
 * Created by lac26 on 5/12/2017.
 * This class is useful for storing information related to a book and thus makes sorting easier.
 * (another implementation for sorting would have been a hashtable, but since there were duplicate years I would have had to make the value an array,
 * this seemed just (if not more) efficient)
 * Book stores and provides getters for id, author, title, edition, and condition
 *
 */
public class Book {
    private String bookId;
    private String author;
    private String title;
    private String edition;
    private String condition;

    public Book(String bookId, String author, String title, String edition, String condition){
        this.bookId = bookId;
        this.author = author;
        this.title = title;
        this.edition = edition;
        this.condition = condition;
    }

    //getters

    public String getAuthor() {
        return author;
    }

    public String getBookId() {
        return bookId;
    }

    public String getCondition() {
        return condition;
    }

    public String getEdition() {
        return edition;
    }

    public String getTitle() {
        return title;
    }
}
