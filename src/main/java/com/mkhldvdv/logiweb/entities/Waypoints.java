package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 18.11.2015.
 */
@Entity
@Table(name = "WAYPOINTS")
public class Waypoints implements Serializable {
    @Id
    @Column(name = "WAYPOINT_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "waypoints_seq")
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id = 0;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ORDER_ID")
    private Orders order;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CITY_ID")
    private Cities city;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CARGO_ID")
    private Cargos cargos;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CARGO_TYPE_ID")
    private CargoTypes cargoType;

    public Waypoints() {
    }

    public Waypoints(Orders order, Cities city, Cargos cargos, CargoTypes cargoType) {
        this.order = order;
        this.city = city;
        this.cargos = cargos;
        this.cargoType = cargoType;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Orders getOrder() {
        return order;
    }

    public void setOrder(Orders order) {
        this.order = order;
    }

    public Cities getCity() {
        return city;
    }

    public void setCity(Cities city) {
        this.city = city;
    }

    public Cargos getCargos() {
        return cargos;
    }

    public void setCargos(Cargos cargos) {
        this.cargos = cargos;
    }

    public CargoTypes getCargoType() {
        return cargoType;
    }

    public void setCargoType(CargoTypes cargoType) {
        this.cargoType = cargoType;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Waypoints waypoints = (Waypoints) o;

        return id == waypoints.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "Waypoints{" +
                "id=" + id +
                ", order=" + order +
                ", city=" + city +
                ", cargos=" + cargos +
                ", cargoType=" + cargoType +
                '}';
    }
}
