package modules;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by lac26 on 5/11/2017.
 */
public class PersongroupEntityPK implements Serializable {
    private long personid;
    private long groupid;

    @Column(name = "PERSONID")
    @Id
    public long getPersonid() {
        return personid;
    }

    public void setPersonid(long personid) {
        this.personid = personid;
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

        PersongroupEntityPK that = (PersongroupEntityPK) o;

        if (personid != that.personid) return false;
        if (groupid != that.groupid) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (personid ^ (personid >>> 32));
        result = 31 * result + (int) (groupid ^ (groupid >>> 32));
        return result;
    }
}
