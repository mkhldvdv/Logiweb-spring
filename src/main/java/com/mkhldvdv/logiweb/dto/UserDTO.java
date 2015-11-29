package com.mkhldvdv.logiweb.dto;

import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.Truck;
import com.mkhldvdv.logiweb.entities.User;
import com.sun.istack.internal.Nullable;

import javax.persistence.*;
import java.util.List;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class UserDTO {
    private long id;

    private String fisrtName;

    private String lastName;

    private String login;

    private String password;

    private byte role;

    private short hours;

    private byte userStatus;

    private long city;

    private Truck truck;

    private List<Order> orders;

    private boolean isDeleted;

    protected UserDTO() {
    }

    public UserDTO(long id, String fisrtName, String lastName, String login, String password, byte role,
                   short hours, byte userStatus, long city, Truck truck, List<Order> orders, boolean isDeleted) {
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
        this.isDeleted = isDeleted;
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

    public byte getRole() {
        return role;
    }

    public void setRole(byte role) {
        this.role = role;
    }

    public short getHours() {
        return hours;
    }

    public void setHours(short hours) {
        this.hours = hours;
    }

    public byte getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(byte userStatus) {
        this.userStatus = userStatus;
    }

    public long getCity() {
        return city;
    }

    public void setCity(long city) {
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

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserDTO user = (UserDTO) o;

        return id == user.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "UserDTO{" +
                "id=" + id +
                ", fisrtName='" + fisrtName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", login='" + login + '\'' +
                ", password='" + password + '\'' +
                ", role=" + role +
                ", hours=" + hours +
                ", userStatus='" + userStatus + '\'' +
                ", city=" + city +
                ", truck=" + truck +
                ", orders=" + orders +
                ", isDeleted=" + isDeleted +
                '}';
    }
}
