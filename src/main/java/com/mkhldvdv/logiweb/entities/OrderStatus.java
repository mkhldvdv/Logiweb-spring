package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "ORDER_STATUSES")
public class OrderStatus implements Serializable {
    @Id
    @Column(name = "ORDER_STATUS_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "order_statuses_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id;

    @Column(name = "ORDER_STATUS_NAME")
    private String orderStatusName;

    protected OrderStatus() {
    }

    public OrderStatus(String orderStatusName) {
        this.orderStatusName = orderStatusName;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getOrderStatusName() {
        return orderStatusName;
    }

    public void setOrderStatusName(String orderStatusName) {
        this.orderStatusName = orderStatusName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        OrderStatus that = (OrderStatus) o;

        if (id != that.id) return false;
        return !(orderStatusName != null ? !orderStatusName.equals(that.orderStatusName) : that.orderStatusName != null);

    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (orderStatusName != null ? orderStatusName.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "OrderStatus{" +
                "id=" + id +
                ", orderStatusName='" + orderStatusName + '\'' +
                '}';
    }
}
