package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 18.11.2015.
 */
@Entity
@Table(name = "TRUCKS")
public class Trucks implements Serializable {
    @Id
    @Column(name = "TRUCK_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "trucks_seq")
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id = 0;

    @Column(name = "REG_NUM")
    private String regNum;

    @Column(name = "DRIVER_COUNT")
    private byte driverCount;

    @Column(name = "CAPACITY")
    private byte capacity;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TRUCK_STATUS_ID")
    private TruckStatuses truckStatus;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CITY_ID")
    private Cities city;

    public Trucks() {
    }

    public Trucks(String regNum, byte driverCount, byte capacity, TruckStatuses truckStatus, Cities city) {
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

    public TruckStatuses getTruckStatus() {
        return truckStatus;
    }

    public void setTruckStatus(TruckStatuses truckStatus) {
        this.truckStatus = truckStatus;
    }

    public Cities getCity() {
        return city;
    }

    public void setCity(Cities city) {
        this.city = city;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Trucks trucks = (Trucks) o;

        return id == trucks.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "Trucks{" +
                "id=" + id +
                ", regNum='" + regNum + '\'' +
                ", driverCount=" + driverCount +
                ", capacity=" + capacity +
                ", truckStatus=" + truckStatus +
                ", city=" + city +
                '}';
    }
}
