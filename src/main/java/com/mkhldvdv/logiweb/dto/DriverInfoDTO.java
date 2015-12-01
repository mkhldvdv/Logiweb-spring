package com.mkhldvdv.logiweb.dto;

import java.util.List;
import java.util.Set;

/**
 * Created by mkhldvdv on 01.12.2015.
 */
public class DriverInfoDTO {

    private long id;

    private List<Long> coDriversIds;

    private String regNum;

    private List<Long> orderId;

    private Set<Byte> cities;

    public DriverInfoDTO() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public List<Long> getCoDriversIds() {
        return coDriversIds;
    }

    public void setCoDriversIds(List<Long> coDriversIds) {
        this.coDriversIds = coDriversIds;
    }

    public String getRegNum() {
        return regNum;
    }

    public void setRegNum(String regNum) {
        this.regNum = regNum;
    }

    public List<Long> getOrderId() {
        return orderId;
    }

    public void setOrderId(List<Long> orderId) {
        this.orderId = orderId;
    }

    public Set<Byte> getCities() {
        return cities;
    }

    public void setCities(Set<Byte> cities) {
        this.cities = cities;
    }

    @Override
    public String toString() {
        return "DriverInfoDTO{" +
                "id=" + id +
                ", coDriversIds=" + coDriversIds +
                ", regNum='" + regNum + '\'' +
                ", orderId=" + orderId +
                ", cities=" + cities +
                '}';
    }
}
