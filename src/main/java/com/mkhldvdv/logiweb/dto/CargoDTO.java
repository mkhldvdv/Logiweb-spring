package com.mkhldvdv.logiweb.dto;

import com.mkhldvdv.logiweb.entities.Waypoint;

import java.util.List;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class CargoDTO {
    private long id;

    private String cargoName;

    private int weight;

    private String cargoStatus;

    private List<Waypoint> waypoints;

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
}
