package com.mkhldvdv.logiweb.dto;

import com.mkhldvdv.logiweb.entities.Truck;
import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.entities.Waypoint;

import java.util.List;
import java.util.Set;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class OrderDTO {

    private long id;

    private byte orderStatus;

    private Set<Long> waypoints;

    private Truck truck;

    private Set<Long> drivers;

    private byte deleted;

    public OrderDTO(long id, byte orderStatus, Set<Long> waypoints, Truck truck, Set<Long> drivers, byte deleted) {
        this.id = id;
        this.orderStatus = orderStatus;
        this.waypoints = waypoints;
        this.truck = truck;
        this.drivers = drivers;
        this.deleted = deleted;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public byte getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(byte orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Set<Long> getWaypoints() {
        return waypoints;
    }

    public void setWaypoints(Set<Long> waypoints) {
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

    public byte getDeleted() {
        return deleted;
    }

    public void setDeleted(byte deleted) {
        this.deleted = deleted;
    }

    @Override
    public String toString() {
        return "OrderDTO{" +
                "id=" + id +
                ", orderStatus=" + orderStatus +
                ", waypoints=" + waypoints +
                ", truck=" + truck +
                ", drivers=" + drivers +
                ", deleted=" + deleted +
                '}';
    }
}
