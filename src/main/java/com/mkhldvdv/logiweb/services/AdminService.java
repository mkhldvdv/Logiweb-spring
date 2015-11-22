package com.mkhldvdv.logiweb.services;

import com.mkhldvdv.logiweb.entities.*;
import com.mkhldvdv.logiweb.exceptions.WrongSpecifiedCargo;

import java.util.List;

/**
 * Created by mkhldvdv on 22.11.2015.
 */
public interface AdminService {

    /**
     * get all trucks list
     * @return  the list of all available Trucks
     */
    public List<Truck> getTruckList();

    /**
     * get all drivers list
     * @return  the list of all available Drivers
     */
    public List<Driver> getDriverList();

    /**
     * adds new Truck
     * @param truck truck to add
     * @return  added truck
     */
    public Truck addNewTruck(Truck truck);

    /**
     * adds new user. If it's driver then adds the Driver as well
     * @param user user to add
     * @return  the added User
     */
    public User addNewUser(User user);

    /**
     * removes the specified truck
     * @param truck truck to remove
     */
    public void removeTruck(Truck truck);

    /**
     * removes the user and the driver if he exists
     * @param user user to remove
     */
    public void removeUser(User user);

    /**
     * updates the specified truck
     * @param truck truck to update
     * @return  updated truck
     */
    public Truck updateTruck(Truck truck);

    /**
     * updates the specified user, the driver as well
     * @param user  user to update
     * @return  updated user
     */
    public User updateUser(User user);

    /**
     * get all orders list
     * @return  the list of orders
     */
    public List<Order> getOrderList();

    /**
     * adds new order
     * @param order             order to add
     * @param waypointLoad      waypoint to load the order
     * @param waypointUnload    waypoint to unload the order
     * @param orderDrivers      list of drivers for the order
     * @return
     */
    public Order addNewOrder(Order order, Waypoint waypointLoad, Waypoint waypointUnload, OrderDriver ... orderDrivers) throws WrongSpecifiedCargo;

    /**
     * get the specified order
     * @param order id of the order
     * @return  specified order
     */
    public Order getOrder(long order);

    /**
     * get the specified cargo
     * @param cargo if of the cargo
     * @return  specified cargo
     */
    public Cargo getCargo(long cargo);

    /**
     * get all the Trucks available for the order
     * @return  the list of Trucks
     */
    public List<Truck> getTruckListAvailable();

    /**
     * search for drivers for the truck
     * 1. no overtimes (176 hours a month)
     * 2. no current active orders
     * 3. driver and truck in the same city
     * @param truck truck for the shift searching
     * @return  list of Drivers available for the truck
     */
    public List<Driver> getDriversShiftForTruck(Truck truck);
}
