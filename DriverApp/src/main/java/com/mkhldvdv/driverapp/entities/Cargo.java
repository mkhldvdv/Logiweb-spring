package com.mkhldvdv.driverapp.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.Formula;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 09.01.2016.
 */

@Entity
@Table(name = "CARGOS")
public class Cargo implements Serializable {

    @Id
    @Column(name = "CARGO_ID")
    private long id;

    @JsonIgnore
    @Column(name = "CARGO_NAME")
    private String cargoName;

    @JsonIgnore
    @Column(name = "CARGO_STATUS_ID")
    private byte cargoStatusId;

    public Cargo() {
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

    public byte getCargoStatusId() {
        return cargoStatusId;
    }

    public void setCargoStatusId(byte cargoStatusId) {
        this.cargoStatusId = cargoStatusId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Cargo cargo = (Cargo) o;

        return id == cargo.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "Cargo{" +
                "id=" + id +
                ", cargoName='" + cargoName + '\'' +
                ", cargoStatusId=" + cargoStatusId +
                '}';
    }
}
