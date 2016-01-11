package com.mkhldvdv.driverapp.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.Formula;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 09.01.2016.
 */

@Entity
@Table(name = "USERS")
//@NamedQuery(name = "getUserByLogin", query = "")
public class User implements Serializable {

    @Id
    @Column(name = "USER_ID")
    private long id;

    @JsonIgnore
    @Column(name = "LOGIN")
    private String login;

    @JsonIgnore
    @Column(name = "PASSWORD")
    private String password;

    @JsonIgnore
    @Column(name = "USER_STATUS_ID")
    private byte statusId;

    @Formula("(select r.USER_STATUS_NAME from USER_STATUSES r where r.USER_STATUS_ID = USER_STATUS_ID)")
    private String status;

    @JsonIgnore
    @Column(name = "ROLE_ID")
    private String roleId;

    @JsonIgnore
    @Formula("(select r.ROLE_NAME from ROLES r where r.ROLE_ID = ROLE_ID)")
    private String role;

    @JsonIgnore
    @Column(name = "DELETED")
    private byte deleted;

    public User() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public byte getStatusId() {
        return statusId;
    }

    public void setStatusId(byte statusId) {
        this.statusId = statusId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public byte getDeleted() {
        return deleted;
    }

    public void setDeleted(byte deleted) {
        this.deleted = deleted;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        User user = (User) o;

        return id == user.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", login='" + login + '\'' +
                ", statusId=" + statusId +
                ", status='" + status + '\'' +
                ", roleId='" + roleId + '\'' +
                ", role='" + role + '\'' +
                '}';
    }
}
