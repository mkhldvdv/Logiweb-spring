package com.mkhldvdv.logiweb.entities;

import com.sun.istack.internal.Nullable;
import org.hibernate.annotations.Formula;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.List;

/**
 * Created by mkhldvdv on 18.11.2015.
 */
@Entity
@Table(name = "TRUCKS")
public class Truck implements Serializable {
    @Id
    @Column(name = "TRUCK_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "trucks_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id;

    @Column(name = "REG_NUM")
    @NotEmpty(message = "Please enter registration number.")
    @Size(min = 7, max = 7, message = "Registration number should be exactly 7 characters")
    @Pattern(regexp="[a-zA-Z]{2}[0-9]{5}", message = "Registration number should contain 2 letters and 5 digits")
    private String regNum;

    @Column(name = "DRIVER_COUNT")
    private byte driverCount;

    @Column(name = "CAPACITY")
    private byte capacity;

    @Column(name = "TRUCK_STATUS_ID")
    private byte truckStatusId;

    @Formula("(select r.TRUCK_STATUS_NAME from TRUCK_STATUSES r where r.TRUCK_STATUS_ID = TRUCK_STATUS_ID)")
    private String truckStatus;

    @Column(name = "CITY_ID")
    private long cityId;

    @Formula("(select r.CITY_NAME from CITIES r where r.CITY_ID = CITY_ID)")
    private String city;

    @OneToMany(mappedBy = "truck", fetch = FetchType.EAGER)
    private List<User> drivers;

    @OneToMany(mappedBy = "truck", fetch = FetchType.EAGER)
    private List<Order> orders;

    @Column(name = "DELETED")
    private byte deleted;

    public Truck() {
    }

//    public Truck(String regNum, byte driverCount, byte capacity,
//                 byte truckStatus, long city) {
//        this.regNum = regNum;
//        this.driverCount = driverCount;
//        this.capacity = capacity;
//        this.truckStatus = truckStatus;
//        this.city = city;
//    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getRegNum() {
        return regNum;
    }

    public void setRegNum(String regNum) {
        this.regNum = regNum;
    }

    public byte getDriverCount() {
        return driverCount;
    }

    public void setDriverCount(byte driverCount) {
        this.driverCount = driverCount;
    }

    public byte getCapacity() {
        return capacity;
    }

    public void setCapacity(byte capacity) {
        this.capacity = capacity;
    }

    public String getTruckStatus() {
        return truckStatus;
    }

    public void setTruckStatus(String truckStatus) {
        this.truckStatus = truckStatus;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public byte getTruckStatusId() {
        return truckStatusId;
    }

    public void setTruckStatusId(byte truckStatusId) {
        this.truckStatusId = truckStatusId;
    }

    public long getCityId() {
        return cityId;
    }

    public void setCityId(long cityId) {
        this.cityId = cityId;
    }

    public List<User> getDrivers() {
        return drivers;
    }

    public void setDrivers(List<User> drivers) {
        this.drivers = drivers;
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

        Truck truck = (Truck) o;

        return id == truck.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "Truck{" +
                "id=" + id +
                ", regNum='" + regNum + '\'' +
                ", driverCount=" + driverCount +
                ", capacity=" + capacity +
                ", truckStatus=" + truckStatus +
                ", city=" + city +
                ", drivers=" + drivers +
                ", orders=" + orders +
                ", deleted=" + deleted +
                '}';
    }
}
