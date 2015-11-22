package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.dao.impl.*;
import com.mkhldvdv.logiweb.entities.*;
import com.mkhldvdv.logiweb.exceptions.WrongSpecifiedCargo;
import com.mkhldvdv.logiweb.services.AdminService;

import java.util.List;

/**
 * Created by mkhldvdv on 22.11.2015.
 */
public class AdminServiceImpl implements AdminService {

    public static final String DRIVER = "driver";
    private TruckDao truckDao;
    private DriverDao driverDao;
    private UserDao userDao;
    private OrderDao orderDao;
    private CargoDao cargoDao;
    private WaypointDao waypointDao;
    private OrderDriverDao orderDriverDao;

    /**
     * get all trucks list
     *
     * @return the list of all available Trucks
     */
    @Override
    public List<Truck> getTruckList() {
        return truckDao.getAll();
    }

    /**
     * get all drivers list
     *
     * @return the list of all available Drivers
     */
    @Override
    public List<Driver> getDriverList() {
        return driverDao.getAll();
    }

    /**
     * adds new Truck
     *
     * @param truck truck to add
     * @return added truck
     */
    @Override
    public Truck addNewTruck(Truck truck) {
        return truckDao.create(truck);
    }

    /**
     * adds new user. If it's driver then adds the Driver as well
     *
     * @param user user to add
     * @return the added User
     */
    @Override
    public User addNewUser(User user) {
        User newUser = userDao.create(user);
        // if it's a driver then add the driver as well
        if (DRIVER.equals(newUser.getRole().getRoleName())) {
            Driver driver = driverDao.getByUserId(user.getId());
            driver = driverDao.create(driver);
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
        truckDao.remove(truck);
    }

    /**
     * removes the user and the driver if he exists
     *
     * @param user user to remove
     */
    @Override
    public void removeUser(User user) {
        // removes driver first
        Driver driver = driverDao.getByUserId(user.getId());
        driverDao.remove(driver);
        // and then removes user
        userDao.remove(user);
    }

    /**
     * updates the specified truck
     *
     * @param truck truck to update
     * @return updated truck
     */
    @Override
    public Truck updateTruck(Truck truck) {
        return truckDao.update(truck);
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
        Driver driver = driverDao.getByUserId(user.getId());
        driver = driverDao.update(driver);
        // and then updates user
        user = userDao.update(user);
        return user;
    }

    /**
     * get all orders list
     *
     * @return the list of orders
     */
    @Override
    public List<Order> getOrderList() {
        return orderDao.getAll();
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
        Order newOrder = orderDao.create(order);
        // set the added order to waypoints
        waypointLoad.setOrder(newOrder);
        waypointUnload.setOrder(newOrder);
        // adding waypoints
        Waypoint newWaypointLoad = waypointDao.create(waypointLoad);
        Waypoint newWaypointUnload = waypointDao.create(waypointUnload);

        // adding drivers for the order
        for (OrderDriver orderDriver : orderDrivers) {
            // set the added order to orderDriver entity
            orderDriver.setOrder(newOrder);
            OrderDriver newOrderDriver = orderDriverDao.create(orderDriver);
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
        return orderDao.getById(order);
    }

    /**
     * get the specified cargo
     *
     * @param cargo if of the cargo
     * @return specified cargo
     */
    @Override
    public Cargo getCargo(long cargo) {
        return cargoDao.getById(cargo);
    }

    /**
     * get all the Trucks available for the order
     *
     * @return the list of Trucks
     */
    @Override
    public List<Truck> getTruckListAvailable() {
        List<Truck> truckList = truckDao.getTrucksByStatusWithoutOrder();
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
        List<Driver> driverList = driverDao.getAvailableDriversCity(truck);
        // toDo: filter drivers according hours in current month and the time for delivery
        return driverList;
    }
}
