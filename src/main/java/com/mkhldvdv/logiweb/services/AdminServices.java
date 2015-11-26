package com.mkhldvdv.logiweb.services;

import com.mkhldvdv.logiweb.entities.Cargo;
import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.Truck;
import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.exceptions.RegNumNotMatchException;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;

import java.util.List;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public interface AdminServices {

    /**
     * get the list of all trucks
     * @return  list of trucks
     */
    public List<Truck> getTrucks();

    /**
     * adds a new truck
     * @param   truck to add
     * @return  added truck
     */
    public long addTruck(Truck truck) throws RegNumNotMatchException, WrongIdException;

    /**
     * updates specified truck
     * @param truckId specified truck
     * @return  updated truck
     */
    public Truck updateTruck(long truckId) throws RegNumNotMatchException, WrongIdException;

    /**
     * deletes specified truck
     * @param truckId specified truck
     */
    public void deleteTruck(long truckId) throws WrongIdException;

    /**
     * get the list of all drivers
     * @return
     */
    public List<User> getDrivers();

    /**
     * adds a new driver
     * @param user  driver to add
     * @return  id of the added driver
     */
    public long addDriver(User user) throws WrongIdException;

    /**
     * updates driver
     * @param driverId specified driver
     * @return  updated driver
     */
    public User updateDriver(long driverId) throws WrongIdException;

    /**
     * deletes specified driver
     * @param driverId  driver to delete
     */
    public void deleteDriver(long driverId) throws WrongIdException;

    /**
     * get the list of all orders
     * @return  orders
     */
    public List<Order> getOrders();

    /**
     * get the full info of order
     * @param orderId   order id
     * @return  specified order
     */
    public Order getOrder(long orderId) throws WrongIdException;

    /**
     * get the full info about the cargo
     * @param cargoId   cargo id
     * @return  specified cargo
     */
    public Cargo getCargo(long cargoId) throws WrongIdException;

    /**
     * adds new order
     * @param order order to add
     * @return  id of added order
     * @throws WrongIdException (shit happens)
     */
    public long addOrder(Order order) throws WrongIdException;

    /**
     * get the list of trucks which are able to delivery order
     * @param orderId     specified order id
     * @return            list of trucks
     */
    public List<Truck> getTruckForOrder(long orderId) throws WrongIdException;

    /**
     * get the list of drivers for the specified truck
     * @param truckId   specified truck
     * @return          list of drivers
     */
    public List<User> getDriversForTruck(long truckId) throws WrongIdException;
}
