package com.mkhldvdv.logiweb.entities;

import org.hibernate.annotations.Formula;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "USERS")
//@SecondaryTable(name = "ROLES", )
public class UserTmp implements Serializable {
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
    private String login;

    @Column(name = "PASSWORD")
    private String password;

//    @JoinColumn(name = "ROLE_ID", table = "ROLES", referencedColumnName = "ROLE_NAME")
    @Formula("(select r.ROLE_NAME from ROLES r where r.ROLE_ID = ROLE_ID)")
    private String role;

    @Column(name = "HOURS")
    private short hours;

//    @Column(name = "USER_STATUS_ID")
//    @JoinColumn(name = "USER_STATUS_ID", table = "USER_STATUSES", referencedColumnName = "USER_STATUS_NAME")
    @Formula("(select r.USER_STATUS_NAME from USER_STATUSES r where r.USER_STATUS_ID = USER_STATUS_ID)")
    private String userStatus;

//    @Column(name = "CITY_ID")
    @Formula("(select r.CITY_NAME from CITIES r where r.CITY_ID = CITY_ID)")
    private String city;

    @ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name = "TRUCK_ID")
    private Truck truck;

    @ManyToMany(fetch=FetchType.EAGER)
    @JoinTable(name = "ORDER_DRIVER", joinColumns = {@JoinColumn(name = "USER_ID")},
    inverseJoinColumns = {@JoinColumn(name = "ORDER_ID")})
    private List<Order> orders;

    @Column(name = "DELETED")
    private byte deleted;

    protected UserTmp() {
    }

    public UserTmp(String firstName, String lastName, String login, String password, String role, short hours,
                   String userStatus, String city, Truck truck, List<Order> orders, byte deleted) {
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
        this.deleted = deleted;
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

        UserTmp user = (UserTmp) o;

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
                ", deleted=" + deleted +
                '}';
    }
}
