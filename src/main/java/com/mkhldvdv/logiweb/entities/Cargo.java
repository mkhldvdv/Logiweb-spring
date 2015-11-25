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

    @JoinColumn(name = "CARGO_STATUS_ID", table = "CARGO_STATUSES", referencedColumnName = "CARGO_STATUS_ID")
    private String cargoStatus;

    @OneToMany(mappedBy = "cargo", cascade = CascadeType.ALL)
    private List<Waypoint> waypoints;

    protected Cargo() {
    }

    public Cargo(String cargoName, int weight, String cargoStatus, List<Waypoint> waypoints) {
        this.cargoName = cargoName;
        this.weight = weight;
        this.cargoStatus = cargoStatus;
        this.waypoints = waypoints;
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

    public String getCargoStatus() {
        return cargoStatus;
    }

    public void setCargoStatus(String cargoStatus) {
        this.cargoStatus = cargoStatus;
    }

    public List<Waypoint> getWaypoints() {
        return waypoints;
    }

    public void setWaypoints(List<Waypoint> waypoints) {
        this.waypoints = waypoints;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Cargo cargo = (Cargo) o;

        if (id != cargo.id) return false;
        if (weight != cargo.weight) return false;
        if (cargoName != null ? !cargoName.equals(cargo.cargoName) : cargo.cargoName != null) return false;
        return !(cargoStatus != null ? !cargoStatus.equals(cargo.cargoStatus) : cargo.cargoStatus != null);

    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (cargoName != null ? cargoName.hashCode() : 0);
        result = 31 * result + weight;
        result = 31 * result + (cargoStatus != null ? cargoStatus.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "Cargo{" +
                "id=" + id +
                ", cargoName='" + cargoName + '\'' +
                ", weight=" + weight +
                ", cargoStatus='" + cargoStatus + '\'' +
                ", waypoints=" + waypoints +
                '}';
    }
}
