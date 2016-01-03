package com.mkhldvdv.logiweb.dto;

import java.io.Serializable;
import java.util.List;

/**
 * Created by mkhldvdv on 03.01.2016.
 */
public class CargoDTO implements Serializable {

    private long id;

    private String cargoName;

    private int weight;

    private String cargoStatus;

    private List<String> waypoints;

    public CargoDTO() {
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

    public List<String> getWaypoints() {
        return waypoints;
    }

    public void setWaypoints(List<String> waypoints) {
        this.waypoints = waypoints;
    }
}
