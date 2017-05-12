package modules;

import javax.persistence.*;

/**
 * Created by lac26 on 5/11/2017.
 */
@Entity
@Table(name = "COLLECTIONGROUP", schema = "LYDIA", catalog = "")
@IdClass(CollectiongroupEntityPK.class)
public class CollectiongroupEntity {
    private long collectionid;
    private long groupid;

    @Id
    @Column(name = "COLLECTIONID")
    public long getCollectionid() {
        return collectionid;
    }

    public void setCollectionid(long collectionid) {
        this.collectionid = collectionid;
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

        CollectiongroupEntity that = (CollectiongroupEntity) o;

        if (collectionid != that.collectionid) return false;
        if (groupid != that.groupid) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (collectionid ^ (collectionid >>> 32));
        result = 31 * result + (int) (groupid ^ (groupid >>> 32));
        return result;
    }
}
