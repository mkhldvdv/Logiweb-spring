package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by mkhldvdv on 18.11.2015.
 */
@Entity
@Table(name = "ORDERS")
public class Order implements Serializable {
    @Id
    @Column(name = "ORDER_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "orders_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id;

    @Column(name = "ORDER_STATUS_ID")
    private byte orderStatus;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Waypoint> waypoints;

    @ManyToOne
    @JoinColumn(name = "TRUCK_ID")
    private Truck truck;

    @ManyToMany(mappedBy = "orders")
    private List<User> drivers;

    @Column(name = "DELETED")
    private boolean isDeleted;

    protected Order() {
    }

    public Order(byte orderStatus, List<Waypoint> waypoints, Truck truck, List<User> drivers) {
        this.orderStatus = orderStatus;
        this.waypoints = waypoints;
        this.truck = truck;
        this.drivers = drivers;
    }

    public long getId() {
        return id;
    }

    public byte getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(byte orderStatus) {
        this.orderStatus = orderStatus;
    }

    public List<Waypoint> getWaypoints() {
        return waypoints;
    }

    public void setWaypoints(List<Waypoint> waypoints) {
        this.waypoints = waypoints;
    }

    public Truck getTruck() {
        return truck;
    }

    public void setTruck(Truck truck) {
        this.truck = truck;
    }

    public List<User> getDrivers() {
        return drivers;
    }

    public void setDrivers(List<User> drivers) {
        this.drivers = drivers;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Order order = (Order) o;

        return id == order.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", orderStatus=" + orderStatus +
                ", waypoints=" + waypoints +
                ", truck=" + truck +
                ", drivers=" + drivers +
                ", isDeleted=" + isDeleted +
                '}';
    }
}
