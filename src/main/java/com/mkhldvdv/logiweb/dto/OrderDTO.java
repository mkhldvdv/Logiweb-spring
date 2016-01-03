package com.mkhldvdv.logiweb.dto;

import com.mkhldvdv.logiweb.entities.Truck;

import java.io.Serializable;
import java.util.List;
import java.util.Set;

/**
 * Created by mkhldvdv on 03.01.2016.
 */
public class OrderDTO implements Serializable {

    private long id;

    private String orderStatus;

    private Set<String> waypoints;

    private Truck truck;

    private Set<Long> drivers;

    public OrderDTO() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Set<String> getWaypoints() {
        return waypoints;
    }

    public void setWaypoints(Set<String> waypoints) {
        this.waypoints = waypoints;
    }

    public Truck getTruck() {
        return truck;
    }

    public void setTruck(Truck truck) {
        this.truck = truck;
    }

    public Set<Long> getDrivers() {
        return drivers;
    }

    public void setDrivers(Set<Long> drivers) {
        this.drivers = drivers;
    }
}
