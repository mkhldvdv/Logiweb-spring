package com.mkhldvdv.logiweb.services;

/**
 * Created by mkhldvdv on 21.11.2015.
 */

import com.mkhldvdv.logiweb.entities.Cargo;
import com.mkhldvdv.logiweb.entities.Driver;
import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.Truck;

import java.util.List;

/**
 * interface contains admin business logic for work such as add/remove/update entities
 */
public interface AdminService {

    /**
     * gets all trucks
     * @return  the list of all trucks
     */
    public List<Truck> getAllTrucks();

    /**
     * adds new truck
     * @param truck truck to add
     * @return id of the new truck
     */
    public Truck addTruck(Truck truck);

    /**
     * deletes the specified truck
     * @param id truck to delete
     */
    public void deleteTruck(Truck truck);

    /**
     * updates the specified truck
     * @param id truck to update
     * @return  updated truck
     */
    public Truck updateTruck(Truck truck);

    /**
     * gets all drivers
     * @return  the list of drivers
     */
    public List<Driver> getAllDrivers();

    /**
     * adds new driver
     * @param driver    driver to add
     * @return id of the new truck
     */
    public long addDriver(Driver driver);

    /**
     * delete the specified driver
     * @param id    driver to delete
     */
    public void deleteDriver(long id);

    /**
     * updates the specified driver
     * @param id    driver to update
     * @return  updated driver
     */
    public Driver updateDriver(long id);

    /**
     * gets all orders
     * @return  the list of orders
     */
    public List<Order> getAllOrders();

    /**
     * updates the specified order
     * @param id order to update
     * @return  updated order
     */
    public Order updateOrder(long id);

    /**
     * gets the specified order
     * @param id order to view
     * @return  specified order
     */
    public Order getOrder(long id);

    /**
     * gets all cargos
     * @return  the list of cargos
     */
    public List<Cargo> getAllCargos();

    /**
     * updates the specified cargo
     * @param id    cargo to update
     * @return  updated cargo
     */
    public Cargo updateCargo(long id);

    /**
     * gets the specified cargo
     * @param id    cargo to view
     * @return  specified cargo
     */
    public Cargo getCargo(long id);

    /**
     * assign drivers according to shift number, driver status and time limit
     * @param truck id of the truck
     * @return list of assigned drivers
     */
    public List<Driver> assignDrivers(long truck);
}
