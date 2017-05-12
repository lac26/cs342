package modules;

import javax.persistence.*;
import java.awt.print.Book;
import java.util.List;

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
    private List<SharegroupEntity> groups;
    private List<CollectionEntity> collections;

    /*one book can only have one condition but one condition can describe many books so is ManyToOne*/
    @ManyToOne
    @JoinColumn(name = "condition", referencedColumnName = "cond")
    public ConditionEntity getCondition(){return condition;}
    public void setCondition(ConditionEntity h) {this.condition= h;}


    /*ManyToMany relationship, there can be many books in a group and a book can belong to many groups */
    @ManyToMany
    @JoinTable(name = "BOOKGROUP", schema = "LYDIA",
            joinColumns = @JoinColumn(name = "BOOKID", referencedColumnName = "ID", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "GROUPID", referencedColumnName = "ID", nullable = false))
    public List<SharegroupEntity> getGroups(){return groups;}
    public void setGroups(List<SharegroupEntity> newGroups){this.groups= newGroups;}

    /*ManyToMany relationship, there can be many books in a collection and a book can belong to many collections */
    @ManyToMany
    @JoinTable(name = "BOOKCOLLECTION", schema = "LYDIA",
            joinColumns = @JoinColumn(name = "BOOKID", referencedColumnName = "ID", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "COLLECTIONID", referencedColumnName = "ID", nullable = false))
    public List<CollectionEntity> getCollections(){return collections;}
    public void setCollections(List<CollectionEntity> newCollections){this.collections= newCollections;}


    @GeneratedValue(generator = "lydiaSequence")
    @SequenceGenerator(name = "lydiaSequence", sequenceName = "seq_book", allocationSize = 1)
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
