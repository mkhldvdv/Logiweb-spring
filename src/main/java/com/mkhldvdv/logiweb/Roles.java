package com.mkhldvdv.logiweb;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "ROLES")
public class Roles implements Serializable {
    @Id
    @Column(name = "ROLE_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "roles_seq")
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id = 0;

    @Column(name = "ROLE_NAME")
    private String roleName = "";

    public Roles() {
    }

    public Roles(String roleName) {
        this.roleName = roleName;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Roles roles = (Roles) o;

        return id == roles.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "Roles{" +
                "id=" + id +
                ", roleName='" + roleName + '\'' +
                '}';
    }
}
