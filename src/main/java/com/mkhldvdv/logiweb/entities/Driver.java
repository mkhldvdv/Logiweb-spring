package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "DRIVERS")
public class Driver implements Serializable {
    @Id
    @Column(name = "DRIVER_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "drivers_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id;

    @Column(name = "HOURS")
    private short hours;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "DRIVER_STATUS_ID")
    private DriverStatus driverStatus;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "CITY_ID")
    private City city;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "TRUCK_ID")
    private Truck truck;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "USER_ID")
    private User user;

    protected Driver() {
    }

    public Driver(short hours, DriverStatus driverStatus, City city, Truck truck, User user) {
        this.hours = hours;
        this.driverStatus = driverStatus;
        this.city = city;
        this.truck = truck;
        this.user = user;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public short getHours() {
        return hours;
    }

    public void setHours(short hours) {
        this.hours = hours;
    }

    public DriverStatus getDriverStatus() {
        return driverStatus;
    }

    public void setDriverStatus(DriverStatus driverStatus) {
        this.driverStatus = driverStatus;
    }

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public Truck getTruck() {
        return truck;
    }

    public void setTruck(Truck truck) {
        this.truck = truck;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Driver driver = (Driver) o;

        if (id != driver.id) return false;
        return hours == driver.hours;

    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (int) hours;
        return result;
    }

    @Override
    public String toString() {
        return "Driver{" +
                "id=" + id +
                ", hours=" + hours +
                ", driverStatus=" + driverStatus +
                ", city=" + city +
                ", truck=" + truck +
                ", user=" + user +
                '}';
    }
}
