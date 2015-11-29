package com.mkhldvdv.logiweb.dto;

import java.util.List;
import java.util.Set;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class CargoDTO {
    private long id;

    private String cargoName;

    private int weight;

    private byte cargoStatus;

    private Set<Long> waypoints;

    private byte deleted;

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

    public Set<Long> getWaypoints() {
        return waypoints;
    }

    public void setWaypoints(Set<Long> waypoints) {
        this.waypoints = waypoints;
    }

    public byte getDeleted() {
        return deleted;
    }

    public void setDeleted(byte deleted) {
        this.deleted = deleted;
    }

    public CargoDTO(long id, String cargoName, int weight, byte cargoStatus, Set<Long> waypoints, byte deleted) {
        this.id = id;
        this.cargoName = cargoName;
        this.weight = weight;
        this.cargoStatus = cargoStatus;
        this.waypoints = waypoints;
        this.deleted = deleted;
    }
}
