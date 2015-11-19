package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "CARGOS")
public class Cargo implements Serializable {
    @Id
    @Column(name = "CARGO_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "cargo_seq")
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id;

    @Column(name = "CARGO_NAME")
    private String cargoName;

    @Column(name = "WEIGHT")
    private int weight;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CARGO_STATUS_ID")
    private CargoStatus cargoStatus;

    public Cargo() {
    }

    public Cargo(String cargoName, int weight, CargoStatus cargoStatus) {
        this.cargoName = cargoName;
        this.weight = weight;
        this.cargoStatus = cargoStatus;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCargoName() {
        return cargoName;
    }

    public void setCargoName(String cargoName) {
        this.cargoName = cargoName;
    }

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    public CargoStatus getCargoStatus() {
        return cargoStatus;
    }

    public void setCargoStatus(CargoStatus cargoStatus) {
        this.cargoStatus = cargoStatus;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Cargo cargo = (Cargo) o;

        if (id != cargo.id) return false;
        if (weight != cargo.weight) return false;
        return !(cargoName != null ? !cargoName.equals(cargo.cargoName) : cargo.cargoName != null);

    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (cargoName != null ? cargoName.hashCode() : 0);
        result = 31 * result + weight;
        return result;
    }

    @Override
    public String toString() {
        return "Cargo{" +
                "id=" + id +
                ", cargoName='" + cargoName + '\'' +
                ", weight=" + weight +
                ", cargoStatus=" + cargoStatus +
                '}';
    }
}
