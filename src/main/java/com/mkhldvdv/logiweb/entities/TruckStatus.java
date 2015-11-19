package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "TRUCK_STATUSES")
public class TruckStatus implements Serializable {
    @Id
    @Column(name = "TRUCK_STATUS_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "truck_statuses_seq")
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id = 0;

    @Column(name = "TRUCK_STATUS_NAME")
    private String truckStatusName = "";

    public TruckStatus() {
    }

    public TruckStatus(String truckStatusName) {
        this.truckStatusName = truckStatusName;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getTruckStatusName() {
        return truckStatusName;
    }

    public void setTruckStatusName(String truckStatusName) {
        this.truckStatusName = truckStatusName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TruckStatus that = (TruckStatus) o;

        return id == that.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "TruckStatus{" +
                "id=" + id +
                ", truckStatusName='" + truckStatusName + '\'' +
                '}';
    }
}
