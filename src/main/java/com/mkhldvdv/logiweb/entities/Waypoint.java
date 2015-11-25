package com.mkhldvdv.logiweb.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by mkhldvdv on 18.11.2015.
 */
@Entity
@Table(name = "WAYPOINTS")
public class Waypoint implements Serializable {
    @Id
    @Column(name = "WAYPOINT_ID")
    @TableGenerator(name = "TABLE_GEN", table = "SEQUENCES", pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_VALUE", pkColumnValue = "waypoints_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GEN")
    private long id;

    @ManyToOne
    @JoinColumn(name = "ORDER_ID")
    private Order order;

    @JoinColumn(name = "CITY_ID", table = "CITIES", referencedColumnName = "CITY_NAME")
    private String city;

    @ManyToOne
    @JoinColumn(name = "CARGO_ID")
    private Cargo cargo;

    @JoinColumn(name = "CARGO_TYPE_ID", table = "CARGO_TYPES", referencedColumnName = "CARGO_TYPE_NAME")
    private String cargoType;

    protected Waypoint() {
    }

    public Waypoint(Order order, String city, Cargo cargo, String cargoType) {
        this.order = order;
        this.city = city;
        this.cargo = cargo;
        this.cargoType = cargoType;
    }

    public long getId() {
        return id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public Cargo getCargo() {
        return cargo;
    }

    public void setCargo(Cargo cargo) {
        this.cargo = cargo;
    }

    public String getCargoType() {
        return cargoType;
    }

    public void setCargoType(String cargoType) {
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
}
