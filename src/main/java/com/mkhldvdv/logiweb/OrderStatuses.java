package com.mkhldvdv.logiweb;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "ORDER_STATUSES")
public class OrderStatuses implements Serializable {
    @Id
    @Column(name = "ORDER_STATUS_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "order_statuses_seq")
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id = 0;

    @Column(name = "ORDER_STATUS_NAME")
    private String orderStatusName = "";

    public OrderStatuses() {
    }

    public OrderStatuses(String orderStatusName) {
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

        OrderStatuses that = (OrderStatuses) o;

        return id == that.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "OrderStatuses{" +
                "id=" + id +
                ", orderStatusName='" + orderStatusName + '\'' +
                '}';
    }
}
