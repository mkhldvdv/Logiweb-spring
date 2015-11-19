package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "DRIVER_STATUSES")
public class DriverStatus implements Serializable {
    @Id
    @Column(name = "DRIVER_STATUS_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "driver_statuses_seq")
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id = 0;

    @Column(name = "DRIVER_STATUS_NAME")
    private String driverStatusName = "";

    public DriverStatus() {
    }

    public DriverStatus(String driverStatusName) {
        this.driverStatusName = driverStatusName;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getDriverStatusName() {
        return driverStatusName;
    }

    public void setDriverStatusName(String driverStatusName) {
        this.driverStatusName = driverStatusName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DriverStatus that = (DriverStatus) o;

        return id == that.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "DriverStatus{" +
                "id=" + id +
                ", driverStatusName='" + driverStatusName + '\'' +
                '}';
    }
}
