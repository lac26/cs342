package modules;

import javax.persistence.*;
import java.sql.Time;

/**
 * Created by lac26 on 5/11/2017.
 */
@Entity
@Table(name = "LOANBOOK", schema = "LYDIA", catalog = "")
@IdClass(LoanbookEntityPK.class)
public class LoanbookEntity {
    private long bookid;
    private long borrowerid;
    private long loanerid;
    private Time loandate;
    private Long loanweeks;

    @Id
    @Column(name = "BOOKID")
    public long getBookid() {
        return bookid;
    }

    public void setBookid(long bookid) {
        this.bookid = bookid;
    }

    @Id
    @Column(name = "BORROWERID")
    public long getBorrowerid() {
        return borrowerid;
    }

    public void setBorrowerid(long borrowerid) {
        this.borrowerid = borrowerid;
    }

    @Id
    @Column(name = "LOANERID")
    public long getLoanerid() {
        return loanerid;
    }

    public void setLoanerid(long loanerid) {
        this.loanerid = loanerid;
    }

    @Basic
    @Column(name = "LOANDATE")
    public Time getLoandate() {
        return loandate;
    }

    public void setLoandate(Time loandate) {
        this.loandate = loandate;
    }

    @Basic
    @Column(name = "LOANWEEKS")
    public Long getLoanweeks() {
        return loanweeks;
    }

    public void setLoanweeks(Long loanweeks) {
        this.loanweeks = loanweeks;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        LoanbookEntity that = (LoanbookEntity) o;

        if (bookid != that.bookid) return false;
        if (borrowerid != that.borrowerid) return false;
        if (loanerid != that.loanerid) return false;
        if (loandate != null ? !loandate.equals(that.loandate) : that.loandate != null) return false;
        if (loanweeks != null ? !loanweeks.equals(that.loanweeks) : that.loanweeks != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (bookid ^ (bookid >>> 32));
        result = 31 * result + (int) (borrowerid ^ (borrowerid >>> 32));
        result = 31 * result + (int) (loanerid ^ (loanerid >>> 32));
        result = 31 * result + (loandate != null ? loandate.hashCode() : 0);
        result = 31 * result + (loanweeks != null ? loanweeks.hashCode() : 0);
        return result;
    }
}
