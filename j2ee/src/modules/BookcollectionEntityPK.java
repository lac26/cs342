package modules;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by lac26 on 5/11/2017.
 */
public class BookcollectionEntityPK implements Serializable {
    private long bookid;
    private long collectionid;

    @Column(name = "BOOKID")
    @Id
    public long getBookid() {
        return bookid;
    }

    public void setBookid(long bookid) {
        this.bookid = bookid;
    }

    @Column(name = "COLLECTIONID")
    @Id
    public long getCollectionid() {
        return collectionid;
    }

    public void setCollectionid(long collectionid) {
        this.collectionid = collectionid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BookcollectionEntityPK that = (BookcollectionEntityPK) o;

        if (bookid != that.bookid) return false;
        if (collectionid != that.collectionid) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (bookid ^ (bookid >>> 32));
        result = 31 * result + (int) (collectionid ^ (collectionid >>> 32));
        return result;
    }
}
