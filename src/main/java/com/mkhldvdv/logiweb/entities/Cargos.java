package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "CARGOS")
public class Cargos implements Serializable {
    @Id
    @Column(name = "CARGO_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "cargo_seq")
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id = 0;

    @Column(name = "CARGO_NAME")
    String cargoName = "";

    @Column(name = "WEIGHT")
    int weight = 0;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CARGO_STATUS_ID")
    private CargoStatuses cargoStatus;

    public Cargos() {
    }

    public Cargos(String cargoName, int weight, CargoStatuses cargoStatus) {
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

    public CargoStatuses getCargoStatus() {
        return cargoStatus;
    }

    public void setCargoStatus(CargoStatuses cargoStatus) {
        this.cargoStatus = cargoStatus;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Cargos cargos = (Cargos) o;

        return id == cargos.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "Cargos{" +
                "id=" + id +
                ", cargoName='" + cargoName + '\'' +
                ", weight=" + weight +
                ", cargoStatus=" + cargoStatus +
                '}';
    }
}
