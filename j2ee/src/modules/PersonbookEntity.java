package modules;

import javax.persistence.*;

/**
 * Created by lac26 on 5/11/2017.
 */
@Entity
@Table(name = "PERSONBOOK", schema = "LYDIA", catalog = "")
@IdClass(PersonbookEntityPK.class)
public class PersonbookEntity {
    private long bookid;
    private long ownerid;
    private Long quant;

    @Id
    @Column(name = "BOOKID")
    public long getBookid() {
        return bookid;
    }

    public void setBookid(long bookid) {
        this.bookid = bookid;
    }

    @Id
    @Column(name = "OWNERID")
    public long getOwnerid() {
        return ownerid;
    }

    public void setOwnerid(long ownerid) {
        this.ownerid = ownerid;
    }

    @Basic
    @Column(name = "QUANT")
    public Long getQuant() {
        return quant;
    }

    public void setQuant(Long quant) {
        this.quant = quant;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PersonbookEntity that = (PersonbookEntity) o;

        if (bookid != that.bookid) return false;
        if (ownerid != that.ownerid) return false;
        if (quant != null ? !quant.equals(that.quant) : that.quant != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (bookid ^ (bookid >>> 32));
        result = 31 * result + (int) (ownerid ^ (ownerid >>> 32));
        result = 31 * result + (quant != null ? quant.hashCode() : 0);
        return result;
    }
}
