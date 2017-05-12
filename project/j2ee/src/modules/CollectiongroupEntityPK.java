package modules;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by lac26 on 5/11/2017.
 */
public class CollectiongroupEntityPK implements Serializable {
    private long collectionid;
    private long groupid;

    @Column(name = "COLLECTIONID")
    @Id
    public long getCollectionid() {
        return collectionid;
    }

    public void setCollectionid(long collectionid) {
        this.collectionid = collectionid;
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

        CollectiongroupEntityPK that = (CollectiongroupEntityPK) o;

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
