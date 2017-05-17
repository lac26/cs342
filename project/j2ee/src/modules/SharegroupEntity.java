package modules;

import javax.persistence.*;
import java.util.List;

/**
 * Created by lac26 on 5/11/2017.
 */
@Entity
@Table(name = "SHAREGROUP", schema = "LYDIA", catalog = "")
public class SharegroupEntity {
    private long id;
    private String name;
    private List<BookEntity> books;

    /*ManyToMany relationship, there can be many books in a group and a book can belong to many groups */
    @ManyToMany
    @JoinTable(name = "BOOKGROUP", schema = "LYDIA",
            joinColumns = @JoinColumn(name = "GROUPID", referencedColumnName = "ID", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "BOOKID", referencedColumnName = "ID", nullable = false))
    public List<BookEntity> getBooks(){return books;}
    public void setBooks(List<BookEntity> newBooks){this.books= newBooks;}

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "NAME")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SharegroupEntity that = (SharegroupEntity) o;

        if (id != that.id) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        return result;
    }
}
