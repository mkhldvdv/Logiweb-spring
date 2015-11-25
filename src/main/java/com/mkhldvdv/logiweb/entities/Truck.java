package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
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
    private String regNum;

    @Column(name = "DRIVER_COUNT")
    private byte driverCount;

    @Column(name = "CAPACITY")
    private byte capacity;

    @JoinColumn(name = "TRUCK_STATUS_ID", table = "TRUCK_STATUSES", referencedColumnName = "TRUCK_STATUS_NAME")
    private String truckStatus;

    @JoinColumn(name = "CITY_ID", table = "CITIES", referencedColumnName = "CITY_NAME")
    private String city;

    @OneToMany(mappedBy = "truck")
    private List<User> drivers;

    @OneToMany(mappedBy = "truck")
    private List<Order> orders;

    protected Truck() {
    }

    public Truck(String regNum, byte driverCount, byte capacity,
                 String truckStatus, String city) {
        this.regNum = regNum;
        this.driverCount = driverCount;
        this.capacity = capacity;
        this.truckStatus = truckStatus;
        this.city = city;
    }

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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Truck truck = (Truck) o;

        if (id != truck.id) return false;
        if (driverCount != truck.driverCount) return false;
        if (capacity != truck.capacity) return false;
        return !(regNum != null ? !regNum.equals(truck.regNum) : truck.regNum != null);

    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (regNum != null ? regNum.hashCode() : 0);
        result = 31 * result + (int) driverCount;
        result = 31 * result + (int) capacity;
        return result;
    }

    @Override
    public String toString() {
        return "Truck{" +
                "id=" + id +
                ", regNum='" + regNum + '\'' +
                ", driverCount=" + driverCount +
                ", capacity=" + capacity +
                ", truckStatus='" + truckStatus + '\'' +
                ", city='" + city + '\'' +
                ", drivers=" + drivers +
                ", orders=" + orders +
                '}';
    }
}
