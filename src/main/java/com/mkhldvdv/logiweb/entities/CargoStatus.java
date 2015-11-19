package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "CARGO_STATUSES")
public class CargoStatus implements Serializable {
    @Id
    @Column(name = "CARGO_STATUS_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "cargo_statuses_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id;

    @Column(name = "CARGO_STATUS_NAME")
    private String cargoStatusName;

    public CargoStatus() {
    }

    public CargoStatus(String cargoStatusName) {
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

        CargoStatus that = (CargoStatus) o;

        if (id != that.id) return false;
        return !(cargoStatusName != null ? !cargoStatusName.equals(that.cargoStatusName) : that.cargoStatusName != null);

    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (cargoStatusName != null ? cargoStatusName.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "CargoStatus{" +
                "id=" + id +
                ", cargoStatusName='" + cargoStatusName + '\'' +
                '}';
    }
}
