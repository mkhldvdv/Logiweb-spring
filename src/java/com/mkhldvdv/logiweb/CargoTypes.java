package com.mkhldvdv.logiweb;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "CARGO_TYPES")
public class CargoTypes implements Serializable {
    @Id
    @Column(name = "CARGO_TYPE_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "cargo_types_seq")
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id = 0;

    @Column(name = "CARGO_TYPE_NAME")
    private String cargoTypeName = "";

    public CargoTypes() {
    }

    public CargoTypes(String cargoTypeName) {
        this.cargoTypeName = cargoTypeName;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCargoTypeName() {
        return cargoTypeName;
    }

    public void setCargoTypeName(String cargoTypeName) {
        this.cargoTypeName = cargoTypeName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CargoTypes that = (CargoTypes) o;

        return id == that.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "CargoTypes{" +
                "id=" + id +
                ", cargoTypeName='" + cargoTypeName + '\'' +
                '}';
    }
}
