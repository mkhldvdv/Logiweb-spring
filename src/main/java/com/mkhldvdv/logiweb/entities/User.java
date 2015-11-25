package com.mkhldvdv.logiweb.entities;

import com.sun.istack.internal.Nullable;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;
import java.util.Set;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "USERS")
public class User implements Serializable {
    @Id
    @Column(name = "USER_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "users_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id;

    @Column(name = "FIRST_NAME")
    private String fisrtName;

    @Column(name = "LAST_NAME")
    private String lastName;

    @Column(name = "LOGIN")
    private String login;

    @Column(name = "PASSWORD")
    private String password;

    @JoinColumn(name = "ROLE_ID", table = "ROLES", referencedColumnName = "ROLE_NAME")
    private String role;

    @Nullable
    @Column(name = "HOURS")
    private short hours;

    @Nullable
    @JoinColumn(name = "USER_STATUS_ID", table = "USER_STATUSES", referencedColumnName = "USER_STATUS_NAME")
    private String userStatus;

    @Nullable
    @JoinColumn(name = "CITY_ID", table = "CITIES", referencedColumnName = "CITY_NAME")
    private String city;

    @Nullable
    @ManyToOne
    @JoinColumn(name = "TRUCK_ID")
    private Truck truck;

    @Nullable
    @ManyToMany
    @JoinTable(name = "ORDER_DRIVER", joinColumns = {@JoinColumn(name = "USER_ID")},
    inverseJoinColumns = {@JoinColumn(name = "ORDER_ID")})
    private List<Order> orders;

    protected User() {
    }

    public User(String fisrtName, String lastName, String login, String password, String role, short hours, String userStatus, String city, Truck truck, List<Order> orders) {
        this.fisrtName = fisrtName;
        this.lastName = lastName;
        this.login = login;
        this.password = password;
        this.role = role;
        this.hours = hours;
        this.userStatus = userStatus;
        this.city = city;
        this.truck = truck;
        this.orders = orders;
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

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public short getHours() {
        return hours;
    }

    public void setHours(short hours) {
        this.hours = hours;
    }

    public String getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(String userStatus) {
        this.userStatus = userStatus;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public Truck getTruck() {
        return truck;
    }

    public void setTruck(Truck truck) {
        this.truck = truck;
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        User user = (User) o;

        if (id != user.id) return false;
        if (fisrtName != null ? !fisrtName.equals(user.fisrtName) : user.fisrtName != null) return false;
        if (lastName != null ? !lastName.equals(user.lastName) : user.lastName != null) return false;
        if (login != null ? !login.equals(user.login) : user.login != null) return false;
        if (password != null ? !password.equals(user.password) : user.password != null) return false;
        return !(role != null ? !role.equals(user.role) : user.role != null);

    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (fisrtName != null ? fisrtName.hashCode() : 0);
        result = 31 * result + (lastName != null ? lastName.hashCode() : 0);
        result = 31 * result + (login != null ? login.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (role != null ? role.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", fisrtName='" + fisrtName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", login='" + login + '\'' +
                ", password='" + password + '\'' +
                ", role='" + role + '\'' +
                ", hours=" + hours +
                ", userStatus='" + userStatus + '\'' +
                ", city='" + city + '\'' +
                ", truck=" + truck +
                ", orders=" + orders +
                '}';
    }
}
