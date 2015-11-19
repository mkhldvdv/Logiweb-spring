package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

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

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TRUCK_STATUS_ID")
    private TruckStatus truckStatus;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CITY_ID")
    private City city;

    public Truck() {
    }

    public Truck(String regNum, byte driverCount, byte capacity, TruckStatus truckStatus, City city) {
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

    public TruckStatus getTruckStatus() {
        return truckStatus;
    }

    public void setTruckStatus(TruckStatus truckStatus) {
        this.truckStatus = truckStatus;
    }

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
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
                ", truckStatus=" + truckStatus +
                ", city=" + city +
                '}';
    }
}
