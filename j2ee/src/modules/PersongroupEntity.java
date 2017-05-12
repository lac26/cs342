package modules;

import javax.persistence.*;

/**
 * Created by lac26 on 5/11/2017.
 */
@Entity
@Table(name = "PERSONGROUP", schema = "LYDIA", catalog = "")
@IdClass(PersongroupEntityPK.class)
public class PersongroupEntity {
    private long personid;
    private long groupid;

    @Id
    @Column(name = "PERSONID")
    public long getPersonid() {
        return personid;
    }

    public void setPersonid(long personid) {
        this.personid = personid;
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

        PersongroupEntity that = (PersongroupEntity) o;

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
