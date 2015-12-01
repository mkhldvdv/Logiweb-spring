package com.mkhldvdv.logiweb.dto;

import com.mkhldvdv.logiweb.entities.Waypoint;

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

    private List<Long> waypoints;

    private byte deleted;

    private List<Waypoint> fullWaypoints;

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

    public List<Long> getWaypoints() {
        return waypoints;
    }

    public void setWaypoints(List<Long> waypoints) {
        this.waypoints = waypoints;
    }

    public byte getDeleted() {
        return deleted;
    }

    public void setDeleted(byte deleted) {
        this.deleted = deleted;
    }

    public List<Waypoint> getFullWaypoints() {
        return fullWaypoints;
    }

    public void setFullWaypoints(List<Waypoint> fullWaypoints) {
        this.fullWaypoints = fullWaypoints;
    }

    public CargoDTO() {
    }

    public CargoDTO(long id, String cargoName, int weight, byte cargoStatus, List<Long> waypoints, byte deleted) {
        this.id = id;
        this.cargoName = cargoName;
        this.weight = weight;
        this.cargoStatus = cargoStatus;
        this.waypoints = waypoints;
        this.deleted = deleted;
    }

    @Override
    public String toString() {
        return "CargoDTO{" +
                "id=" + id +
                ", cargoName='" + cargoName + '\'' +
                ", weight=" + weight +
                ", cargoStatus=" + cargoStatus +
                ", waypoints=" + waypoints +
                ", deleted=" + deleted +
                '}';
    }
}
