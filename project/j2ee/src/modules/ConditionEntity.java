package modules;

import javax.persistence.*;

/**
 * Created by lac26 on 5/11/2017.
 */
@Entity
@Table(name = "CONDITION", schema = "LYDIA", catalog = "")
public class ConditionEntity {
    private String cond;
    private String description;

    @Id
    @Column(name = "COND")
    public String getCond() {
        return cond;
    }

    public void setCond(String cond) {
        this.cond = cond;
    }

    @Basic
    @Column(name = "DESCRIPTION")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ConditionEntity that = (ConditionEntity) o;

        if (cond != null ? !cond.equals(that.cond) : that.cond != null) return false;
        if (description != null ? !description.equals(that.description) : that.description != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = cond != null ? cond.hashCode() : 0;
        result = 31 * result + (description != null ? description.hashCode() : 0);
        return result;
    }
}
