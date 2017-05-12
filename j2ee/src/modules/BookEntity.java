package modules;

import javax.persistence.*;

/**
 * Created by lac26 on 5/11/2017.
 */
@Entity
@Table(name = "BOOK", schema = "LYDIA", catalog = "")
public class BookEntity {
    private long id;
    private String author;
    private String title;
    private Long edition;
    private ConditionEntity condition;

    //@ManyToOne(cascade = CascadeType.PERSIST)
    /*one book can only have one condition but one condition can describe many books so is ManyToOne*/
    @ManyToOne
    @JoinColumn(name = "condition", referencedColumnName = "cond")
    public ConditionEntity getCondition(){return condition;}
    public void setCondition(ConditionEntity h) {this.condition= h;}

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "AUTHOR")
    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    @Basic
    @Column(name = "TITLE")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Basic
    @Column(name = "EDITION")
    public Long getEdition() {
        return edition;
    }

    public void setEdition(Long edition) {
        this.edition = edition;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BookEntity that = (BookEntity) o;

        if (id != that.id) return false;
        if (author != null ? !author.equals(that.author) : that.author != null) return false;
        if (title != null ? !title.equals(that.title) : that.title != null) return false;
        if (edition != null ? !edition.equals(that.edition) : that.edition != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (author != null ? author.hashCode() : 0);
        result = 31 * result + (title != null ? title.hashCode() : 0);
        result = 31 * result + (edition != null ? edition.hashCode() : 0);
        return result;
    }
}
