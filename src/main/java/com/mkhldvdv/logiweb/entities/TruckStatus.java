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
            valueColumnName = "SEQ_VALUE", pkColumnValue = "truck_statuses_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id;

    @Column(name = "TRUCK_STATUS_NAME")
    private String truckStatusName;

    protected TruckStatus() {
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

        if (id != that.id) return false;
        return !(truckStatusName != null ? !truckStatusName.equals(that.truckStatusName) : that.truckStatusName != null);

    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (truckStatusName != null ? truckStatusName.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "TruckStatus{" +
                "id=" + id +
                ", truckStatusName='" + truckStatusName + '\'' +
                '}';
    }
}
