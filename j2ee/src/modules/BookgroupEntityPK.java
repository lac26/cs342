package modules;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by lac26 on 5/11/2017.
 */
public class BookgroupEntityPK implements Serializable {
    private long bookid;
    private long groupid;

    @Column(name = "BOOKID")
    @Id
    public long getBookid() {
        return bookid;
    }

    public void setBookid(long bookid) {
        this.bookid = bookid;
    }

    @Column(name = "GROUPID")
    @Id
    public long getGroupid() {
        return groupid;
    }

    public void setGroupid(long groupid) {
        this.groupid = groupid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BookgroupEntityPK that = (BookgroupEntityPK) o;

        if (bookid != that.bookid) return false;
        if (groupid != that.groupid) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (bookid ^ (bookid >>> 32));
        result = 31 * result + (int) (groupid ^ (groupid >>> 32));
        return result;
    }
}
