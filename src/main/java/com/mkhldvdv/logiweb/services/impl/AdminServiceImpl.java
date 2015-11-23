package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.dao.impl.*;
import com.mkhldvdv.logiweb.entities.*;
import com.mkhldvdv.logiweb.exceptions.RegNumNotMatchException;
import com.mkhldvdv.logiweb.exceptions.WrongSpecifiedCargo;
import com.mkhldvdv.logiweb.services.AdminService;

import java.util.List;
import java.util.regex.Pattern;

/**
 * Created by mkhldvdv on 22.11.2015.
 */
public class AdminServiceImpl implements AdminService {

    public static final String DRIVER = "driver";
    private TruckDaoImpl truckDaoImpl;
    private DriverDaoImpl driverDaoImpl;
    private UserDaoImpl userDaoImpl;
    private OrderDaoImpl orderDaoImpl;
    private CargoDaoImpl cargoDaoImpl;
    private WaypointDaoImpl waypointDaoImpl;
    private OrderDriverDaoImpl orderDriverDaoImpl;

    /**
     * get all trucks list
     *
     * @return the list of all available Trucks
     */
    @Override
    public List<Truck> getTruckList() {
        return truckDaoImpl.getAll();
    }

    /**
     * get all drivers list
     *
     * @return the list of all available Drivers
     */
    @Override
    public List<Driver> getDriverList() {
        return driverDaoImpl.getAll();
    }

    /**
     * adds new Truck
     *
     * @param truck truck to add
     * @return added truck
     */
    @Override
    public Truck addNewTruck(Truck truck) throws RegNumNotMatchException {

        // regNum validation
        if (!Pattern.matches("[a-zA-Z]{2}[0-9]{5}]", truck.getRegNum())) {
            throw new RegNumNotMatchException("regNum should be 2 latin letters followed by 5 digits");
        }

        return truckDaoImpl.create(truck);
    }

    /**
     * adds new user. If it's driver then adds the Driver as well
     *
     * @param user user to add
     * @return the added User
     */
    @Override
    public User addNewUser(User user) {
        User newUser = userDaoImpl.create(user);
        // if it's a driver then add the driver as well
        if (DRIVER.equals(newUser.getRole().getRoleName())) {
            Driver driver = driverDaoImpl.getByUserId(user.getId());
            driver = driverDaoImpl.create(driver);
        }
        return newUser;
    }

    /**
     * removes the specified truck
     *
     * @param truck truck to remove
     */
    @Override
    public void removeTruck(Truck truck) {
        truckDaoImpl.remove(truck);
    }

    /**
     * removes the user and the driver if he exists
     *
     * @param user user to remove
     */
    @Override
    public void removeUser(User user) {
        // removes driver first
        Driver driver = driverDaoImpl.getByUserId(user.getId());
        driverDaoImpl.remove(driver);
        // and then removes user
        userDaoImpl.remove(user);
    }

    /**
     * updates the specified truck
     *
     * @param truck truck to update
     * @return updated truck
     */
    @Override
    public Truck updateTruck(Truck truck) throws RegNumNotMatchException {

        // regNum validation
        if (!Pattern.matches("[a-zA-Z]{2}[0-9]{5}]", truck.getRegNum())) {
            throw new RegNumNotMatchException("regNum should be 2 latin letters followed by 5 digits");
        }

        return truckDaoImpl.update(truck);
    }

    /**
     * updates the specified user, the driver as well
     *
     * @param user user to update
     * @return updated user
     */
    @Override
    public User updateUser(User user) {
        // updates Driver first
        Driver driver = driverDaoImpl.getByUserId(user.getId());
        driver = driverDaoImpl.update(driver);
        // and then updates user
        user = userDaoImpl.update(user);
        return user;
    }

    /**
     * get all orders list
     *
     * @return the list of orders
     */
    @Override
    public List<Order> getOrderList() {
        return orderDaoImpl.getAll();
    }

    /**
     * adds new order
     *
     * @param order          order to add
     * @param waypointLoad   waypoint to load the order
     * @param waypointUnload waypoint to unload the order
     * @param orderDrivers   list of drivers for the order
     * @return
     */
    @Override
    public Order addNewOrder(Order order, Waypoint waypointLoad, Waypoint waypointUnload,
                             OrderDriver... orderDrivers) throws WrongSpecifiedCargo {
        // check the had load and unload waypoints
        if (waypointLoad == null || waypointUnload == null) {
            throw new WrongSpecifiedCargo("Cargo should be somewhere loaded and somewhere unloaded");
        }
        // adding order
        Order newOrder = orderDaoImpl.create(order);
        // set the added order to waypoints
        waypointLoad.setOrder(newOrder);
        waypointUnload.setOrder(newOrder);
        // adding waypoints
        Waypoint newWaypointLoad = waypointDaoImpl.create(waypointLoad);
        Waypoint newWaypointUnload = waypointDaoImpl.create(waypointUnload);

        // adding drivers for the order
        for (OrderDriver orderDriver : orderDrivers) {
            // set the added order to orderDriver entity
            orderDriver.setOrder(newOrder);
            OrderDriver newOrderDriver = orderDriverDaoImpl.create(orderDriver);
        }

        return newOrder;
    }

    /**
     * get the specified order
     *
     * @param order id of the order
     * @return specified order
     */
    @Override
    public Order getOrder(long order) {
        return orderDaoImpl.getById(order);
    }

    /**
     * get the specified cargo
     *
     * @param cargo if of the cargo
     * @return specified cargo
     */
    @Override
    public Cargo getCargo(long cargo) {
        return cargoDaoImpl.getById(cargo);
    }

    /**
     * get all the Trucks available for the order
     *
     * @return the list of Trucks
     */
    @Override
    public List<Truck> getTruckListAvailable() {
        List<Truck> truckList = truckDaoImpl.getTrucksByStatusWithoutOrder();
        // toDo: filter trucks according to capacity and waypoints
        return truckList;
    }

    /**
     * search for drivers for the truck
     * 1. no overtimes (176 hours a month)
     * 2. no current active orders
     * 3. driver and truck in the same city
     *
     * @param truck truck for the shift searching
     * @return list of Drivers available for the truck
     */
    @Override
    public List<Driver> getDriversShiftForTruck(Truck truck) {
        List<Driver> driverList = driverDaoImpl.getAvailableDriversCity(truck);
        // toDo: filter drivers according hours in current month and the time for delivery
        return driverList;
    }
}
