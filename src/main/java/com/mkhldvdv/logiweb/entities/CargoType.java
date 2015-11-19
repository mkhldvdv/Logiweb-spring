package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "CARGO_TYPES")
public class CargoType implements Serializable {
    @Id
    @Column(name = "CARGO_TYPE_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "cargo_types_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id;

    @Column(name = "CARGO_TYPE_NAME")
    private String cargoTypeName;

    public CargoType() {
    }

    public CargoType(String cargoTypeName) {
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

        CargoType cargoType = (CargoType) o;

        if (id != cargoType.id) return false;
        return !(cargoTypeName != null ? !cargoTypeName.equals(cargoType.cargoTypeName) : cargoType.cargoTypeName != null);

    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (cargoTypeName != null ? cargoTypeName.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "CargoType{" +
                "id=" + id +
                ", cargoTypeName='" + cargoTypeName + '\'' +
                '}';
    }
}
