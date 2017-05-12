package modules;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by lac26 on 5/11/2017.
 */
public class LoanbookEntityPK implements Serializable {
    private long bookid;
    private long borrowerid;
    private long loanerid;

    @Column(name = "BOOKID")
    @Id
    public long getBookid() {
        return bookid;
    }

    public void setBookid(long bookid) {
        this.bookid = bookid;
    }

    @Column(name = "BORROWERID")
    @Id
    public long getBorrowerid() {
        return borrowerid;
    }

    public void setBorrowerid(long borrowerid) {
        this.borrowerid = borrowerid;
    }

    @Column(name = "LOANERID")
    @Id
    public long getLoanerid() {
        return loanerid;
    }

    public void setLoanerid(long loanerid) {
        this.loanerid = loanerid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        LoanbookEntityPK that = (LoanbookEntityPK) o;

        if (bookid != that.bookid) return false;
        if (borrowerid != that.borrowerid) return false;
        if (loanerid != that.loanerid) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (bookid ^ (bookid >>> 32));
        result = 31 * result + (int) (borrowerid ^ (borrowerid >>> 32));
        result = 31 * result + (int) (loanerid ^ (loanerid >>> 32));
        return result;
    }
}
