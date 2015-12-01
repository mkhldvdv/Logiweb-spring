package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by mkhldvdv on 17.11.2015.
 */
@Entity
@Table(name = "CARGOS")
public class Cargo implements Serializable {
    @Id
    @Column(name = "CARGO_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "cargo_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id;

    @Column(name = "CARGO_NAME")
    private String cargoName;

    @Column(name = "WEIGHT")
    private int weight;

    @Column(name = "CARGO_STATUS_ID")
    private byte cargoStatus;

    @OneToMany(mappedBy = "cargo", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Waypoint> waypoints;

    @Column(name = "DELETED")
    private byte deleted;

    public Cargo() {
    }

    public Cargo(String cargoName, int weight, byte cargoStatus, List<Waypoint> waypoints, byte deleted) {
        this.cargoName = cargoName;
        this.weight = weight;
        this.cargoStatus = cargoStatus;
        this.waypoints = waypoints;
        this.deleted = deleted;
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

    public byte getCargoStatus() {
        return cargoStatus;
    }

    public void setCargoStatus(byte cargoStatus) {
        this.cargoStatus = cargoStatus;
    }

    public List<Waypoint> getWaypoints() {
        return waypoints;
    }

    public void setWaypoints(List<Waypoint> waypoints) {
        this.waypoints = waypoints;
    }

    public byte getDeleted() {
        return deleted;
    }

    public void setDeleted(byte deleted) {
        this.deleted = deleted;
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
                ", weight=" + weight +
                ", cargoStatus=" + cargoStatus +
                ", waypoints=" + waypoints +
                ", deleted=" + deleted +
                '}';
    }
}
