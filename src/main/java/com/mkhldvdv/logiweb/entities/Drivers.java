package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "DRIVERS")
public class Drivers implements Serializable {
    @Id
    @Column(name = "DRIVER_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "drivers_seq")
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id = 0;

    @Column(name = "HOURS")
    private short hours = 0;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "DRIVER_STATUS_ID")
    private DriverStatuses driverStatus;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CITY_ID")
    private Cities city;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TRUCK_ID")
    private Trucks truck;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID")
    private Users user;

    public Drivers() {
    }

    public Drivers(short hours, DriverStatuses driverStatus, Cities city, Trucks truck, Users user) {
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

    public DriverStatuses getDriverStatus() {
        return driverStatus;
    }

    public void setDriverStatus(DriverStatuses driverStatus) {
        this.driverStatus = driverStatus;
    }

    public Cities getCity() {
        return city;
    }

    public void setCity(Cities city) {
        this.city = city;
    }

    public Trucks getTruck() {
        return truck;
    }

    public void setTruck(Trucks truck) {
        this.truck = truck;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Drivers drivers = (Drivers) o;

        return id == drivers.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "Drivers{" +
                "id=" + id +
                ", hours=" + hours +
                ", driverStatus=" + driverStatus +
                ", city=" + city +
                ", truck=" + truck +
                ", user=" + user +
                '}';
    }
}
