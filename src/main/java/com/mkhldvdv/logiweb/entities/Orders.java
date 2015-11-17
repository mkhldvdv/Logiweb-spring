package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 18.11.2015.
 */
@Entity
@Table(name = "ORDERS")
public class Orders implements Serializable {
    @Id
    @Column(name = "ORDER_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "orders_seq")
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id = 0;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ORDER_STATUS_ID")
    private OrderStatuses orderStatus;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TRUCK_ID")
    private Trucks truck;

    public Orders() {
    }

    public Orders(OrderStatuses orderStatus, Trucks truck) {
        this.orderStatus = orderStatus;
        this.truck = truck;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public OrderStatuses getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(OrderStatuses orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Trucks getTruck() {
        return truck;
    }

    public void setTruck(Trucks truck) {
        this.truck = truck;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Orders orders = (Orders) o;

        return id == orders.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "Orders{" +
                "id=" + id +
                ", orderStatus=" + orderStatus +
                ", truck=" + truck +
                '}';
    }
}
