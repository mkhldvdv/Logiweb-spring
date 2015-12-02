package com.mkhldvdv.logiweb.dto;

import com.mkhldvdv.logiweb.entities.Order;

import java.util.List;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class TruckDTO {

    private long id;

    private String regNum;

    private byte driverCount;

    private byte capacity;

    private byte truckStatus;

    private long city;

    private List<Order> orders;

    private byte deleted;

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

    public byte getTruckStatus() {
        return truckStatus;
    }

    public void setTruckStatus(byte truckStatus) {
        this.truckStatus = truckStatus;
    }

    public long getCity() {
        return city;
    }

    public void setCity(long city) {
        this.city = city;
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

    public TruckDTO() {
    }

    public TruckDTO(long id, String regNum, byte driverCount, byte capacity, byte truckStatus, long city, byte deleted) {
        this.id = id;
        this.regNum = regNum;
        this.driverCount = driverCount;
        this.capacity = capacity;
        this.truckStatus = truckStatus;
        this.city = city;
        this.deleted = deleted;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TruckDTO truckDTO = (TruckDTO) o;

        return id == truckDTO.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "TruckDTO{" +
                "id=" + id +
                ", regNum='" + regNum + '\'' +
                ", driverCount=" + driverCount +
                ", capacity=" + capacity +
                ", truckStatus=" + truckStatus +
                ", city=" + city +
                '}';
    }
}
