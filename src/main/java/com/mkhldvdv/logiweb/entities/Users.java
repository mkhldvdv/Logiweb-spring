package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "USERS")
public class Users implements Serializable {
    @Id
    @Column(name = "USER_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "users_seq")
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id = 0;

    @Column(name = "FIRST_NAME")
    private String fisrtName = "";

    @Column(name = "LAST_NAME")
    private String lastName = "";

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ROLE_ID")
    private Roles role;

    @Column(name = "PASSWORD")
    private String password = "";

    public Users() {
    }

    public Users(String fisrtName, String lastName, Roles role, String password) {
        this.fisrtName = fisrtName;
        this.lastName = lastName;
        this.role = role;
        this.password = password;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getFisrtName() {
        return fisrtName;
    }

    public void setFisrtName(String fisrtName) {
        this.fisrtName = fisrtName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Roles getRole() {
        return role;
    }

    public void setRole(Roles role) {
        this.role = role;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Users users = (Users) o;

        return id == users.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "Users{" +
                "id=" + id +
                ", fisrtName='" + fisrtName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", role=" + role +
                ", password='" + password + '\'' +
                '}';
    }
}
