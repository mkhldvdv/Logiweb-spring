package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.dao.impl.*;
import com.mkhldvdv.logiweb.entities.*;
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
        // and then user
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
     * add new order with the check of all cargos should be
     * somewhere loaded and somwhere unloaded
     * @param order to add
     * @return added Order
     */
    @Override
    public Order addNewOrder(Order order) {
        // toDo: logic for order according to cargo types
        return orderDao.create(order);
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
        // toDo: filter drivers accosrding hours in current month and the time for delivery
        return driverList;
    }
}
