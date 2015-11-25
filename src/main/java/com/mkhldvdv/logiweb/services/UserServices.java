package com.mkhldvdv.logiweb.services;

import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.entities.Waypoint;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;

import java.util.List;
import java.util.Set;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public interface UserServices {

    /**
     * returns user by login name and password
     * @param login login name
     * @param pass  password
     * @return      specified user
     */
    public User getUser(String login, String pass);

    /**
     * returns list of co-drivers for the specified driver
     * @param driverId  specified driver
     * @return          list of co-drivers
     */
    public List<User> getCoDrivers(long driverId) throws WrongIdException;

    /**
     * returns registration number of the truck
     * @param driverId  driver's personal number
     * @return          reg number of the truck
     */
    public String getTruckRegNum(long driverId) throws WrongIdException;

    /**
     * returns the list of all open assigned orders for the driver
     * @param driverId  driver's id
     * @return          list of open assigned orders
     */
    public List<Order> getOrderNumbers(long driverId) throws WrongIdException;

    /**
     * get list of waypoints
     * @param driverId  driver's id
     * @return          list of waypoints
     */
    public Set<Waypoint> getWaypoints(long driverId) throws WrongIdException;
}
