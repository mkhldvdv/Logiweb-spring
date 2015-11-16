package com.mkhldvdv.logiweb;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "CARGO_STATUSES")
public class CargoStatuses implements Serializable {
    @Id
    @Column(name = "CARGO_STATUS_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "cargo_statuses_seq")
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id = 0;

    @Column(name = "CARGO_STATUS_NAME")
    private String cargoStatusName = "";

    public CargoStatuses() {
    }

    public CargoStatuses(String cargoStatusName) {
        this.cargoStatusName = cargoStatusName;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCargoStatusName() {
        return cargoStatusName;
    }

    public void setCargoStatusName(String cargoStatusName) {
        this.cargoStatusName = cargoStatusName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CargoStatuses that = (CargoStatuses) o;

        return id == that.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "CargoStatuses{" +
                "id=" + id +
                ", cargoStatusName='" + cargoStatusName + '\'' +
                '}';
    }
}
