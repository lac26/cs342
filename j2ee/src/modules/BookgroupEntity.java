package modules;

import javax.persistence.*;

/**
 * Created by lac26 on 5/11/2017.
 */
@Entity
@Table(name = "BOOKGROUP", schema = "LYDIA", catalog = "")
@IdClass(BookgroupEntityPK.class)
public class BookgroupEntity {
    private long bookid;
    private long groupid;

    @Id
    @Column(name = "BOOKID")
    public long getBookid() {
        return bookid;
    }

    public void setBookid(long bookid) {
        this.bookid = bookid;
    }

    @Id
    @Column(name = "GROUPID")
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

        BookgroupEntity that = (BookgroupEntity) o;

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
