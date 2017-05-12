package modules;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by lac26 on 5/11/2017.
 */
public class PersonbookEntityPK implements Serializable {
    private long bookid;
    private long ownerid;

    @Column(name = "BOOKID")
    @Id
    public long getBookid() {
        return bookid;
    }

    public void setBookid(long bookid) {
        this.bookid = bookid;
    }

    @Column(name = "OWNERID")
    @Id
    public long getOwnerid() {
        return ownerid;
    }

    public void setOwnerid(long ownerid) {
        this.ownerid = ownerid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PersonbookEntityPK that = (PersonbookEntityPK) o;

        if (bookid != that.bookid) return false;
        if (ownerid != that.ownerid) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (bookid ^ (bookid >>> 32));
        result = 31 * result + (int) (ownerid ^ (ownerid >>> 32));
        return result;
    }
}
