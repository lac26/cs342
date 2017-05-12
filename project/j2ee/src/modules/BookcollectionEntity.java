package modules;

import javax.persistence.*;

/**
 * Created by lac26 on 5/11/2017.
 */
@Entity
@Table(name = "BOOKCOLLECTION", schema = "LYDIA", catalog = "")
@IdClass(BookcollectionEntityPK.class)
public class BookcollectionEntity {
    private long bookid;
    private long collectionid;

    @Id
    @Column(name = "BOOKID")
    public long getBookid() {
        return bookid;
    }

    public void setBookid(long bookid) {
        this.bookid = bookid;
    }

    @Id
    @Column(name = "COLLECTIONID")
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

        BookcollectionEntity that = (BookcollectionEntity) o;

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
