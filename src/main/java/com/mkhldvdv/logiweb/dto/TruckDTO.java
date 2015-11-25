package com.mkhldvdv.logiweb.dto;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class TruckDTO {

    private long id;

    private String regNum;

    private byte driverCount;

    private byte capacity;

    private String truckStatus;

    private String city;

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
}
