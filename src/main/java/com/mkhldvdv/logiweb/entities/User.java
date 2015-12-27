package com.mkhldvdv.logiweb.entities;

import org.hibernate.annotations.Formula;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.List;

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
    private String firstName;

    @Column(name = "LAST_NAME")
    private String lastName;

    @Column(name = "LOGIN")
    @NotEmpty(message = "Please enter your login name.")
    @Size(min = 5, max = 10, message = "Login name should be between 5 and 10 characters")
    @Pattern(regexp="[\\w.]+", message = "Login should contain letters, \".\"(dot) or \"_\"")
    private String login;

    @Column(name = "PASSWORD")
    @NotEmpty(message = "Please enter your password.")
    @Size(min = 5, max = 30, message = "Password should be between 5 and 30 characters")
    private String password;

    @Formula("(select r.ROLE_NAME from ROLES r where r.ROLE_ID = ROLE_ID)")
    private String role;

    @Column(name = "HOURS")
    private short hours;

    @Formula("(select r.USER_STATUS_NAME from USER_STATUSES r where r.USER_STATUS_ID = USER_STATUS_ID)")
    private String userStatus;

    @Formula("(select r.CITY_NAME from CITIES r where r.CITY_ID = CITY_ID)")
    private String city;

    @ManyToOne
    @JoinColumn(name = "TRUCK_ID")
    private Truck truck;

    @ManyToMany
    @JoinTable(name = "ORDER_DRIVER", joinColumns = {@JoinColumn(name = "USER_ID")},
            inverseJoinColumns = {@JoinColumn(name = "ORDER_ID")})
    private List<Order> orders;

    @Column(name = "DELETED")
    private short deleted;

    public User() {
    }

    public User(String firstName, String lastName, String login, String password, String role, short hours,
                   String userStatus, String city, Truck truck, List<Order> orders) {
        this.firstName = firstName;
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

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String fisrtName) {
        this.firstName = fisrtName;
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

    public short getDeleted() {
        return deleted;
    }

    public void setDeleted(short deleted) {
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
                ", fisrtName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", login='" + login + '\'' +
                ", password='" + password + '\'' +
                ", role=" + role +
                ", hours=" + hours +
                ", userStatus='" + userStatus + '\'' +
                ", city=" + city +
                ", truck=" + truck +
                ", orders=" + orders +
                '}';
    }
}
