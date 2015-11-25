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

    @JoinColumn(name = "ORDER_STATUS_ID", table = "ORDER_STATUSES", referencedColumnName = "ORDER_STATUS_NAME")
    private String orderStatus;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Waypoint> waypoints;

    @ManyToOne
    @JoinColumn(name = "TRUCK_ID")
    private Truck truck;

    @ManyToMany(mappedBy = "orders")
    private List<User> drivers;

    protected Order() {
    }

    public Order(String orderStatus, List<Waypoint> waypoints, Truck truck, List<User> users) {
        this.orderStatus = orderStatus;
        this.waypoints = waypoints;
        this.truck = truck;
        this.drivers = users;
    }

    public long getId() {
        return id;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
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
                ", orderStatus='" + orderStatus + '\'' +
                ", waypoints=" + waypoints +
                ", truck=" + truck +
                ", drivers=" + drivers +
                '}';
    }
}
