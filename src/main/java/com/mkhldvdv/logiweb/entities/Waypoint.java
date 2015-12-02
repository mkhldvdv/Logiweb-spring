package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by mkhldvdv on 18.11.2015.
 */
@Entity
@Table(name = "WAYPOINTS")
public class Waypoint implements Serializable, Comparable<Waypoint> {
    @Id
    @Column(name = "WAYPOINT_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "waypoints_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id;

    @ManyToOne
    @JoinColumn(name = "ORDER_ID")
    private Order order;

    @Column(name = "CITY_ID")
    private byte city;

    @ManyToOne
    @JoinColumn(name = "CARGO_ID")
    private Cargo cargo;

    @Column(name = "CARGO_TYPE_ID")
    private byte cargoType;

    public Waypoint() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public byte getCity() {
        return city;
    }

    public void setCity(byte city) {
        this.city = city;
    }

    public Cargo getCargo() {
        return cargo;
    }

    public void setCargo(Cargo cargo) {
        this.cargo = cargo;
    }

    public byte getCargoType() {
        return cargoType;
    }

    public void setCargoType(byte cargoType) {
        this.cargoType = cargoType;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Waypoint waypoint = (Waypoint) o;

        return id == waypoint.id;

    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }

    @Override
    public String toString() {
        return "Waypoint{" +
                "id=" + id +
                ", order=" + order +
                ", city='" + city + '\'' +
                ", cargo=" + cargo +
                ", cargoType='" + cargoType + '\'' +
                '}';
    }

    public int compareTo(Waypoint waypoint) {
        return (int) (this.id - waypoint.getId());
    }
}
