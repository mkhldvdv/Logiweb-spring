package com.mkhldvdv.logiweb.services;

import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.entities.Waypoint;

import java.util.List;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public interface DriverServices {

    /**
     * return the list of co-drivers
     * @param driverId specified driver id
     * @return the list of co-drivers
     */
    public List<User> getCoDrivers(long driverId);

    /**
     * return the regNum of specified truck
     * @param driverId   specified driver id
     * @return  registration number
     */
    public String getTruckRegNum(long driverId);

    /**
     * return the list of waypoints
     * @param driverId   specified driver id
     * @return  the list of waypoints
     */
    public List<Waypoint> getListOfWaypoints(long driverId);
}
