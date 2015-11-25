package com.mkhldvdv.logiweb.dto;

import com.mkhldvdv.logiweb.entities.Cargo;
import com.mkhldvdv.logiweb.entities.Order;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class WaypointDTO {
    private long id;

    private Order order;

    private String city;

    private Cargo cargo;

    private String cargoType;

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
}
